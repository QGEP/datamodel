------------------------------------------
/* GRANT on schemas - once per database */
------------------------------------------

/* Viewer */
GRANT USAGE ON SCHEMA qgep_od  TO qgep_viewer;
GRANT USAGE ON SCHEMA qgep_sys TO qgep_viewer;
GRANT USAGE ON SCHEMA qgep_vl  TO qgep_viewer;
GRANT USAGE ON SCHEMA qgep_network  TO qgep_viewer;
GRANT USAGE ON SCHEMA qgep_import   TO qgep_viewer;
GRANT USAGE ON SCHEMA qgep_swmm     TO qgep_viewer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA qgep_od  TO qgep_viewer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA qgep_sys TO qgep_viewer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA qgep_vl  TO qgep_viewer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA qgep_network  TO qgep_viewer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA qgep_import   TO qgep_viewer;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA qgep_swmm     TO qgep_viewer;
GRANT SELECT, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA qgep_od  TO qgep_viewer;
GRANT SELECT, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA qgep_sys TO qgep_viewer;
GRANT SELECT, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA qgep_vl  TO qgep_viewer;
GRANT SELECT, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA qgep_network  TO qgep_viewer;
GRANT SELECT, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA qgep_import   TO qgep_viewer;
GRANT SELECT, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA qgep_swmm     TO qgep_viewer;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_od  GRANT SELECT, REFERENCES, TRIGGER ON TABLES TO qgep_viewer;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_sys GRANT SELECT, REFERENCES, TRIGGER ON TABLES TO qgep_viewer;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_vl  GRANT SELECT, REFERENCES, TRIGGER ON TABLES TO qgep_viewer;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_network  GRANT SELECT, REFERENCES, TRIGGER ON TABLES TO qgep_viewer;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_import  GRANT SELECT, REFERENCES, TRIGGER ON TABLES TO qgep_viewer;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_swmm  GRANT SELECT, REFERENCES, TRIGGER ON TABLES TO qgep_viewer;

/* User */
GRANT ALL ON SCHEMA qgep_od TO qgep_user;
GRANT ALL ON ALL TABLES IN SCHEMA qgep_od TO qgep_user;
GRANT ALL ON ALL SEQUENCES IN SCHEMA qgep_od TO qgep_user;
GRANT ALL ON ALL TABLES IN SCHEMA qgep_network TO qgep_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_od GRANT ALL ON TABLES TO qgep_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_od GRANT ALL ON SEQUENCES TO qgep_user;
GRANT ALL ON ALL TABLES IN SCHEMA qgep_import TO qgep_user;
DO $$ BEGIN EXECUTE 'GRANT CREATE ON DATABASE ' || (SELECT current_database()) || ' TO "qgep_user"'; END $$;  -- required for ili2pg imports/exports

/* Manager */
GRANT ALL ON SCHEMA qgep_vl TO qgep_manager;
GRANT ALL ON ALL TABLES IN SCHEMA qgep_vl TO qgep_manager;
GRANT ALL ON ALL SEQUENCES IN SCHEMA qgep_vl TO qgep_manager;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_vl GRANT ALL ON TABLES TO qgep_manager;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_vl GRANT ALL ON SEQUENCES TO qgep_manager;

/* SysAdmin */
GRANT ALL ON SCHEMA qgep_sys TO qgep_sysadmin;
GRANT ALL ON ALL TABLES IN SCHEMA qgep_sys TO qgep_sysadmin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA qgep_sys TO qgep_sysadmin;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_sys GRANT ALL ON TABLES TO qgep_sysadmin;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_sys GRANT ALL ON SEQUENCES TO qgep_sysadmin;

/*
-- Revoke
REVOKE ALL ON SCHEMA qgep_od  FROM qgep_viewer;
REVOKE ALL ON SCHEMA qgep_sys FROM qgep_viewer;
REVOKE ALL ON SCHEMA qgep_vl  FROM qgep_viewer;
REVOKE ALL ON ALL TABLES IN SCHEMA qgep_od  FROM qgep_viewer;
REVOKE ALL ON ALL TABLES IN SCHEMA qgep_sys FROM qgep_viewer;
REVOKE ALL ON ALL TABLES IN SCHEMA qgep_vl  FROM qgep_viewer;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_od  REVOKE ALL ON TABLES  FROM qgep_viewer;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_sys REVOKE ALL ON TABLES  FROM qgep_viewer;
ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_vl  REVOKE ALL ON TABLES  FROM qgep_viewer;
*/
