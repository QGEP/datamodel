Docker setup for QGEP
=========================

Normal usage
----------------

```bash
# start the postgis server
docker run -d --name qgep -p 5432:5432 opengisch/qgep_datamodel
```

This sets up two different databases, that should be available via `127.0.0.1:5432` with user and password `postgres` :

- *qgep_build* : the structure using installation scripts
- *qgep_build_pum* : the demo data (produced through successive pum migrations of initial demo data)

Reinitialization
----------------

```bash
# later on, to reinitialize all databases
docker exec qgep init_qgep.sh
# optionally, you can specify which database to reinitialize like this 
# docker exec qgep init_qgep.sh structure
```

Released data
----------------

```bash
# download and restore a specific release (with demo data) to the qgep_release database
docker exec qgep init_qgep.sh release 1.4.0
# download and restore a specific release (structure only demo data) to the qgep_release_struct database
docker exec qgep init_qgep.sh release_struct 1.4.0
```

Development of the datamodel
----------------

```bash
# (re)build the image
docker build -f .docker/Dockerfile --build-arg POSTGIS_VERSION=9.6-2.5 --tag opengisch/qgep_datamodel .

# start the server
# -v mounts the source, so that changes to the datamodel don't require rebuild
# --rm delete the container when it stops (the data won't be persisted !)
docker run -d --rm -p 5432:5432 -v "${PWD}:/src" --name qgep opengisch/qgep_datamodel

# example 1: run some tests on a built database
docker exec qgep init_qgep.sh build
docker exec -e PGSERVICE=qgep_build qgep pytest --ignore test/test_import.py

# example 2: compare released data version 1.2.0 with freshly built structure
docker exec qgep init_qgep.sh release_struct 1.2.0
docker exec qgep init_qgep.sh build
docker exec qgep pum upgrade -t qgep_sys.pum_info -p qgep_release_struct -d delta -v int SRID 2056
docker exec qgep pum check -p1 qgep_build -p2 qgep_release_struct -v 1
```
