DISCONNECT
CONNECT &&ST_USER/&&ST_PASS@&&DB_NAME
SET serveroutput ON SIZE 1000000
--
UPDATE installation
   SET api_version = '&&CLIENT_VERSION';
COMMIT;
--
-- done
--
DISCONNECT
