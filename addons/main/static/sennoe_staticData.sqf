private["_worldName"];
 _worldName = tolower(worldName);
 ["ALiVE SETTING UP MAP: sennoe"] call ALIVE_fnc_dump;
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
 if(tolower(_worldName) == "sennoe") then {
ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + ["a3\structures_f\mil\barracks\i_barracks_v2_dam_f.p3d","a3\structures_f\ind\shed\shed_big_f.p3d"];
ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + ["a3\structures_f\mil\barracks\i_barracks_v2_dam_f.p3d","a3\structures_f\ind\shed\shed_big_f.p3d"];
ALIVE_civilianPopulationBuildingTypes = ALIVE_civilianPopulationBuildingTypes + ["a3\structures_f\households\stone_big\i_stone_housebig_v2_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v1_f.p3d","a3\structures_f\households\house_small02\i_house_small_02_v1_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v3_f.p3d","a3\structures_f\households\slum\slum_house02_f.p3d","a3\structures_f\households\house_small01\i_house_small_01_v3_f.p3d","a3\structures_f\households\house_small02\i_house_small_02_v3_f.p3d","a3\structures_f\households\addons\i_garage_v2_f.p3d","a3\structures_f\households\house_big02\i_house_big_02_v3_f.p3d","a3\structures_f\households\house_big01\i_house_big_01_v3_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v2_f.p3d","a3\structures_f\households\stone_big\d_stone_housebig_v1_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v3_f.p3d","a3\structures_f\households\house_big01\i_house_big_01_v1_f.p3d","a3\structures_f\households\house_big02\i_house_big_02_v1_f.p3d","a3\structures_f\households\house_small01\i_house_small_01_v1_f.p3d","a3\structures_f\households\wip\unfinished_building_01_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v3_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v2_f.p3d","a3\structures_f\households\wip\unfinished_building_02_f.p3d","a3\structures_f\households\house_shop02\i_shop_02_v1_f.p3d","a3\structures_f\households\house_small01\u_house_small_01_v1_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v1_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v1_f.p3d","a3\structures_f\households\slum\slum_house03_f.p3d","a3\structures_f\households\house_shop02\i_shop_02_v2_f.p3d","a3\structures_f\households\house_shop01\i_shop_01_v3_f.p3d","a3\structures_f_argo\industrial\agriculture\barn_01_grey_f.p3d"];
ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + ["a3\structures_f\households\stone_big\i_stone_housebig_v2_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v1_f.p3d","a3\structures_f\households\house_small02\i_house_small_02_v1_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v3_f.p3d","a3\structures_f\households\slum\slum_house02_f.p3d","a3\structures_f\households\house_small01\i_house_small_01_v3_f.p3d","a3\structures_f\households\house_small02\i_house_small_02_v3_f.p3d","a3\structures_f\households\addons\i_garage_v2_f.p3d","a3\structures_f\households\house_big02\i_house_big_02_v3_f.p3d","a3\structures_f\households\house_big01\i_house_big_01_v3_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v2_f.p3d","a3\structures_f\households\stone_big\d_stone_housebig_v1_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v3_f.p3d","a3\structures_f\households\house_big01\i_house_big_01_v1_f.p3d","a3\structures_f\households\house_big02\i_house_big_02_v1_f.p3d","a3\structures_f\households\house_small01\i_house_small_01_v1_f.p3d","a3\structures_f\households\wip\unfinished_building_01_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v3_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v2_f.p3d","a3\structures_f\households\wip\unfinished_building_02_f.p3d","a3\structures_f\households\house_shop02\i_shop_02_v1_f.p3d","a3\structures_f\households\house_small01\u_house_small_01_v1_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v1_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v1_f.p3d","a3\structures_f\households\slum\slum_house03_f.p3d","a3\structures_f\households\house_shop02\i_shop_02_v2_f.p3d","a3\structures_f\households\house_shop01\i_shop_01_v3_f.p3d","a3\structures_f_argo\industrial\agriculture\barn_01_grey_f.p3d"];
ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + ["a3\structures_f\households\slum\slum_house01_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v2_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v1_f.p3d","a3\structures_f\households\house_small02\i_house_small_02_v1_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v3_f.p3d","a3\structures_f\households\slum\slum_house02_f.p3d","a3\structures_f\households\house_small01\i_house_small_01_v3_f.p3d","a3\structures_f\households\house_small02\i_house_small_02_v3_f.p3d","a3\structures_f\households\addons\i_garage_v2_f.p3d","a3\structures_f\households\house_big02\i_house_big_02_v3_f.p3d","a3\structures_f\households\house_big01\i_house_big_01_v3_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v2_f.p3d","a3\structures_f\households\stone_big\d_stone_housebig_v1_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v3_f.p3d","a3\structures_f\households\house_big01\i_house_big_01_v1_f.p3d","a3\structures_f\households\house_big02\i_house_big_02_v1_f.p3d","a3\structures_f\households\house_small01\i_house_small_01_v1_f.p3d","a3\structures_f\households\wip\unfinished_building_01_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v3_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v2_f.p3d","a3\structures_f\households\wip\unfinished_building_02_f.p3d","a3\structures_f\households\house_shop02\i_shop_02_v1_f.p3d","a3\structures_f\households\house_small01\u_house_small_01_v1_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v1_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v1_f.p3d","a3\structures_f\households\slum\slum_house03_f.p3d","a3\structures_f\households\house_shop02\i_shop_02_v2_f.p3d","a3\structures_f\households\house_shop01\i_shop_01_v3_f.p3d","a3\structures_f_argo\industrial\agriculture\barn_01_grey_f.p3d"];
ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + ["a3\structures_f\ind\transmitter_tower\tbox_f.p3d","a3\structures_f\ind\transmitter_tower\communication_f.p3d"];
ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + ["a3\structures_f\ind\fuelstation_small\fs_roof_f.p3d","a3\structures_f\ind\fuelstation_small\fs_feed_f.p3d"];
};
