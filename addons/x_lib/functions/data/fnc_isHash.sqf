#include "\x\alive\addons\x_lib\script_component.hpp"
SCRIPT(isHash);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_isHash

Description:
Checks if the given value is a native Arma 3 HashMap.

Parameters:
Mixed - value to check

Returns:
Bool - true if the value is a HashMap

Examples:
(begin example)
_result = [_hash] call ALiVE_fnc_isHash;
(end)

See Also:

Author:
CBA
---------------------------------------------------------------------------- */

private _value = _this select 0;

_value isEqualType createHashMap

_result;
