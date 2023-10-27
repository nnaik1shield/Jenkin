--
-- unlock.sql - unlocks the Dragon users
--
CONNECT &&DBA_USER/&&DBA_PASS@&&DB_NAME

ALTER USER &&MD_USER ACCOUNT UNLOCK;
ALTER USER &&ST_USER ACCOUNT UNLOCK;

DISCONNECT
--
-- done
--
