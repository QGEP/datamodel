
## About
These script are used to migrate from former model versions to version 1.0? a.k.a table dispatch (see https://github.com/QGEP/datamodel/pull/61)

## How-to
The logic behind the migration is:

1. Make a copy of the original DB containing QGEP schema (`CREATE DATABASE new WITH TEMPLATE old`)
2. Init QGEP with its new schema within the new DB (hence former `qgep` schema will be along with new `qgep_sys`, `qgep_vl`, `qgep_od` schemas)
3. Copy data from `qgep`schema to the new ones.
 
To perform the migration:

1. Adapt the script `migrate_dispatch.sh` and define source and destination PG services and databases.
2. Run the script.
  
## Things which are handled

* Every table in qgep schema has its content copied to new schemas, except:
  * for `qgep_sys` destination schema, only `logged_actions` is copied
  * for value lists, only ones with code > 10000 (user defined) are copied
* Some former model updates are automatically handled by the script:
  * table renames
  * column renames and addition (missing in former models)
  * sequences rename
  * missing language support
  * these changes are performed wisely: they are only applied after checking if the latest version cannot be found
* If a table present in former schema doesn't have its correspondance in new schemas, a WARNING is thrown for value list and an ERROR for any other type of tables.
* Sequences are updated from former schema.
  
## Things which are **NOT** handled or should be considered
* If some fields are too long (varchar columns were extended in former schema).
* Former `qgep` schema is kept in the new DB, it would need to be removed afterwards.
* This migration will break history in logged_actions, this would require patching data in the logged actions.
 
## Technical details
* table renames
  * hydraulic_characteristic_data to hydraulic_char_data
  * overflow_characteristic_kind_overflow_characteristic to overflow_char_kind_overflow_characteristic
  * overflow_characteristic_overflow_characteristic_digital to overflow_char_overflow_characteristic_digital
* column renames
  * in table catchment_area_text, fk_catchment to fk_catchment_area
  * in tables hq_relation, hydraulic_char_data and overflow: fk_overflow_char to fk_overflow_characteristic
* columns addition (missing in former models)
  * in table txt_symbol, skip fk_wastewater_structure
  * in table txt_text, skip fk_wastewater_structure, fk_catchment_area, fk_reach
* missing language support
  * skip Italian columns in value lists
