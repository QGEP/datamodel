Docker setup for QGEP
=========================

**WARNING** : The Docker setup is currently meant for testing purposes only.
The following instructions do not set up a correct installation (data not
persisted, no password, etc.)

Normal usage
----------------

```bash
# start the postgis server
docker run -d --name qgep -p 5432:5432 opengisch/qgep_datamodel
```

This sets up two different databases, that should be available via `127.0.0.1:5432` with user and password `postgres` :

- *qgep_build* : the structure using installation scripts
- *qgep_prod* : the demo data (produced through successive pum migrations of initial demo data)

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

Docker tags (QGEP versions)
----------------

The docker image comes in multiple versions of QGEP, postgres and postgis.

By default, the first time you run the image, the version downloaded is the latest released version
of QGEP running on postgres 11, postgis 2.5.

If you need a different version, or if you prefer to explicitely define which version is being used, you
can specify the version like this (this corresponds to QGEP 1.5.0, Postgres 10, Postgis 2.5 ):
```bash
docker run -d --name qgep -p 5432:5432 opengisch/qgep_datamodel:v1.5.0-10-2.5
```

The list of all available tags can be found here : https://hub.docker.com/r/opengisch/qgep_datamodel/tags?page=1&ordering=-name

Development of the datamodel
----------------

```bash
# (re)build the image
docker build -f .docker/Dockerfile --build-arg POSTGIS_VERSION=9.6-2.5 --tag opengisch/qgep_datamodel .

# start the server
# -v mounts the source, so that changes to the datamodel don't require rebuild
# --rm delete the container when it stops (the data won't be persisted !)
docker run -d --rm -p 5432:5432 -v "$(pwd):/src" --name qgep opengisch/qgep_datamodel

# example 1: run tests on the structure/demo data database
docker exec -e PGSERVICE=qgep_build qgep pytest --ignore test/test_import.py
docker exec -e PGSERVICE=qgep_prod qgep pytest

# example 2: compare released data version 1.2.0 with freshly built structure
docker exec qgep init_qgep.sh release_struct 1.2.0
docker exec qgep init_qgep.sh build
docker exec qgep pum upgrade -t qgep_sys.pum_info -p qgep_release_struct -d delta -v int SRID 2056
docker exec qgep pum check -p1 qgep_build -p2 qgep_release_struct -v 1

# example 3: create the release files (you need to mount to /tmp volume)
docker run -d --rm -p 5432:5432 -v "${PWD}:/src" -v "${PWD}/_tmp:/tmp" --name qgep opengisch/qgep_datamodel
docker exec -e PGSERVICE=qgep_build -e TRAVIS_TAG=1.5.0 -e TRAVIS_SECURE_ENV_VARS=true qgep .deploy/create-release.py
```
