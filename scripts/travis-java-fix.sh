cd /var/lib/dpkg/info
sed -i 's|JAVA_VERSION=8u161|JAVA_VERSION=8u171|' oracle-java8-installer.*
sed -i 's|PARTNER_URL=http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/|PARTNER_URL=http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/|' oracle-java8-installer.*
sed -i 's|SHA256SUM_TGZ="[^"]+"|SHA256SUM_TGZ="68ec82d47fd9c2b8eb84225b6db398a72008285fafc98631b1ff8d2229680257"|' oracle-java8-installer.*
sed -i 's|J_DIR=jdk1.8.0_161|J_DIR=jdk1.8.0_171|' oracle-java8-installer.*
