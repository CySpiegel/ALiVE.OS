#include "\x\alive\addons\x_lib\script_component.hpp"
SCRIPT(hashCreate);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_hashCreate

Description:
Creates a native Arma 3 HashMap. Supports optional initial key-value pairs
passed as alternating [key, value, key, value, ...] array.

Parameters:
Array (optional) - alternating key-value pairs for initial data

Returns:
HashMap - The new hash

Examples:
(begin example)
_result = [] call ALiVE_fnc_hashCreate;
_result = [["key1", "val1", "key2", "val2"]] call ALiVE_fnc_hashCreate;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

if (_this isEqualTo []) exitWith { createHashMap };

private _hash = createHashMap;
private _pairs = _this;

// Support CBA-style initial pairs: [[key,val,key,val,...]]
if (count _pairs > 0 && {typeName (_pairs select 0) == "ARRAY"}) then {
    _pairs = _pairs select 0;
};

for "_i" from 0 to (count _pairs - 1) step 2 do {
    _hash set [_pairs select _i, _pairs select (_i + 1)];
};

_hash
