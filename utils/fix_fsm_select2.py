#!/usr/bin/env python3
"""Fix select 2 select N patterns in FSM files.

FSM files contain SQF code as escaped strings where quotes are doubled ("").
The patterns _var select 2 select N need to be converted to _var get ""keyName"".
"""

import re
import os

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Key mappings from old array indices to new HashMap key names
# These match the order of hashSet calls in the profile creation functions

ENTITY_KEYS = {
    0: "debug", 1: "active", 2: "position", 3: "side", 4: "profileID",
    5: "type", 6: "objectType", 7: "vehicleAssignments", 8: "vehiclesInCommandOf",
    9: "vehiclesInCargoOf", 10: "leader", 11: "unitClasses", 12: "unitCount",
    13: "group", 14: "companyID", 15: "groupID", 16: "waypoints",
    17: "waypointsCompleted", 18: "positions", 19: "damages", 20: "ranks",
    21: "units", 22: "speedPerSecond", 23: "despawnPosition", 24: "hasSimulated",
    25: "isCycling", 26: "activeCommands", 27: "inactiveCommands", 28: "spawnType",
    29: "faction", 30: "isPlayer", 31: "_rev", 32: "_id", 33: "busy",
    34: "pendingWaypointPaths", 35: "isSPE", 36: "aiBehaviour"
}

CIV_AGENT_KEYS = {
    0: "debug", 1: "active", 2: "position", 3: "agentID", 4: "type",
    5: "unit", 6: "agentClass", 7: "faction", 8: "side", 9: "homeCluster",
    10: "homePosition", 11: "activeCommands", 12: "posture", 13: "firstName",
    14: "lastName"
}

CLUSTER_KEYS = {
    0: "nodes", 1: "clusterID", 2: "center", 3: "size", 4: "type",
    5: "priority", 6: "debugColor"
}

OPCOM_OBJ_KEYS = {
    0: "objectiveID", 1: "center", 2: "size", 3: "objectiveType",
    4: "priority", 5: "opcom_state", 6: "clusterID", 7: "opcomID", 8: "_rev"
}

def fix_file(filepath, replacements):
    """Apply replacements to a file. Each replacement is (old, new)."""
    fullpath = os.path.join(BASE, filepath)
    with open(fullpath, 'r') as f:
        content = f.read()

    count = 0
    for old, new in replacements:
        occurrences = content.count(old)
        if occurrences == 0:
            print(f"  WARNING: Pattern not found: {old!r}")
        else:
            content = content.replace(old, new)
            count += occurrences
            print(f"  Replaced ({occurrences}x): {old!r} -> {new!r}")

    with open(fullpath, 'w') as f:
        f.write(content)

    print(f"  Total replacements in {filepath}: {count}")
    return count


def main():
    total = 0

    # --- opcom.fsm ---
    # OPCOM objectives: _x select 2 select N
    print("\n=== mil_opcom/opcom.fsm ===")
    total += fix_file("addons/mil_opcom/opcom.fsm", [
        ('_x select 2 select 5', '_x get ""opcom_state""'),
        ('_x select 2 select 0', '_x get ""objectiveID""'),
    ])

    # --- mil_command/testCommand.fsm ---
    # Entity profiles: _profile select 2 select N
    print("\n=== mil_command/testCommand.fsm ===")
    total += fix_file("addons/mil_command/testCommand.fsm", [
        ('_profile select 2 select 4', '_profile get ""profileID""'),
        ('_profile select 2 select 10', '_profile get ""leader""'),
        ('_profile select 2 select 13', '_profile get ""group""'),
        ('_profile select 2 select 21', '_profile get ""units""'),
    ])

    # --- clusterActivator.fsm ---
    print("\n=== amb_civ_population/clusterActivator.fsm ===")
    # Fix compound pattern FIRST before simple patterns
    # _agentsToSpawn select _i select 2 select 3  ->  (_agentsToSpawn select _i) get ""agentID""
    total += fix_file("addons/amb_civ_population/clusterActivator.fsm", [
        # Compound patterns (must be done before simple ones)
        ('_agentsToSpawn select _i select 2 select 3', '(_agentsToSpawn select _i) get ""agentID""'),

        # Cluster patterns
        ('_cluster select 2 select 1', '_cluster get ""clusterID""'),
        ('_cluster select 2 select 2', '_cluster get ""center""'),
        ('_cluster select 2 select 3', '_cluster get ""size""'),

        # Civ agent patterns
        ('_agent select 2 select 1', '_agent get ""active""'),
        ('_agent select 2 select 2', '_agent get ""position""'),
        ('_agent select 2 select 3', '_agent get ""agentID""'),
        ('_agent select 2 select 4', '_agent get ""type""'),
        ('_agent select 2 select 5', '_agent get ""unit""'),

        # _this is civ_agent in sort code context
        ('_this select 2 select 2', '_this get ""position""'),

        # _x is cluster in line 1217 context
        ('_x select 2 select 1', '_x get ""clusterID""'),

        # _x is civ_agent in line 1560 context
        ('_x select 2 select 3', '_x get ""agentID""'),
    ])

    # --- clusterActivator_old.fsm ---
    print("\n=== amb_civ_population/clusterActivator_old.fsm ===")
    total += fix_file("addons/amb_civ_population/clusterActivator_old.fsm", [
        # Cluster patterns
        ('_cluster select 2 select 1', '_cluster get ""clusterID""'),
        ('_cluster select 2 select 2', '_cluster get ""center""'),
        ('_cluster select 2 select 3', '_cluster get ""size""'),

        # Civ agent patterns
        ('_agent select 2 select 1', '_agent get ""active""'),
        ('_agent select 2 select 3', '_agent get ""agentID""'),
        ('_agent select 2 select 4', '_agent get ""type""'),
        ('_agent select 2 select 5', '_agent get ""unit""'),
    ])

    print(f"\n=== TOTAL REPLACEMENTS: {total} ===")


if __name__ == "__main__":
    main()
