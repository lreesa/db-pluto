-- if a lot did not get assigned service areas through Geosupport assign service areas spatially
-- make the x /y coordinate the centroid of the lot
-- where x/ y did not come from Geosupport
UPDATE pluto a
SET xcoord = ST_X(ST_Centroid(ST_Transform(geom,2263)))
WHERE xcoord IS NULL;
UPDATE pluto a
SET ycoord = ST_Y(ST_Centroid(ST_Transform(geom,2263)))
WHERE ycoord IS NULL;

UPDATE pluto a
SET cd = b.borocd
FROM dcp_cdboundaries b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND a.cd IS NULL
AND b.geom IS NOT NULL;

UPDATE pluto a
SET ct2010 = LEFT(b.ct2010,4)||'.'||RIGHT(b.ct2010,2),
tract2010 = LEFT(b.ct2010,4)||'.'||RIGHT(b.ct2010,2)
FROM dcp_censustracts b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND (a.ct2010 IS NULL OR a.ct2010::numeric = 0)
AND b.geom IS NOT NULL;

UPDATE pluto a
SET cb2010 = b.cb2010
FROM dcp_censusblocks b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND a.cb2010 IS NULL
AND b.geom IS NOT NULL;

UPDATE pluto a
SET schooldist = b.schooldist
FROM dcp_school_districts b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND a.schooldist IS NULL
AND b.geom IS NOT NULL;

UPDATE pluto a
SET council = ltrim(b.coundist::text, '0')
FROM dcp_councildistricts b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND a.council IS NULL
AND b.geom IS NOT NULL;

UPDATE pluto a
SET firecomp = b.firecotype||lpad(b.fireconum::text,3,'0')
FROM dcp_firecompanies b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND a.firecomp IS NULL
AND b.geom IS NOT NULL;

UPDATE pluto a
SET policeprct = b.precinct
FROM dcp_policeprecincts b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND a.policeprct IS NULL
AND b.geom IS NOT NULL;

UPDATE pluto a
SET healthcenterdistrict = b.hcentdist
FROM dcp_healthcenters b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND a.healthcenterdistrict IS NULL
AND b.geom IS NOT NULL;

UPDATE pluto a
SET healtharea = b.healtharea
FROM dcp_healthareas b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND a.healtharea IS NULL
AND b.geom IS NOT NULL;

UPDATE pluto a
SET sanitdistrict = LEFT(schedulecode,3),
sanitsub = RIGHT(schedulecode,2)
FROM dsny_frequencies b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND (a.sanitsub IS NULL OR a.sanitsub = ' ')
AND b.geom IS NOT NULL;

UPDATE pluto a
SET zipcode = b.zipcode
FROM doitt_zipcodeboundaries b
WHERE a.geom&&b.geom AND ST_Within(ST_Centroid(a.geom),b.geom)
AND a.zipcode IS NULL
AND b.geom IS NOT NULL;