-- -- change all wkb_geometry to geom
ALTER TABLE dcp_edesignation RENAME wkb_geometry to geom;
ALTER TABLE dcas_facilities_colp RENAME wkb_geometry to geom;
ALTER TABLE lpc_historic_districts RENAME wkb_geometry to geom;
ALTER TABLE lpc_landmarks RENAME wkb_geometry to geom;
ALTER TABLE dcp_cdboundaries RENAME wkb_geometry to geom;
ALTER TABLE dcp_censustracts RENAME wkb_geometry to geom;
ALTER TABLE dcp_censusblocks RENAME wkb_geometry to geom;
ALTER TABLE dcp_school_districts RENAME wkb_geometry to geom;
ALTER TABLE dcp_councildistricts RENAME wkb_geometry to geom;
ALTER TABLE dcp_firecompanies RENAME wkb_geometry to geom;
ALTER TABLE dcp_policeprecincts RENAME wkb_geometry to geom;
ALTER TABLE dcp_healthareas RENAME wkb_geometry to geom;
ALTER TABLE dcp_healthcenters RENAME wkb_geometry to geom;
ALTER TABLE dsny_frequencies RENAME wkb_geometry to geom;
ALTER TABLE dcp_zoning_maxfar RENAME wkb_geometry to geom;
ALTER TABLE pluto_input_bsmtcode RENAME wkb_geometry to geom;
ALTER TABLE pluto_input_landuse_bldgclass RENAME wkb_geometry to geom;
ALTER TABLE pluto_input_condo_bldgclass RENAME wkb_geometry to geom;
ALTER TABLE pluto_input_geocodes RENAME wkb_geometry to geom;
ALTER TABLE dof_dtm RENAME wkb_geometry to geom;
ALTER TABLE dof_shoreline RENAME wkb_geometry to geom;
ALTER TABLE dof_condo RENAME wkb_geometry to geom;
ALTER TABLE dcp_commercialoverlay RENAME wkb_geometry to geom;
ALTER TABLE dcp_limitedheight RENAME wkb_geometry to geom;
ALTER TABLE dcp_zoningdistricts RENAME wkb_geometry to geom;
ALTER TABLE dcp_specialpurpose RENAME wkb_geometry to geom;
ALTER TABLE dcp_specialpurposesubdistricts RENAME wkb_geometry to geom;
ALTER TABLE dcp_zoningmapamendments RENAME wkb_geometry to geom;
ALTER TABLE dcp_zoningmapindex RENAME wkb_geometry to geom;
ALTER TABLE fema_firms2007_100yr RENAME wkb_geometry to geom;
ALTER TABLE fema_pfirms2015_100yr RENAME wkb_geometry to geom;
ALTER TABLE pluto_input_condolot_descriptiveattributes RENAME wkb_geometry to geom;
ALTER TABLE dcp_mappluto RENAME wkb_geometry to geom;
ALTER TABLE dcp_mih RENAME wkb_geometry to geom;
ALTER TABLE transitzones RENAME wkb_geometry to geom;
ALTER TABLE inclusionary_housing RENAME wkb_geometry to geom;
ALTER TABLE waterfront_access_plan RENAME wkb_geometry to geom;
ALTER TABLE fresh_zones RENAME wkb_geometry to geom;
ALTER TABLE coastal_zone_boundary RENAME wkb_geometry to geom;
ALTER TABLE lower_density_growth_management_areas RENAME wkb_geometry to geom;
ALTER TABLE upland_waterfront_areas RENAME wkb_geometry to geom;
ALTER TABLE appendixj_designated_mdistricts RENAME wkb_geometry to geom;
