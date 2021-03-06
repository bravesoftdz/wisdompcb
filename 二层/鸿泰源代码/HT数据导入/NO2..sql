SET IDENTITY_INSERT data0504 ON
insert into Data0504( RKEY,ENG_FLOW_NAME,ENG_FLOW_DESC  )
select  RKEY,ENG_FLOW_NAME,ENG_FLOW_DESC   from [192.168.1.253].sj_v20_live.dbo.data0504 AS KD0504
WHERE NOT EXISTS(SELECT RKEY FROM Data0504 WHERE Data0504.RKEY=KD0504.RKEY)
go
SET IDENTITY_INSERT data0504 off



SET IDENTITY_INSERT data0017 ON
insert into Data0017( RKEY,INV_PART_NUMBER,INV_NAME,INV_DESCRIPTION,
GROUP_PTR,P_M,S_B_N,INSPECT,STOP_PURCH,MIX_PARTS,PHY_COUNT_METHOD,BOM_FLAG,COST_METHOD,
STOCK_UNIT_PTR,PURCH_UNIT_PTR,PREF_SUPPLIER_PTR,STOCK_PURCH,STOCK_QUOTE,STD_COST,SHELF_LIFE,AVL_FLAG,
CONSIGNMENT_FLAG,ACTIVE_FLAG,QUAN_ON_HAND,QUAN_ASSIGN,AUTO_PURCHASE_FLAG ,CRITICAL_MATL_FLAG)
select RKEY,INV_PART_NUMBER,INV_NAME,INV_DESCRIPTION,
GROUP_PTR,P_M,S_B_N,INSPECT,STOP_PURCH,MIX_PARTS,PHY_COUNT_METHOD,BOM_FLAG,COST_METHOD,
STOCK_UNIT_PTR,PURCH_UNIT_PTR,PREF_SUPPLIER_PTR,STOCK_PURCH,STOCK_QUOTE,STD_COST,SHELF_LIFE,AVL_FLAG,
CONSIGNMENT_FLAG,ACTIVE_FLAG,QUAN_ON_HAND,QUAN_ASSIGN,0 as AUTO_PURCHASE_FLAG,0 as CRITICAL_MATL_FLAG from [192.168.1.253].sj_v20_live.dbo.data0017 as KD0017
WHERE NOT EXISTS(SELECT RKEY FROM Data0017  WHERE Data0017.RKEY=KD0017.RKEY)
go
set identity_insert data0017 off


select NETWORK_IP,*  from [192.168.1.253].sj_v20_live.dbo.data0073
where remark<>''

SET IDENTITY_INSERT data0073 ON
insert into Data0073( RKEY,USER_FULL_NAME,USER_LOGIN_NAME,USER_GROUP_FLAG,LANGUAGE_FLAG,
GROUP_PTR,EMPLOYEE_PTR,NETWORK_ID,COMPUTER,ACTIVE_FLAG,LOGIN_IN_TIME,rpl_pr_ptr,rpl_po_ptr,
reject_flag,message_flag,flag)
select RKEY,USER_FULL_NAME,USER_LOGIN_NAME,USER_GROUP_FLAG,LANGUAGE_FLAG,
GROUP_PTR,EMPLOYEE_PTR,NETWORK_ID,COMPUTER,ACTIVE_FLAG,LOGIN_IN_TIME,rpl_pr_ptr,rpl_po_ptr,
reject_flag,message_flag,flag from [192.168.1.253].sj_v20_live.dbo.data0073 as kd0073
WHERE NOT EXISTS(SELECT RKEY FROM Data0073  WHERE Data0073.RKEY=KD0073.RKEY)
go
set identity_insert data0073 off



SET IDENTITY_INSERT data0028 ON
insert into Data0028 (RKEY,SUPPLIER_PTR,INVENTORY_PTR,EMPLOYEE_PTR,CSI_USER_PTR,TDATE,SUPPLIER_PART_NO,
LEAD_TIME,AMT_QUAN_FLAG,TAX_1,TAX_2,PRICE_1,PRICE_2,PRICE_3,PRICE_4,PRICE_5,PRICE_6,
DISC_1,DISC_2,DISC_3,DISC_4,DISC_5,DISC_6,TAX_3,TAX_4,PURCHASE_UNIT_PTR,CONVERSION_FACTOR,
AVL_FLAG,CURRENCY_PTR,EDI_OUT_FORCST,qte_price,tax_flag,qte_price2,QTE_PRICE1,SUGG_REORDER_QTY,
MIN_ORDER_QTY,MIN_ORDER_AMT,QUAN_VOL_1,QUAN_VOL_2,QUAN_VOL_3,QUAN_VOL_4,QUAN_VOL_5)
select RKEY,SUPPLIER_PTR,INVENTORY_PTR, case when EMPLOYEE_PTR in (23,29,15)   then 1 else EMPLOYEE_PTR end  as EMPLOYEE_PTR  ,CSI_USER_PTR,TDATE,SUPPLIER_PART_NO,
LEAD_TIME,AMT_QUAN_FLAG,TAX_1,TAX_2,PRICE_1,PRICE_2,PRICE_3,PRICE_4,PRICE_5,PRICE_6,
DISC_1,DISC_2,DISC_3,DISC_4,DISC_5,DISC_6,TAX_3,TAX_4,PURCHASE_UNIT_PTR,CONVERSION_FACTOR,
AVL_FLAG,CURRENCY_PTR,EDI_OUT_FORCST,qte_price,tax_flag,qte_price2,QTE_PRICE1,0 as SUGG_REORDER_QTY,
 0 as MIN_ORDER_QTY,0 as MIN_ORDER_AMT, QUAN_VOL_1,QUAN_VOL_2,QUAN_VOL_3,QUAN_VOL_4,QUAN_VOL_5
  from [192.168.1.253].sj_v20_live.dbo.data0028 as kd0028
WHERE NOT EXISTS(SELECT RKEY FROM Data0028  WHERE Data0028.RKEY=KD0028.RKEY)

go
SET IDENTITY_INSERT data0028 off




select * from Data0025 

sp_help Data0025
SET IDENTITY_INSERT data0025 ON
insert into Data0025 (
 RKEY,MANU_PART_NUMBER,MANU_PART_DESC,ANCESTOR_PTR,PARENT_PTR,QTY_BOM,
BOM_STEP,CREATED_BY_EMPL_PTR,CURRENT_REV,ENG_ROUTE_PTR,PROD_ROUTE_PTR,REMARK,
ENG_NOTE,OPT_LOT_SIZE,OPT_CUT_SIZE,EST_SCRAP,
SHELF_LIFE,REVIEW_DAYS,tot_accu_matl_per_sqft,tot_accu_OVHD_per_sqft,      
CUSTOMER_PTR,LAST_SO_DATE,REPORT_UNIT_VALUE1,TSTATUS,CHECK_BY_PTR,CHECK_DATE, ---50
AUDITED_BY_PTR,AUDITED_DATE,ALLOW_EDIT_FLAG,ONHOLD_SALES_FLAG,ONHOLD_RELEASE_FLAG, ---50
ONHOLD_PLANNING_FLAG,CUSTPART_ENT_DATE,LAST_MODIFIED_BY_PTR,LAST_MODIFIED_DATE,LATEST_PRICE, ---50
ANALYSIS_CODE_2,--59
LAYERS,green_flag,set_lngth,set_width,set_qty,unit_sq,ANALYSIS_CODE_1,---50
spell_qty,spell_sq,ttype,PROD_CODE_PTR,barcode_flag --50
)
select RKEY,cast(MANU_PART_NUMBER as varchar(20)) as MANU_PART_NUMBER,cast(MANU_PART_DESC as varchar(80)) as MANU_PART_DESC,ANCESTOR_PTR,
case when PARENT_PTR=0 then null else PARENT_PTR end as PARENT_PTR  ,QTY_BOM,
BOM_STEP,CREATED_BY_EMPL_PTR,CURRENT_REV,ENG_ROUTE_PTR,2 as PROD_ROUTE_PTR,REMARK,
ENG_NOTE, OPT_LOT_SIZE,OPT_CUT_SIZE,EST_SCRAP,
SHELF_LIFE,REVIEW_DAYS,tot_accu_matl_per_sqft,tot_accu_OVHD_per_sqft,      
CUSTOMER_PTR,LAST_SO_DATE,REPORT_UNIT_VALUE1,TSTATUS,CHECK_BY_PTR,CHECK_DATE, ---50
AUDITED_BY_PTR,AUDITED_DATE,ALLOW_EDIT_FLAG,ONHOLD_SALES_FLAG,ONHOLD_RELEASE_FLAG, ---50
ONHOLD_PLANNING_FLAG,CUSTPART_ENT_DATE,LAST_MODIFIED_BY_PTR,LAST_MODIFIED_DATE, 
case when LATEST_PRICE IS null then 0.00 else LATEST_PRICE  end as LATEST_PRICE  , ---50
ANALYSIS_CODE_2,--59
LAYERS,green_flag,
case when  set_lngth IS null then 0.00 else set_lngth end as set_lngth,
case when  set_width IS null then 0.00  else set_width end as set_width ,case when set_qty IS null then 0.00 else set_qty end as set_qty,
case when  unit_sq IS null then 0.00 else unit_sq end as unit_sq,ANALYSIS_CODE_1,---50
case when spell_qty IS null then 0.00 else spell_qty end as spell_qty ,
case when spell_sq IS null then 0.00 else spell_sq end as spell_sq ,
ttype,PROD_CODE_PTR,barcode_flag from #66  as KD0025
WHERE NOT EXISTS(SELECT RKEY FROM Data0025  WHERE Data0025.RKEY=KD0025.RKEY)

SET IDENTITY_INSERT data0025 off

select * from Data0025 


select PROD_CODE_PTR,* from #66 
--update #66 set PROD_CODE_PTR=2  
 where PROD_CODE_PTR is null
 

go
SET IDENTITY_INSERT data0025 off

select cust_part_ptr into #22 from [192.168.1.253].sj_v20_live.dbo.data0059 
group by  cust_part_ptr
having count(cust_part_ptr)>1 
order by cust_part_ptr 

select count(MANU_PART_NUMBER) as rkey  ,MANU_PART_NUMBER into  #11 from #22
group by MANU_PART_NUMBER 
having count(MANU_PART_NUMBER)>1

select distinct MANU_PART_NUMBER  from #22


---一个本厂料号对应多个客户型号和料号---
select MAX(rkey ) as rkey  into #10  from [192.168.1.253].sj_v20_live.dbo.data0059
group  by cust_part_ptr
having cust_part_ptr in(
select cust_part_ptr from [192.168.1.253].sj_v20_live.dbo.data0059 
group by  cust_part_ptr
having count(cust_part_ptr)>1  )
order by cust_part_ptr


select rkey  into #d59 from [192.168.1.253].sj_v20_live.dbo.data0059
where cust_part_ptr in(
select cust_part_ptr from [192.168.1.253].sj_v20_live.dbo.data0059 
group by  cust_part_ptr
having count(cust_part_ptr)>1  ) and rkey not in
(select * from #10)



select data0025.rkey, case when data0025.PARENT_PTR>0  then data0050.CUSTOMER_PART_NUMBER+data0050.cp_rev+'.'+Data0025.MANU_PART_NUMBER
else data0050.CUSTOMER_PART_NUMBER+data0050.cp_rev end as MANU_PART_NUMBER,data0059.customer_part_desc as MANU_PART_DESC,
data0025.ANCESTOR_PTR,data0025.PARENT_PTR,data0025.qty_bom,
data0025.BOM_STEP,data0025.CREATED_BY_EMPL_PTR,data0025.CURRENT_REV,data0025.ENG_ROUTE_PTR,data0025.PROD_ROUTE_PTR,data0025.REMARK,
data0025.ENG_NOTE,data0025.PROD_CODE_PTR,data0025.OPT_LOT_SIZE,data0025.OPT_CUT_SIZE,data0025.EST_SCRAP,
data0025.SHELF_LIFE,data0025.REVIEW_DAYS,data0025.tot_accu_matl_per_sqft,data0025.tot_accu_OVHD_per_sqft, 
data0059.customer_ptr as CUSTOMER_PTR,data0050.LAST_SO_DATE,data0050.REPORT_UNIT_VALUE1,
case when  data0050.TSTATUS = 9 then 1 when data0050.TSTATUS = 6 then 2  when data0050.TSTATUS = 1 then 3
when data0050.TSTATUS = 2 then 4 when data0050.TSTATUS = 5 then 5  else 0 end  as TSTATUS, 
data0050.CHECK_BY_PTR,data0050.CHECK_DATE, ---50
data0050.AUDITED_BY_PTR,data0050.AUDITED_DATE,data0050.ALLOW_EDIT_FLAG,data0059.ONHOLD_SALES_FLAG,data0050.ONHOLD_RELEASE_FLAG, ---50
data0050.ONHOLD_PLANNING_FLAG,data0050.CUSTPART_ENT_DATE,data0050.LAST_MODIFIED_BY_PTR,data0050.LAST_MODIFIED_DATE,data0050.LATEST_PRICE,
data0059.customer_matl_desc as ANALYSIS_CODE_2,--59
data0050.LAYERS,data0050.green_flag,data0050.set_lngth,data0050.set_width,data0050.set_x_qty * data0050.set_y_qty as set_qty,data0050.unit_sq,data0050.ANALYSIS_CODE_1,---50
data0050.set_x_qty * data0050.set_y_qty  as spell_qty,data0050.unit_sq as spell_sq,data0050.ttype,data050.rspec_FLAG_1 as barcode_flag --50
  into  #66 from [192.168.1.253].sj_v20_live.dbo.data0050 inner join [192.168.1.253].sj_v20_live.dbo.data0025 on data0050.rkey =data0025.ancestor_ptr
left join  (select * from [192.168.1.253].sj_v20_live.dbo.data0059 where rkey not in (select rkey from #d59)) data0059 on data0059.cust_part_ptr=data0050.rkey 

drop table #66





select  RKEY,MANU_PART_NUMBER,MANU_PART_DESC,ANCESTOR_PTR,PARENT_PTR,QTY_BOM,
BOM_STEP,CREATED_BY_EMPL_PTR,CURRENT_REV,ENG_ROUTE_PTR,PROD_ROUTE_PTR,REMARK,
ENG_NOTE,PROD_CODE_PTR,OPT_LOT_SIZE,OPT_CUT_SIZE,EST_SCRAP,
SHELF_LIFE,REVIEW_DAYS,tot_accu_matl_per_sqft,tot_accu_OVHD_per_sqft,      
CUSTOMER_PTR,LAST_SO_DATE,REPORT_UNIT_VALUE1,TSTATUS,CHECK_BY_PTR,CHECK_DATE, ---50
AUDITED_BY_PTR,AUDITED_DATE,ALLOW_EDIT_FLAG,ONHOLD_SALES_FLAG,ONHOLD_RELEASE_FLAG, ---50
ONHOLD_PLANNING_FLAG,CUSTPART_ENT_DATE,LAST_MODIFIED_BY_PTR,LAST_MODIFIED_DATE,LATEST_PRICE, ---50
ANALYSIS_CODE_2,--59
LAYERS,green_flag,set_lngth,set_width,set_qty,unit_sq,ANALYSIS_CODE_1,---50
spell_qty,spell_sq,ttype from data0025