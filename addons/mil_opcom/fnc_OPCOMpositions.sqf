#include "\x\alive\addons\mil_opcom\script_component.hpp"
SCRIPT(OPCOMpositions);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_OPCOM
Description:
Returns a list of OPCOM objective positions with current state

Parameters:
faction (string)
state (string)

Returns:
Array (List of positions)

Attributes:
none

Examples:
(begin example)
_objectivesPositions = ["BLU_F","idle"] call ALIVE_fnc_OPCOMpositions;
(end)

See Also:

Author:
Highhead

Peer reviewed:
nil
---------------------------------------------------------------------------- */
private ["_faction","_objectives","_state","_result"];

_faction = _this select 0;
_state = _this select 1;

{
    private ["_OPCOM","_OPCOM_faction"];
    _OPCOM = _x;
    _OPCOM_faction = _OPCOM getOrDefault ["factions", []];

    if ((_faction) in (_OPCOM_faction)) exitwith {_objectives = _OPCOM getOrDefault ["objectives", []]};
} foreach OPCOM_INSTANCES;

_result = [];
{
    private ["_objective","_OPCOM_state","_pos"];

    _objective = _x;
    _OPCOM_state = _objective getOrDefault ["opcom_state", "unassigned"];

    if (_OPCOM_state == _state) then {
        _pos = _objective get "center";
        _result pushback _pos;
    };
} foreach _objectives;

_result;