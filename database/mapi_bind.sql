--
-- mapi_bind.sql - issues grants and creates synonyms required for Dragon Designer
--

--
-- metatdata user - grant WRITE privs to MAPI
--
CONNECT &&MD_USER/&&MD_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 120
SET PAGES 200
SET trimout ON
SET trimspool ON
PROMPT
PROMPT Installing PKG_OS_GRANT for &&MD_USER
PROMPT
@@pkg_os_grant.sql
PROMPT
PROMPT Creating grants for &&MD_USER
PROMPT
SET FEEDBACK OFF
BEGIN
   PKG_OS_GRANT.grant_wr('&&MAPI_USER');
   PKG_OS_GRANT.grant_seq('&&MAPI_USER');
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
-- MAPI_LOG user - grant WRITE privs to MAPI
--
CONNECT &&MAPI_LOG_USER/&&MAPI_LOG_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 120
SET PAGES 200
SET trimout ON
SET trimspool ON
PROMPT
PROMPT Installing PKG_OS_GRANT for &&MAPI_LOG_USER
PROMPT
@@pkg_os_grant.sql
PROMPT
PROMPT Creating grants for &&MAPI_LOG_USER
PROMPT
SET FEEDBACK OFF
BEGIN
   PKG_OS_GRANT.grant_wr('&&MAPI_USER');
   PKG_OS_GRANT.grant_seq('&&MAPI_USER');
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
-- storage user - grant READ privs to MAPI
--
CONNECT &&ST_USER/&&ST_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 120
SET PAGES 200
SET trimout ON
SET trimspool ON
PROMPT
PROMPT Installing PKG_OS_GRANT for &&ST_USER
PROMPT
@@pkg_os_grant.sql
PROMPT
PROMPT Creating grants FOR &&ST_USER
PROMPT
SET FEEDBACK OFF
BEGIN
   PKG_OS_GRANT.grant_rd('&&MAPI_USER');
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
-- API user - grants to MAPI and to MD
--
CONNECT &&API_USER/&&API_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 120
SET PAGES 200
SET trimout ON
SET trimspool ON
PROMPT
PROMPT Creating grants for &&API_USER
PROMPT
--
PROMPT GRANT EXECUTE ON pkg_os_exp TO &&MAPI_USER;
GRANT EXECUTE ON pkg_os_exp TO &&MAPI_USER;
PROMPT GRANT EXECUTE ON pkg_os_exp_utility TO &&MAPI_USER;
GRANT EXECUTE ON pkg_os_exp_utility TO &&MAPI_USER;
PROMPT GRANT EXECUTE ON pkg_os_exp_validation TO &&MAPI_USER;
GRANT EXECUTE ON pkg_os_exp_validation TO &&MAPI_USER;
PROMPT GRANT EXECUTE ON pkg_os_object_search TO &&MAPI_USER;
GRANT EXECUTE ON pkg_os_object_search TO &&MAPI_USER;
PROMPT GRANT EXECUTE ON pkg_os_utility TO &&MAPI_USER;
GRANT EXECUTE ON pkg_os_utility TO &&MAPI_USER;
--
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
PROMPT
DISCONNECT
PROMPT
--
-- MAPI user - synonyms to MD and 2 grants to MD
--
CONNECT &&MAPI_USER/&&MAPI_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 120
SET PAGES 200
--
-- compile MAPI's PL/SQL
--
PROMPT =============================================================================
PROMPT Compile MAPI PL/SQL objects
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
--
PROMPT
PROMPT Creating grants for &&MAPI_USER
PROMPT
GRANT SELECT ON mapi_table TO &&MD_USER;
GRANT SELECT ON mapi_table_column TO &&MD_USER;
--
PROMPT
DISCONNECT
PROMPT
--
-- metatdata user - make 2 synonyms to MAPI and some DDL
--
--CONNECT &&MD_USER/&&MD_PASS@&&DB_NAME
--SHOW USER
--SET SERVEROUTPUT ON SIZE 1000000
--SET LINES 120
--SET PAGES 200
--PROMPT
--
--CREATE SYNONYM mapi_table FOR &&MAPI_USER..mapi_table;
--CREATE SYNONYM mapi_table_column FOR &&MAPI_USER..mapi_table_column;
--
-- some DDL
--
--@@fn_get_physical_data_type.sql
--@@physical_data_type.sql
--@@pkg_md_service.sql
--
--PROMPT
--DISCONNECT
--PROMPT
--
-- done
--
