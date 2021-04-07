/*
    Original Author: Wyqer, veteran29
    Date: 2019-07-21

    Description:
        Adds the briefing to the map screen.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

if (!hasInterface) exitWith {true};

// Select "Briefing" by default on the map screen
[] spawn {
    disableSerialization;
    private ["_display"];
    waitUntil {
        _display = uiNamespace getVariable ["RscDiary", displayNull];
        !isNull _display
    };

    private _diaryList = (_display displayCtrl 1001);
    _diaryList lnbSetCurSelRow 1; // Briefing

    private _ca_diaryIndex = (_display displayCtrl 1002);
    _ca_diaryIndex lnbSetCurSelRow 0; // How To Play ALiVE
};



player createDiaryRecord [
    "Diary", [localize "STR_A3_Diary_Signal_title", localize "STR_VN_BRIEFING_COALIVE_SIGNAL_XRAY"]
];


player createDiaryRecord [
    "Diary", ["Tactical", localize "STR_VN_BRIEFING_COALIVE_TACTICAL_XRAY"]
];


player createDiaryRecord [
    "Diary", [localize "STR_A3_Diary_Execution_title", localize "STR_VN_BRIEFING_COALIVE_EXECUTION_XRAY"]
];

player createDiaryRecord [
    "Diary", [localize "STR_A3_Diary_Situation_title", localize "STR_VN_BRIEFING_COALIVE_SITUATION_XRAY"]
];


player createDiaryRecord [
    "Diary", [localize "STR_A3_Diary_Mission_title", localize "STR_VN_BRIEFING_COALIVE_MISSION_XRAY"]
];


player createDiaryRecord [
    "Diary", ["ALiVE Respawn", localize "STR_VN_BRIEFING_COALIVE_ALIVERESPAWN_XRAY"]
];

player createDiaryRecord [
    "Diary", ["ALiVE Menu and Interactions", localize "STR_VN_BRIEFING_COALIVE_ALIVEMENUINTER_XRAY"]
];

player createDiaryRecord [
    "Diary", ["How To Play ALiVE", localize "STR_VN_BRIEFING_COALIVE_ALIVEHOWTO_XRAY"]
];

true