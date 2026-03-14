#include "\x\alive\addons\x_lib\script_component.hpp"
SCRIPT(hashSet);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_hashSet

Description:
Sets a key-value pair in a native Arma 3 HashMap.

Parameters:
HashMap - The hash
String - The key to set value of
Mixed - The value to store

Returns:
HashMap - The hash

Examples:
(begin example)
_result = [_hash, "key", "value"] call ALiVE_fnc_hashSet;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private _hash = _this select 0;
private _key = _this select 1;

if (count _this < 3) exitWith {
    ["ALiVE_fnc_hashSet called with %1 args from %2 - key: %3 - this: %4", count _this, _fnc_scriptNameParent, _key, _this] call ALiVE_fnc_Dump;
    _hash
};

private _value = _this select 2;

_hash set [_key, _value];

_hash
