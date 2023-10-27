set timing on
--Drop and recreate dr_data_reconcile_datamart table to get fresh data from object
begin
  execute immediate 'drop table dr_data_reconcile_datamart purge';
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

create table dr_data_reconcile_datamart
as
select
  object_id, object_type_id, object_state_id, template_object_id, parent_object_id, last_updated_date
from
  %_API%.object
 where object_type_id in
       (select object_type_id from %_API%.object_datamart where DATAMART_ENABLED_TF = 'T') 
 or object_type_id in (2356809, 3341546);

                           

create index dr_data_reconcile_datamart_i1 on dr_data_reconcile_datamart (object_type_id);
create unique index dr_data_reconcile_datamart_uk on dr_data_reconcile_datamart (object_id);
