DEFINE PREDECESSOR_RELEASE = '&1';
set heading off;
set verify off;
SPOOL count.txt;
set echo off;
	select count (*) from installation_log i where i.CORE_VERSION = '&&PREDECESSOR_RELEASE' or i.MD_VERSION = '&&PREDECESSOR_RELEASE';
SPOOL OFF;
