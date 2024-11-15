-- noop delta, used only to unambigously define the datamodel version

UPDATE qgep_sys.dictionary_od_table
SET shortcut_en = 'CH'
WHERE id = 38;
