UNDEFINE RESPFILE
DEFINE RESPFILE = '&1'
DEFINE UN = &2

PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
PROMPT Loading response file: &&RESPFILE
PROMPT 
@@&&RESPFILE

conn sys/o5p4ss_&&UN@&&UN as SYSDBA
SET DEFINE ON
SET VERIFY OFF
SET HEADING OFF
SET FEED OFF
PROMPT Killing MD sessions
SPOOL temp_md_kill.sql
select 'alter system kill session '''||sid||','||serial#||''';' from v$session where lower(username) in lower(('&&MD_USER'));
SPOOL OFF
@temp_md_kill.sql
conn sys/o5p4ss_&&UN@&&UN as SYSDBA
SET DEFINE ON
SET VERIFY OFF
SET HEADING OFF
SET FEED OFF
PROMPT Killing ST sessions
SPOOL temp_st_kill.sql
select 'alter system kill session '''||sid||','||serial#||''';' from v$session where lower(username) in lower(('&&ST_USER'));
SPOOL OFF
@temp_st_kill.sql
conn sys/o5p4ss_&&UN@&&UN as SYSDBA
SET DEFINE ON
SET VERIFY OFF
SET HEADING OFF
SET FEED OFF
PROMPT Killing API sessions
SPOOL temp_api_kill.sql
select 'alter system kill session '''||sid||','||serial#||''';' from v$session where lower(username) in lower(('&&API_USER'));
SPOOL OFF
@temp_api_kill.sql
