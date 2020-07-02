-- Fix missing ON DELETE CASCADE statement on network view

ALTER TABLE qgep_network.segment DROP CONSTRAINT segment_ne_id_fkey;
ALTER TABLE qgep_network.segment ADD CONSTRAINT segment_ne_id_fkey
  FOREIGN KEY (ne_id) REFERENCES qgep_od.wastewater_networkelement(obj_id) ON DELETE CASCADE;
