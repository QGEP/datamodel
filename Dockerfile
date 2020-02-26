FROM python:3.7-buster

RUN apt-get update
RUN apt-get install -y postgresql-client wget

ARG DATAMODEL_VERSION=1.4.0

# get releases of schema only / demo data (db: qgep)
RUN mkdir /data
RUN wget https://github.com/QGEP/datamodel/releases/download/${DATAMODEL_VERSION}/qgep_v${DATAMODEL_VERSION}_structure_with_value_lists.sql -O /data/structure.sql
RUN wget https://github.com/QGEP/datamodel/releases/download/${DATAMODEL_VERSION}/qgep_v${DATAMODEL_VERSION}_structure_and_demo_data.backup -O /data/demo_data.backup

# add deps
ADD requirements.txt .
RUN pip3 install nose
RUN pip3 install -r ./requirements.txt

# Add source
ADD . /src
WORKDIR /src

# Configure the postgres connections
RUN printf '[qgep_release]\nhost=postgis\nport=5432\ndbname=qgep_release\nuser=postgres\n' >> ~/.pg_service.conf
RUN printf '[qgep_release_struct]\nhost=postgis\nport=5432\ndbname=qgep_release_struct\nuser=postgres\n' >> ~/.pg_service.conf
RUN printf '[qgep_build]\nhost=postgis\nport=5432\ndbname=qgep_build\nuser=postgres\n' >> ~/.pg_service.conf
RUN printf '[qgep_build_pum]\nhost=postgis\nport=5432\ndbname=qgep_build_pum\nuser=postgres\n' >> ~/.pg_service.conf

RUN chmod +x /src/docker-entrypoint.sh

ENTRYPOINT ["/src/docker-entrypoint.sh"]
CMD [""]
