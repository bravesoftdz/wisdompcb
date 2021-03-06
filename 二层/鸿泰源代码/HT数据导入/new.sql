SET IDENTITY_INSERT data0061 ON

insert into Data0061(RKEY,CATEGORY,tax_flag,commission_flag )
select RKEY,CATEGORY,tax_flag,commission_flag  from [192.168.1.253].sj_v20_live.dbo.data0061 AS KD0061
WHERE NOT EXISTS(SELECT RKEY FROM Data0061 WHERE Data0061.RKEY=KD0061.RKEY)
go
SET IDENTITY_INSERT data0061 off

SET IDENTITY_INSERT data0015 ON

insert into Data0015(rkey,WAREHOUSE_CODE,WAREHOUSE_NAME,ENG_NAME,ABBR_NAME,ADDRESS_LINE_1,WAREHOUSE_TYPE,purchase_order,
o_purchase_order  )
select rkey,WAREHOUSE_CODE,WAREHOUSE_NAME,ENG_NAME,ABBR_NAME,ADDRESS_LINE_1,WAREHOUSE_TYPE,purchase_order,
o_purchase_order   from [192.168.1.253].sj_v20_live.dbo.data0015 AS KD0015
WHERE NOT EXISTS(SELECT RKEY FROM Data0015 WHERE Data0015.RKEY=KD0015.RKEY)
go
SET IDENTITY_INSERT data0015 off


SET IDENTITY_INSERT data0016 ON
insert into Data0016(RKEY,CODE,LOCATION,LOCATION_TYPE,whouse_ptr )
select RKEY,CODE,LOCATION,LOCATION_TYPE,whouse_ptr   from [192.168.1.253].sj_v20_live.dbo.data0016 AS KD0016
WHERE NOT EXISTS(SELECT RKEY FROM Data0016 WHERE Data0016.RKEY=KD0016.RKEY)
go
SET IDENTITY_INSERT data0016 off

SET IDENTITY_INSERT data0007 ON
insert into Data0007(RKEY,PR_GRP_CODE,PRODUCT_GROUP_NAME,PR_GRP_SEEDVALUE,PR_GRP_INCREMENTBY  )
select RKEY,PR_GRP_CODE,PRODUCT_GROUP_NAME,PR_GRP_SEEDVALUE,PR_GRP_INCREMENTBY   from [192.168.1.253].sj_v20_live.dbo.data0007 AS KD0007
WHERE NOT EXISTS(SELECT RKEY FROM Data0007 WHERE Data0007.RKEY=KD0007.RKEY)
go
SET IDENTITY_INSERT data0007 off

SET IDENTITY_INSERT data0007 ON
insert into Data0007(RKEY,PR_GRP_CODE,PRODUCT_GROUP_NAME,PR_GRP_SEEDVALUE,PR_GRP_INCREMENTBY  )
select RKEY,PR_GRP_CODE,PRODUCT_GROUP_NAME,PR_GRP_SEEDVALUE,PR_GRP_INCREMENTBY   from [192.168.1.253].sj_v20_live.dbo.data0007 AS KD0007
WHERE NOT EXISTS(SELECT RKEY FROM Data0007 WHERE Data0007.RKEY=KD0007.RKEY)
go
SET IDENTITY_INSERT data0007 off

SET IDENTITY_INSERT data0008 ON
insert into Data0008(RKEY,PROD_CODE,PRODUCT_NAME,PR_GRP_POINTER,LEAD_TIME,OPT_LOT_SIZE,MAX_DAYS_EARLY_BUILD,
 PROD_SEEDVALUE,PROD_INCREMENTBY,EST_SCRAP,EST_SCRAP1,difficulty_grade,difficulty_grade_value,DG_ADJ_PTH  ,DG_ADJ_NPTH ,REVIEW_DAYS,batch_flag,former_flag)
 select RKEY,PROD_CODE,PRODUCT_NAME,PR_GRP_POINTER,LEAD_TIME,OPT_LOT_SIZE,MAX_DAYS_EARLY_BUILD,
 PROD_SEEDVALUE,PROD_INCREMENTBY,EST_SCRAP,EST_SCRAP1,difficulty_grade,difficulty_grade_value, 
 case when DG_ADJ_PTH is null then 0.00 else DG_ADJ_PTH end as DG_ADJ_PTH, 
  case when DG_ADJ_NPTH is null then 0.00 else DG_ADJ_NPTH end as DG_ADJ_NPTH ,
    case when REVIEW_DAYS is null then 1 else REVIEW_DAYS end  as REVIEW_DAYS,0 as batch_flag,0 as former_flag
from [192.168.1.253].sj_v20_live.dbo.data0008 AS KD0008
WHERE NOT EXISTS(SELECT RKEY FROM Data0008 WHERE Data0008.RKEY=KD0008.RKEY)
go
SET IDENTITY_INSERT data0008 off

SET IDENTITY_INSERT data0189 ON
insert into Data0189(RKEY,STATE_ID,STATE_TAX,NAME )
select RKEY,STATE_ID,STATE_TAX,NAME  from [192.168.1.253].sj_v20_live.dbo.data0189 AS KD0189
WHERE NOT EXISTS(SELECT RKEY FROM Data0189 WHERE Data0189.RKEY=KD0189.RKEY)
go
SET IDENTITY_INSERT data0189 off



SET IDENTITY_INSERT data0504 ON
insert into Data0504( RKEY,ENG_FLOW_NAME,ENG_FLOW_DESC  )
select  RKEY,ENG_FLOW_NAME,ENG_FLOW_DESC   from [192.168.1.253].sj_v20_live.dbo.data0504 AS KD0504
WHERE NOT EXISTS(SELECT RKEY FROM Data0504 WHERE Data0504.RKEY=KD0504.RKEY)
go
SET IDENTITY_INSERT data0504 off

SET IDENTITY_INSERT data0505 ON
insert into Data0505( RKEY,TTYPE,DEPT_PTR,NODE_NAME,PARENT,SUPERVISOR_PTR,Formula,Step,Eng_Flow_ptr )
select  RKEY,TTYPE, case when DEPT_PTR in(162,254) then 41 else DEPT_PTR end as DEPT_PTR,NODE_NAME,PARENT,SUPERVISOR_PTR,Formula,Step,Eng_Flow_ptr   from [192.168.1.253].sj_v20_live.dbo.data0505 AS KD0505
WHERE NOT EXISTS(SELECT RKEY FROM Data0505 WHERE Data0505.RKEY=KD0505.RKEY)
go
SET IDENTITY_INSERT data0505 off

select  RKEY,EMPL_PTR,LOGIN_NAME,PRIV  into #KD0486 from [192.168.1.253].sj_v20_live.dbo.data0486  where rkey<>185 
SET IDENTITY_INSERT data0486 ON
insert into Data0486( RKEY,EMPL_PTR,LOGIN_NAME,PRIV  )
select RKEY,EMPL_PTR,LOGIN_NAME,PRIV   from #KD0486 
WHERE NOT EXISTS(SELECT RKEY FROM Data0486 WHERE Data0486.RKEY=#KD0486.RKEY)
go
drop table #KD0486

SET IDENTITY_INSERT data0486 off


SET IDENTITY_INSERT data0039 ON
insert into Data0039( RKEY,REJ_CODE,REJECT_DESCRIPTION,REJECT_DEFECT_FLAG )
select RKEY,REJ_CODE,REJECT_DESCRIPTION,REJECT_DEFECT_FLAG  from [192.168.1.253].sj_v20_live.dbo.data0039 AS KD0039
WHERE NOT EXISTS(SELECT RKEY FROM Data0039 WHERE Data0039.RKEY=KD0039.RKEY)
go
SET IDENTITY_INSERT data0039 off


SET IDENTITY_INSERT data0076 ON
insert into Data0076( RKEY,CODE,REJECT_DESCRIPTION)
select RKEY,CODE,REJECT_DESCRIPTION from [192.168.1.253].sj_v20_live.dbo.data0076 AS KD0076
WHERE NOT EXISTS(SELECT RKEY FROM Data0076 WHERE Data0076.RKEY=KD0076.RKEY)
go
SET IDENTITY_INSERT data0076 off

alter table data0010  alter  column cust_code varchar(50)
alter table data0010  alter  column  ABBR_NAME varchar(20)

alter table data0010  alter  column BILLING_ADDRESS_1 varchar(100)
alter table data0010  alter  column  BILLING_ADDRESS_2  varchar(100)
alter table data0010  alter  column BILLING_ADDRESS_3 varchar(100)
alter table data0010  alter  column  ABBR_NAME varchar(20)
,BILLING_ADDRESS_2,BILLING_ADDRESS_3,
SET IDENTITY_INSERT data0010 ON

insert into Data0010( RKEY,CUST_CODE,CUSTOMER_NAME,BILLING_ADDRESS_1,BILLING_ADDRESS_2,BILLING_ADDRESS_3,STATE,
ZIP,PHONE,FAX,TELEX,SALES_REP_PTR,CURRENCY_PTR,INVOICE_NOTE_PAD_PTR,CONTACT_NAME_1,CONTACT_NAME_2,CONTACT_NAME_3,
CONTACT_NAME_4,CONTACT_NAME_5,CONTACT_NAME_6,CONT_PHONE_1,CONT_PHONE_2,CONT_PHONE_3,
CONT_PHONE_4,CONT_PHONE_5,CONT_PHONE_6,FED_TAX_ID_NO,COFC_FILENAME,COD_FLAG,REG_TAX_FIXED_UNUSED,
DISCOUNT_PCT,HIGH_BALANCE,CREDIT_LIMIT,CREDIT_RATING,BALANCE_DUE,OUTSTANDING_CREDIT,DISCOUNT_DAYS,
CURRENT_BOOKINGS,NET_PAY,LAST_ACTIVE_DATE,LANGUAGE_FLAG,BILLING_ADDRESS_4,COUNTRY_PTR,INTERNAL_ECN_COUNT,EXTERNAL_ECN_COUNT,
OUTGOING_FORM_NAME,OUTGOING_FORM_ADDR1,OUTGOING_FORM_ADDR2,OUTGOING_FORM_ADDR3,
ANALYSIS_CODE1,ANALYSIS_CODE2,ANALYSIS_CODE3,CUST_ENT_DATE,EDI_ID,EDI_FLAG_FOR_SOACK,
EDI_FLAG_FOR_INVOICE,EDI_FLAG_CREDIT_MEMO,GEN_EMAIL_ADDRESS,EMAIL_FOR_CONTACT1,EMAIL_FOR_CONTACT2,
EMAIL_FOR_CONTACT3,EMAIL_FOR_CONTACT4,EMAIL_FOR_CONTACT5,EMAIL_FOR_CONTACT6,ACC_REC_PTR,
CONSUME_FORECASTS,BACKWARD_DAYS,FORWARD_DAYS,PLANNING_HORIZON,RAW_HORIZON,VISIBILITY_HORIZON,
DAYS_EARLY_SCHEDULE,APPLY_IN_TRANSIT,CUSTOMER_TYPE,DO_SMOOTHING,SMOOTHING_THRESHOLD,
ANALYSIS_CODE4,ANALYSIS_CODE5,EDI_IN_LOGGING,quote_factor,QUOTE_FACTOR1,REP_EVAL,MAK_EVAL,
FIN_EVAL,MARMANG_EVAL,REP_CREDIT,MAK_CREDIT,FIN_CREDIT,MARMANG_CREDIT,REP_HIGH,MAK_HIGH,
FIN_HIGH,MARMANG_HIGH,REP_NAME,MAK_NAME,FIN_NAME,MARMANG_NAME,REP_DATE,MAK_DATE,
FIN_DATE,MARMANG_DATE,HOUSE_FIXED,FIXED_SCOPE,SALES_DISCOUNT,MONTH_AMOUNT,MONTH_PCBAMOUNT,
CAPITAL)select RKEY,CUST_CODE,CUSTOMER_NAME,BILLING_ADDRESS_1,BILLING_ADDRESS_2,BILLING_ADDRESS_3,STATE,
ZIP,PHONE,FAX,TELEX,SALES_REP_PTR,CURRENCY_PTR,INVOICE_NOTE_PAD_PTR,CONTACT_NAME_1,CONTACT_NAME_2,CONTACT_NAME_3,
CONTACT_NAME_4,CONTACT_NAME_5,CONTACT_NAME_6,CONT_PHONE_1,CONT_PHONE_2,CONT_PHONE_3,
CONT_PHONE_4,CONT_PHONE_5,CONT_PHONE_6,FED_TAX_ID_NO,COFC_FILENAME,COD_FLAG,REG_TAX_FIXED_UNUSED,
DISCOUNT_PCT,HIGH_BALANCE,CREDIT_LIMIT,CREDIT_RATING,BALANCE_DUE,OUTSTANDING_CREDIT,DISCOUNT_DAYS,
CURRENT_BOOKINGS,NET_PAY,LAST_ACTIVE_DATE,LANGUAGE_FLAG,BILLING_ADDRESS_4,COUNTRY_PTR,INTERNAL_ECN_COUNT,EXTERNAL_ECN_COUNT,
OUTGOING_FORM_NAME,OUTGOING_FORM_ADDR1,OUTGOING_FORM_ADDR2,OUTGOING_FORM_ADDR3,
ANALYSIS_CODE1,ANALYSIS_CODE2,ANALYSIS_CODE3,CUST_ENT_DATE,EDI_ID,EDI_FLAG_FOR_SOACK,
EDI_FLAG_FOR_INVOICE,EDI_FLAG_CREDIT_MEMO,GEN_EMAIL_ADDRESS,EMAIL_FOR_CONTACT1,EMAIL_FOR_CONTACT2,
EMAIL_FOR_CONTACT3,EMAIL_FOR_CONTACT4,EMAIL_FOR_CONTACT5,EMAIL_FOR_CONTACT6,ACC_REC_PTR,
CONSUME_FORECASTS,BACKWARD_DAYS,FORWARD_DAYS,PLANNING_HORIZON,RAW_HORIZON,VISIBILITY_HORIZON,
DAYS_EARLY_SCHEDULE,APPLY_IN_TRANSIT,CUSTOMER_TYPE,DO_SMOOTHING,SMOOTHING_THRESHOLD,
ANALYSIS_CODE4,ANALYSIS_CODE5,EDI_IN_LOGGING,quote_factor,QUOTE_FACTOR1,REP_EVAL,MAK_EVAL,
FIN_EVAL,MARMANG_EVAL,REP_CREDIT,MAK_CREDIT,FIN_CREDIT,MARMANG_CREDIT,REP_HIGH,MAK_HIGH,
FIN_HIGH,MARMANG_HIGH,REP_NAME,MAK_NAME,FIN_NAME,MARMANG_NAME,REP_DATE,MAK_DATE,
FIN_DATE,MARMANG_DATE,HOUSE_FIXED,FIXED_SCOPE,SALES_DISCOUNT,MONTH_AMOUNT,MONTH_PCBAMOUNT,
CAPITAL from [192.168.1.253].sj_v20_live.dbo.data0010  AS KD0010
WHERE NOT EXISTS(SELECT RKEY FROM Data0010 WHERE Data0010.RKEY=KD0010.RKEY)
go
SET IDENTITY_INSERT data0010 off



select ABBR_NAME,* from Data0025

select 
RKEY,CUST_CODE,CUSTOMER_NAME,ABBR_NAME,BILLING_ADDRESS_1,BILLING_ADDRESS_2,BILLING_ADDRESS_3,STATE,
ZIP,PHONE,FAX,TELEX,SALES_REP_PTR,CURRENCY_PTR,INVOICE_NOTE_PAD_PTR,CONTACT_NAME_1,CONTACT_NAME_2,CONTACT_NAME_3,
CONTACT_NAME_4,CONTACT_NAME_5,CONTACT_NAME_6,CONT_PHONE_1,CONT_PHONE_2,CONT_PHONE_3,
CONT_PHONE_4,CONT_PHONE_5,CONT_PHONE_6,FED_TAX_ID_NO,COFC_FILENAME,COD_FLAG,REG_TAX_FIXED_UNUSED,
DISCOUNT_PCT,HIGH_BALANCE,CREDIT_LIMIT,CREDIT_RATING,BALANCE_DUE,OUTSTANDING_CREDIT,DISCOUNT_DAYS,
CURRENT_BOOKINGS,NET_PAY,LAST_ACTIVE_DATE,LANGUAGE_FLAG,BILLING_ADDRESS_4,COUNTRY_PTR,INTERNAL_ECN_COUNT,EXTERNAL_ECN_COUNT,
OUTGOING_FORM_NAME,OUTGOING_FORM_ADDR1,OUTGOING_FORM_ADDR2,OUTGOING_FORM_ADDR3,
ANALYSIS_CODE1,ANALYSIS_CODE2,ANALYSIS_CODE3,CUST_ENT_DATE,EDI_ID,EDI_FLAG_FOR_SOACK,
EDI_FLAG_FOR_INVOICE,EDI_FLAG_CREDIT_MEMO,GEN_EMAIL_ADDRESS,EMAIL_FOR_CONTACT1,EMAIL_FOR_CONTACT2,
EMAIL_FOR_CONTACT3,EMAIL_FOR_CONTACT4,EMAIL_FOR_CONTACT5,EMAIL_FOR_CONTACT6,ACC_REC_PTR,
CONSUME_FORECASTS,BACKWARD_DAYS,FORWARD_DAYS,PLANNING_HORIZON,RAW_HORIZON,VISIBILITY_HORIZON,
DAYS_EARLY_SCHEDULE,APPLY_IN_TRANSIT,CUSTOMER_TYPE,DO_SMOOTHING,SMOOTHING_THRESHOLD,
ANALYSIS_CODE4,ANALYSIS_CODE5,EDI_IN_LOGGING,quote_factor,QUOTE_FACTOR1,REP_EVAL,MAK_EVAL,
FIN_EVAL,MARMANG_EVAL,REP_CREDIT,MAK_CREDIT,FIN_CREDIT,MARMANG_CREDIT,REP_HIGH,MAK_HIGH,
FIN_HIGH,MARMANG_HIGH,REP_NAME,MAK_NAME,FIN_NAME,MARMANG_NAME,REP_DATE,MAK_DATE,
FIN_DATE,MARMANG_DATE,HOUSE_FIXED,FIXED_SCOPE,SALES_DISCOUNT,MONTH_AMOUNT,MONTH_PCBAMOUNT
CAPITAL from [192.168.1.253].sj_v20_live.dbo.Data0010 

select  top 10 * from [192.168.1.253].sj_v20_live.dbo.Data0010 
go
sp_help data0010

select RKEY,PROD_CODE,PRODUCT_NAME,PR_GRP_POINTER,LEAD_TIME,OPT_LOT_SIZE,MAX_DAYS_EARLY_BUILD,
 PROD_SEEDVALUE,PROD_INCREMENTBY,EST_SCRAP,EST_SCRAP1,difficulty_grade,difficulty_grade_value,DG_ADJ_PTH,DG_ADJ_NPTH
 from [192.168.1.253].sj_v20_live.dbo.data0008
go
sp_help data0010

select * from Data0010 