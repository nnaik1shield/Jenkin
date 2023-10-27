create or replace view vw_renewal_image_create as
select
     a.policy_id,
     a.policy_effective_date,
     a.policy_number,
     a.policy_object_state_id,
     a.policy_expiration_date,
     a.hold_status,
     a.renewal_image_prior_days
from
     dragon_policy a
where
     (
        trunc(a.policy_expiration_date) - trunc(pkg_db_functions.fn_get_policy_current_date (1,1,a.policy_id))  <= a.renewal_image_prior_days
      )
and
        policy_object_state_id       =   71  
and
        policy_product_id  not in (86546, 105448) 
and
       bor_renewal_transaction_id   is null
and 
		a.customer_id is not null  
and
      --
      -- Part 1: Pick Policies which do not have WIP Renewals on the Policy.
      --
       not exists (
                      select
                              1
                      from
                              dragon_policy_trx t
                      where
                              t.policy_id    = a.policy_id
						and
                              t.policy_trx_type_id in ( 8 ) 
                        and
                             policy_trx_object_state_id not in (
                                                                  24,    
                                                                  106,   
                                                                  27502, 
                                                                  28905, 
                                                                  23    
                                                                )
                   )
      --
      -- Part 1: Check if a Non Renewal transaction is available on Policy
      --
and
       not exists (
                      select
                              1
                      from
                              dragon_policy_trx t
                      where
                              t.policy_id                 = a.policy_id
                        and
                              t.policy_trx_type_id         =  2207 

							    and nvl(pkg_os_object_io.fn_object_bv_get(1,
                                                     1,
                                                     pkg_os_object_search.fn_object_11_child_get(1,
                                                                                                 1,
                                                                                                 POLICY_TRX_ID,
                                                                                                 2207607),
                                                     33558148),
                   2) = 2
                        and
                              trunc(t.policy_trx_eff_date) = trunc(a.policy_expiration_date) 
                   )
UNION
--
--  Part 2A : Get Policy on which there is a Renewal in status = Prospect and Tree readonly flag = No
--
select
     a.policy_id,
     a.policy_effective_date,
     a.policy_number,
     a.policy_object_state_id,
     a.policy_expiration_date,
     a.hold_status,
     a.renewal_image_prior_days
from
      dragon_policy_trx t,
      dragon_policy a
where
       a.policy_id = t.policy_id
and
    (
        trunc(a.policy_expiration_date) - trunc(pkg_db_functions.fn_get_policy_current_date (1,1,a.policy_id))  <= a.renewal_image_prior_days
    )
and
        policy_object_state_id       =   71  
and
        policy_product_id    not in (86546, 105448)  
and
        t.policy_trx_type_id         =  8
and
        t.object_source <>  1		
and 
		a.customer_id is not null  
and
      (
            (
                  t.policy_trx_object_state_id = 34902  
               or
			       (
                   nvl( pkg_os_object_io.fn_object_bv_get(1,1,t.policy_trx_id,29616301 ),0) = 1 
				   
				   and

                     t.policy_trx_object_state_id = 15402
				   )
             )
             and
                   nvl( pkg_os_object_io.fn_object_bv_get(1,1,t.policy_trx_id,33172048 ),2)= 2 
      )

UNION
--
--  Part 2B: Get Policy on which there is a BOR Renewal in status = Prospect and Tree readonly flag = No
--
select
     a.policy_id,
     a.policy_effective_date,
     a.policy_number,
     a.policy_object_state_id,
     a.policy_expiration_date,
     a.hold_status,
     a.renewal_image_prior_days
from
      dragon_policy_trx t,
      dragon_policy a
where
       a.policy_id = t.policy_id
and
   (
        trunc(a.policy_effective_date) - trunc(pkg_db_functions.fn_get_policy_current_date (1,1,a.policy_id))  <= a.renewal_image_prior_days
   )
and
        policy_object_state_id       =   75748  
and
        policy_product_id    not in (86546, 105448)  
and
        t.policy_trx_type_id         =   8  
and
        t.object_source <>  1		
and 
		a.customer_id is not null  
and
      (
            (
                  t.policy_trx_object_state_id = 34902 
               or
			      (
                   nvl( pkg_os_object_io.fn_object_bv_get(1,1,t.policy_trx_id,29616301 ),0) = 1 
				   
				   and

                   t.policy_trx_object_state_id = 15402
				   )
             )
             and
                   nvl( pkg_os_object_io.fn_object_bv_get(1,1,t.policy_trx_id,33172048 ),2)= 2 
      )
UNION
--
--  Part 3 : Get Renewal Transaction which is in status PolicyTransactionCreated or RenewalTPRReportOrdered (35202)
--
select
     t.policy_trx_id,
     a.policy_effective_date,
     a.policy_number,
     a.policy_object_state_id,
     a.policy_expiration_date,
     a.hold_status,
     a.renewal_image_prior_days
from
      dragon_policy_trx t,
      dragon_policy a
where
       a.policy_id = t.policy_id
and
       t.policy_trx_type_id         =  8  
and 
		a.customer_id is not null   
and
     (
     trunc(pkg_db_functions.fn_get_policy_current_date(1, 1, a.policy_id)) - trunc(t.policy_trx_creation_date) >= a.renewal_rate_days
     or
     trunc(pkg_db_functions.fn_get_policy_current_date(1, 1, a.policy_id)) - trunc(t.policy_trx_eff_date) <= a.renewal_issue_prior_days
	 )
and
        ( t.policy_trx_object_state_id in (15402) or (t.policy_trx_object_state_id in (35202) and t.object_source != 1))
and
        policy_product_id    not in (86546, 105448)  
and
        policy_object_state_id       in  (
                                             71,    
                                             75748  
                                         )
and
        ( nvl( pkg_os_object_io.fn_object_bv_get(1,1,t.policy_trx_id,29616301 ),0) <> 1 or t.object_source = 1 )
		
UNION
 
  Select
       t.POLICY_TRX_ID,
       a.policy_effective_date,
       a.policy_number,
       a.policy_object_state_id,
       a.policy_expiration_date,
       a.hold_status,
       a.renewal_image_prior_days
  from 
              dragon_policy_trx t
  inner join 
             dragon_policy a
   on 
            a.policy_id = t.policy_id
  where
        t.policy_trx_type_id = 8
 and 
		a.customer_id is not null  
   and 
       a.policy_object_state_id in (75748, 71) 
   and 
      (
	   t.policy_trx_eff_date - sysdate <= a.renewal_issue_prior_days
       or 
	   sysdate-t.POLICY_TRX_LAST_UPD_DT  <= 3
       ) 
   and 
      ( t.policy_trx_object_state_id in (15402) or (t.policy_trx_object_state_id in (35202) and t.object_source != 1))
   and 
      nvl(pkg_os_object_io.fn_object_bv_get(1, 1, policy_trx_id, 32999248),
           1) = 1 
	and
        ( nvl( pkg_os_object_io.fn_object_bv_get(1,1,t.policy_trx_id,29616301 ),0) <> 1 or  t.object_source = 1  )
;
/