UNDEFINE LOGDIR
UNDEFINE RESPFILE
DEFINE LOGDIR = 'c:'
DEFINE RESPFILE = '&1'
--CLEAR SCREEN
SET VERIFY OFF
--
@@undef.sql
--
@@versions.sql
--
PROMPT 
PROMPT update_mapi.sql
PROMPT 
PROMPT Run from SQL*Plus to update MAPI
PROMPT 
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
PROMPT Loading response file: &&RESPFILE
PROMPT 
@@&&RESPFILE
--
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
PROMPT Checking connection &&MAPI_USER @ &&DB_NAME
PROMPT
CONNECT &&MAPI_USER/&&MAPI_PASS@&&DB_NAME
PROMPT
PROMPT Checking connection &&MAPI_LOG_USER @ &&DB_NAME
PROMPT
CONNECT &&MAPI_LOG_USER/&&MAPI_LOG_PASS@&&DB_NAME
--
-- start spooling
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Starting spool file
PROMPT
SPOOL &&LOGDIR./mapi_update__&&CLIENT_VERSION._&&DB_NAME..lst
--
-- Get on with it!
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MAPI Schema DDL
PROMPT
--
CONNECT &&MAPI_USER/&&MAPI_PASS@&&DB_NAME
SET SERVEROUTPUT ON SIZE 1000000
SET trimout ON
SET trimspool ON
--
-- SET DEFINE OFF
--
SET DEFINE OFF
--
-- Apply MAPI DDL patch scripts
--
@@update_mapi_ddl.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
--
-- done
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Purge Recycle Bin (for Oracle 10g only... ignored on Oracle 9i)
PROMPT
purge recyclebin;
PROMPT ... Done.
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MAPI LOG Schema DDL
PROMPT
--
CONNECT &&MAPI_LOG_USER/&&MAPI_LOG_PASS@&&DB_NAME
SET SERVEROUTPUT ON SIZE 1000000
SET trimout ON
SET trimspool ON
--
-- SET DEFINE OFF
--
SET DEFINE OFF
--
-- Apply MAPI LOG DDL patch scripts
--
@@update_mapi_log_ddl.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
--
-- done
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Purge Recycle Bin (for Oracle 10g only... ignored on Oracle 9i)
PROMPT
purge recyclebin;
PROMPT ... Done.
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MAPI Schema PL/SQL and compile
PROMPT
--
CONNECT &&MAPI_USER/&&MAPI_PASS@&&DB_NAME
SET SERVEROUTPUT ON SIZE 1000000
SET trimout ON
SET trimspool ON
--
-- SET DEFINE OFF
--
SET DEFINE OFF
--
-- Apply MAPI PLSQL patch scripts
--
@@update_mapi_plsql.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
--
-- compile
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Compile PL/SQL objects
PROMPT
PROMPT Pass #1
PROMPT
@@compile.sql
PROMPT
PROMPT Pass #2
PROMPT
@@compile.sql
PROMPT
PROMPT Pass #3
PROMPT
@@compile.sql
PROMPT
PROMPT Pass #4
PROMPT
@@compile.sql
PROMPT
--
-- done
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MAPI DML
PROMPT
--
CONNECT &&MAPI_USER/&&MAPI_PASS@&&DB_NAME
SET SERVEROUTPUT ON SIZE 1000000
SET trimout ON
SET trimspool ON
--
-- SET DEFINE OFF
--
SET DEFINE OFF
--
-- MAPI DML patch scripts
--
@@update_mapi_dml.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
--
-- COMMIT
--
COMMIT;
--
-- done
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MAPI LOG DML
PROMPT
--
CONNECT &&MAPI_LOG_USER/&&MAPI_LOG_PASS@&&DB_NAME
SET SERVEROUTPUT ON SIZE 1000000
SET trimout ON
SET trimspool ON
--
-- SET DEFINE OFF
--
SET DEFINE OFF
--
-- Apply MAPI LOG DML patch scripts
--
@@update_mapi_log_dml.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
--
-- COMMIT
--
COMMIT;
--
-- done
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Logfile is &&LOGDIR./mapi_update__&&CLIENT_VERSION._&&DB_NAME..lst
PROMPT End of update. Have a nice day!
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
@@undef.sql
--
SPOOL OFF
--
UNDEFINE LOGDIR
UNDEFINE RESPFILE
EXIT
