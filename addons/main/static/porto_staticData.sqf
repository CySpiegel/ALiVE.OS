private["_worldName"];
 _worldName = tolower(worldName);
 ["SETTING UP MAP: porto"] call ALiVE_fnc_dump;
 ALIVE_Indexing_Blacklist = [];
 ALIVE_airBuildingTypes = [];
 ALIVE_militaryParkingBuildingTypes = [];
 ALIVE_militarySupplyBuildingTypes = [];
 ALIVE_militaryHQBuildingTypes = [];
 ALIVE_militaryAirBuildingTypes = [];
 ALIVE_civilianAirBuildingTypes = [];
 ALiVE_HeliBuildingTypes = [];
 ALIVE_militaryHeliBuildingTypes = [];
 ALIVE_civilianHeliBuildingTypes = [];
 ALIVE_militaryBuildingTypes = [];
 ALIVE_civilianPopulationBuildingTypes = [];
 ALIVE_civilianHQBuildingTypes = [];
 ALIVE_civilianPowerBuildingTypes = [];
 ALIVE_civilianCommsBuildingTypes = [];
 ALIVE_civilianMarineBuildingTypes = [];
 ALIVE_civilianRailBuildingTypes = [];
 ALIVE_civilianFuelBuildingTypes = [];
 ALIVE_civilianConstructionBuildingTypes = [];
 ALIVE_civilianSettlementBuildingTypes = [];
 if(tolower(_worldName) == "porto") then {
ALIVE_Indexing_Blacklist = ALIVE_Indexing_Blacklist + ["ca\desert2\data\plant\rasy.p3d","ca\buildings\molo_krychle.p3d","ca\buildings\misc\lampa_vysoka.p3d","ca\buildings\shop1_double.p3d","ca\misc\sloupyeli.p3d","ca\buildings\misc\leseni2x.p3d","ca\buildings\misc\zed_podplaz_civil.p3d","ca\buildings\misc\zed_civil.p3d","ca\buildings\misc\zed_dira_civil.p3d","ca\buildings\misc\stanek_4b.p3d"];
ALIVE_civilianPopulationBuildingTypes = ALIVE_civilianPopulationBuildingTypes + ["ca\buildings\hut06.p3d","ca\buildings\hut01.p3d","ca\buildings\hut02.p3d","ca\buildings\hut04.p3d","ca\buildings\hut03.p3d","ca\buildings\dum_istan2b.p3d","ca\buildings\dum_olez_istan1.p3d","ca\buildings\shop2_short.p3d","ca\buildings\dum_olez_istan2_maly.p3d","ca\buildings\dum_istan3_hromada.p3d"];
ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + ["ca\buildings\hut06.p3d","ca\buildings\bouda_plech.p3d","ca\buildings\hut01.p3d","ca\buildings\hut02.p3d","ca\buildings\hut04.p3d","ca\buildings\dum_olez_istan2.p3d","ca\buildings\hut03.p3d","ca\buildings\molo_beton.p3d","ca\buildings\dum_istan3.p3d","ca\buildings\dum_istan3_hromada2.p3d","ca\buildings\dum_olez_istan2_maly2.p3d","ca\buildings\dum_istan2b.p3d","ca\buildings\dum_olez_istan1.p3d","ca\buildings\shop2_short.p3d","ca\buildings\shop5_double.p3d","ca\buildings\dum_olez_istan2_maly.p3d","ca\buildings\kulna.p3d","ca\buildings\shop5_short.p3d","ca\buildings\dum_istan3_hromada.p3d","ca\buildings\dum_istan2_04a.p3d","ca\buildings\shop2_double.p3d","ca\desert2\build\r_minaret.p3d","ca\buildings\shop3.p3d","ca\buildings\shop4.p3d","ca\buildings\shop5.p3d","ca\buildings\shop3_short.p3d","ca\buildings\shop1.p3d","ca\buildings\dum_istan2_02.p3d","ca\buildings\shop2.p3d","ca\buildings\misc\stanek_1.p3d","ca\buildings\misc\stanek_1b.p3d","ca\buildings\misc\stanek_1c.p3d","ca\buildings\misc\stanek_2b.p3d","ca\buildings\misc\stanek_2.p3d","ca\buildings\watertower1.p3d","ca\buildings\garaz_mala.p3d"];
ALIVE_civilianMarineBuildingTypes = ALIVE_civilianMarineBuildingTypes + ["ca\buildings\majak2.p3d","ca\buildings\majak_podesta.p3d"];
ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + ["ca\buildings\garaz.p3d","ca\buildings\hut_old02.p3d"];
};
