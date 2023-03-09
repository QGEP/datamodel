CREATE TABLE qgep_swmm.reach_coefficient_of_friction (fk_material integer, coefficient_of_friction smallint);

ALTER TABLE qgep_swmm.reach_coefficient_of_friction 
    ADD CONSTRAINT pkey_qgep_vl_reach_coefficient_of_friction_id PRIMARY KEY (fk_material);

INSERT INTO qgep_swmm.reach_coefficient_of_friction(fk_material) 
    SELECT vsacode 
    FROM qgep_vl.reach_material;

UPDATE qgep_swmm.reach_coefficient_of_friction 
SET coefficient_of_friction = (
    CASE 
        WHEN fk_material IN (5381,5081,3016) THEN 100
        WHEN fk_material IN (2754,3638,3639,3640,3641,3256,147,148,3648,5079,5080,153,2762) THEN 83
        WHEN fk_material IN (2755) THEN 67
        WHEN fk_material IN (5076,5077,5078,5382) THEN 111
        WHEN fk_material IN (3654) THEN 91
        WHEN fk_material IN (154,2761) THEN 71
        ELSE 100 END);