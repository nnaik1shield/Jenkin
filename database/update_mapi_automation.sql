--CLEAR SCREEN
SET VERIFY OFF
--
@@undef.sql
--
@@versions.sql
--
DEFINE MAPI_USER=&1
DEFINE MAPI_PASS=&2
DEFINE MAPI_LOG_USER=&3
DEFINE MAPI_LOG_PASS=&4
DEFINE DB_NAME=&5
PROMPT &MAPI_USER
PROMPT &MAPI_PASS
PROMPT &MAPI_LOG_USER
PROMPT &MAPI_LOG_PASS
PROMPT &DB_NAME
PROMPT 
PROMPT update_mapi.sql
PROMPT 
PROMPT Run from SQL*Plus to update MAPI
PROMPT 
--
PROMPT *** This script will require the following parameters to execute:
PROMPT ***
PROMPT *** - MAPI schema username
PROMPT *** - MAPI schema password
PROMPT *** - MAPI LOG schema username
PROMPT *** - MAPI LOG schema password
PROMPT *** - Oracle instance TNS name (MUST BE LISTED IN tnsnames.ora!)
PROMPT *** - Folder to use for log file output
PROMPT ***
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
SPOOL &&LOGDIR./dragon_&&MAPI_USER._&&DB_NAME._&&MAPI_VERSION..lst
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
PROMPT Logfile is &&LOGDIR./dragon_&&MAPI_USER._&&DB_NAME._&&MAPI_VERSION..lst
PROMPT End of update. Have a nice day!
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
@@undef.sql
--
SPOOL OFF
--
EXIT
