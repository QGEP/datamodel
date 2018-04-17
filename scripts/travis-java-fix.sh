#!/usr/bin/env bash

pushd /var/lib/dpkg/info
sed -i 's|JAVA_VERSION=8u162|JAVA_VERSION=8u171|' oracle-java8-installer.*
sed -i 's|PARTNER_URL=http://download.oracle.com/otn-pub/java/jdk/[^/]+/[^/]+/|PARTNER_URL=http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/|' oracle-java8-installer.*
sed -i 's|SHA256SUM_TGZ="[^"]+"|SHA256SUM_TGZ="b6dd2837efaaec4109b36cfbb94a774db100029f98b0d78be68c27bec0275982"|' oracle-java8-installer.*
sed -i 's|J_DIR=jdk1.8.0_162|J_DIR=jdk1.8.0_171|' oracle-java8-installer.*
popd
