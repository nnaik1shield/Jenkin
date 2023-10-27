--CLEAR SCREEN
SET VERIFY OFF
--
@@undef.sql
--
@@versions.sql
--
PROMPT 
PROMPT update.sql - Run from SQL*Plus to update a Dragon installation
PROMPT 
--
-- call specified response file, or if not specified, load ask.sql
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
PROMPT Loading response file: &&RESPFILE
PROMPT 
@@&&RESPFILE
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
PROMPT Checking database connections
PROMPT 
@@check_connections.sql
--
-- Check if the predecessor release has been deployed
--
PROMPT
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Check if the predecessor release has been deployed
PROMPT
DEFINE PREDECESSOR_RELEASE = ''
@@ask_predecessor.sql
@@predecessor_check.sql
PAUSE
--
-- Display current installed versions and what version will be updated to
--
PROMPT
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Checking version information
PROMPT
@@show_versions.sql
--
-- Are you sure?
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Logfile is: &&LOGDIR./dragon_update_&&CORE_VERSION._&&CLIENT_VERSION._&&DB_NAME..lst 
PROMPT
PROMPT *** Last chance to exit before processing!
PROMPT *** (CTRL-C to exit, ENTER to UPDATE)
PAUSE
--
-- start spooling
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Starting spool file
PROMPT
SPOOL &&LOGDIR./dragon_update_&&CORE_VERSION._&&CLIENT_VERSION._&&DB_NAME..lst
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Log start of update
PROMPT
@@update_started.sql
--
-- Get on with it!
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MD Schema DDL
PROMPT
CONNECT &&MD_USER/&&MD_PASS@&&DB_NAME
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
exec dbms_output.put_line('Update to MD Schema DDL at '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'));
--
-- SET DEFINE OFF
--
SET DEFINE OFF
SET SQLBLANKLINES ON
--
-- Apply MD DDL patch scripts
--
@@update_md_ddl.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
SET SQLBLANKLINES OFF
--
-- done
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Purge Recycle Bin (for Oracle 10g only... ignored on Oracle 9i)
PROMPT
purge recyclebin;
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update ST Schema DDL
PROMPT
CONNECT &&ST_USER/&&ST_PASS@&&DB_NAME
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
exec dbms_output.put_line('Update ST Schema DDL at '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'));
--
-- SET DEFINE OFF
--
SET DEFINE OFF
SET SQLBLANKLINES ON
--
-- Apply ST DDL patch scripts
--
@@update_st_ddl.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
SET SQLBLANKLINES OFF
--
-- Drop any Foreign keys that are in ST
--
@@drop_fk.sql
--
-- done
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Purge Recycle Bin (for Oracle 10g only... ignored on Oracle 9i)
PROMPT
purge recyclebin;
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update API Schema PL/SQL
PROMPT
CONNECT &&API_USER/&&API_PASS@&&DB_NAME
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
exec dbms_output.put_line('Update API Schema PL/SQL at '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'));
--
-- SET DEFINE OFF
--
SET DEFINE OFF
SET SQLBLANKLINES ON
--
-- Apply PL/SQL patch scripts
--
@@update_api.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
SET SQLBLANKLINES OFF
--
-- done
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Purge Recycle Bin (for Oracle 10g only... ignored on Oracle 9i)
PROMPT
purge recyclebin;
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Bind schemas with new grants and synonyms and compile PL/SQL
PROMPT
@@bind.sql
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MD DML
PROMPT
CONNECT &&MD_USER/&&MD_PASS@&&DB_NAME
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
exec dbms_output.put_line('Update MD DML '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'));
--
-- SET DEFINE OFF
--
SET DEFINE OFF
SET SQLBLANKLINES ON
--
-- Apply MD DML patch scripts
--
@@update_md_dml.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
SET SQLBLANKLINES OFF
--
-- Turn off XXX buttons and fields
--
@@turn_off_xxx.sql
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
PROMPT Update ST DML
PROMPT
--
-- update_st_dml.sql
--
-- Connect to API
-- Run ST DML updates as controlled API procedures that output to SYSTEM_LOG
--
CONNECT &&API_USER/&&API_PASS@&&DB_NAME
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
exec dbms_output.put_line('Update ST DML at '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'));
--
-- SET DEFINE OFF
--
SET DEFINE OFF
SET SQLBLANKLINES ON
--
-- Apply ST DML patch scripts
--
@@update_st_dml.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
SET SQLBLANKLINES OFF
--
-- Connect to ST
-- Run the standard table truncates
--
CONNECT &&ST_USER/&&ST_PASS@&&DB_NAME
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
--
-- Note: we no longer truncate system log
--PROMPT TRUNCATE TABLE system_log;
--TRUNCATE TABLE system_log;
PROMPT TRUNCATE TABLE pr_cached_lookup_sql;
TRUNCATE TABLE pr_cached_lookup_sql;
--
-- done
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Log completion of update and display final installed versions
PROMPT
@@update_completed.sql
--
PROMPT 
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Logfile is: &&LOGDIR./dragon_update_&&CORE_VERSION._&&CLIENT_VERSION._&&DB_NAME..lst 
PROMPT End of update. Have a nice day!
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
-- end spooling
--
SPOOL OFF
--
@@undef.sql
--
PROMPT
PROMPT Press ENTER to exit...
PAUSE
EXIT
