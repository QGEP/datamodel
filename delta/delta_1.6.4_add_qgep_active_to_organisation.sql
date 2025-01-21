ALTER TABLE qgep_od.organisation
ADD COLUMN qgep_active boolean DEFAULT false;
COMMENT ON COLUMN qgep_od.organisation.qgep_active IS 'Not part of the VSA-DSS data model added solely for QGEP and used to filter organisations';
