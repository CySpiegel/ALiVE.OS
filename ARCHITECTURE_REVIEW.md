# ALiVE.OS Arma 3 Mod - Architecture Review & Rewrite Assessment

## Context

ALiVE.OS is a mature, large-scale Arma 3 mod (~65 addons, 2,257 SQF files) that provides a persistent AI battlefield simulation. The user wants to know if a ground-up rewrite is justified vs. incremental refactoring. This review analyzes the architecture's strengths, weaknesses, and provides a clear recommendation.

---

## 1. Architecture Summary

| Metric | Value |
|--------|-------|
| Addons | 65 + 6 optional |
| SQF files | 2,257 |
| HPP config files | 681 |
| Largest logic file | `fnc_OPCOM.sqf` (2,889 lines, 72 switch cases) |
| Map index data files | ~8M+ lines (pre-computed map analysis data) |
| Dependencies | CBA_A3 (required), ACE3 (optional) |
| OOP pattern | Custom switch-case dispatch via BaseClassHash |
| Build system | MakePbo.exe + Python validators + Travis CI |

---

## 2. Strengths (Preserve These)

### A. Virtual Profiling System (`sys_profile`)
The crown jewel. Virtualizes AI units when far from players, dramatically reducing simulation load. This is architecturally sound and well-decomposed (profileHandler, profileEntity, profileVehicle, spawn/despawn logic). **Must be preserved in any approach.**

### B. Modular Addon Structure
Clean separation into mil_/sys_/amb_/sup_ prefixes. Each addon is independently PBO-packable. The `script_component.hpp` + `CfgFunctions.hpp` + `CfgPatches.hpp` convention is consistent across all 65 addons.

### C. OPCOM (AI Commander)
Sophisticated AI decision-making (`fnc_OPCOM.sqf`) with support for multiple operation types (invasion, occupation, asymmetric). While the file is too large (2,889 lines), the underlying tactical logic is valuable.

### D. CBA Integration
Proper use of CBA Extended Event Handlers (XEH), CBA settings, and CBA events. This is the right foundation for an Arma 3 mod.

### E. Pre-computed Map Data
Hundreds of map index files in `fnc_strategic/indexes/` and `fnc_analysis/data/` provide pre-analyzed terrain data. This is a massive investment that must be carried forward.

---

## 3. Architectural Weaknesses

### A. God-Object Anti-Pattern (CRITICAL)
The biggest problem. Core modules are monolithic switch-case dispatch files:

| File | Lines | Switch Cases | Role |
|------|-------|-------------|------|
| `fnc_OPCOM.sqf` | 2,889 | 72 | AI Commander |
| `fnc_orbatCreator.sqf` | 7,636 | ~100+ | ORBAT Editor |
| `fnc_ML.sqf` | 6,342 | ~80+ | Military Logistics |
| `fnc_ATO.sqf` | 5,692 | ~70+ | Air Tasking |
| `fnc_profileHandler.sqf` | 1,507 | 51 | Profile Manager |
| `fnc_profileEntity.sqf` | 1,451 | 58 | Profile Entity |

Each file is a single function with a massive `switch(_operation)` that handles everything from initialization to destruction. This makes them:
- Hard to read and navigate
- Impossible to unit test individual operations
- Prone to variable scope leaks (all cases share one scope)
- Difficult to extend without touching the monolith

### B. Custom OOP is Overhead Without Benefit
The `BaseClassHash` pattern (`[_logic, "operation", args] call ALIVE_fnc_Module`) simulates OOP via function calls + switch dispatch. In SQF, this adds:
- **Function call overhead** on every "method" invocation (params parsing, switch matching)
- **No compile-time checking** — typos in operation strings silently hit the `default` case
- **No real inheritance** — subclasses just copy the switch pattern and add a `default` case that calls `SUPERCLASS`
- **Variable scope pollution** — all cases in one function share private scope

Modern Arma 3 SQF (2.02+) has better alternatives: separate functions per operation, native HashMaps, and CBA event-driven patterns.

### C. Mixed State Management
State is stored inconsistently across the codebase:
- Object variables (`setVariable`/`getVariable`) on game logic objects
- HashMap keys via `ALiVE_fnc_hashSet`/`hashGet` wrappers
- Global variables via `GVAR()` macros
- Profile namespace for persistence
- `publicVariable` for MP sync

There's no unified data layer or state management pattern.

### D. Deprecated API Usage
- `BIS_fnc_param` used instead of modern `params` command
- `typeName _var == "ARRAY"` instead of `_var isEqualType []`
- `call compile` for string-to-code conversion (security/performance concern)
- Mix of old CBA hash arrays and native HashMaps (migration in progress but incomplete)

### E. Over-Modularization in Some Areas
Some addons are trivially small and could be consolidated:
- `splashscreen` (40 lines), `intro` (94 lines)
- Multiple composition addons that are just data
- `sys_data`, `sys_data_couchdb`, `sys_data_pns` could be one addon with providers

### F. Massive Pre-computed Data Bloat
Map index files account for ~10M lines of SQF. These are hardcoded arrays/hashes. A better approach would be:
- Binary data format (faster loading)
- Runtime generation with caching
- External tooling to generate config-based indexes instead of SQF

### G. No Testing Infrastructure
Despite some addons having `tests/` directories, there's no systematic test framework, no CI test execution, and no integration tests. The Travis CI only runs syntax validation.

### H. Tight Coupling to Eden Editor
Modules must be placed in the Eden Editor as game logic objects. This makes programmatic/scripted use harder and ties the mod's API to editor placement.

---

## 4. Recommendation: **Incremental Refactor, NOT Ground-Up Rewrite**

### Why NOT Rewrite

1. **The core algorithms work.** OPCOM, profiling, placement — these represent years of gameplay tuning. Rewriting risks losing subtle behavioral correctness.

2. **Map data investment is enormous.** Hundreds of pre-computed map indexes can't be easily regenerated. They must be carried forward regardless.

3. **Community compatibility.** Mission makers have built hundreds of missions against ALiVE's API (module placement, function calls). A rewrite breaks all of them.

4. **SQF hasn't changed enough.** The language is still SQF. A rewrite would still be SQF. The fundamental limitations (no real OOP, no modules) remain. You'd end up building another custom framework.

5. **Risk of "second system effect."** The original authors' domain knowledge is embedded in the code. Edge cases, workarounds for Arma engine bugs, MP synchronization timing — these are hard to rediscover.

### What Refactoring Should Address (Priority Order)

#### P0: Break Up God Objects
Split monolithic switch-case files into individual functions:
```
fnc_OPCOM.sqf (2,889 lines, 72 cases)
→ fnc_OPCOM_init.sqf
→ fnc_OPCOM_start.sqf
→ fnc_OPCOM_createObjectives.sqf
→ fnc_OPCOM_setOrders.sqf
→ ... (one file per operation)
```
Use a dispatch table (HashMap) instead of switch:
```sqf
private _dispatch = createHashMapFromArray [
    ["init", ALIVE_fnc_OPCOM_init],
    ["start", ALIVE_fnc_OPCOM_start],
    ...
];
(_dispatch get _operation) call [_logic, _args];
```
This preserves the external API (`[_logic, "op"] call ALIVE_fnc_OPCOM`) while eliminating the monolith.

#### P1: Complete HashMap Migration
Finish the `feature/native-hashmap` work. Replace all `ALiVE_fnc_hashGet/Set/Rem` wrapper calls with native HashMap operations (`get`, `set`, `deleteAt`). This is pure performance gain with no API change.

#### P2: Modernize SQF Patterns
- Replace `BIS_fnc_param` with `params`
- Replace `typeName` checks with `isEqualType`
- Remove `call compile` where possible
- Use `remoteExecCall` instead of `publicVariable` + event handlers

#### P3: Consolidate Trivial Addons
Merge small addons (splashscreen, intro) into `main`. Merge data system addons into one with provider pattern.

#### P4: Externalize Map Data
Move map indexes out of SQF into a binary or config-based format. Create tooling to generate indexes rather than shipping them as source.

#### P5: Add Testing
Implement a test runner (CBA has a test framework). Add integration tests for core systems (profiling, OPCOM decision-making).

---

## 5. Verification

This is a review document — verification consists of:
- Confirming the file sizes and patterns cited match the actual codebase (done via exploration)
- Validating that the refactoring priorities address the real pain points the user experiences
- Discussing with the user whether the recommendation aligns with their goals

---

## 6. Summary

| Factor | Rewrite | Refactor |
|--------|---------|----------|
| Preserves battle-tested logic | No | Yes |
| Breaks existing missions | Yes | No |
| Addresses god-object problem | Yes | Yes (P0) |
| Modernizes SQF patterns | Yes | Yes (P2) |
| Time to feature parity | Very long | Incremental |
| Risk of regression | Very high | Low per change |
| **Recommendation** | | **This one** |

**Bottom line:** The architecture has real problems (god objects, mixed state, deprecated patterns), but they're all incrementally fixable. The valuable parts (profiling, OPCOM algorithms, map data, community API compatibility) far outweigh the cost of starting over. Refactor the structure while preserving the logic.
