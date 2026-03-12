#include "\x\alive\addons\x_lib\script_component.hpp"
SCRIPT(hashRem);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_hashRem

Description:
Removes a key from a native Arma 3 HashMap.

Parameters:
HashMap - The hash
String - The key to remove

Returns:
HashMap - The hash

Examples:
(begin example)
_result = [_hash, "key"] call ALiVE_fnc_hashRem;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private _hash = _this select 0;
private _key = _this select 1;

_hash deleteAt _key;

_hash
