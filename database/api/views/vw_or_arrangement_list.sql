create or replace view vw_or_arrangement_list as
select
        r.or_arrangement_id    or_arrangement_id,
        r.or_arrngmnt_nbr      or_arrangement_number,
        r.or_arrngmnt_name     or_arrangement_name,
        PKG_OR_FUNCTIONS.fn_get_cession_type_name(111,111,r.OR_CESSION_TYPE)     or_cession_type,
        to_date(r.or_effective_date,'YYYYMMDDHH24MISS')    or_effective_date,
        to_date(r.or_expiration_date,'YYYYMMDDHH24MISS')    or_expiration_date,
        pkg_os_object_io.fn_object_bv_path_get( 111, 111, r.or_arrangement_id,'210153' ) or_arrangement_state,
         NULL policy_number,
         NULL policy_effective_date,
         NULL policy_expiry_date,
         NULL customer_name,
         NULL policy_transaction_id,
         NULL policy_term_id,
         NULL policy_premium

from
        or_reinsurance_arrangement r
where
  r.or_arrngmnt_name is not null
ORDER BY 5 DESC;
