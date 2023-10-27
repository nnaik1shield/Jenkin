--CLEAR SCREEN
SET VERIFY OFF
--
@@undef.sql
--
@@versions.sql
--
DEFINE RESPFILE = '&1'
DEFINE LOGFILE = '&2'
DEFINE MAPI_LABEL = '&3'
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
PROMPT Loading response file: &&RESPFILE
PROMPT 
@@&&RESPFILE
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
PROMPT Logfile is &&LOGFILE
PROMPT 
--
-- start spooling
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT Starting spool file &&LOGFILE
PROMPT
SPOOL &&LOGDIR/&&LOGFILE
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
purge recyclebin;
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
        v_designer_version_label,--SUBSTR('&&MAPI_VERSION',INSTR('&&MAPI_VERSION','v')+1),
        v_designer_version_label,
        v_deployer_version_label,
        'Update to &&MAPI_VERSION core &&MAPI_LABEL',
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
PROMPT Logfile is &&LOGFILE
PROMPT End of update. Have a nice day!
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
@@undef.sql
--
SPOOL OFF
--
PAUSE
EXIT
