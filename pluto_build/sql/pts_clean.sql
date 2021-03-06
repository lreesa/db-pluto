-- create table with target field names
DROP TABLE IF EXISTS dof_pts_propmaster;
CREATE TABLE dof_pts_propmaster (
	BBL text,
	BORO text,
	TB text,
	TL text,
	STREET_NAME text,
	HOUSENUM_LO text,
	HOUSENUM_HI text,
	APTNO text,
	ZIP text,
	BLDGCL text,
	EASE text,
	OWNER text, 
	LAND_AREA text,
	GROSS_SQFT text,
	RESIDAREA text,
	OFFICEAREA text,
	RETAILAREA text,
	GARAGEAREA text,
	STORAGEAREA text,
	FACTORYAREA	text,
	OTHERAREA text,
	BLDGS text,
	STORY text,
	COOP_APTS text,
	UNITS text,
	LFFT text,
	LDFT text,
	BFFT text,
	BDFT text,
	EXT text,
	IRREG text,
	CURAVL_ACT text,
	CURAVT_ACT text,
	CUREXT_ACT text,
	YRBUILT text,
	YRALT1 text,
	YRALT2 text,
	CONDO_NUMBER text,
	AP_BORO text,
	AP_BLOCK text,
	AP_LOT text,
	AP_EASE text,
	AP_DATE text,
	PRIMEBBL text);
-- insert unique ids
INSERT INTO dof_pts_propmaster (BBL)
SELECT DISTINCT parid FROM pluto_pts;
-- insert values
UPDATE dof_pts_propmaster a
SET BORO = b.boro,
	TB = block,
	TL = lot,
	STREET_NAME = b.street_name,
	HOUSENUM_LO = b.housenum_lo,
	HOUSENUM_HI = b.housenum_hi,
	APTNO = b.aptno,
	ZIP = zip_code,
	BLDGCL = bldg_class,
	EASE = b.ease,
	OWNER = av_owner,
	LAND_AREA = REPLACE(b.land_area, '+', '')::double precision,
	GROSS_SQFT = REPLACE(b.gross_sqft, '+', '')::double precision,
	RESIDAREA = REPLACE(residential_area_gross, '+', '')::double precision,
	OFFICEAREA = REPLACE(office_area_gross, '+', '')::double precision,
	RETAILAREA = REPLACE(retail_area_gross, '+', '')::double precision,
	GARAGEAREA = REPLACE(garage_area, '+', '')::double precision,
	STORAGEAREA = REPLACE(storage_area_gross, '+', '')::double precision,
	FACTORYAREA	= REPLACE(factory_area_gross, '+', '')::double precision,
	OTHERAREA = REPLACE(other_area_gross, '+', '')::double precision,
	BLDGS = REPLACE(num_bldgs, '+', '')::double precision,
	STORY = REPLACE(bld_story, '+', '')::double precision,
	COOP_APTS = REPLACE(b.coop_apts, '+', '')::double precision,
	UNITS = REPLACE(b.units, '+', '')::double precision,
	LFFT = REPLACE(lot_frt, '+', '')::double precision,
	LDFT = REPLACE(lot_dep, '+', '')::double precision,
	BFFT = REPLACE(bld_frt, '+', '')::double precision,
	BDFT = REPLACE(bld_dep, '+', '')::double precision,
	EXT = bld_ext,
	IRREG = lot_irreg,
	CURAVL_ACT = REPLACE(pyactland, '+', '')::double precision,
	CURAVT_ACT = REPLACE(pyacttot, '+', '')::double precision,
	CUREXT_ACT = REPLACE(pyactextot, '+', '')::double precision,
	YRBUILT = b.yrbuilt,
	YRALT1 = b.yralt1,
	YRALT2 = b.yralt2,
	CONDO_NUMBER = b.condo_number,
	AP_BORO = appt_boro,
	AP_BLOCK = appt_block,
	AP_LOT = appt_lot,
	AP_EASE = appt_ease,
	AP_DATE = appt_date
FROM pluto_pts b
WHERE a.bbl::text=b.parid::text;