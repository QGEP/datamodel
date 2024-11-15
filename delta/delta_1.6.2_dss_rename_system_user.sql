-- noop delta, used only to unambigously define the datamodel version
ALTER TABLE qgep_od.mutation 
RENAME COLUMN system_user to user_system;

UPDATE qgep_sys.dictionary_od_field
SET field_name = 'user_system'
WHERE attribute_id = 5532;

UPDATE qgep_sys.dictionary_od_field
SET field_name_en = 'user_system'
WHERE attribute_id = 5532;