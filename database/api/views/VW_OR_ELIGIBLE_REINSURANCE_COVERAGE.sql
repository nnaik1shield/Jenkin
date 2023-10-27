create or replace view vw_or_eligible_reinsurance_coverage as
select
         distinct
         rs.or_reinsrnce_cvrg_type_id   as   enum
        ,rs.or_reinsrnce_cvrg_type_name as  text
        ,progm.program_program_id
from
         pc_coverage              cvrg
        ,program_product           progm
        ,pc_coverage_type         cvrg_type
        ,or_reinsurance_cvrg_type rs
where
        cvrg.pc_coverage_type_id      =   cvrg_type.coverage_type_id
and
        cvrg.true_coverage_tf         =   'T'
and
        cvrg.pc_charge_type_id        =   '105'

and
        cvrg_type.active_tf           =   'T'
and
        cvrg.pd_product_id            =   progm.program_product_def_id
and
        rs.or_reinsrnce_cvrg_type_id  =   cvrg_type.or_reinsrnce_cvrg_type_id
and
        rs.active_tf                  = 'T';
