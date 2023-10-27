--
-- lock.sql - locks the Dragon users
--
CONNECT &&DBA_USER/&&DBA_PASS@&&DB_NAME

ALTER USER &&MD_USER ACCOUNT LOCK;
ALTER USER &&ST_USER ACCOUNT LOCK;

DISCONNECT
--
-- done
--
