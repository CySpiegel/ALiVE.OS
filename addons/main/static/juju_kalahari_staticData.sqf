private["_worldName"];
 _worldName = tolower(worldName);
 ["ALiVE SETTING UP MAP: juju_kalahari"] call ALIVE_fnc_dump;
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
 if(tolower(_worldName) == "juju_kalahari") then {
ALIVE_Indexing_Blacklist = ALIVE_Indexing_Blacklist + ["a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d","ca\buildings2\houseruins\r_shed_ind02.p3d","a3\structures_f_enoch\wrecks\trailercistern_wreck_f.p3d","ca\buildings2\ind_shed_01\ind_shed_01_end.p3d","ca\roads2\runwayold_40_main.p3d","a3\structures_f_enoch\military\radar\radar_01_cooler_f.p3d","a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d","a3\structures_f_exp\infrastructure\runways\runwaydigit_7_f.p3d","ca\roads2\runway_poj_t_2.p3d","a3\structures_f_exp\infrastructure\runways\runwayholdmark_23-05_f.p3d","a3\structures_f_exp\walls\stone\stonewall_01_s_10m_f.p3d","a3\structures_f_exp\commercial\market\metalshelter_01_f.p3d","a3\structures_f_exp\civilian\sheds\shed_03_f.p3d","a3\structures_f_exp\civilian\sheds\shed_06_f.p3d","a3\structures_f_exp\industrial\surfacemine_01\sm_01_shed_unfinished_f.p3d","a3\structures_f_enoch\industrial\mines\mine_01_heap_f.p3d","ca\buildings2\shed_small\shed_m02.p3d","a3\structures_f_enoch\industrial\farms\greenhouse_01_damaged_f.p3d","ca\buildings2\houseruins\r_farm_cowshed_a.p3d","a3\structures_f_enoch\wrecks\v3s_wreck_f.p3d","a3\props_f_exp\industrial\heavyequipment\combineharvester_01_wreck_f.p3d","ca\buildings2\ind_shed_02\ind_shed_02_end.p3d","ca\buildings2\farm_cowshed\farm_cowshed_c_ruins.p3d","ca\buildings2\farm_cowshed\farm_cowshed_c.p3d","ca\buildings2\farm_cowshed\farm_cowshed_c_dam.p3d","a3\structures_f_exp\civilian\sheds\shed_07_f.p3d","ca\structures_e\housea\a_stationhouse\a_stationhouse_ruins_ep1.p3d","a3\structures_f_enoch\industrial\sheds\industrialshed_01_f.p3d","a3\structures_f_exp\civilian\house_small_01\house_small_01_ruins_f.p3d","ca\structures_e\housek\terrace_k_1_r_ep1.p3d","ca\structures_e\housel\house_l_1_ruins_ep1.p3d","a3\structures_f_enoch\walls\polewalls\polewall_03_5m_v2_f.p3d","a3\structures_f_enoch\walls\stone\mound04_8m_f.p3d","a3\props_f_exp\industrial\heavyequipment\bulldozer_01_wreck_f.p3d","a3\props_f_exp\industrial\heavyequipment\excavator_01_wreck_f.p3d","a3\structures_f_exp\walls\polewalls\polewall_01_6m_f.p3d","ca\buildings2\houseruins\r_barn_metal.p3d","a3\structures_f\ind\fuelstation\fuelstation_shed_f.p3d","a3\structures_f_exp\civilian\accessories\clothesline_01_f.p3d","a3\structures_f_enoch\civilian\sheds\shed_12_f.p3d","ca\misc2\bagfenceround.p3d","a3\structures_f_exp\naval\piers\pierwooden_02_16m_f.p3d","a3\structures_f\ind\shed\shed_big_f.p3d","ca\structures_e\housek\terrace_k_1_ep1.p3d","a3\structures_f_argo\walls\city\wallcity_01_4m_grey_f.p3d","a3\structures_f_exp\commercial\addons\addon_03_f.p3d","a3\structures_f_exp\walls\bamboo\bamboofence_01_s_4m_f.p3d","a3\structures_f_exp\walls\bamboo\bamboofence_01_s_8m_f.p3d","a3\structures_f_exp\walls\bamboo\bamboofence_01_s_d_f.p3d","a3\structures_f_exp\walls\stone\stonewall_01_s_d_f.p3d","a3\structures_f_enoch\industrial\mines\mine_01_rail_track_end_f.p3d","a3\props_f_exp\industrial\heavyequipment\haultruck_01_abandoned_f.p3d","a3\structures_f_enoch\infrastructure\railways\rail_tracke_r25_5_f.p3d","a3\structures_f_enoch\infrastructure\railways\rail_tracke_25_f.p3d","a3\props_f_exp\infrastructure\railways\railwaycar_01_tank_f.p3d","a3\structures_f_enoch\infrastructure\railways\rail_track_passing_10_f.p3d","a3\structures_f_enoch\wrecks\mi8_wreck_f.p3d","a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_shed_f.p3d","a3\props_f_exp\infrastructure\railways\railwaycar_01_passenger_f.p3d","a3\structures_f_enoch\infrastructure\railways\rail_tracke_turnoutl_f.p3d"];
ALIVE_Indexing_Blacklist = ALIVE_Indexing_Blacklist + ["a3\props_f_exp\infrastructure\railways\railwaycar_01_sugarcane_f.p3d","a3\structures_f_enoch\wrecks\powergenerator_wreck_f.p3d","a3\structures_f_enoch\walls\polewalls\polewall_03_end_f.p3d"];
ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + ["a3\structures_f_enoch\military\barracks\guardtower_01_f.p3d","a3\structures_f_enoch\industrial\sawmills\sawmill_01_illuminati_tower_f.p3d","a3\structures_f_enoch\industrial\sheds\i_shed_ind_old_f.p3d","a3\structures_f_enoch\military\barracks\guardhouse_02_f.p3d","a3\structures_f_exp\military\barracks_01\barracks_01_camo_f.p3d","a3\structures_f_enoch\industrial\garages\garageoffice_01_f.p3d","a3\structures_f_enoch\industrial\garages\garagerow_01_large_f.p3d","a3\structures_f_enoch\military\airfield\controltower_02_f.p3d","a3\structures_f\ind\airport\hangar_f.p3d","a3\structures_f_enoch\military\barracks\barracks_03_f.p3d","a3\structures_f_enoch\military\barracks\controltower_01_f.p3d","a3\structures_f_enoch\military\barracks\guardtower_02_f.p3d"];
ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + ["a3\structures_f_enoch\industrial\sawmills\sawmill_01_illuminati_tower_f.p3d","a3\structures_f_enoch\industrial\sheds\i_shed_ind_old_f.p3d","a3\structures_f_enoch\industrial\garages\garagerow_01_large_f.p3d","a3\structures_f_enoch\military\barracks\controltower_01_f.p3d"];
ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + ["a3\structures_f_enoch\industrial\sheds\i_shed_ind_old_f.p3d","a3\structures_f_exp\military\barracks_01\barracks_01_camo_f.p3d"];
ALIVE_airBuildingTypes = ALIVE_airBuildingTypes + ["ca\roads2\runway_main.p3d","a3\structures_f\ind\airport\hangar_f.p3d","ca\roads2\runway_end15.p3d"];
ALIVE_militaryAirBuildingTypes = ALIVE_militaryAirBuildingTypes + ["ca\roads2\runway_main.p3d","a3\structures_f\ind\airport\hangar_f.p3d","ca\roads2\runway_end15.p3d"];
ALIVE_civilianPopulationBuildingTypes = ALIVE_civilianPopulationBuildingTypes + ["a3\structures_f_exp\civilian\slum_04\slum_04_f.p3d","ca\structures_e\misc\shed_w03_ep1.p3d","ca\structures_e\misc\shed_w02_ep1.p3d","a3\structures_f_exp\civilian\slum_01\slum_01_f.p3d","a3\structures_f_exp\civilian\slum_03\slum_03_f.p3d","a3\structures_f_exp\civilian\slum_02\slum_02_f.p3d","a3\structures_f_exp\civilian\slum_05\slum_05_f.p3d","ca\structures_e\housel\house_l_1_ep1.p3d","ca\structures_e\housel\house_l_3_ep1.p3d","ca\structures_e\housel\house_l_4_ep1.p3d","ca\structures_e\housel\house_l_7_ep1.p3d","ca\structures_e\housel\house_l_8_ep1.p3d","ca\structures_e\housel\house_l_6_ep1.p3d","ca\structures_e\housel\house_l_3_h_ep1.p3d","ca\structures_e\housel\house_l_8_dam_ep1.p3d","ca\structures_e\housel\house_l_9_ep1.p3d","ca\structures_e\misc\misc_market\market_stalls_01_ep1.p3d","a3\structures_f_exp\civilian\sheds\shed_05_f.p3d","a3\structures_f\households\slum\slum_house01_f.p3d","a3\structures_f_exp\civilian\house_small_05\house_small_05_f.p3d","a3\structures_f_exp\civilian\house_small_06\house_small_06_f.p3d","a3\structures_f_exp\civilian\house_small_01\house_small_01_f.p3d","a3\structures_f_exp\civilian\house_small_03\house_small_03_f.p3d","a3\structures_f\households\slum\slum_house02_f.p3d","a3\structures_f\households\slum\cargo_house_slum_f.p3d","ca\buildings2\farm_cowshed\farm_cowshed_a.p3d","a3\structures_f\households\wip\unfinished_building_02_f.p3d","a3\structures_f_exp\civilian\house_small_02\house_small_02_f.p3d","a3\structures_f_exp\civilian\house_big_03\house_big_03_f.p3d","a3\structures_f_exp\civilian\house_big_01\house_big_01_f.p3d","a3\structures_f_exp\cultural\church_02\church_02_f.p3d","a3\structures_f\households\house_small03\i_house_small_03_v1_dam_f.p3d","a3\structures_f_exp\civilian\house_big_05\house_big_05_f.p3d","a3\structures_f_enoch\cultural\church_04\church_04_white_f.p3d","a3\structures_f_exp\commercial\shop_town_05\shop_town_05_f.p3d","a3\structures_f_exp\commercial\shop_city_06\shop_city_06_f.p3d","a3\structures_f_exp\commercial\shop_town_01\shop_town_01_f.p3d","a3\structures_f_exp\commercial\shop_town_03\shop_town_03_f.p3d","a3\structures_f_exp\commercial\shop_town_04\shop_town_04_f.p3d","a3\structures_f_exp\civilian\garages\garageshelter_01_f.p3d","ca\structures_e\misc\misc_market\kiosk_ep1.p3d","a3\structures_f_exp\civilian\house_big_04\house_big_04_f.p3d","a3\structures_f_exp\commercial\shop_city_07\shop_city_07_f.p3d","a3\structures_f_exp\commercial\shop_city_04\shop_city_04_f.p3d","a3\structures_f_exp\commercial\shop_city_05\shop_city_05_f.p3d","a3\structures_f_exp\commercial\warehouses\warehouse_03_f.p3d","a3\structures_f_exp\commercial\multistorybuilding_01\multistorybuilding_01_f.p3d","a3\structures_f_exp\commercial\shop_city_03\shop_city_03_f.p3d","a3\structures_f_exp\commercial\shop_city_02\shop_city_02_f.p3d","a3\structures_f_exp\commercial\supermarket_01\supermarket_01_f.p3d","a3\structures_f_exp\civilian\house_big_02\house_big_02_f.p3d","a3\structures_f_exp\civilian\house_small_04\house_small_04_f.p3d","a3\structures_f_exp\commercial\shop_city_01\shop_city_01_f.p3d","a3\structures_f_exp\civilian\house_native_01\house_native_01_f.p3d","a3\structures_f\households\wip\unfinished_building_01_f.p3d"];
ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + ["ca\structures_e\housel\house_l_3_h_ep1.p3d","ca\structures_e\housel\house_l_8_dam_ep1.p3d","a3\structures_f_exp\civilian\house_small_05\house_small_05_f.p3d","a3\structures_f_exp\civilian\house_small_06\house_small_06_f.p3d","ca\buildings2\farm_cowshed\farm_cowshed_a.p3d","a3\structures_f_exp\civilian\house_big_03\house_big_03_f.p3d","a3\structures_f\households\house_small03\i_house_small_03_v1_dam_f.p3d","a3\structures_f_exp\civilian\house_big_04\house_big_04_f.p3d"];
ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + ["a3\structures_f_exp\civilian\slum_04\slum_04_f.p3d","ca\structures_e\misc\shed_w03_ep1.p3d","ca\structures_e\misc\shed_w02_ep1.p3d","a3\structures_f_exp\civilian\slum_01\slum_01_f.p3d","a3\structures_f_exp\civilian\slum_03\slum_03_f.p3d","a3\structures_f_exp\civilian\slum_02\slum_02_f.p3d","a3\structures_f_exp\civilian\slum_05\slum_05_f.p3d","ca\buildings2\shed_small\shed_m03.p3d","ca\structures_e\housel\house_l_1_ep1.p3d","ca\structures_e\housel\house_l_3_ep1.p3d","ca\structures_e\housel\house_l_4_ep1.p3d","ca\structures_e\housel\house_l_7_ep1.p3d","ca\structures_e\housel\house_l_8_ep1.p3d","ca\structures_e\housel\house_l_6_ep1.p3d","ca\structures_e\housel\house_l_3_h_ep1.p3d","ca\structures_e\housel\house_l_8_dam_ep1.p3d","ca\structures_e\housel\house_l_9_ep1.p3d","a3\structures_f_enoch\industrial\houses\workshop_05_f.p3d","ca\structures_e\misc\misc_market\market_stalls_01_ep1.p3d","a3\structures_f_exp\civilian\sheds\shed_05_f.p3d","a3\structures_f\households\slum\slum_house01_f.p3d","a3\structures_f_exp\civilian\house_small_05\house_small_05_f.p3d","ca\buildings2\shed_wooden\shed_wooden.p3d","a3\structures_f_exp\civilian\house_small_06\house_small_06_f.p3d","a3\structures_f_exp\civilian\house_small_01\house_small_01_f.p3d","a3\structures_f_exp\civilian\sheds\shed_02_f.p3d","a3\structures_f_exp\civilian\house_small_03\house_small_03_f.p3d","a3\structures_f\households\slum\slum_house02_f.p3d","a3\structures_f\households\slum\slum_house03_f.p3d","a3\structures_f\households\slum\cargo_house_slum_f.p3d","ca\buildings2\shed_small\shed_w03.p3d","ca\buildings2\farm_cowshed\farm_cowshed_a.p3d","ca\buildings2\farm_cowshed\farm_cowshed_b_dam.p3d","ca\buildings2\farm_cowshed\farm_cowshed_b.p3d","a3\structures_f_exp\commercial\market\metalshelter_02_f.p3d","ca\buildings2\barn_metal\barn_metal.p3d","ca\structures_e\misc\shed_m01_ep1.p3d","a3\structures_f\households\wip\unfinished_building_02_f.p3d","a3\structures_f_exp\civilian\house_small_02\house_small_02_f.p3d","a3\structures_f_exp\civilian\house_big_03\house_big_03_f.p3d","a3\structures_f\ind\crane\crane_f.p3d","a3\structures_f_exp\civilian\sheds\shed_01_f.p3d","a3\structures_f_exp\civilian\house_big_01\house_big_01_f.p3d","a3\structures_f_exp\cultural\church_02\church_02_f.p3d","ca\buildings2\shed_small\shed_m01.p3d","a3\structures_f\households\house_small03\i_house_small_03_v1_dam_f.p3d","a3\structures_f_exp\civilian\house_big_05\house_big_05_f.p3d","a3\structures_f_enoch\cultural\church_04\church_04_white_f.p3d","a3\structures_f_exp\commercial\shop_town_05\shop_town_05_f.p3d","a3\structures_f_exp\commercial\shop_city_06\shop_city_06_f.p3d","a3\structures_f_exp\commercial\shop_town_01\shop_town_01_f.p3d","a3\structures_f_exp\commercial\shop_town_03\shop_town_03_f.p3d","a3\structures_f_exp\commercial\shop_town_04\shop_town_04_f.p3d","a3\structures_f_exp\civilian\garages\garageshelter_01_f.p3d","a3\structures_f_enoch\industrial\farms\greenhouse_01_f.p3d","ca\structures_e\misc\misc_market\kiosk_ep1.p3d","a3\structures_f_exp\civilian\house_big_04\house_big_04_f.p3d","a3\structures_f_exp\commercial\shop_city_07\shop_city_07_f.p3d","a3\structures_f_exp\commercial\shop_city_04\shop_city_04_f.p3d","a3\structures_f_exp\commercial\shop_city_05\shop_city_05_f.p3d"];
ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + ["a3\structures_f_exp\commercial\warehouses\warehouse_03_f.p3d","a3\structures_f_exp\commercial\multistorybuilding_01\multistorybuilding_01_f.p3d","a3\structures_f_exp\commercial\shop_city_03\shop_city_03_f.p3d","a3\structures_f_exp\commercial\shop_city_02\shop_city_02_f.p3d","a3\structures_f_exp\commercial\addons\addon_05_f.p3d","a3\structures_f_exp\commercial\supermarket_01\supermarket_01_f.p3d","a3\structures_f_exp\civilian\house_big_02\house_big_02_f.p3d","a3\structures_f_exp\civilian\house_small_04\house_small_04_f.p3d","a3\structures_f_exp\commercial\shop_city_01\shop_city_01_f.p3d","a3\structures_f_exp\civilian\house_native_01\house_native_01_f.p3d","a3\structures_f\households\wip\unfinished_building_01_f.p3d","ca\buildings2\shed_small\shed_w01.p3d"];
ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + ["a3\structures_f_enoch\industrial\houses\workshop_04_f.p3d","a3\structures_f\ind\dieselpowerplant\dp_transformer_f.p3d","a3\structures_f\ind\solarpowerplant\spp_transformer_f.p3d","ca\structures_e\misc\misc_powerline\powlines_transformer1_ep1.p3d","a3\structures_f_enoch\industrial\power\powerstation_01_f.p3d"];
ALIVE_civilianCommsBuildingTypes = ALIVE_civilianCommsBuildingTypes + ["a3\structures_f_exp\military\barracks_01\barracks_01_camo_f.p3d","a3\structures_f_enoch\military\airfield\controltower_02_f.p3d","a3\structures_f_enoch\military\barracks\controltower_01_f.p3d"];
ALIVE_civilianFuelBuildingTypes = ALIVE_civilianFuelBuildingTypes + ["ca\buildings2\farm_wtower\farm_wtower.p3d","a3\structures_f_enoch\industrial\houses\waterstation_01_f.p3d"];
ALIVE_civilianConstructionBuildingTypes = ALIVE_civilianConstructionBuildingTypes + ["ca\buildings2\ind_garage01\ind_garage01.p3d","a3\structures_f_enoch\industrial\garages\garageoffice_01_f.p3d","a3\structures_f_enoch\industrial\garages\garagerow_01_large_f.p3d","ca\buildings2\barn_metal\barn_metal.p3d","a3\structures_f\households\wip\unfinished_building_02_f.p3d","a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_warehouse_f.p3d","a3\structures_f_enoch\industrial\mines\mine_01_warehouse_f.p3d"];
};
