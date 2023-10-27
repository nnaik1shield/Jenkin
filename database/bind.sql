--
-- bind.sql - issues grants and creates synonyms required for Dragon
--

--
-- metatdata user
--
SET VERIFY OFF
CONNECT &&MD_USER/&&MD_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 120
SET PAGES 200
PROMPT
PROMPT Installing PKG_OS_GRANT for &&MD_USER
PROMPT
@@pkg_os_grant.sql
PROMPT
PROMPT Creating grants for &&MD_USER
PROMPT
SET FEEDBACK OFF
BEGIN
   PKG_OS_GRANT.grant_rd('&&ST_USER');
   PKG_OS_GRANT.grant_rd('&&API_USER');
   
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
/
SET FEEDBACK ON
PROMPT
DISCONNECT
PROMPT
--
-- legacy user
--
SET VERIFY OFF
CONNECT &&LEG_USER/&&LEG_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 120
SET PAGES 200
PROMPT
PROMPT Installing PKG_OS_GRANT for &&LEG_USER
PROMPT
@@pkg_os_grant.sql
PROMPT
PROMPT Creating grants for &&LEG_USER
PROMPT
SET FEEDBACK OFF
BEGIN
   PKG_OS_GRANT.grant_rd('&&ST_USER');
   PKG_OS_GRANT.grant_rd('&&API_USER');
   
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
/
SET FEEDBACK ON
PROMPT
DISCONNECT
PROMPT
--
-- storage user
--
CONNECT &&ST_USER/&&ST_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 120
SET PAGES 200
PROMPT
PROMPT Installing PKG_OS_GRANT for &&ST_USER
PROMPT
@@pkg_os_grant.sql
PROMPT
PROMPT Creating grants and new synonyms for &&ST_USER
PROMPT
SET FEEDBACK OFF
BEGIN
   PKG_OS_GRANT.syn('&&MD_USER');
   PKG_OS_GRANT.syn('&&LEG_USER');
   PKG_OS_GRANT.grant_wr('&&API_USER');
   PKG_OS_GRANT.grant_seq('&&API_USER');
--
-- grant r/o back to MD for tool use
--
   PKG_OS_GRANT.grant_rd('&&MD_USER');
   PKG_OS_GRANT.grant_seq('&&MD_USER');
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
/
SET FEEDBACK ON
PROMPT
DISCONNECT
PROMPT
--
-- metatdata user (again)
--
CONNECT &&MD_USER/&&MD_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 120
SET PAGES 200
PROMPT
PROMPT Creating new synonyms for &&MD_USER
PROMPT
SET FEEDBACK OFF
BEGIN
   PKG_OS_GRANT.syn('&&ST_USER');
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
/
SET FEEDBACK ON
PROMPT
DISCONNECT
PROMPT
--
-- API user
--
CONNECT &&API_USER/&&API_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 120
SET PAGES 200
PROMPT
PROMPT Installing PKG_OS_GRANT for &&API_USER
PROMPT
@@pkg_os_grant.sql
PROMPT
PROMPT Creating new synonyms for &&API_USER
PROMPT
SET FEEDBACK OFF
BEGIN
   PKG_OS_GRANT.syn('&&MD_USER');
   PKG_OS_GRANT.syn('&&ST_USER');
   PKG_OS_GRANT.syn('&&LEG_USER');
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
/
SET FEEDBACK ON
PROMPT
PROMPT GRANT EXECUTE ON pkg_os_exp TO &&MD_USER;
GRANT EXECUTE ON pkg_os_exp TO &&MD_USER;
PROMPT GRANT EXECUTE ON pkg_os_exp_utility TO &&MD_USER;
GRANT EXECUTE ON pkg_os_exp_utility TO &&MD_USER;
PROMPT GRANT EXECUTE ON pkg_os_exp_validation TO &&MD_USER;
GRANT EXECUTE ON pkg_os_exp_validation TO &&MD_USER;
PROMPT GRANT EXECUTE ON pkg_os_object_search TO &&MD_USER;
GRANT EXECUTE ON pkg_os_object_search TO &&MD_USER;
PROMPT GRANT EXECUTE ON pkg_os_utility TO &&MD_USER;
GRANT EXECUTE ON pkg_os_utility TO &&MD_USER;
--
--
-- DAP_Schema_Bind.sql - issues grants and creates synonyms required for DAP
--
DISCONNECT
--
CONNECT &&DAP_USER/&&DAP_PASS@&&DB_NAME
SHOW USER
grant all on qrtz_calendars to &&API_USER;
grant all on qrtz_fired_triggers to &&API_USER;
grant all on qrtz_trigger_listeners to &&API_USER;
grant all on qrtz_blob_triggers to &&API_USER;
grant all on qrtz_cron_triggers to &&API_USER;
grant all on qrtz_simple_triggers to &&API_USER;
grant all on qrtz_triggers to &&API_USER;
grant all on qrtz_job_listeners to &&API_USER;
grant all on qrtz_job_details to &&API_USER;
grant all on qrtz_paused_trigger_grps to &&API_USER;
grant all on qrtz_locks to &&API_USER;
grant all on qrtz_scheduler_state to &&API_USER;
grant all on VW_OS_QRTZ_JOB_DETAILS to &&API_USER;
/
DISCONNECT
CONNECT &&API_USER/&&API_PASS@&&DB_NAME
SET FEEDBACK OFF
BEGIN
   PKG_OS_GRANT.syn('&&DAP_USER');
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
/
PROMPT =============================================================================
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
DISCONNECT
PROMPT
--
-- done
--
