UPDATE qgep_sys.dictionary_od_field dof
SET field_name_de = 'Datenlieferant'

WHERE dof.field_name_en = 'provider';
