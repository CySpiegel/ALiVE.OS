#include "\x\alive\addons\x_lib\script_component.hpp"
SCRIPT(hashGet);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_hashGet

Description:
Retrieves a value from a native Arma 3 HashMap by key.
Supports an optional default value for missing keys.

Parameters:
HashMap - The hash
String - The key to get value of
Mixed (optional) - The default value to return if key not found

Returns:
Mixed - The value

Examples:
(begin example)
// get from hash key
_result = [_hash, "key"] call ALiVE_fnc_hashGet;

// get from hash key with default value
_result = [_hash, "key", "value"] call ALiVE_fnc_hashGet;
(end)

See Also:

Author:
ARJay
Wolffy
---------------------------------------------------------------------------- */

private _hash = _this select 0;
private _key = _this select 1;

if (isNil "_hash" || {isNil "_key"}) exitWith {
    ["ALiVE_fnc_HashGet retrieved wrong input from %2 - %1",_this,_fnc_scriptNameParent] call ALiVE_fnc_Dump;
};

if (count _this > 2) then {
    private _default = _this select 2;
    _hash getOrDefault [_key, _default]
} else {
    private _result = _hash getOrDefault [_key, nil];
    if !(isNil "_result") then {_result} else {nil}
};