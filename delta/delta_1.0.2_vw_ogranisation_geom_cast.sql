DROP VIEW IF EXISTS qgep_od.vw_organisation;

CREATE OR REPLACE VIEW qgep_od.vw_organisation AS
 SELECT
        CASE
            WHEN administrative_office.obj_id IS NOT NULL THEN 'administrative_office'::qgep_od.organisation_type
            WHEN waste_water_treatment_plant.obj_id IS NOT NULL THEN 'waste_water_treatment_plant'::qgep_od.organisation_type
            WHEN waste_water_association.obj_id IS NOT NULL THEN 'waste_water_association'::qgep_od.organisation_type
            WHEN cooperative.obj_id IS NOT NULL THEN 'cooperative'::qgep_od.organisation_type
            WHEN municipality.obj_id IS NOT NULL THEN 'municipality'::qgep_od.organisation_type
            WHEN private.obj_id IS NOT NULL THEN 'private'::qgep_od.organisation_type
            WHEN canton.obj_id IS NOT NULL THEN 'canton'::qgep_od.organisation_type
            ELSE 'organisation'::qgep_od.organisation_type
        END AS organisation_type,
    organisation.obj_id,
    organisation.identifier,
    organisation.remark,
    organisation.uid,
    organisation.last_modification,
    organisation.fk_dataowner,
    organisation.fk_provider,
        CASE
            WHEN municipality.obj_id IS NOT NULL THEN municipality.perimeter_geometry
            WHEN canton.obj_id IS NOT NULL THEN canton.perimeter_geometry
            ELSE NULL::geometry(CurvePolygon,%(SRID)s)
        END AS perimeter_geometry,
    waste_water_treatment_plant.bod5,
    waste_water_treatment_plant.cod,
    waste_water_treatment_plant.elimination_cod,
    waste_water_treatment_plant.elimination_n,
    waste_water_treatment_plant.elimination_nh4,
    waste_water_treatment_plant.elimination_p,
    waste_water_treatment_plant.installation_number,
    waste_water_treatment_plant.kind AS waste_water_treatment_plant_kind,
    waste_water_treatment_plant.nh4,
    waste_water_treatment_plant.start_year,
    municipality.altitude,
    municipality.gwdp_year,
    municipality.municipality_number,
    municipality.population,
    municipality.total_surface,
    private.kind AS private_kind
   FROM qgep_od.organisation organisation
     LEFT JOIN qgep_od.administrative_office administrative_office ON organisation.obj_id::text = administrative_office.obj_id::text
     LEFT JOIN qgep_od.waste_water_treatment_plant waste_water_treatment_plant ON organisation.obj_id::text = waste_water_treatment_plant.obj_id::text
     LEFT JOIN qgep_od.waste_water_association waste_water_association ON organisation.obj_id::text = waste_water_association.obj_id::text
     LEFT JOIN qgep_od.cooperative cooperative ON organisation.obj_id::text = cooperative.obj_id::text
     LEFT JOIN qgep_od.municipality municipality ON organisation.obj_id::text = municipality.obj_id::text
     LEFT JOIN qgep_od.private private ON organisation.obj_id::text = private.obj_id::text
     LEFT JOIN qgep_od.canton canton ON organisation.obj_id::text = canton.obj_id::text;