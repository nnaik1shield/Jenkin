create or replace view vw_or_eligible_reinsurance_sub_coverage as
select
           distinct
           rs_sub_cvrg.or_reinsrnce_sub_cvrg_type_id   as  enum
          ,rs_sub_cvrg.or_reinsrnce_sub_cvrg_type_name as  text
          ,progm.program_program_id
          ,or_reinsrnce_cvrg_type_id
from
         pc_coverage                  cvrg
        ,program_product              progm
        ,pc_coverage_sub_types        sub_cvrg
        ,pc_coverage_type             cvrg_type
        ,or_reinsurance_sub_cvrg_type rs_sub_cvrg
where
        cvrg.true_coverage_tf                   =   'T'
and
        cvrg.pc_charge_type_id                  =   '105'
and
        cvrg.pd_product_id                      =   progm.program_product_def_id
and
        progm.reinsurance_tf                    =   'T'
and
        cvrg.pc_coverage_type_id               =   cvrg_type.coverage_type_id
and
        cvrg.pc_coverage_sub_type_id            =   sub_cvrg.pc_coverage_sub_types_id
and
        sub_cvrg.or_reinsrnce_sub_cvrg_type_id  =  rs_sub_cvrg.or_reinsrnce_sub_cvrg_type_id
and
        rs_sub_cvrg.active_tf                   = 'T';