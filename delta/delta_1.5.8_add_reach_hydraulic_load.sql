ALTER TABLE qgep_od.reach ADD COLUMN dss2020_hydraulic_load_current smallint;
COMMENT ON COLUMN qgep_od.reach.dss2020_hydraulic_load_current IS 'Dimensioning of the discharge divided by the normal discharge capacity of the reach [%%]. / Débit de dimensionnement divisé par la capacité d''écoulement normale de la conduite [%%].';
