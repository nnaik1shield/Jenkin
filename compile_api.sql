--
-- compile_api.sql - define variables and apply rules.sql
--
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT     $Workfile:   compile_api.sql  $
PROMPT     $Revision: 2427 $
PROMPT     $Date: 2014-04-29 22:32:52 +0530 (Tue, 29 Apr 2014) $
PROMPT 	   $Author: achenard $
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
UNDEFINE MD_USER 
UNDEFINE MD_PASS 
UNDEFINE API_USER
UNDEFINE API_PASS
UNDEFINE DB_NAME 
UNDEFINE ENV_NAME 
--
DEFINE ENV_NAME = '&1'
DEFINE DB_NAME = '&2'
DEFINE MD_USER = '&3'
DEFINE MD_PASS = '&4'
DEFINE API_USER = '&5'
DEFINE API_PASS = '&6'
--
-- start spooling
--
SPOOL &&ENV_NAME.log
--
-- rebuild table indexes
--
CONNECT &&MD_USER/&&MD_PASS@&&DB_NAME
alter index RULE_B1 rebuild;
alter index RULE_IIF1083 rebuild;
alter index RULE_IIF1085 rebuild;
alter index RULE_IIF1087 rebuild;
alter index RULE_IIF1098 rebuild;
alter index RULE_IIF1123 rebuild;
alter index RULE_IPK rebuild;
alter index RULE_M4 rebuild;

--
SET VERIFY OFF
CONNECT &&API_USER/&&API_PASS@&&DB_NAME
SHOW USER
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 120
SET PAGES 200
--
PROMPT =============================================================================
PROMPT Compile PL/SQL objects
PROMPT
PROMPT Pass #1 is the only one needed now
PROMPT
@@compile.sql
PROMPT
PROMPT
DISCONNECT
PROMPT
--
UNDEFINE MD_USER 
UNDEFINE MD_PASS 
UNDEFINE API_USER
UNDEFINE API_PASS
UNDEFINE DB_NAME 
UNDEFINE ENV_NAME 
--
-- done
--
SPOOL OFF
EXIT
