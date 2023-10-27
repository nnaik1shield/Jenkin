create or replace view vw_dr_data_reconcile_history
as
Select
     as_of_date "As of Date",
     curr.table_name "BI Data Set",
     nvl(curr.dragon_object_count, 0) "Dragon Object Count",
     nvl(curr.bi_object_count, 0) "BI Object Count",
     nvl(curr.missing_rows, 0) "Missing Rows",
     nvl((curr.missing_rows - prev.prev_missing_rows), 0) "Missing Rows Variance",
     nvl(curr.additional_rows, 0) "Additional Rows",
     nvl((curr.additional_rows - prev.prev_additional_rows), 0) "Additional Rows Variance",
     (case when nvl(curr.difference, 0) = 0 then '-' else nvl(curr.difference, 0)||'%' end) "% Difference"
 from dr_data_reconcile_history curr,
      (select
            table_name,
            missing_rows prev_missing_rows,
            additional_rows prev_additional_rows
       from
            dr_data_reconcile_history
       where
            as_of_date = trunc(sysdate-1)) prev
where
    curr.table_name = prev.table_name(+)
and
    curr.as_of_date = trunc(sysdate) ;
