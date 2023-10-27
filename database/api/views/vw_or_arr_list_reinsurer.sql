create or replace view vw_or_arr_list_reinsurer as
select
        distinct r.or_arrangement_id    or_arrangement_id,
        r.or_arrngmnt_nbr      or_arrangement_number,
        r.or_arrngmnt_name     or_arrangement_name,
        PKG_OR_FUNCTIONS.fn_get_cession_type_name(111,111,r.OR_CESSION_TYPE)     or_cession_type,
        to_date(r.or_effective_date,'YYYYMMDDHH24MISS')    or_effective_date,
        to_date(r.or_expiration_date,'YYYYMMDDHH24MISS')    or_expiration_date,
        pkg_os_object_io.fn_object_bv_path_get( 111, 111, r.or_arrangement_id,'210153' ) or_arrangement_state,
        PR.OR_REF_ASSOCIATED_REINSURER,
        PR.OR_REF_ASSOC_REINSURANCE_BROKR,
        R.OR_ARRNGMNT_TYPE

from
OR_PARTICIPANT_REINSURER PR,OR_REINSURANCE_ARRANGEMENT R
where R.OR_ARRANGEMENT_ID = PR.OR_REF_PARENT_ID 
AND
pkg_os_object_io.fn_object_bv_path_get( 111, 111, r.or_arrangement_id,'210153' ) <> 23
ORDER BY 5 DESC;
/