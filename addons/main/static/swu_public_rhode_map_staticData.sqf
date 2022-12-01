private["_worldName"];
 _worldName = tolower(worldName);
 ["ALiVE SETTING UP MAP: swu_public_rhode_map"] call ALIVE_fnc_dump;
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
 if(tolower(_worldName) == "swu_public_rhode_map") then {
ALIVE_Indexing_Blacklist = ALIVE_Indexing_Blacklist + ["a3\structures_f_exp\walls\slum\slumwall_01_s_4m_f.p3d","a3\structures_f_exp\walls\slum\slumwall_01_s_2m_f.p3d","a3\structures_f_enoch\military\training\shellcrater_02_debris_f.p3d","a3\structures_f_argo\walls\military\mil_wallbig_debris_f.p3d","a3\structures_f_enoch\military\training\shellcrater_02_extralarge_f.p3d","a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d","a3\structures_f_enoch\military\training\shellcrater_02_large_f.p3d","a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d","a3\structures_f\civ\accessories\timbers_f.p3d","a3\structures_f_enoch\ruins\housewallruin_corner_02_f.p3d","a3\structures_f_enoch\ruins\housewallruin_door_01_f.p3d","a3\structures_f_enoch\ruins\housewallruin_corner_01_f.p3d","a3\props_f_enoch\industrial\supplies\woodenbox_02_f.p3d","a3\props_f_orange\furniture\sofa_01_f.p3d","a3\structures_f_argo\military\fortifications\czechhedgehog_01_f.p3d","a3\props_f_exp\naval\boats\boat_05_wreck_f.p3d","a3\structures_f_enoch\military\radar\radar_01_airshaft_f.p3d","a3\structures_f_exp\civilian\sheds\shed_07_ruins_f.p3d","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_hole_f.p3d","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_f.p3d","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d","a3\structures_f_exp\naval\piers\pierwooden_02_hut_f.p3d","a3\structures_f_heli\items\sport\football_01_f.p3d"];
ALIVE_militaryBuildingTypes = ALIVE_militaryBuildingTypes + ["a3\structures_f\mil\bagbunker\bagbunker_large_f.p3d","a3\structures_f\mil\bagbunker\bagbunker_small_f.p3d"];
ALIVE_militarySupplyBuildingTypes = ALIVE_militarySupplyBuildingTypes + ["a3\structures_f\mil\bagbunker\bagbunker_large_f.p3d","a3\structures_f\mil\bagbunker\bagbunker_small_f.p3d"];
ALIVE_militaryHQBuildingTypes = ALIVE_militaryHQBuildingTypes + ["a3\structures_f\mil\bagbunker\bagbunker_large_f.p3d","a3\structures_f\mil\bagbunker\bagbunker_small_f.p3d"];
ALIVE_civilianPopulationBuildingTypes = ALIVE_civilianPopulationBuildingTypes + ["a3\structures_f\households\slum\slum_house01_f.p3d","a3\structures_f_exp\civilian\slum_01\slum_01_f.p3d","a3\structures_f_exp\civilian\house_small_02\house_small_02_f.p3d","a3\structures_f_exp\civilian\slum_02\slum_02_f.p3d","a3\structures_f\households\slum\slum_house03_f.p3d","a3\structures_f\households\slum\cargo_house_slum_f.p3d","a3\structures_f\households\slum\slum_house02_f.p3d","a3\structures_f\households\house_big01\d_house_big_01_v1_f.p3d","a3\structures_f\households\house_small02\d_house_small_02_v1_f.p3d","a3\structures_f\households\house_big02\d_house_big_02_v1_f.p3d","a3\structures_f_argo\industrial\agriculture\shed_08_grey_f.p3d","a3\structures_f\households\house_big02\u_house_big_02_v1_f.p3d","a3\structures_f_argo\industrial\agriculture\barn_01_grey_f.p3d","a3\structures_f\households\house_small01\u_house_small_01_v1_f.p3d","a3\structures_f\households\wip\unfinished_building_02_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v2_f.p3d","a3\structures_f_exp\civilian\house_native_02\house_native_02_f.p3d","a3\structures_f_enoch\ruins\houseruin_big_05_f.p3d","a3\structures_f\households\house_shop01\u_shop_01_v1_f.p3d","a3\structures_f\households\house_big01\u_house_big_01_v1_f.p3d","a3\structures_f_enoch\ruins\houseruin_small_01_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v2_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v1_f.p3d","a3\structures_f_enoch\ruins\houseruin_small_02_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v3_dam_f.p3d","a3\structures_f\households\house_small02\u_house_small_02_v1_f.p3d","a3\structures_f\civ\chapels\chapel_v2_f.p3d","a3\structures_f_exp\civilian\house_small_05\house_small_05_ruins_f.p3d","a3\structures_f_enoch\industrial\houses\workshop_04_grey_f.p3d","a3\structures_f_exp\civilian\slum_03\slum_03_ruins_f.p3d","a3\structures_f_enoch\ruins\houseruin_small_04_f.p3d","a3\structures_f_exp\civilian\house_native_01\house_native_01_f.p3d","a3\structures_f_argo\industrial\agriculture\barn_01_grey_ruins_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v3_dam_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v1_f.p3d","a3\structures_f_exp\civilian\sheds\shed_02_f.p3d","a3\structures_f\households\house_shop01\d_shop_01_v1_f.p3d","a3\structures_f_exp\civilian\sheds\shed_06_f.p3d","a3\structures_f_exp\civilian\sheds\shed_07_f.p3d","a3\structures_f_exp\civilian\sheds\shed_03_f.p3d","a3\structures_f_exp\civilian\sheds\shed_05_f.p3d","a3\structures_f\households\house_small01\u_house_small_01_v1_dam_f.p3d","a3\structures_f_exp\civilian\house_small_04\house_small_04_ruins_f.p3d","a3\structures_f\households\wip\unfinished_building_01_f.p3d","a3\structures_f\households\addons\i_garage_v1_dam_f.p3d","a3\structures_f\households\addons\i_garage_v2_dam_f.p3d","a3\structures_f\households\house_shop01\u_shop_01_v1_dam_f.p3d"];
ALIVE_civilianHQBuildingTypes = ALIVE_civilianHQBuildingTypes + ["a3\structures_f\households\slum\slum_house01_f.p3d","a3\structures_f_exp\civilian\slum_01\slum_01_f.p3d","a3\structures_f_exp\civilian\house_small_02\house_small_02_f.p3d","a3\structures_f_exp\civilian\slum_02\slum_02_f.p3d","a3\structures_f\households\slum\slum_house03_f.p3d","a3\structures_f\households\slum\cargo_house_slum_f.p3d","a3\structures_f\households\slum\slum_house02_f.p3d","a3\structures_f\households\house_big01\d_house_big_01_v1_f.p3d","a3\structures_f\households\house_small02\d_house_small_02_v1_f.p3d","a3\structures_f\households\house_big02\d_house_big_02_v1_f.p3d","a3\structures_f_argo\industrial\agriculture\shed_08_grey_f.p3d","a3\structures_f\households\house_big02\u_house_big_02_v1_f.p3d","a3\structures_f_argo\industrial\agriculture\barn_01_grey_f.p3d","a3\structures_f\households\house_small01\u_house_small_01_v1_f.p3d","a3\structures_f\households\wip\unfinished_building_02_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v2_f.p3d","a3\structures_f_exp\civilian\house_native_02\house_native_02_f.p3d","a3\structures_f_enoch\ruins\houseruin_big_05_f.p3d","a3\structures_f\households\house_shop01\u_shop_01_v1_f.p3d","a3\structures_f\households\house_big01\u_house_big_01_v1_f.p3d","a3\structures_f_enoch\ruins\houseruin_small_01_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v2_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v1_f.p3d","a3\structures_f_enoch\ruins\houseruin_small_02_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v3_dam_f.p3d","a3\structures_f\households\house_small02\u_house_small_02_v1_f.p3d","a3\structures_f\civ\chapels\chapel_v2_f.p3d","a3\structures_f_exp\civilian\house_small_05\house_small_05_ruins_f.p3d","a3\structures_f_enoch\industrial\houses\workshop_04_grey_f.p3d","a3\structures_f_exp\civilian\slum_03\slum_03_ruins_f.p3d","a3\structures_f_enoch\ruins\houseruin_small_04_f.p3d","a3\structures_f_exp\civilian\house_native_01\house_native_01_f.p3d","a3\structures_f_argo\industrial\agriculture\barn_01_grey_ruins_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v3_dam_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v1_f.p3d","a3\structures_f_exp\civilian\sheds\shed_02_f.p3d","a3\structures_f\households\house_shop01\d_shop_01_v1_f.p3d","a3\structures_f_exp\civilian\sheds\shed_06_f.p3d","a3\structures_f_exp\civilian\sheds\shed_07_f.p3d","a3\structures_f_exp\civilian\sheds\shed_03_f.p3d","a3\structures_f_exp\civilian\sheds\shed_05_f.p3d","a3\structures_f\households\house_small01\u_house_small_01_v1_dam_f.p3d","a3\structures_f_exp\civilian\house_small_04\house_small_04_ruins_f.p3d","a3\structures_f\households\wip\unfinished_building_01_f.p3d","a3\structures_f\households\addons\i_garage_v1_dam_f.p3d","a3\structures_f\households\addons\i_garage_v2_dam_f.p3d","a3\structures_f\households\house_shop01\u_shop_01_v1_dam_f.p3d"];
ALIVE_civilianSettlementBuildingTypes = ALIVE_civilianSettlementBuildingTypes + ["a3\structures_f\households\slum\slum_house01_f.p3d","a3\structures_f_exp\civilian\slum_01\slum_01_f.p3d","a3\structures_f_exp\civilian\house_small_02\house_small_02_f.p3d","a3\structures_f_exp\civilian\slum_02\slum_02_f.p3d","a3\structures_f\households\slum\slum_house03_f.p3d","a3\structures_f\households\slum\cargo_house_slum_f.p3d","a3\structures_f\households\slum\slum_house02_f.p3d","a3\structures_f\households\house_big01\d_house_big_01_v1_f.p3d","a3\structures_f\households\house_small02\d_house_small_02_v1_f.p3d","a3\structures_f\households\house_big02\d_house_big_02_v1_f.p3d","a3\structures_f_argo\industrial\agriculture\shed_08_grey_f.p3d","a3\structures_f\households\house_big02\u_house_big_02_v1_f.p3d","a3\structures_f_argo\industrial\agriculture\barn_01_grey_f.p3d","a3\structures_f\households\house_small01\u_house_small_01_v1_f.p3d","a3\structures_f\households\wip\unfinished_building_02_f.p3d","a3\structures_f_exp\civilian\slum_05\slum_05_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v2_f.p3d","a3\structures_f_exp\civilian\house_native_02\house_native_02_f.p3d","a3\structures_f_enoch\ruins\houseruin_big_05_f.p3d","a3\structures_f\households\house_shop01\u_shop_01_v1_f.p3d","a3\structures_f\households\house_big01\u_house_big_01_v1_f.p3d","a3\structures_f_enoch\ruins\houseruin_small_01_f.p3d","a3\structures_f_exp\civilian\slum_04\slum_04_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v2_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v1_f.p3d","a3\structures_f_enoch\ruins\houseruin_small_02_f.p3d","a3\structures_f\households\stone_big\i_stone_housebig_v3_dam_f.p3d","a3\structures_f\households\house_small02\u_house_small_02_v1_f.p3d","a3\structures_f\civ\chapels\chapel_v2_f.p3d","a3\structures_f_exp\civilian\house_small_05\house_small_05_ruins_f.p3d","a3\structures_f_enoch\industrial\houses\workshop_04_grey_f.p3d","a3\structures_f_exp\civilian\slum_03\slum_03_ruins_f.p3d","a3\structures_f_exp\civilian\slum_03\slum_03_f.p3d","a3\structures_f_enoch\ruins\houseruin_small_04_f.p3d","a3\structures_f_exp\civilian\house_native_01\house_native_01_f.p3d","a3\structures_f_argo\industrial\agriculture\barn_01_grey_ruins_f.p3d","a3\structures_f_exp\cultural\church_03\church_03_f.p3d","a3\structures_f\households\stone_small\i_stone_housesmall_v3_dam_f.p3d","a3\structures_f\households\stone_shed\i_stone_shed_v1_f.p3d","a3\structures_f_exp\civilian\sheds\shed_02_f.p3d","a3\structures_f\households\house_shop01\d_shop_01_v1_f.p3d","a3\structures_f_exp\civilian\sheds\shed_06_f.p3d","a3\structures_f_exp\civilian\sheds\shed_07_f.p3d","a3\structures_f_exp\civilian\sheds\shed_03_f.p3d","a3\structures_f_exp\civilian\sheds\shed_05_f.p3d","a3\structures_f\households\house_small01\u_house_small_01_v1_dam_f.p3d","a3\structures_f_exp\civilian\house_small_04\house_small_04_ruins_f.p3d","a3\structures_f\households\wip\unfinished_building_01_f.p3d","a3\structures_f\households\addons\i_garage_v1_dam_f.p3d","a3\structures_f\households\addons\i_garage_v2_dam_f.p3d","a3\structures_f\households\house_shop01\u_shop_01_v1_dam_f.p3d"];
ALIVE_civilianPowerBuildingTypes = ALIVE_civilianPowerBuildingTypes + ["a3\structures_f_enoch\industrial\houses\waterstation_01_f.p3d","a3\structures_f\ind\transmitter_tower\tbox_f.p3d"];
};
