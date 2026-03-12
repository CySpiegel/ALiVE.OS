#include "\x\alive\addons\x_lib\script_component.hpp"
SCRIPT(inspectHash);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_inspectHash

Description:
Inspect an hash to the RPT

Parameters:

Returns:

Examples:
(begin example)
// inspect config class
_hash call ALIVE_fnc_inspectHash;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private _target = _this;

private _level = 0;

private _text = " ------------------ Inspecting Hash -------------------- ";
[_text] call ALIVE_fnc_dump;

private _inspectRecurse = {
    private _target = _this select 0;
    private _level = (_this select 1) + 1;
    private _index = 0;

    {
        private _key = _x;
        private _value = _y;

        private _indent = " ";
        for "_i" from 0 to _level-1 do {
            _indent = format["%1%2",_indent,_indent];
        };

        if ([_value] call ALIVE_fnc_isHash) then {
            ["%1 k: %2",_indent,_key] call ALIVE_fnc_dump;
            [_value,_level] call _inspectRecurse;
        } else {
            ["%1 k [%4]: %2 v: %3",_indent,_key,_value,_index] call ALIVE_fnc_dump;
        };

        _index = _index + 1;
    } forEach _target;
};

[_target,_level] call _inspectRecurse;

_text = " ------------------ Inspection Complete -------------------- ";
[_text] call ALIVE_fnc_dump;