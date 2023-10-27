spool /home/oracle/scripts/DataValidationObjectvsDataMart/sqlfiles/dr_data_reconcile_dm_history.sql
set line 300
set echo off
set feedback off
set head off
set sqlb on
Select
	'insert into dr_data_reconcile_dm_history '||
	'(as_of_date, table_name, dragon_row_count, object_count, missing_rows, additional_rows, difference)'||
	'values (to_date('''||to_char(as_of_date, 'mm/dd/yyyy')||''',''mm/dd/yyyy'')' ||','||
	''''||table_name||''','||
	dragon_row_count||','||
	object_count||','||
	missing_rows||','||
	additional_rows||','||
	difference||');' inst
from
	dr_data_reconcile_dm_history;

prompt commit;;
spool off
set echo on
set feedback on
set head on
set sqlb off


