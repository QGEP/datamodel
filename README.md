[![Build Status](https://travis-ci.org/QGEP/datamodel.svg?branch=master)](https://travis-ci.org/QGEP/datamodel)

The QGEP Datamodel
==================

This repository contains a bare QGEP datamodel. This is an SQL implementation
of the VSA-DSS datamodel (including SIA405 Waste water). It ships with SQL scripts required
to setup an empty PostgreSQL/PostGIS database to use as basis for the QGEP
project.

The latest release can be downloaded here: https://github.com/QGEP/datamodel/releases/

Ordinary data tables (qgep\_od.)
---------------------------

These tables contain the business data. In these tables the information which
is maintained by organizations can be found.

Value Lists (qgep\_vl.)
------------------

These tables contain value lists which are referenced by qgep_od. tables. The value
lists contain additional information in different languages about the values.

Information Schema (qgep\_sys.is\_)
-------------------------

These tables contain meta information about the schema.

Views (vw\_)
------------

The VSA-DSS model is built in an object relational way. Its PostgreSQL
implementation does not make use of object inheritance and instead uses a pure
relational approach. For base classes (like od\_wastewater\_structure) there
are multiple child classes (like qgep\_od.manhole or gep\_od.special\_structure) which
are linked with the same `obj_id` to the parent object.

For easier usage views are provided which give access to the merged attributes
of child and parent classes. These views are prefixed with `vw_` and all come
with INSERT, UPDATE and DELETE rules which allow changing data directly on the
view.

E.g. The view `vw_manhole` merges all the attributes of the tables `od_manhole`
and `od_wastewater_structure`.

QGEP Views (vw\_qgep\_\*)
-------------------------

These Views are handcrafted specifically for QGEP data entry. They normally
join data from various tables. They also come with INSERT, UPDATE and DELETE
rules but some attributes may be read-only (aggregated from multiple tables,
calculated otherwise).

Functions
---------

The functions are mainly used to create cached data required for symbology.
They are often triggered for changes on specific tables and then executed only
to update information on specific roles.

Installation instructions
=========================

Detailed instructions can be found in the [QGEP documentation](http://qgep.github.io/docs/).
This is only a short summary for reference.

Preparation:
------------

 * Create new database (e.g. `qgeptest`)
 * Create a service in a pg\_service definition (e.g. `pg_qgep`)

Installation:
-------------

 * `export PG_SERVICE=pg_qgep`
 * Run `scripts/db_setup.sh`

Using Docker (quickstart):
----------------

Install Docker, then run :

```bash
docker run -d --name qgep -p 5432:5432 opengisch/qgep_datamodel
```

This sets up two different databases, that should be available via `127.0.0.1:5432` with user and password `postgres` :

- *qgep_build* : the structure using installation scripts
- *qgep_prod* : the demo data (produced through successive pum migrations of initial demo data)

**WARNING** : The Docker setup is currently meant for testing purposes only.
The following instructions do not set up a correct installation (data not
persisted, no password, etc.)

Head to `.docker/README.md` for advanced usage of the QGEP Docker setup.
