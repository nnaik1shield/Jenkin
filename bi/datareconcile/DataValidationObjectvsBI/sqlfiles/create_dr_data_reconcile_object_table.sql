set timing on
--Drop and recreate dr_data_reconcile_object table to get fresh data from object
begin
  execute immediate 'drop table dr_data_reconcile_object purge';
exception when others
then
  if sqlcode = -00942
  then
    null;
  else
    raise;
  end if;
end;
/

create table dr_data_reconcile_object
as
select
	object_id, object_type_id, object_state_id, template_object_id, parent_object_id, last_updated_date
from
	%_API%.object
--get BI specific objects
where object_type_id in (
                            Select
                                 tr.tr_source_object_type_id
                            from
                                 %_API%.object_type ot,
                                 %_API%.tr_object_transform tr
                            where
                                ot.object_type_id = tr.tr_target_object_type_id
                            and
                                default_table_name like 'BI\__%' escape '\'
                            group by tr.tr_source_object_type_id);

create index dr_data_reconcile_object_idx1 on dr_data_reconcile_object (object_type_id);
create unique index dr_data_reconcile_object_uk on dr_data_reconcile_object (object_id);
