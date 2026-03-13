#include "\x\alive\addons\x_lib\script_component.hpp"
SCRIPT(hashCreate);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_hashCreate

Description:
Creates a native Arma 3 HashMap from an array of key-value pairs.

Parameters:
Array (optional) - array of [key, value] pairs, e.g. [["key1","val1"],["key2","val2"]]

Returns:
HashMap - The new hash

Examples:
(begin example)
_result = [] call ALiVE_fnc_hashCreate;
_result = [[["key1", "val1"], ["key2", "val2"]]] call ALiVE_fnc_hashCreate;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

if (_this isEqualTo []) exitWith { createHashMap };

params [["_array", [], [[]]]];

createHashMapFromArray _array
