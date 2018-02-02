#!/usr/bin/env bash

find . -type f -exec gsed -i -r 's/qgep\.(od|vl|is)_/qgep_\1./g' {} \;
find . -type f -exec gsed -i -r 's/qgep\.vw_/qgep_od.vw_/g' {} \;


find . -type f -exec gsed -i -r 's/qgep_is\./qgep_sys./g' {} \;

find . -type f -exec gsed -i -r 's/qgep\.txt_/qgep_od.txt_/g' {} \;

find . -type f -exec gsed -i -r 's/qgep\.seq_txt_/qgep_od.seq_txt_/g' {} \;
find . -type f -exec gsed -i -r 's/qgep\.seq_re_/qgep_od.seq_re_/g' {} \;
find . -type f -exec gsed -i -r 's/qgep\.seq_is_/qgep_sys.seq_/g' {} \;
find . -type f -exec gsed -i -r 's/qgep\.seq_od_/qgep_od.seq_/g' {} \;
find . -type f -exec gsed -i -r 's/qgep\.seq_vl_/qgep_vl.seq_/g' {} \;

find . -type f -exec gsed -i -r 's/qgep\.(update_last_modified|update_last_modified_parent|generate_oid|audit_table|if_modified_func|create_symbology_triggers)/qgep_sys.\1/g' {} \;
find . -type f -exec gsed -i -r 's/qgep\.(\w+\()/qgep_od.\1/g' {} \;

find . -type f -exec gsed -i -r 's/\s+ON\s+(od|vl)_/ ON /g' {} \;
find . -type f -exec gsed -i -r 's/\s+=\s+(od|vl)_/ = /g' {} \;
find . -type f -exec gsed -i -r 's/\sod_/ /g' {} \;

find . -type f -exec gsed -i -r 's/qgep\.plantype/qgep_od.plantype/g' {} \;

find view -type f -exec gsed -i -r 's/qgep\./qgep_od./g' {} \;

find . -type f -exec gsed -i -r "s/generate_oid\('(od|vl)_/generate_oid('qgep_\1','/g" {} \;
find . -type f -exec gsed -i -r "s/generate_oid\('(re|txt)_/generate_oid('qgep_od','\1_/g" {} \;

find . -type f -exec gsed -i -r "s/\((od|vl)_/(/g" {} \;

find view -type f -iname "*.py" -exec gsed -i -r 's/schema: qgep/schema: qgep_od/' {} \;

gsed -i -r "s/(INSERT INTO qgep_sys.dictionary_od_table.*')(od|vl|sys)_/\1/" 09_qgep_dictionaries.sql

find . -type f -exec gsed -i -r "s/\('/('/g" {} \;
