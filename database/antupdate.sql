UNDEFINE LOGDIR
UNDEFINE RESPFILE
DEFINE LOGDIR = 'c:'
DEFINE RESPFILE = '&1'
DEFINE LOGFILE = '&2'

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
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
PROMPT Alter passwords to temp
PROMPT 
@@alter_passwords_to_temp.sql
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
PROMPT Checking database connections
PROMPT 
@@check_connections.sql
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
PROMPT Logfile is: &&LOGDIR/&&LOGFILE 
PROMPT

--
-- start spooling
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Starting spool file
PROMPT
SPOOL &&LOGDIR/&&LOGFILE
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
PROMPT Purging Recycle Bin...
PROMPT
purge recyclebin;
PROMPT ... Done.
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update DAP Schema DDL
PROMPT
CONNECT &&DAP_USER/&&DAP_PASS@&&DB_NAME
SET SERVEROUTPUT ON SIZE 1000000
SET trimout ON
SET trimspool ON
--
-- SET DEFINE OFF
--
SET DEFINE OFF
SET SQLBLANKLINES ON
--
-- Apply DAP DDL patch scripts
--
@@update_dap_ddl.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
SET SQLBLANKLINES OFF
--
-- done
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Purging Recycle Bin...
PROMPT
purge recyclebin;
PROMPT ... Done.
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update ST Schema DDL
PROMPT
CONNECT &&ST_USER/&&ST_PASS@&&DB_NAME
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
exec dbms_output.put_line('Drop any Foreign keys that are in ST at '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'));
@@drop_fk.sql
--
-- done
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Purging Recycle Bin...
PROMPT
purge recyclebin;
PROMPT ... Done.
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update API Schema PL/SQL
PROMPT

CONNECT &&API_USER/&&API_PASS@&&DB_NAME
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
PROMPT Purging Recycle Bin...
PROMPT
purge recyclebin;
PROMPT ... Done.
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Bind schemas with new grants and synonyms and compile PL/SQL
PROMPT
@@bind.sql
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update DAP DML
PROMPT
CONNECT &&DAP_USER/&&DAP_PASS@&&DB_NAME
SET SERVEROUTPUT ON SIZE 1000000
SET trimout ON
SET trimspool ON
--
-- SET DEFINE OFF
--
SET DEFINE OFF
SET SQLBLANKLINES ON
--
-- Apply DAP DML patch scripts
--
@@update_dap_dml.sql
--
-- SET DEFINE ON
--
SET DEFINE ON
SET SQLBLANKLINES OFF
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MD DML
PROMPT
CONNECT &&MD_USER/&&MD_PASS@&&DB_NAME
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
exec dbms_output.put_line('Turn off XXX buttons and fields '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'));
@@turn_off_xxx_I18N.sql
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
PROMPT Alter passwords back
PROMPT 
@@alter_passwords_back.sql
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
PROMPT Checking database connections
PROMPT 
@@check_connections.sql
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Log completion of update and display final installed versions
PROMPT
@@update_completed.sql
--
PROMPT 
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Logfile is: &&LOGDIR/&&LOGFILE 
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
UNDEFINE LOGDIR
UNDEFINE RESPFILE

EXIT
