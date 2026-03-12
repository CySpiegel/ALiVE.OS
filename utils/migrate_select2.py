#!/usr/bin/env python3
"""
Migrate CBA hash 'select 2 select N' patterns to native HashMap 'get "keyName"'.

Each CBA hash stores values in an array at index 2: _hash select 2 select N
Native HashMap uses: _hash get "keyName"

This script maps numeric indices to key names based on the hash type.
"""

import re
import sys
import os

# ─── Key Mappings ────────────────────────────────────────────────────────────

# Entity Profile (fnc_profileEntity.sqf) - indices 0-36
ENTITY_KEYS = {
    0: "debug", 1: "active", 2: "position", 3: "side", 4: "profileID",
    5: "type", 6: "objectType", 7: "vehicleAssignments",
    8: "vehiclesInCommandOf", 9: "vehiclesInCargoOf", 10: "leader",
    11: "unitClasses", 12: "unitCount", 13: "group", 14: "companyID",
    15: "groupID", 16: "waypoints", 17: "waypointsCompleted",
    18: "positions", 19: "damages", 20: "ranks", 21: "units",
    22: "speedPerSecond", 23: "despawnPosition", 24: "hasSimulated",
    25: "isCycling", 26: "activeCommands", 27: "inactiveCommands",
    28: "spawnType", 29: "faction", 30: "isPlayer",
    31: "_rev", 32: "_id", 33: "busy", 34: "pendingWaypointPaths",
    35: "isSPE", 36: "aiBehaviour",
}

# Vehicle Profile (fnc_profileVehicle.sqf) - indices 0-31
VEHICLE_KEYS = {
    0: "debug", 1: "active", 2: "position", 3: "side", 4: "profileID",
    5: "type", 6: "objectType", 7: "vehicleAssignments",
    8: "entitiesInCommandOf", 9: "entitiesInCargoOf", 10: "vehicle",
    11: "vehicleClass", 12: "direction", 13: "fuel", 14: "ammo",
    15: "engineOn", 16: "damage", 17: "canMove", 18: "canFire",
    19: "needReload", 20: "despawnPosition", 21: "hasSimulated",
    22: "spawnType", 23: "faction", 24: "_rev", 25: "_id",
    26: "busy", 27: "cargo", 28: "slingload", 29: "slung",
    30: "isSPE", 31: "aiBehaviour",
}

# Civilian Agent (fnc_civilianAgent.sqf) - indices 0-14
CIV_AGENT_KEYS = {
    0: "debug", 1: "active", 2: "position", 3: "agentID",
    4: "type", 5: "unit", 6: "agentClass", 7: "faction",
    8: "side", 9: "homeCluster", 10: "homePosition",
    11: "activeCommands", 12: "posture", 13: "firstName", 14: "lastName",
}

# Civilian Vehicle (fnc_civilianVehicle.sqf) - indices 0-14
CIV_VEHICLE_KEYS = {
    0: "debug", 1: "active", 2: "position", 3: "agentID",
    4: "type", 5: "unit", 6: "agentClass", 7: "faction",
    8: "side", 9: "homeCluster", 10: "homePosition",
    11: "direction", 12: "fuel", 13: "damage", 14: "initialdamage",
}

# Spatial Grid (fnc_spacialGrid.sqf) - indices 0-5
SPATIAL_GRID_KEYS = {
    0: "origin", 1: "sectorSize", 2: "gridSize",
    3: "minSector", 4: "maxSector", 5: "sectors",
}

# Attack (fnc_profileAttack.sqf) - indices 0-10
ATTACK_KEYS = {
    0: "super", 1: "class", 2: "cyclesLeft", 3: "attackID",
    4: "attackerSide", 5: "position", 6: "timeStarted",
    7: "attacker", 8: "targets", 9: "targetsKilled", 10: "maxRange",
}

# Combat Handler (fnc_profileCombatHandler.sqf) - indices 0-10
COMBAT_HANDLER_KEYS = {
    0: "super", 1: "class", 2: "debug", 3: "combatRange",
    4: "combatRate", 5: "profilesInCombatBySide.EAST",
    6: "profilesInCombatBySide.WEST", 7: "profilesInCombatBySide.GUER",
    8: "profilesInCombatBySide", 9: "attackCount", 10: "attacksByID",
}

# Waypoint (fnc_createProfileWaypoint.sqf) - indices 0-12
WAYPOINT_KEYS = {
    0: "position", 1: "radius", 2: "type", 3: "speed",
    4: "completionRadius", 5: "timeout", 6: "formation",
    7: "combatMode", 8: "behaviour", 9: "description",
    10: "attachVehicle", 11: "statements", 12: "name",
}

# Tour selection options (fnc_tour.sqf selection UI)
TOUR_SELECTION_KEYS = {
    0: "icon", 1: "inactiveLabel", 2: "activeLabel", 3: "iconState",
}

# OPCOM Objective (fnc_OPCOM.sqf addObjective case) - indices 0-8
OPCOM_OBJECTIVE_KEYS = {
    0: "objectiveID", 1: "center", 2: "size", 3: "objectiveType",
    4: "priority", 5: "opcom_state", 6: "clusterID", 7: "opcomID",
    8: "_rev",
}

# ─── File → Hash Type Mapping ───────────────────────────────────────────────

# Files that ONLY access entity profiles
ENTITY_ONLY_FILES = {
    "fnc_profileEntity.sqf",
    "fnc_profileHandler.sqf",
    "fnc_profileSpawner.sqf",
    "fnc_commandHandler.sqf",
    "fnc_commandRouter.sqf",
    "fnc_ambientMovement.sqf",
    "fnc_ambush.sqf",
    "fnc_buildingPatrol.sqf",
    "fnc_garrison.sqf",
    "fnc_insurgents.sqf",
    "fnc_managedBuildingPatrol.sqf",
    "fnc_managedGarrison.sqf",
    "fnc_testCommand.sqf",
    "fnc_testManagedCommand.sqf",
    "fnc_gridAnalysisProfileEntity.sqf",
    "fnc_gridAnalysisActive.sqf",
    "fnc_liveAnalysis.sqf",
    "fnc_sectorPlot.sqf",
    "fnc_profile.sqf",
    "fnc_getNearProfiles.sqf",
    "fnc_createProfileVehicleAssignment.sqf",
    "fnc_createProfilesFromPlayers.sqf",
    "fnc_profileGetInEventHandler.sqf",
    "fnc_profileKilledEventHandler.sqf",
    "fnc_waypointsToProfileWaypoints.sqf",
    "fnc_profileVehicleAssignmentGetEmptyPositions.sqf",
    "fnc_profileVehicleAssignmentToVehicleAssignment.sqf",
    "fnc_profileVehicleAssignmentsGetInCargo.sqf",
    "fnc_profileVehicleAssignmentsGetInCommand.sqf",
    "fnc_profileVehicleAssignmentsGetSpeedPerSecond.sqf",
    "fnc_profileVehicleAssignmentsSetAllPositions.sqf",
    "fnc_vehicleAssignmentsGetLinkedProfiles.sqf",
    "fnc_vehicleAssignmentsToProfileVehicleAssignments.sqf",
    "fnc_taskHandler.sqf",
    "fnc_taskAssassination.sqf",
    "fnc_taskCSAR.sqf",
    "fnc_taskDCA.sqf",
    "fnc_taskDestroyInfantry.sqf",
    "fnc_taskMilDefence.sqf",
    "fnc_taskRescue.sqf",
    "fnc_taskSEAD.sqf",
    "fnc_taskTransportInsertion.sqf",
    "fnc_taskCreateVehicleExtractionForUnits.sqf",
    "fnc_taskCreateVehicleInsertionForUnits.sqf",
    "fnc_taskGetRandomSideEntityFromSector.sqf",
    "fnc_taskGetStateOfEntityProfiles.sqf",
    "fnc_OPCOM.sqf",
    "fnc_SCOM.sqf",
    "fnc_G2.sqf",
    "fnc_logistics.sqf",
    "fnc_ATO.sqf",
    "test_getNearProfiles.sqf",
    "test_stressTest.sqf",
    "fnc_getDominantFaction.sqf",
    "fnc_unitsInArea.sqf",
    "fnc_arrayBlockHandler.sqf",
    "fnc_checkConfigCompatibility.sqf",
    "fnc_checkConfigWarnings.sqf",
    "fnc_checkStaticDataMapping.sqf",
}

# Files that ONLY access vehicle profiles
VEHICLE_ONLY_FILES = {
    "fnc_profileVehicle.sqf",
    "fnc_gridAnalysisProfileVehicle.sqf",
    "fnc_taskDestroyVehicles.sqf",
    "fnc_taskGetRandomSideVehicleFromSector.sqf",
    "fnc_taskGetStateOfVehicleProfiles.sqf",
}

# Files that access civilian agent hashes
CIV_AGENT_FILES = {
    "fnc_civilianAgent.sqf",
    "fnc_cc_campfire.sqf",
    "fnc_cc_driveTo.sqf",
    "fnc_cc_flee.sqf",
    "fnc_cc_getWeapons.sqf",
    "fnc_cc_housework.sqf",
    "fnc_cc_idle.sqf",
    "fnc_cc_joinGathering.sqf",
    "fnc_cc_joinMeeting.sqf",
    "fnc_cc_journey.sqf",
    "fnc_cc_observe.sqf",
    "fnc_cc_randomMovement.sqf",
    "fnc_cc_rogue.sqf",
    "fnc_cc_rogueTarget.sqf",
    "fnc_cc_sabotage.sqf",
    "fnc_cc_sleep.sqf",
    "fnc_cc_startGathering.sqf",
    "fnc_cc_startMeeting.sqf",
    "fnc_cc_suicide.sqf",
    "fnc_cc_suicideTarget.sqf",
    "fnc_civCommandRouter.sqf",
    "fnc_selectCivilianCommand.sqf",
    "fnc_agentKilledEventHandler.sqf",
    "fnc_civInteract.sqf",
    "fnc_getAgentData.sqf",
    "fnc_getGlobalPosture.sqf",
    "fnc_getNearestActiveAgent.sqf",
    "test_agentCommands.sqf",
    "test_assignAgentCommands.sqf",
}

# Files that access civilian vehicle hashes
CIV_VEHICLE_FILES = {
    "fnc_civilianVehicle.sqf",
}

# Spatial grid file
SPATIAL_GRID_FILES = {
    "fnc_spacialGrid.sqf",
}

# ─── Variable Name → Hash Type Detection ────────────────────────────────────

# For mixed files, detect hash type based on variable name
ENTITY_VAR_PATTERNS = re.compile(
    r'_(?:profile|entityProfile|infantryProfile|targetProfile|'
    r'_profile|nearProfile|sideProfile|entityProf)(?:\s|$)',
    re.IGNORECASE
)

VEHICLE_VAR_PATTERNS = re.compile(
    r'_(?:vehicleProfile|transportProfile|slingLoadProfile|vehProfile|'
    r'vehicleProf)(?:\s|$)',
    re.IGNORECASE
)


def get_key_name(index, hash_type, line_context="", filename=""):
    """Get key name for a given index and hash type."""
    mapping = {
        "entity": ENTITY_KEYS,
        "vehicle": VEHICLE_KEYS,
        "civ_agent": CIV_AGENT_KEYS,
        "civ_vehicle": CIV_VEHICLE_KEYS,
        "spatial_grid": SPATIAL_GRID_KEYS,
        "attack": ATTACK_KEYS,
        "combat_handler": COMBAT_HANDLER_KEYS,
        "waypoint": WAYPOINT_KEYS,
        "tour_selection": TOUR_SELECTION_KEYS,
        "opcom_objective": OPCOM_OBJECTIVE_KEYS,
    }

    keys = mapping.get(hash_type, {})
    if index in keys:
        return keys[index]
    return None


def detect_hash_type_for_var(var_name, line, filename):
    """Detect hash type based on variable name and context."""
    vl = var_name.lower()

    # Attack hash - only exact _attack, not _attacker
    if vl == "_attack":
        return "attack"

    # Vehicle profile indicators
    if any(kw in vl for kw in [
        "vehicleprofile", "transportprofile", "slingloadprofile",
        "vehprofile", "vehicleprof", "subordinatevehicle",
        "payloadvehicle", "pvehicle",
    ]):
        return "vehicle"

    # Entity profile indicators
    if any(kw in vl for kw in [
        "entityprofile", "infantryprofile", "targetprofile",
        "sideprofile", "entityprof", "commandingentity",
        "entityincommandof", "victim", "killer", "attacker",
        "target",
    ]):
        return "entity"

    # _targetToAttack needs context - index 11 differs between entity/vehicle
    if "targettoattack" in vl:
        return "entity"  # default; specific overrides handled in process_file

    # Generic _profile - check context and file
    if "profile" in vl:
        # Check if this is in a vehicle context
        if "vehicle" in line.lower() or "transport" in line.lower():
            return "vehicle"
        return "entity"  # default for profiles

    # _vehicle by itself (not vehicleProfile) - likely vehicle profile
    if vl == "_vehicle" or vl.endswith("vehicle"):
        return "vehicle"

    return None


def detect_hash_type_for_file(filename):
    """Get the primary hash type for a file."""
    basename = os.path.basename(filename)

    if basename in ENTITY_ONLY_FILES:
        return "entity"
    if basename in VEHICLE_ONLY_FILES:
        return "vehicle"
    if basename in CIV_AGENT_FILES:
        return "civ_agent"
    if basename in CIV_VEHICLE_FILES:
        return "civ_vehicle"
    if basename in SPATIAL_GRID_FILES:
        return "spatial_grid"
    if basename == "fnc_profileAttack.sqf":
        return "attack"
    if basename == "fnc_profileCombatHandler.sqf":
        return "combat_handler"

    return None


def process_file(filepath, dry_run=False):
    """Process a single file, replacing select 2 select N patterns."""
    with open(filepath, 'r') as f:
        content = f.read()

    basename = os.path.basename(filepath)
    file_hash_type = detect_hash_type_for_file(filepath)
    changes = []
    warnings = []

    # Pattern: _var select 2 select N
    # Also handles nested: _var select M select 2 select N
    # where M is 0 or 1 (accessing array element that is a hash)
    pattern_simple = re.compile(
        r'(\b\w+)\s+select\s+2\s+select\s+(\d+)',
        re.IGNORECASE
    )
    # Nested pattern: _var select M select 2 select N
    pattern_nested = re.compile(
        r'(\b\w+)\s+select\s+(\d+)\s+select\s+2\s+select\s+(\d+)',
        re.IGNORECASE
    )

    # Known plain array access patterns (NOT hashes) - skip these
    SKIP_PATTERNS = {
        "_selectionOption",  # tour UI array
    }

    lines = content.split('\n')
    new_lines = []
    for line_num, line in enumerate(lines, 1):
        # Skip comment-only lines
        stripped = line.lstrip()
        if stripped.startswith('//'):
            new_lines.append(line)
            continue

        # Check if select 2 select appears in comments part only
        code_part = line.split('//')[0] if '//' in line else line
        comment_part = line[len(code_part):] if '//' in line else ""

        new_code = code_part

        # First try nested pattern (more specific, process first)
        nested_matches = list(pattern_nested.finditer(code_part))
        processed_ranges = []

        for match in reversed(nested_matches):
            var_name = match.group(1)
            array_index = int(match.group(2))
            hash_index = int(match.group(3))
            full_match = match.group(0)
            start, end = match.start(), match.end()

            # Skip known plain arrays
            if var_name in SKIP_PATTERNS:
                processed_ranges.append((start, end))
                continue

            # Determine hash type for nested access
            hash_type = None

            # _eventData select 1 → OPCOM objective
            if "eventdata" in var_name.lower() and array_index == 1:
                hash_type = "opcom_objective"
            # _profiles select 0 → entity profile, _profiles select 1 → vehicle profile
            elif "profiles" in var_name.lower() or "profile" in var_name.lower():
                if array_index == 0:
                    hash_type = "entity"
                elif array_index == 1:
                    hash_type = "vehicle"
            else:
                # Try variable detection
                var_type = detect_hash_type_for_var(var_name, line, filepath)
                if var_type:
                    hash_type = var_type
                elif file_hash_type:
                    hash_type = file_hash_type

            if not hash_type:
                warnings.append(f"  WARNING: {filepath}:{line_num} - Cannot determine hash type for nested '{var_name} select {array_index}' index {hash_index}")
                warnings.append(f"    Line: {line.strip()}")
                processed_ranges.append((start, end))
                continue

            key_name = get_key_name(hash_index, hash_type, line, filepath)
            if key_name is None:
                warnings.append(f"  WARNING: {filepath}:{line_num} - No key for index {hash_index} in {hash_type} hash (nested)")
                warnings.append(f"    Line: {line.strip()}")
                processed_ranges.append((start, end))
                continue

            replacement = f'({var_name} select {array_index}) get "{key_name}"'
            new_code = new_code[:start] + replacement + new_code[end:]
            processed_ranges.append((start, end))
            changes.append(f"  {filepath}:{line_num}: {var_name} select {array_index} select 2 select {hash_index} -> ({var_name} select {array_index}) get \"{key_name}\" [{hash_type}]")

        # Then process simple patterns (not already handled by nested)
        for match in reversed(list(pattern_simple.finditer(new_code))):
            var_name = match.group(1)
            index = int(match.group(2))
            full_match = match.group(0)
            start, end = match.start(), match.end()

            # Skip if this is a numeric var (was part of nested pattern already processed)
            if var_name.isdigit():
                # Already handled or can't determine - skip
                continue

            # Skip known plain arrays
            if var_name in SKIP_PATTERNS:
                continue

            # Determine hash type
            hash_type = None

            # First try variable-based detection
            var_type = detect_hash_type_for_var(var_name, line, filepath)
            if var_type:
                hash_type = var_type
            elif file_hash_type:
                hash_type = file_hash_type
            else:
                # For mixed files, try harder
                vl = var_name.lower()
                if "_logic" in vl:
                    hash_type = file_hash_type or "entity"
                elif "_x" in vl or "_data" in vl:
                    hash_type = file_hash_type or "entity"

            if not hash_type:
                warnings.append(f"  WARNING: {filepath}:{line_num} - Cannot determine hash type for '{var_name}' index {index}")
                warnings.append(f"    Line: {line.strip()}")
                continue

            key_name = get_key_name(index, hash_type, line, filepath)
            if key_name is None:
                warnings.append(f"  WARNING: {filepath}:{line_num} - No key for index {index} in {hash_type} hash")
                warnings.append(f"    Line: {line.strip()}")
                # Don't modify this line at all
                continue
            else:
                replacement = f'{var_name} get "{key_name}"'
                new_code = new_code[:start] + replacement + new_code[end:]
                changes.append(f"  {filepath}:{line_num}: {var_name} select 2 select {index} -> {var_name} get \"{key_name}\" [{hash_type}]")

        new_lines.append(new_code + comment_part)

    if changes and not dry_run:
        with open(filepath, 'w') as f:
            f.write('\n'.join(new_lines))

    return changes, warnings


def main():
    dry_run = "--dry-run" in sys.argv
    verbose = "--verbose" in sys.argv or "-v" in sys.argv
    single_file = None

    for arg in sys.argv[1:]:
        if not arg.startswith("-"):
            single_file = arg

    if single_file:
        files = [single_file]
    else:
        # Find all .sqf files with select 2 select
        import subprocess
        result = subprocess.run(
            ["grep", "-rln", "select 2 select", "addons/", "--include=*.sqf"],
            capture_output=True, text=True
        )
        files = sorted(result.stdout.strip().split('\n'))

    total_changes = 0
    total_warnings = 0

    for filepath in files:
        if not filepath:
            continue
        changes, warnings = process_file(filepath, dry_run=dry_run)
        total_changes += len(changes)
        total_warnings += len(warnings)

        if changes or warnings:
            if verbose or warnings:
                print(f"\n{'[DRY RUN] ' if dry_run else ''}{filepath}:")
                for c in changes:
                    print(c)
                for w in warnings:
                    print(w)

    action = "Would change" if dry_run else "Changed"
    print(f"\n{'='*60}")
    print(f"{action} {total_changes} patterns across {len(files)} files")
    print(f"Warnings: {total_warnings}")
    if dry_run:
        print("Run without --dry-run to apply changes")


if __name__ == "__main__":
    main()
