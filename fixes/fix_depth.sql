ALTER TABLE qgep.od_cover
DROP COLUMN depth;

ALTER TABLE qgep.od_manhole
DROP COLUMN depth;

ALTER TABLE qgep.od_discharge_point
DROP COLUMN depth;

ALTER TABLE qgep.od_special_structure
DROP COLUMN depth;

ALTER TABLE qgep.od_infiltration_installation
DROP COLUMN depth;

ALTER TABLE qgep.od_wastewater_structure ADD COLUMN _depth numeric(6,3);
COMMENT ON COLUMN qgep.od_wastewater_structure._depth IS 'yyy_Funktion (berechneter Wert) = repräsentative Abwasserknoten.Sohlenkote minus zugehörige Deckenkote des Bauwerks falls Detailgeometrie vorhanden, sonst Funktion (berechneter Wert) = Abwasserknoten.Sohlenkote minus zugehörige Deckel.Kote des Bauwerks / Funktion (berechneter Wert) = repräsentative Abwasserknoten.Sohlenkote minus zugehörige Deckenkote des Bauwerks falls Detailgeometrie vorhanden, sonst Funktion (berechneter Wert) = Abwasserknoten.Sohlenkote minus zugehörige Deckel.Kote des Bauwerks / Fonction (valeur calculée) = NOEUD_RESEAU.COTE_RADIER représentatif moins COTE_PLAFOND de l’ouvrage correspondant si la géométrie détaillée est disponible, sinon fonction (valeur calculée) = NŒUD_RESEAU.COT_RADIER moins COUVERCLE.COTE de l’ouvrage correspondant';

