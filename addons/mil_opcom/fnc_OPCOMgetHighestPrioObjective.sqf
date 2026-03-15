#include "\x\alive\addons\mil_opcom\script_component.hpp"
SCRIPT(OPCOMgetHighestPrioObjective);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_OPCOMgetHighestPrioObjective

Description:
Gets current highest priority objective by states given ("attack","attacking","defend","defending","reserve","reserving")

Parameters:
Array - [_side (STRING), _states (ARRAY)]

Returns:
objective as string, if none is found for that states its ""

Examples:
(begin example)
//
_result = ["WEST",["attacking"]] call ALIVE_fnc_OPCOMgetHighestPrioObjective;
(end)

See Also:

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_opcom","_result"];

params ["_side","_states"];

_result = "";

{
    private _handle = _x;

    if ((_handle getOrDefault ["side", ""]) == _side) exitwith {
        _opcom = _handle;
    };
} foreach OPCOM_instances;

if (isnil "_opcom") exitwith {
    ["MIL OPCOM - fnc_OPCOMgetHighestPrioObjective didn't find an OPCOM for side %1! Exiting...",_side] call ALiVE_fnc_dump;
};

private _objectives = _opcom getOrDefault ["objectives", []];

{
    private _objective = _x;

    private _id = _objective getOrDefault ["objectiveID", ""];
    private _state = _objective getOrDefault ["opcom_state", "none"];

    if (_state in _states) exitwith {
        _result = _id;
    };
} foreach _objectives;

_result;