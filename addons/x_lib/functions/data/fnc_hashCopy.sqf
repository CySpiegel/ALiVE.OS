#include "\x\alive\addons\x_lib\script_component.hpp"
SCRIPT(hashCopy);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_hashCopy

Description:
Deep-copies a native Arma 3 HashMap with optional key filtering.

Parameters:
HashMap - source hash to copy
Array (optional) - whitelist keys (only copy these)
Array (optional) - blacklist keys (skip these)

Returns:
HashMap - The new hash

Examples:
(begin example)
_result = [_hash, ["apples","oranges"], ["grapes"]] call ALiVE_fnc_hashCopy;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private _target = _this select 0;
private _whitelist = if (count _this > 1) then {_this select 1} else {[]};
private _blacklist = if (count _this > 2) then {_this select 2} else {[]};

private _hash = createHashMap;

{
    private _key = _x;
    private _value = _y;
    private _copy = true;

    if (count _whitelist > 0) then {
        _copy = _key in _whitelist;
    };

    if (_copy && {count _blacklist > 0}) then {
        _copy = !(_key in _blacklist);
    };

    if (_copy) then {
        if (_value isEqualType createHashMap) then {
            [_hash, _key, [_value, _whitelist, _blacklist] call ALiVE_fnc_hashCopy] call ALIVE_fnc_hashSet;
        } else {
            if (_value isEqualType []) then {
                [_hash, _key, +_value] call ALIVE_fnc_hashSet;
            } else {
                [_hash, _key, _value] call ALIVE_fnc_hashSet;
            };
        };
    };
} forEach _target;

_hash
