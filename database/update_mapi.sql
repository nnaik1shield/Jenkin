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
PROMPT *** You will now be prompted for these parameters interactively
PROMPT ***
--
PROMPT
PROMPT Enter the MAPI schema username (<ENTER> = &&FROM_MAPI_USER), or CTRL-C to quit:
ACCEPT MAPI_USER CHAR DEFAULT '&&FROM_MAPI_USER' PROMPT '--> '
PROMPT Using: &&MAPI_USER
--
PROMPT
PROMPT Enter the MAPI schema password (<ENTER> = &&MAPI_USER), or CTRL-C to quit:
PROMPT NOTE: the password will NOT display on the screen
ACCEPT MAPI_PASS CHAR DEFAULT '&&MAPI_USER' PROMPT '--> ' HIDE
--
PROMPT
PROMPT Enter the MAPI LOG schema username (<ENTER> = &&FROM_MAPI_LOG_USER), or CTRL-C to quit:
ACCEPT MAPI_LOG_USER CHAR DEFAULT '&&FROM_MAPI_LOG_USER' PROMPT '--> '
PROMPT Using: &&MAPI_LOG_USER
--
PROMPT
PROMPT Enter the MAPI LOG schema password (<ENTER> = &&MAPI_LOG_USER), or CTRL-C to quit:
PROMPT NOTE: the password will NOT display on the screen
ACCEPT MAPI_LOG_PASS CHAR DEFAULT '&&MAPI_LOG_USER' PROMPT '--> ' HIDE
--
PROMPT
PROMPT Enter the database instance name (<ENTER> = DRAGON), or CTRL-C to quit:
ACCEPT DB_NAME CHAR DEFAULT 'DRAGON' PROMPT '--> '
PROMPT Using: &&DB_NAME
--
PROMPT
PROMPT Enter the folder to use for the log files (<ENTER> = &&LOGDIR), or CTRL-C to quit:
ACCEPT LOGDIR CHAR DEFAULT '&&LOGDIR' PROMPT '--> '
PROMPT Using: &&LOGDIR
--
PROMPT
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
-- Are you sure?
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Logfile is &&LOGDIR./dragon_&&MAPI_USER._&&DB_NAME._&&MAPI_VERSION..lst
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
SPOOL &&LOGDIR./dragon_&&MAPI_USER._&&DB_NAME._&&MAPI_VERSION..lst
--
-- Get on with it!
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MAPI Schema DDL
PROMPT
--
CONNECT &&MAPI_USER/&&MAPI_PASS@&&DB_NAME
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
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
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MAPI LOG Schema DDL
PROMPT
--
CONNECT &&MAPI_LOG_USER/&&MAPI_LOG_PASS@&&DB_NAME
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
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
@@purge_recyclebin.sql
--
DISCONNECT
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update MAPI Schema PL/SQL and compile
PROMPT
--
CONNECT &&MAPI_USER/&&MAPI_PASS@&&DB_NAME
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
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
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
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
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
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
-- update the MAPI_VERSION table
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Update the MAPI_VERSION table
PROMPT
--
CONNECT &&MAPI_USER/&&MAPI_PASS@&&DB_NAME
show user
SET SERVEROUTPUT ON SIZE UNLIMITED
SET trimout ON
SET trimspool ON
--
DECLARE
    v_id mapi_version.mapi_version_id%TYPE;
    v_designer_version_label mapi_version.designer_version_label%TYPE;
    v_deployer_version_label mapi_version.deployer_version_label%TYPE;    
BEGIN
    SELECT mapi_version_id + 1, designer_version_label, deployer_version_label
      INTO v_id, v_designer_version_label, v_deployer_version_label
      FROM mapi_version
     WHERE mapi_version_id = (SELECT MAX(mapi_version_id) FROM mapi_version);
      
    INSERT INTO mapi_version(
        mapi_version_id,
        mapi_version_label,
        designer_version_label,
        deployer_version_label,
        mapi_version_desc,
        mapi_deploy_date
    ) VALUES (
        v_id,
        SUBSTR('&&MAPI_VERSION',INSTR('&&MAPI_VERSION','v')+1),
        v_designer_version_label,
        v_deployer_version_label,
        'Update to &&MAPI_VERSION',
        sysdate);
END;
/
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
PAUSE
EXIT
