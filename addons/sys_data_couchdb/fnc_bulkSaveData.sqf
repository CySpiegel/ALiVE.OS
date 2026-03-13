#include "script_component.hpp"
SCRIPT(bulkSaveData_couchdb);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_bulkSaveData_couchdb

Description:
Saves multiple records to a table using CouchDB Bulk API

Parameters:
Object - Data handler logic
Array - Module (string), Data (CBA Hash), mission key (string), Async (bool) optional

Returns:
String - Returns a response error or confirmation of write

Examples:
(begin example)
    _result = [_logic, "save", ["sys_player", GVAR(player_data), _missionKey, _ondisconnect]] call ALIVE_fnc_Data;
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
private ["_result","_error","_module","_data","_async","_missionKey","_saveData", "_indexRev","_indexDoc","_index","_newIndexDoc","_createIndex","_indexArray","_tempIndexDoc","_indexCount","_indexRevs"];

_logic = _this select 0;
_args = _this select 1;

_module = _args select 0;
_data = _args select 1;
_missionKey  = _args select 2;
_async = _args select 3;

TRACE_3("Saving data", _logic, _args);

if(ALiVE_SYS_DATA_DEBUG_ON) then {
    ["SYS_DATA_COUCHDB - BULK SAVE"] call ALiVE_fnc_dump;
};

_result = "";

// Save Docs
TRACE_3("Saving Data", _data);
_response = [_logic, "bulkWrite", [_module, _data, _async, _missionKey] ] call ALIVE_fnc_Data;

TRACE_1("", _response);

// Create/Overwrite Index ==========================

// Create new Index
_indexArray = [];

_createIndex = {
    If (_x != "") then {
        _indexArray pushback _x;
    };
};
_createIndex forEach _data;

// Create the index doc record
_newIndexDoc = createHashMap;
_newIndexDoc set ["_id", _missionKey];

_newIndexDoc set ["index", _indexArray];

// Handle indices greater than 10kb

if(ALiVE_SYS_DATA_DEBUG_ON) then {
    ["SYS_DATA_COUCHDB - BULK SAVE INDEX SIZE: %1 : %2",_module, [str(_newIndexDoc)] call CBA_fnc_strLen] call ALiVE_fnc_dump;
};

if ( ([str(_newIndexDoc)] call CBA_fnc_strLen) > DATA_INBOUND_LIMIT ) then {

        private ["_tempIndex","_indexName","_i"];

        _indexRevs = _logic getOrDefault ["indexRevs", []];

        _tempIndex = [];

        _i = 0;

        {
            if ( ([str(_tempIndex)] call CBA_fnc_strLen) < DATA_INBOUND_LIMIT ) then {

                if(ALiVE_SYS_DATA_DEBUG_ON) then {
//                    ["SYS_DATA_COUCHDB - BULK SAVE TEMP INDEX SIZE: %1",[str(_tempIndex)] call CBA_fnc_strLen] call ALiVE_fnc_dump;
                };

                _tempIndex pushback (_indexArray select _foreachIndex);

            } else {

                if (_i == 0) then {
                    _indexName = _missionKey;
                } else {
                    _indexName = format["%1_%2", _missionKey, _i];
                };

                _tempIndexDoc = createHashMap;
                _tempIndexDoc set ["_id", _indexName];
                _tempIndexDoc set ["index", _tempIndex];

                if (_i < count _indexRevs) then {
                    _tempIndexDoc set ["_rev", _indexRevs select _i];
                };

                _result = [_logic, "write", [_module, _tempIndexDoc, false, _indexName] ] call ALIVE_fnc_Data;

                if(ALiVE_SYS_DATA_DEBUG_ON) then {
                    ["SYS_DATA_COUCHDB - SAVING DATA INDEX: %1 : %2",_indexName,_result] call ALiVE_fnc_dump;
                };

                _tempIndex = [];
                _tempIndex pushback (_indexArray select _foreachIndex);
                _i = _i + 1;

            };

        } foreach _indexArray;

        // Save the final index doc

        if (_i == 0) then {
            _indexName = _missionKey;
        } else {
            _indexName = format["%1_%2", _missionKey, _i];
        };
        _tempIndexDoc = createHashMap;
        _tempIndexDoc set ["_id", _indexName];
        _tempIndexDoc set ["index", _tempIndex];
        if (_i < count _indexRevs) then {
            _tempIndexDoc set ["_rev", _indexRevs select _i];
        };
        _result = [_logic, "write", [_module, _tempIndexDoc, false, _indexName] ] call ALIVE_fnc_Data;

//        _logic set ["indexRevs", _indexRevs];

        if(ALiVE_SYS_DATA_DEBUG_ON) then {
            ["SYS_DATA_COUCHDB - SAVING DATA INDEX: %1",_indexName,_result] call ALiVE_fnc_dump;
        };


} else {

    // If exists, get revision number so we can overwrite it
    _indexRevs = _logic getOrDefault ["indexRevs", []];
    if (count _indexRevs > 0) then {
        _newIndexDoc set ["_rev", _indexRevs select 0];
    };

    if(ALiVE_SYS_DATA_DEBUG_ON) then {
        ["SYS_DATA_COUCHDB - SAVING NEW DATA INDEX:"] call ALiVE_fnc_dump;
        _newIndexDoc call ALIVE_fnc_inspectHash;
    };

    // Write new index
    _result = [_logic, "write", [_module, _newIndexDoc, _async, _missionKey]] call ALIVE_fnc_Data;
};
//=============================================


_result;
