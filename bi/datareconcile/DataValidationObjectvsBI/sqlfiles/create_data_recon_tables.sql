begin			
execute immediate 'create table dr_data_reconcile_history
				(
					as_of_date date default sysdate,
					table_name varchar2(30),
					dragon_object_count number,
					bi_object_count number,
					missing_rows number,
					additional_rows number,
					difference number
				)';
exception when others
then
	if sqlcode = -00955
	then
		null;
	else
		raise;
	end if;
end;
/

--Table to store comparison metadata
begin
execute immediate 'create table dr_data_reconcile_metadata
				(
					id number primary key,
					table_name varchar2(30) unique,
					pk_column varchar2(30),
					source_sql varchar2(4000),
					source_sql_ext_condition varchar2(4000),
					dest_sql varchar2(4000),
					dm_id number,
					active_tf number default 1
				)';
exception when others
then
	if sqlcode = -00955
	then
		null;
	else
		raise;
	end if;
end;
/

begin            
execute immediate 'create unique index dr_data_reconcile_history_uk on dr_data_reconcile_history (as_of_date, table_name)';
exception when others then
    if sqlcode = -00955
    then
        null;
    else
        raise;
    end if;
end;
/
