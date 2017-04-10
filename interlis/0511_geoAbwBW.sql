-- 14.07.16 kf
-- change gemetry type in Export Schema
ALTER TABLE sia405abwasser.abwasserbauwerk DROP COLUMN detailgeometrie;
ALTER TABLE sia405abwasser.abwasserbauwerk ADD COLUMN detailgeometrie geometry(Polygon,21781);


-- Column: verlauf
ALTER TABLE sia405abwasser.haltung DROP COLUMN verlauf;
ALTER TABLE sia405abwasser.haltung ADD COLUMN verlauf geometry(LineString,21781);
