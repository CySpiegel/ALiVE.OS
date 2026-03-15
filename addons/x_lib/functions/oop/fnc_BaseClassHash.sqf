#include "\x\alive\addons\x_lib\script_component.hpp"
SCRIPT(baseClassHash);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_baseClassHash
Description:
Base class

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Nil - create - Create instance
Nil - destroy - Destroy instance

Examples:
(begin example)
// Create instance
_logic = [nil, "create"] call ALIVE_fnc_baseClassHash;

// Destroy instance
[_logic, "destroy"] call ALIVE_fnc_baseClassHash;
(end)

See Also:
- nil

Author:
Wolffy.au

Peer reviewed:
nil
---------------------------------------------------------------------------- */
if(
    isNil "_this" ||
    {!(_this isEqualType [] || _this isEqualType createHashMap)} ||
    {count _this == 0} ||
    {!((_this select 0) isEqualType [] || (_this select 0) isEqualType createHashMap)}
) then {
    _this = [createHashMap, "create"];
};

TRACE_1("baseClassHash - input",_this);

params [
    ["_logic", objNull, [objNull,[],createHashMap]],
    ["_operation", "", [""]],
    ["_args", objNull, [objNull,[],"",0,true,false,createHashMap]]
];

private _result = true;

switch(_operation) do {

    case "create": {
        // Create a module object for settings and persistence
        _result = [
            [
                ["class", ALIVE_fnc_baseClassHash]
            ]
        ] call ALiVE_fnc_hashCreate;
    };

    case "destroy": {
        {
            [_logic, _x] call ALIVE_fnc_hashRem;
        } forEach +(keys _logic);

        _logic = nil;
    };

    default {
        private _baseclass = [_logic,"class", _fnc_scriptNameParent] call ALiVE_fnc_hashGet;
        ["class '%3' does not support operation '%2' - %1", _logic, _operation, _baseclass] call ALiVE_fnc_dump;
    };

};

TRACE_1("baseClassHash - output",_result);

_result;
