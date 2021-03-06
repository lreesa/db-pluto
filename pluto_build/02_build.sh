#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi
if [ -f version.env ]
then
  export $(cat version.env | sed 's/#.*//g' | xargs)
fi

echo "\nStarting to build PLUTO ... \e[32m"
psql $BUILD_ENGINE -f sql/preprocessing.sql
psql $BUILD_ENGINE -f sql/pts_clean.sql
psql $BUILD_ENGINE -c "DROP TABLE pluto_pts;"
psql $BUILD_ENGINE -f sql/create_rpad_geo.sql

echo '\nReporting records that did not get geocoded... \e[32m'
psql $BUILD_ENGINE -f sql/geocode_notgeocoded.sql

echo '\nMaking DCP edits to RPAD... \e[32m'
psql $BUILD_ENGINE -f sql/zerovacantlots.sql
psql $BUILD_ENGINE -f sql/lotarea.sql
psql $BUILD_ENGINE -f sql/primebbl.sql
psql $BUILD_ENGINE -f sql/apdate.sql

echo '\nCreating table that aggregates condo data and is used to build PLUTO... \e[32m'
psql $BUILD_ENGINE -f sql/create_allocated.sql
psql $BUILD_ENGINE -f sql/yearbuiltalt.sql

echo '\nCreating base PLUTO table \e[32m'
psql $BUILD_ENGINE -v version=$VERSION -f sql/create.sql
psql $BUILD_ENGINE -f sql/bbl.sql

echo '\nAdding on RPAD data attributes \e[32m'
psql $BUILD_ENGINE -f sql/allocated.sql

echo '\nAdding on spatial data attributes \e[32m'
psql $BUILD_ENGINE -f sql/geocodes.sql
# clean up numeric fields
psql $BUILD_ENGINE -f sql/numericfields.sql
psql $BUILD_ENGINE -f sql/condono.sql

echo '\nAdding on CAMA data attributes \e[32m'
psql $BUILD_ENGINE -f sql/landuse.sql
psql $BUILD_ENGINE -f sql/create_cama_primebbl.sql
psql $BUILD_ENGINE -c "DROP TABLE pluto_input_cama_dof;"

psql $BUILD_ENGINE -f sql/cama_bsmttype.sql
psql $BUILD_ENGINE -f sql/cama_lottype.sql
psql $BUILD_ENGINE -f sql/cama_proxcode.sql
psql $BUILD_ENGINE -f sql/cama_bldgarea_1.sql
psql $BUILD_ENGINE -f sql/cama_bldgarea_2.sql
psql $BUILD_ENGINE -f sql/cama_bldgarea_3.sql
psql $BUILD_ENGINE -f sql/cama_bldgarea_4.sql
psql $BUILD_ENGINE -f sql/cama_easements.sql
psql $BUILD_ENGINE -c "DROP TABLE pluto_input_geocodes;"

echo '\nAdding on data attributes from other sources \e[32m'
psql $BUILD_ENGINE -f sql/lpc.sql
psql $BUILD_ENGINE -f sql/edesignation.sql
psql $BUILD_ENGINE -f sql/ownertype.sql

echo '\nTransform RPAD data attributes \e[32m'
psql $BUILD_ENGINE -f sql/irrlotcode.sql

echo '\nAdding DCP data attributes \e[32m'
psql $BUILD_ENGINE -f sql/address.sql

echo '\nCreate base DTM \e[32m'
psql $BUILD_ENGINE -f sql/dedupecondotable.sql
psql $BUILD_ENGINE -f sql/dtmmergepolygons.sql
psql $BUILD_ENGINE -f sql/plutogeoms.sql
psql $BUILD_ENGINE -f sql/geomclean.sql
psql $BUILD_ENGINE -f sql/shorelineclip.sql
psql $BUILD_ENGINE -f sql/spatialindex.sql

echo '\nComputing zoning fields \e[32m'
psql $BUILD_ENGINE -f sql/zoning_create_priority.sql
psql $BUILD_ENGINE -f sql/zoning_zoningdistrict_create.sql
psql $BUILD_ENGINE -f sql/zoning_zoningdistrict.sql
psql $BUILD_ENGINE -f sql/zoning_commercialoverlay.sql
psql $BUILD_ENGINE -f sql/zoning_specialdistrict.sql
psql $BUILD_ENGINE -f sql/zoning_limitedheight.sql
psql $BUILD_ENGINE -f sql/zoning_zonemap.sql
psql $BUILD_ENGINE -f sql/zoning_parks.sql
psql $BUILD_ENGINE -f sql/zoning_correctdups.sql
psql $BUILD_ENGINE -f sql/zoning_correctgaps.sql
psql $BUILD_ENGINE -f sql/zoning_splitzone.sql
psql $BUILD_ENGINE -c "DROP TABLE dof_dtm;"

echo '\nFilling in FAR values \e[32m'
psql $BUILD_ENGINE -f sql/far.sql

echo '\nPopulating building class for condos lots and land use field \e[32m'
psql $BUILD_ENGINE -f sql/bldgclass.sql
psql $BUILD_ENGINE -f sql/landuse.sql

echo '\nAdding in geometries that are in the DTM but not in RPAD'
psql $BUILD_ENGINE -f sql/dtmgeoms.sql
psql $BUILD_ENGINE -f sql/geomclean.sql

echo '\nFlagging tax lots within the FEMA floodplain \e[32m'
psql $BUILD_ENGINE -f sql/latlong.sql
psql $BUILD_ENGINE -f sql/flood_flag.sql
echo '\nAssigning political values with spatial join \e[32m'
psql $BUILD_ENGINE -f sql/spatialjoins.sql
psql $BUILD_ENGINE -f sql/spatialjoins_centroid.sql
# clean up numeric fields
psql $BUILD_ENGINE -f sql/numericfields_geomfields.sql
psql $BUILD_ENGINE -f sql/sanitboro.sql
psql $BUILD_ENGINE -f sql/latlong.sql

echo '\nPopulating PLUTO tags and version fields \e[32m'
psql $BUILD_ENGINE -v ON_ERROR_STOP=1 -f sql/plutomapid.sql
psql $BUILD_ENGINE -c "VACUUM ANALYZE pluto;" & 
psql $BUILD_ENGINE -c "VACUUM ANALYZE dof_shoreline_subdivide;"
psql $BUILD_ENGINE -v ON_ERROR_STOP=1 -f sql/plutomapid_1.sql
psql $BUILD_ENGINE -v ON_ERROR_STOP=1 -f sql/plutomapid_2.sql

echo '\nBackfilling'
psql $BUILD_ENGINE -v ON_ERROR_STOP=1 -f sql/backfill.sql

echo '\nDone'
exit 0