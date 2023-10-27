set timing on
set serveroutput on size 1000000
--Process to run data validation using the dr_data_reconcile_datamart table
declare
  v_rpt_date date default trunc(sysdate);
  v_schema_prefix varchar2(30) := '%OSSCHEMA_%'; --pass this value as a parameter
  v_sql varchar2(10000);
  v_sql_frame varchar2(10000);
  v_bi_dataset varchar2(30);
  v_dragon_row_count number;
  v_object_count number;
  v_missing_rows number;
  v_additional_rows number;
  v_difference number;
begin
	v_sql_frame := '
				select
					bi_dataset,
					dragon_row_count,
					object_count,
					missing_rows,
					additional_rows,
					round((abs(dragon_row_count-object_count)/(case when dragon_row_count = 0 then 1 else dragon_row_count end)) * 100 , 2) difference
				from
				(Select
					''%DEST_TABLE%'' bi_dataset,
					sum((case when dt.%PK_COLUMN% is not null then 1 else 0 end)) dragon_row_count,
					sum((case when ro.%PK_COLUMN% is not null then 1 else 0 end)) object_count,
					sum((case when dt.%PK_COLUMN% is null and ro.%PK_COLUMN% is not null then 1 else 0 end)) missing_rows,
					sum((case when dt.%PK_COLUMN% is not null and ro.%PK_COLUMN% is null then 1 else 0 end)) additional_rows
				  from
					%API%.%DEST_TABLE% dt
				full outer join (%SOURCE_SQL%) ro
				on (dt.%PK_COLUMN% = ro.%PK_COLUMN%)
				 %IGNORE_CREATED%
				 ) ';
	for r in (select
				*
			from
				dr_data_reconcile_dm_metadata
			where
				1 = 1
			and
				active_tf = 1
			order by id
			)
	loop
	   v_sql := v_sql_frame;
	   v_sql := replace(replace(replace(v_sql, '%DEST_TABLE%', r.table_name), '%PK_COLUMN%', r.pk_column), '%SOURCE_SQL%', r.source_sql||
			  (case when r.source_sql_ext_condition is null then null else ' AND '||r.source_sql_ext_condition end));
	   v_sql := replace(v_sql,'%IGNORE_CREATED%',(case when r.dest_sql_ext_condition is null then null else 'WHERE dt.' || r.dest_sql_ext_condition end));
	   v_sql := replace(v_sql, '%API%', v_schema_prefix||'API');
	   v_sql := replace(v_sql, '%MD%', v_schema_prefix||'MD');
	   v_sql := replace(v_sql, '%SRCAPI%', user);
	   --dbms_output.put_line(v_sql);
	   begin
		   execute immediate v_sql
		   into
			   v_bi_dataset,
			   v_dragon_row_count,
			   v_object_count,
			   v_missing_rows,
			   v_additional_rows,
			   v_difference;
	   exception when others
	   then
		dbms_output.put_line ('Failed: '||sqlcode||' - '||sqlerrm||' '||v_sql);
	   end;
	   if v_bi_dataset is not null
	   then
		   merge into
			    dr_data_reconcile_dm_history rh
			using (select
					  v_rpt_date report_date,
					  v_bi_dataset table_name, 
					  v_dragon_row_count dragon_row_count,
					  v_object_count object_count,
					  v_missing_rows missing_rows,
					  v_additional_rows additional_rows,
					  v_difference difference
				  from
					  dual) stg
			on (rh.table_name = stg.table_name
			    and
			    rh.as_of_date = stg.report_date)
		  when matched
		  then
		  update
		  set
			  dragon_row_count = stg.dragon_row_count,
			  object_count = stg.object_count,
			  missing_rows = stg.missing_rows,
			  additional_rows = stg.additional_rows,
			  difference = stg.difference
		  when not matched
		  then
		  insert
			 (
			  as_of_date,
			  table_name,
			  dragon_row_count,
			  object_count,
			  missing_rows,
			  additional_rows,
			  difference
			  )
		  values
			 (
			  stg.report_date,
			  stg.table_name,
			  stg.dragon_row_count,
			  stg.object_count,
			  stg.missing_rows,
			  stg.additional_rows,
			  stg.difference
			  );
	end if;
	commit;
	end loop;	
end;
/