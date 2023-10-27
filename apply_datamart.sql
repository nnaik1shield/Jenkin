--
-- apply_datamart.sql - define variables and apply xforms.sql
--
UNDEFINE FILE_NAME 
--
 DEFINE FILE_NAME = '&1'
-- start spooling
--
SPOOL &&FILE_NAME
--
--
-- apply datamart.sql
--
PROMPT Appling file &&FILE_NAME
@@&&FILE_NAME
--
DISCONNECT
PROMPT
--
UNDEFINE API_USER
UNDEFINE API_PASS
UNDEFINE DB_NAME 
UNDEFINE FILE_NAME 
--
-- done
--
SPOOL OFF
EXIT
