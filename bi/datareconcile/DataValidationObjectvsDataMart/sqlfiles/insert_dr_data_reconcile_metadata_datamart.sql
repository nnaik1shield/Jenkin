set define off
delete dr_data_reconcile_dm_metadata;
insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (1,'DRAGON_POLICY','POLICY_ID','SELECT OBJECT_ID as POLICY_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=24)','','SELECT * FROM %ST%.DRAGON_POLICY' ,24);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (2,'DRAGON_PARTNER_AGREEMENT','PARTNER_AGREEMENT_ID','SELECT OBJECT_ID as PARTNER_AGREEMENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=306)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_PARTNER_AGREEMENT','AGREEMENT_STATUS_ID <> 23' ,15846);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition,dm_id) values (3,'DRAGON_PARTNER_AGREEMENT_PROD','PARTNER_AGREEMENT_PRODUCT_ID','SELECT OBJECT_ID as PARTNER_AGREEMENT_PRODUCT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=382705)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_PARTNER_AGREEMENT_PROD', 'AGREEMENT_PRODUCT_STATUS_ID <> 23' ,15401);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (4,'DRAGON_SERVICE_GROUP_TERRITORY','SERVICE_GROUP_TERRITORY_ID','SELECT OBJECT_ID as SERVICE_GROUP_TERRITORY_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2358246)','','SELECT * FROM %ST%.DRAGON_SERVICE_GROUP_TERRITORY' ,15546);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (5,'DRAGON_USER_SERVICE_GROUP','DRAGON_USER_SERVICE_GROUP_ID','SELECT OBJECT_ID as DRAGON_USER_SERVICE_GROUP_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2358346) AND OBJECT_STATE_ID <> 23','','SELECT * FROM %ST%.DRAGON_USER_SERVICE_GROUP' ,15646);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (6,'DRAGON_POLICY_TRX','POLICY_TRX_ID','SELECT OBJECT_ID as POLICY_TRX_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=629)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_POLICY_TRX', 'POLICY_TRX_OBJECT_STATE_ID <> 23' ,11902);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (7,'DRAGON_TREATY','TREATY_ID','SELECT OBJECT_ID as TREATY_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2288605)','','SELECT * FROM %ST%.DRAGON_TREATY' ,11205);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (8,'DRAGON_REINSURANCE','REINSURANCE_ID','SELECT OBJECT_ID as REINSURANCE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2288705)','','SELECT * FROM %ST%.DRAGON_REINSURANCE' ,11305);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (9,'DRAGON_USER','USER_ID','SELECT OBJECT_ID as USER_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=309)','OBJECT_STATE_ID <> 23','SELECT USER_ID, USERNAME, AGENCY_CODE, EXCHANGE_ID, PRIMARY_GROUP_ID, PRIMARY_GROUP_NAME, ACTOR_TYPE_ID, ACTOR_TYPE_NAME, USER_FULL_NAME, USER_FIRST_NAME, PHONE_NUMBER, USER_LAST_NAME, EMAIL, AGENT_NBR, CREATION_DATE, STATUS_ID, STATUS_DESC, PARTNER_ID, USER_EFFECTIVE_DATE, USER_TERMINATION_DATE, OUT_OF_OFFICE_TF, LAST_UPDATED_DATE, OBJECT_STATE_ID, LEGACY_OBJECT_ID, OBJECT_SOURCE_DESC, LEGACY_ID, OBJECT_SOURCE, ASSIGN_TASK, PHONE_EXTENSION, CARRIER_BRANCH_ID, CARRIER_BRANCH, USER_JOB_TITLE, ALLOW_ANONYMOUS_TF,  BI_PROCESS_DATE, RGSTRTN_CMPLTN_STATUS_TF FROM %ST%.DRAGON_USER','STATUS_ID <> 23' ,309);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (10,'DRAGON_BULLETIN','BULLETIN_ID','SELECT OBJECT_ID as BULLETIN_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=66)','','SELECT * FROM %ST%.DRAGON_BULLETIN' ,8605);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (11,'DRAGON_PARTNER','PARTNER_ID','SELECT OBJECT_ID as PARTNER_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=63)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_PARTNER','PARTNER_STATE_ID <> 23' ,63);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (12,'DRAGON_CUSTOMER','CUSTOMER_ID','SELECT OBJECT_ID as CUSTOMER_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=12)','','SELECT * FROM %ST%.DRAGON_CUSTOMER' ,2701);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (13,'DRAGON_TASK','TASK_ID','SELECT OBJECT_ID as TASK_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=62)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_TASK','TASK_OBJECT_STATE_ID <> 23' ,4905);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (14,'DRAGON_LICENSE','LICENSE_ID','SELECT OBJECT_ID as LICENSE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID IN (342,2273305))','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_LICENSE','LICENSE_OBJECT_STATUS <> 23' ,10005);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (15,'DRAGON_ASSOCIATED_AGENT','ASSOC_AGENT_ID','SELECT OBJECT_ID as ASSOC_AGENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2346713)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_ASSOCIATED_AGENT' ,13713);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (16,'DRAGON_POLICY_QUOTE','POLICYQUOTE_ID','SELECT OBJ.OBJECT_ID as POLICYQUOTE_ID, OBJ.OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart OBJ INNER JOIN (select object_id, object_type_id from %SRCAPI%.dr_data_reconcile_datamart WHERE Object_Type_Id IN (2356809,3341546)) POBJ ON (pobj.object_id = obj.parent_object_id) where OBJ.OBJECT_TYPE_ID = 2276904','','SELECT * FROM %ST%.DRAGON_POLICY_QUOTE' ,14709);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (17,'DRAGON_BILLINGACCOUNTTRXSET','BILLINGACCOUNTTRXSET_ID','SELECT OBJECT_ID as BILLINGACCOUNTTRXSET_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2365946)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_BILLINGACCOUNTTRXSET','BATCH_STATUS_ID <> 23' ,17446);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (18,'DRAGON_FITRANSACTION','FITRANSACTION_ID','SELECT OBJECT_ID as FITRANSACTION_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2365046)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_FITRANSACTION' ,'STATUS_ENUM <> 23' ,16946);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (19,'DRAGON_FICHANGE','FICHANGE_ID','SELECT OBJECT_ID as FICHANGE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2365146)','','SELECT * FROM %ST%.DRAGON_FICHANGE' ,17146);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (20,'DRAGON_BILLINGACCOUNT','BILLINGACCOUNT_ID','SELECT OBJECT_ID as BILLINGACCOUNT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE  ((OBJECT_TYPE_ID=2365346 AND %API%.pkg_os_exp.fn_evaluate_expression(111,111, OBJECT_ID,10208248) = ''T'') OR (OBJECT_TYPE_ID=3168046))','','SELECT * FROM %ST%.DRAGON_BILLINGACCOUNT' ,20946);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (21,'DRAGON_FITEM','FITEM_ID','SELECT OBJECT_ID as FITEM_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2365246)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_FITEM','FITEM_OBJECT_STATE_ID <> 23' ,17346);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (22,'DRAGON_BOR_TRANSFER','BOR_TRANSFER_REQUEST_ID','SELECT OBJECT_ID as BOR_TRANSFER_REQUEST_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2358101)','','SELECT * FROM %ST%.DRAGON_BOR_TRANSFER' ,17946);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (23,'DRAGON_POLICY_TERM','POLICY_TERM_ID','SELECT OBJECT_ID as POLICY_TERM_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2389401)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_POLICY_TERM' ,19246);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (24,'DRAGON_STATEMENTPROFILE','STATEMENTPROFILE_ID','SELECT OBJECT_ID as STATEMENTPROFILE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2866546)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_STATEMENTPROFILE', 'STATUS_ID <> 23' ,19446);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (25,'ORM_MASTER_ENTITY','ME_ID','SELECT OBJECT_ID as ME_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2871246)','','SELECT * FROM %ST%.ORM_MASTER_ENTITY' ,19546);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (26,'DRAGON_PARTNER_AFFILIATION','PARTNER_AFFILIATION_ID','SELECT OBJECT_ID as PARTNER_AFFILIATION_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2400001)','','SELECT * FROM %ST%.DRAGON_PARTNER_AFFILIATION' ,20546);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (27,'DRAGON_CASH_ALLOCATION','FITEMALLOCATION_ID','SELECT OBJECT_ID as FITEMALLOCATION_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3158046)','','SELECT * FROM %ST%.DRAGON_CASH_ALLOCATION' ,20646);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (28,'DRAGON_CALENDAR_EVENT','CALENDAR_EVENT_ID','SELECT OBJECT_ID as CALENDAR_EVENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2563401)','OBJECT_STATE_ID != 23','SELECT * FROM %ST%.DRAGON_CALENDAR_EVENT' ,20246);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (29,'DRAGON_ROLLUP','RU_ID','SELECT OBJECT_ID as RU_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2367646) OR (OBJECT_TYPE_ID=2374846)','','SELECT * FROM %ST%.DRAGON_ROLLUP' ,36746);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (30,'DRAGON_ROLLUP_MEMBER','RUM_ID','SELECT OBJECT_ID as RUM_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2367846)','','SELECT * FROM %ST%.DRAGON_ROLLUP_MEMBER' ,21646);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (31,'DRAGON_UW_TRIGGER_DETAIL','UW_TRIGGER_DETAIL_ID','SELECT OBJECT_ID as UW_TRIGGER_DETAIL_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2240405)','','SELECT * FROM %ST%.DRAGON_UW_TRIGGER_DETAIL' ,23446);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (32,'DRAGON_SUBCLAIM','SUB_CLAIM_ID','SELECT OBJECT_ID as SUB_CLAIM_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3204946)','','SELECT * FROM %ST%.DRAGON_SUBCLAIM' ,26346);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (33,'DRAGON_SUBCLAIM_TRX','SUBCLAIM_TRX_ID','SELECT OBJECT_ID as SUBCLAIM_TRX_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3204746) OR (OBJECT_TYPE_ID=3337246) OR (OBJECT_TYPE_ID=3337346) OR (OBJECT_TYPE_ID=3337446) OR (OBJECT_TYPE_ID=3337646) OR (OBJECT_TYPE_ID=3337846) OR (OBJECT_TYPE_ID=3342346)','','SELECT * FROM %ST%.DRAGON_SUBCLAIM_TRX' ,30346);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (34,'DRAGON_CLAIM_TRX','CLAIM_TRX_ID','SELECT OBJECT_ID as CLAIM_TRX_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3331746) OR (OBJECT_TYPE_ID=3336746) OR (OBJECT_TYPE_ID=3336846) OR (OBJECT_TYPE_ID=3336946) OR (OBJECT_TYPE_ID=3337046) OR (OBJECT_TYPE_ID=3337146) OR (OBJECT_TYPE_ID=3337746) OR (OBJECT_TYPE_ID=3342246) OR (OBJECT_TYPE_ID=3342746) OR (OBJECT_TYPE_ID=3345646) OR (OBJECT_TYPE_ID=3351946) OR (OBJECT_TYPE_ID=3373948) OR (OBJECT_TYPE_ID=3395946) OR (OBJECT_TYPE_ID=3396246) OR (OBJECT_TYPE_ID=3355448)','','SELECT * FROM %ST%.DRAGON_CLAIM_TRX' ,32548);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (35,'DRAGON_INCIDENTLOSS','INCIDENTLOSS_ID','SELECT OBJECT_ID as INCIDENTLOSS_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3201546)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_INCIDENTLOSS', 'INCIDENT_STATUS_ID <> 23' ,29846);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (36,'DRAGON_UW_TRIGGER_SUMMARY','UW_TRIGGER_SUMMARY_ID','SELECT OBJECT_ID as UW_TRIGGER_SUMMARY_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2359401)','','SELECT * FROM %ST%.DRAGON_UW_TRIGGER_SUMMARY' ,29946);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (37,'DRAGON_BILLING_GL','GL_ID','SELECT OBJECT_ID as GL_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3199846)','','SELECT * FROM %ST%.DRAGON_BILLING_GL' ,25646);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (38,'ORM_MASTER_ADDRESS','MA_ID','SELECT OBJECT_ID as MA_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3199346)','','SELECT * FROM %ST%.ORM_MASTER_ADDRESS' ,25446);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (39,'DRAGON_SCHEDULED_INSTALLMENT','INSTALLMENT_ID','SELECT OBJECT_ID as INSTALLMENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2365446)','','SELECT * FROM %ST%.DRAGON_SCHEDULED_INSTALLMENT' ,22519);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (40,'DRAGON_FUND_TRANS_REQ_TRY','SCHD_FUND_REQ_TRY_ID','SELECT OBJECT_ID as SCHD_FUND_REQ_TRY_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3194146)','','SELECT * FROM %ST%.DRAGON_FUND_TRANS_REQ_TRY' ,25046);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (41,'DRAGON_SUSPENSION','SUSPENSION_ID','SELECT OBJECT_ID as SUSPENSION_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3193346) OR (OBJECT_TYPE_ID=3193446) OR (OBJECT_TYPE_ID=3193546) OR (OBJECT_TYPE_ID=3193646)','','SELECT * FROM %ST%.DRAGON_SUSPENSION' ,25346);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (42,'ORM_ENTITY_VERSION','VERSION_OBJECT_ID','SELECT OBJECT_ID as VERSION_OBJECT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2871446)','','SELECT * FROM %ST%.ORM_ENTITY_VERSION' ,25118);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (43,'DRAGON_INCIDENT','INCIDENT_ID','SELECT OBJECT_ID as INCIDENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3201046)','','SELECT * FROM %ST%.DRAGON_INCIDENT' ,26046);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (44,'DRAGON_CLAIM','CLAIM_ID','SELECT OBJECT_ID as CLAIM_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3203646)','','SELECT * FROM %ST%.DRAGON_CLAIM' ,26146);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (45,'DRAGON_INCIDENT_ENTITY','INCIDENT_ENTITY_ID','SELECT OBJECT_ID as INCIDENT_ENTITY_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3200746)','OBJECT_STATE_ID NOT IN (22,23)','SELECT * FROM %ST%.DRAGON_INCIDENT_ENTITY' ,26246);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (46,'DRAGON_DOC_DLVRY_INSTRCTN','DOC_DLVRY_INSTRCTN_ID','SELECT OBJECT_ID as DOC_DLVRY_INSTRCTN_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3157946)','','SELECT * FROM %ST%.DRAGON_DOC_DLVRY_INSTRCTN' ,26546);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (47,'DRAGON_ASSOCIATED_TRANSACTION','ASSO_TRX_MAP_ID','SELECT OBJECT_ID as ASSO_TRX_MAP_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3363546)','','SELECT * FROM %ST%.DRAGON_ASSOCIATED_TRANSACTION' ,31846);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (48,'DRAGON_BA_INSTALMENT','BA_INSTALMENT_ID','SELECT OBJECT_ID as BA_INSTALMENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3209840)','','SELECT * FROM %ST%.DRAGON_BA_INSTALMENT' ,25864);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (49,'DRAGON_BA_INSTALMENT_COMPONENT','BA_INSTALMENT_COMPONENT_ID','SELECT OBJECT_ID as BA_INSTALMENT_COMPONENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3209940)','','SELECT * FROM %ST%.DRAGON_BA_INSTALMENT_COMPONENT' ,25764);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (50,'DRAGON_CATASTROPHE','CATASTROPHE_ID','SELECT OBJECT_ID as CATASTROPHE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3373846)','','SELECT * FROM %ST%.DRAGON_CATASTROPHE' ,33546);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (51,'DRAGON_POLICY_TERM_PAYER','POLICY_TERM_PAYER_ID','SELECT OBJECT_ID as POLICY_TERM_PAYER_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3349024)','','SELECT * FROM %ST%.DRAGON_POLICY_TERM_PAYER' ,35746);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (52,'DRAGON_PAY_PROFILE','PAY_PROFILE_ID','SELECT OBJECT_ID as PAY_PROFILE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2384546)','','SELECT * FROM %ST%.DRAGON_PAY_PROFILE' ,25440);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (53,'DRAGON_DISB_PROFILE','DISB_PROFILE_ID','SELECT OBJECT_ID as DISB_PROFILE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2384646)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_DISB_PROFILE' ,25540);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (54,'ORM_MASTER_PHONE_NUMBER','MASTER_OBJECT_ID','SELECT OBJECT_ID as MASTER_OBJECT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3383946)','','SELECT * FROM %ST%.ORM_MASTER_PHONE_NUMBER' ,36346);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (55,'ORM_MASTER_EMAIL_ADDRESS','MASTER_OBJECT_ID','SELECT OBJECT_ID as MASTER_OBJECT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3385546)','','SELECT * FROM %ST%.ORM_MASTER_EMAIL_ADDRESS' ,36546);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (56,'DRAGON_USER_ASGMT_PROFILE','DRAGON_USER_ASGMT_ID','SELECT OBJECT_ID as DRAGON_USER_ASGMT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3349608)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_USER_ASGMT_PROFILE', 'OBJECT_STATE_ID <> 23' ,36946);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (57,'DRAGON_BA_SCHEDULEDPAYMENT','BA_SCHEDULED_PAYMENT_ID','SELECT OBJECT_ID as BA_SCHEDULED_PAYMENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3393746)','','SELECT * FROM %ST%.DRAGON_BA_SCHEDULEDPAYMENT' ,38546);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (58,'DRAGON_BA_PAYMENTCOMPONENT','BA_PAYMENT_COMPONENT_ID','SELECT OBJECT_ID as BA_PAYMENT_COMPONENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3393846)','','SELECT * FROM %ST%.DRAGON_BA_PAYMENTCOMPONENT' ,38746);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (59,'DRAGON_SERVICE_GROUP','SERVICE_GROUP_ID','SELECT OBJECT_ID as SERVICE_GROUP_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2290409)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_SERVICE_GROUP','SERVICE_GROUP_STATE_ID <> 23' ,38646);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (60,'DRAGON_USER_LOAD_PROFILE','DRAGON_USER_LOAD_PROFILE_ID','SELECT OBJECT_ID as DRAGON_USER_LOAD_PROFILE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3363608)','','SELECT * FROM %ST%.DRAGON_USER_LOAD_PROFILE' ,39146);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (61,'DRAGON_QUEUE_DEFINITION','QUEUE_DEFINITION_ID','SELECT OBJECT_ID as QUEUE_DEFINITION_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3365408)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_QUEUE_DEFINITION', 'QUEUE_OBJECT_STATE_ID <> 23' ,39646);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (62,'DRAGON_QUEUE_CRITERIA','QUEUE_CRITERIA_ID','SELECT OBJECT_ID as QUEUE_CRITERIA_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3365708)','','SELECT * FROM %ST%.DRAGON_QUEUE_CRITERIA' ,39746);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (63,'DRAGON_QUEUE_GRP_ASGMT_CR','QUEUE_GROUP_CRITERIA_ID','SELECT OBJECT_ID as QUEUE_GROUP_CRITERIA_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3365808)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_QUEUE_GRP_ASGMT_CR' ,'OBJECT_STATE_ID <> 23' ,39846);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (64,'ORM_SUBSCRIBER','MASTER_ENTITY_SUBSCRIBER_ID','SELECT OBJECT_ID as MASTER_ENTITY_SUBSCRIBER_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3393146)','','SELECT * FROM %ST%.ORM_SUBSCRIBER' ,30148);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (65,'DRAGON_BILL_PLAN','BILL_PLAN_ID','SELECT OBJECT_ID as BILL_PLAN_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3398446)','','SELECT * FROM %ST%.DRAGON_BILL_PLAN' ,30448);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (66,'ORM_ENTITY_DETAIL_DATAMART','OBJECT_ID','SELECT OBJECT_ID as OBJECT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3339548) OR (OBJECT_TYPE_ID=3385046) OR (OBJECT_TYPE_ID=3385146) OR (OBJECT_TYPE_ID=3385746)','','SELECT * FROM %ST%.ORM_ENTITY_DETAIL_DATAMART' ,30848);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (67,'DRAGON_CASHTRANSFERPROFILE','CTF_ID','SELECT OBJECT_ID as CTF_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2384446 AND OBJECT_STATE_ID IN (75,58548))','','SELECT * FROM %ST%.DRAGON_CASHTRANSFERPROFILE' ,30948);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (68,'DRAGON_BOR_INCLUDED','BOR_INCLUDED_OBJECT_ID','SELECT OBJECT_ID as BOR_INCLUDED_OBJECT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2358201)','','SELECT * FROM %ST%.DRAGON_BOR_INCLUDED' ,31248);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (69,'DRAGON_PTP_PAYER','PTP_PAYER_ID','SELECT OBJECT_ID as PTP_PAYER_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3347724)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_PTP_PAYER' ,31448);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (70,'DRAGON_EVENT','EVENT_ID','SELECT OBJECT_ID as EVENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3364448 AND %API%.pkg_os_exp.fn_evaluate_expression(111,111, OBJECT_ID,10344848) = ''T'')','','SELECT * FROM %ST%.DRAGON_EVENT' ,31548);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql,dest_sql_ext_condition, dm_id) values (71,'DRAGON_INCIDENT_ASSET','INCIDENT_ASSET_OBJECT_ID','SELECT OBJECT_ID as INCIDENT_ASSET_OBJECT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3201146)','OBJECT_STATE_ID <> 23','SELECT * FROM %ST%.DRAGON_INCIDENT_ASSET', 'PROPERTY_STATUS not in (''Created'')' ,32148);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (72,'ORM_ADDRESS_VERSION','VERSION_OBJECT_ID','SELECT OBJECT_ID as VERSION_OBJECT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3199146)','','SELECT * FROM %ST%.ORM_ADDRESS_VERSION' ,25318);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (73,'DRAGON_PARTNER_SVC_TERRITORY','PARTNER_SVC_TERRITORY_ID','SELECT OBJECT_ID as PARTNER_SVC_TERRITORY_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2358446)','','SELECT * FROM %ST%.DRAGON_PARTNER_SVC_TERRITORY' ,15746);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (74,'DRAGON_CUSTOMER_ENTITY','CE_ID','SELECT OBJ.OBJECT_ID as CE_ID, OBJ.OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart OBJ INNER JOIN (select object_id, object_type_id from %SRCAPI%.dr_data_reconcile_datamart WHERE Object_Type_Id = 12) POBJ ON (pobj.object_id = obj.parent_object_id) where OBJ.OBJECT_TYPE_ID = 205','','SELECT * FROM %ST%.DRAGON_CUSTOMER_ENTITY' ,12114);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (75,'DRAGON_TRANSACTION_STATS','TRANSACTION_STAT_ID','SELECT OBJECT_ID as TRANSACTION_STAT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2297706)','','SELECT * FROM %ST%.DRAGON_TRANSACTION_STATS' ,11802);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (76,'DRAGON_SUBMISSION','SUBMISSION_ID','SELECT OBJECT_ID as SUBMISSION_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=5)','','SELECT * FROM %ST%.DRAGON_SUBMISSION' ,6705);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (77,'DRAGON_ADDRESS','ADDRESS_ID','SELECT OBJECT_ID as ADDRESS_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=405)','','SELECT * FROM %ST%.DRAGON_ADDRESS' ,16246);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (78,'DRAGON_POLICY_CLAIM','POLICY_CLAIM_ID','SELECT OBJECT_ID as POLICY_CLAIM_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2357346)','','SELECT * FROM %ST%.DRAGON_POLICY_CLAIM' ,16446);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (79,'DRAGON_CUSTOMER_PHONE_NUMBER','PHONE_NUMBER_ID','SELECT OBJECT_ID as PHONE_NUMBER_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2601546)','','SELECT * FROM %ST%.DRAGON_CUSTOMER_PHONE_NUMBER' ,20649);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (80,'DRAGON_CUSTOMER_EMAIL','EMAIL_ID','SELECT OBJECT_ID as EMAIL_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2385346)','','SELECT * FROM %ST%.DRAGON_CUSTOMER_EMAIL' ,20749);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (81,'DRAGON_PROPERTY_SCHEDULE','PROPERTY_SCHEDULE_ID','SELECT OBJECT_ID as PROPERTY_SCHEDULE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE  (OBJECT_TYPE_ID=2184605) OR (OBJECT_TYPE_ID=2191305) OR (OBJECT_TYPE_ID=2191405) OR (OBJECT_TYPE_ID=2191505) OR (OBJECT_TYPE_ID=2227307) OR (OBJECT_TYPE_ID=2623246)','','SELECT * FROM %ST%.DRAGON_PROPERTY_SCHEDULE' ,24546);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (82,'DRAGON_ADDRESS_USAGE','ADDR_USAGE_ID','SELECT OBJECT_ID as ADDR_USAGE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2383746 AND %API%.pkg_os_exp.fn_evaluate_expression(111,111, OBJECT_ID,9694531) = ''T'')','','SELECT * FROM %ST%.DRAGON_ADDRESS_USAGE' ,26931);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (83,'DRAGON_OBJECTDOCUMENT','DOCUMENT_ID','SELECT OBJECT_ID as DOCUMENT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE  ((OBJECT_TYPE_ID=325) OR (OBJECT_TYPE_ID=3364346))','((%API%.pkg_os_object_io.fn_object_bv_get(1,1,OBJECT_ID,200818) <> 12446 AND %API%.pkg_os_object_io.fn_object_bv_get(1,1,OBJECT_ID,200818) is not null)  OR %API%.pkg_os_object_io.fn_object_bv_get(1,1,OBJECT_ID,201224) is not null)','SELECT * FROM %ST%.DRAGON_OBJECTDOCUMENT' ,31146);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (84,'DRAGON_VEHICLE_SCHEDULE','VEHICLE_SCHEDULE_ID','SELECT OBJECT_ID as VEHICLE_SCHEDULE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=2600146) OR (OBJECT_TYPE_ID=2600346) OR (OBJECT_TYPE_ID=2600746)','','SELECT * FROM %ST%.DRAGON_VEHICLE_SCHEDULE' ,33178);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (85,'DRAGON_USER_AUTHORITY_PROFILE','USER_AUTHORITY_PROFILE_ID','SELECT OBJECT_ID as USER_AUTHORITY_PROFILE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3349408)','','SELECT * FROM %ST%.DRAGON_USER_AUTHORITY_PROFILE' ,39246);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (86,'DRAGON_USER_REPORTING_PROFILE','USER_REPORTING_PROFILE_ID','SELECT OBJECT_ID as USER_REPORTING_PROFILE_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3363508)','','SELECT * FROM %ST%.DRAGON_USER_REPORTING_PROFILE' ,39346);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (87,'IMPORT_EXPORT_FILE_LOG','FILE_OBJECT_ID','SELECT OBJECT_ID as FILE_OBJECT_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3425408)','','SELECT * FROM %ST%.IMPORT_EXPORT_FILE_LOG' ,29208);

insert into dr_data_reconcile_dm_metadata (id, table_name, pk_column, source_sql, source_sql_ext_condition, dest_sql, dm_id) values (88,'DRAGON_INSIGHT_REQUEST','INSIGHT_RESPONSE_DETAIL_ID','SELECT OBJECT_ID as INSIGHT_RESPONSE_DETAIL_ID, OBJECT_TYPE_ID FROM %SRCAPI%.dr_data_reconcile_datamart WHERE (OBJECT_TYPE_ID=3371148)','','SELECT * FROM %ST%.DRAGON_INSIGHT_REQUEST' ,32848);

--exclude deprecated tables
update dr_data_reconcile_dm_metadata
set
active_tf = 0
where
	table_name in ('DRAGON_PARTNER_SVC_TERRITORY',
	'DRAGON_CUSTOMER_ENTITY',
	'DRAGON_TRANSACTION_STATS',
	'DRAGON_SUBMISSION',
	'DRAGON_ADDRESS',
	'DRAGON_POLICY_CLAIM',
	'DRAGON_CUSTOMER_PHONE_NUMBER',
	'DRAGON_CUSTOMER_EMAIL',
	'DRAGON_PROPERTY_SCHEDULE',
	'DRAGON_ADDRESS_USAGE',
	'DRAGON_OBJECTDOCUMENT',
	'DRAGON_VEHICLE_SCHEDULE',
	'DRAGON_USER_AUTHORITY_PROFILE',
	'DRAGON_USER_REPORTING_PROFILE',
	'IMPORT_EXPORT_FILE_LOG',
	'DRAGON_INSIGHT_REQUEST'
	);
	
update dr_data_reconcile_dm_metadata
set
active_tf = 1
where
	table_name not in ('DRAGON_PARTNER_SVC_TERRITORY',
	'DRAGON_CUSTOMER_ENTITY',
	'DRAGON_TRANSACTION_STATS',
	'DRAGON_SUBMISSION',
	'DRAGON_ADDRESS',
	'DRAGON_POLICY_CLAIM',
	'DRAGON_CUSTOMER_PHONE_NUMBER',
	'DRAGON_CUSTOMER_EMAIL',
	'DRAGON_PROPERTY_SCHEDULE',
	'DRAGON_ADDRESS_USAGE',
	'DRAGON_OBJECTDOCUMENT',
	'DRAGON_VEHICLE_SCHEDULE',
	'DRAGON_USER_AUTHORITY_PROFILE',
	'DRAGON_USER_REPORTING_PROFILE',
	'IMPORT_EXPORT_FILE_LOG',
	'DRAGON_INSIGHT_REQUEST'
	);
	

-- Below Table Queries to be updated	
update dr_data_reconcile_dm_metadata
set
active_tf = 0
where table_name in ('DRAGON_BILLINGACCOUNT',
	'DRAGON_EVENT',
	'DRAGON_ADDRESS_USAGE',
	'DRAGON_OBJECTDOCUMENT'
	);

commit;

