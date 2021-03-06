select * from Data0097 
select * from [192.168.1.253].sj_v20_live.dbo.data0097 where LEN(PO_NUMBER)>50

alter table data0097 alter column PO_NUMBER varchar(50) 

SET IDENTITY_INSERT data0097 ON
insert into Data0097(RKEY,PO_NUMBER,CUSTOMER_PTR,PO_DATE,OPEN_SOS)
select RKEY,PO_NUMBER,CUSTOMER_PTR,PO_DATE,OPEN_SOS from  [192.168.1.253].sj_v20_live.dbo.data0097
where Data0097.CUSTOMER_PTR in (select RKEY from data0010)  and PO_DATE>='2015-01-01'

SET IDENTITY_INSERT data0097 off



select RKEY into #d25 from Data0025
select data0060.RKEY,SALES_ORDER,data0060.CUSTOMER_PTR,d25.rkey as CUST_PART_PTR,COMM_ASSIGNED_BY_E_P,CUST_SHIP_ADDR_PTR,CONF_BY_EMPL_PTR,
CSI_USER_PTR,ENTERED_BY_EMPL_PTR,MODIFIED_BY_EMPL_PTR,PURCHASE_ORDER_PTR,P_CODE,STATUS,PROD_REL,CUSTOMER_CONTACT,
PART_PRICE,set_price,TOTAL_ADD_L_PRICE,INVD_ADD_L_PRICE,PARTS_ORDERED,set_ordered,PARTS_SHIPPED,PARTS_RETURNED,
PARTS_ALLOC,PARTS_INVOICED,DISCOUNT,EXCH_RATE,ENT_DATE,DUE_DATE,SCH_DATE,CURR_SHIPMENT,CONF_DATE,MODF_DATE,
STATE_PROD_TAX_FLAG,STATE_TOOL_TAX_FLAG,COMMISION_ON_TOOLING,FOB,SHIPPING_CONTACT,SHIPPING_METHOD,COD_FLAG,
ITEM_NBR,SHIP_CONTACT_PHONE,TOOL_ITEM_NO,CURRENCY_PTR,RUSH_CHARGE,TO_BE_PLANNED,TO_BE_CONFIRMED,RMA_PTR,
ORIG_REQUEST_DATE,ORIG_SCHED_SHIP_DATE,QTY_PLANNNED,MFG_ORDER_DATE,
SO_ACK_PRINT_DATE,RUSH_CHARGE_PCT_USED, data0060.CONSUME_FORECASTS, 
data0060.BACKWARD_DAYS, data0060.FORWARD_DAYS,QUOTE_PRICE,reg_tax_fixed_unused,QTE_PTR,REPUT_QTY,REPUT_APPR_BY,
REPUT_REMARK,so_tp,supplier_ptr,ISSUED_QTY,so_style,RETURNED_SHIP,so_oldnew,tax_in_price,SHIP_REG_TAX_ID,
complete_date  into #d60 from [192.168.1.253].sj_v20_live.dbo.data0060  
inner join [192.168.1.253].sj_v20_live.dbo.data0050 on data0060.CUST_PART_PTR=data0050.RKEY 
inner  join [192.168.1.253].sj_v20_live.dbo.data0025 on data0050.RKEY=Data0025.ANCESTOR_PTR  and data0025.PARENT_PTR=0
inner  join data0025 d25 on Data0025.RKEY=d25.RKEY  
where data0060.ENT_DATE>='2016-01-01' 
drop table #d60

select RKEY,cast(SALES_ORDER as CHAR(12)) as SALES_ORDER,CUSTOMER_PTR,CUST_PART_PTR,COMM_ASSIGNED_BY_E_P,CUST_SHIP_ADDR_PTR,CONF_BY_EMPL_PTR,
CSI_USER_PTR,ENTERED_BY_EMPL_PTR,MODIFIED_BY_EMPL_PTR,PURCHASE_ORDER_PTR,P_CODE,STATUS,PROD_REL,CUSTOMER_CONTACT,
PART_PRICE,set_price,TOTAL_ADD_L_PRICE,INVD_ADD_L_PRICE,PARTS_ORDERED,set_ordered,PARTS_SHIPPED,PARTS_RETURNED,
PARTS_ALLOC,PARTS_INVOICED,DISCOUNT,EXCH_RATE,ENT_DATE,DUE_DATE,SCH_DATE,CURR_SHIPMENT,CONF_DATE,MODF_DATE,
STATE_PROD_TAX_FLAG,STATE_TOOL_TAX_FLAG,COMMISION_ON_TOOLING,FOB,SHIPPING_CONTACT,SHIPPING_METHOD,COD_FLAG,
ITEM_NBR,SHIP_CONTACT_PHONE,TOOL_ITEM_NO,CURRENCY_PTR,RUSH_CHARGE,TO_BE_PLANNED,TO_BE_CONFIRMED,RMA_PTR,
ORIG_REQUEST_DATE,ORIG_SCHED_SHIP_DATE,QTY_PLANNNED,MFG_ORDER_DATE,
SO_ACK_PRINT_DATE,RUSH_CHARGE_PCT_USED,CONSUME_FORECASTS,BACKWARD_DAYS,FORWARD_DAYS,QUOTE_PRICE,reg_tax_fixed_unused,QTE_PTR,REPUT_QTY,REPUT_APPR_BY,
REPUT_REMARK,so_tp,supplier_ptr,ISSUED_QTY,so_style,RETURNED_SHIP,so_oldnew,tax_in_price,SHIP_REG_TAX_ID,
complete_date into #D61 from #d60

select SALES_ORDER,count(SALES_ORDER) from #D61
group by SALES_ORDER
having count(SALES_ORDER)>1

select * from #D61
--delete from  #D61
where SALES_ORDER='110035686-01' and rkey =35954
select RKEY,cast(SALES_ORDER as CHAR(12)) as SALES_ORDER,CUSTOMER_PTR,CUST_PART_PTR,COMM_ASSIGNED_BY_E_P,CUST_SHIP_ADDR_PTR,CONF_BY_EMPL_PTR,
CSI_USER_PTR,ENTERED_BY_EMPL_PTR,MODIFIED_BY_EMPL_PTR,PURCHASE_ORDER_PTR,P_CODE,STATUS,PROD_REL,CUSTOMER_CONTACT,
PART_PRICE,set_price,TOTAL_ADD_L_PRICE,INVD_ADD_L_PRICE,PARTS_ORDERED,set_ordered,PARTS_SHIPPED,PARTS_RETURNED,
PARTS_ALLOC,PARTS_INVOICED,DISCOUNT,EXCH_RATE,ENT_DATE,DUE_DATE,SCH_DATE,CURR_SHIPMENT,CONF_DATE,MODF_DATE,
STATE_PROD_TAX_FLAG,STATE_TOOL_TAX_FLAG,COMMISION_ON_TOOLING,FOB,SHIPPING_CONTACT,SHIPPING_METHOD,COD_FLAG,
ITEM_NBR,SHIP_CONTACT_PHONE,TOOL_ITEM_NO,CURRENCY_PTR,RUSH_CHARGE,TO_BE_PLANNED,TO_BE_CONFIRMED,RMA_PTR,
ORIG_REQUEST_DATE,ORIG_SCHED_SHIP_DATE,QTY_PLANNNED,MFG_ORDER_DATE,
SO_ACK_PRINT_DATE,RUSH_CHARGE_PCT_USED,CONSUME_FORECASTS,BACKWARD_DAYS,FORWARD_DAYS,QUOTE_PRICE,reg_tax_fixed_unused,QTE_PTR,REPUT_QTY,REPUT_APPR_BY,
REPUT_REMARK,so_tp,supplier_ptr,ISSUED_QTY,so_style,RETURNED_SHIP,so_oldnew,tax_in_price,SHIP_REG_TAX_ID,
complete_date from #d60
where len(SALES_ORDER)>12


SET IDENTITY_INSERT data0060 ON
insert into Data0060(RKEY,SALES_ORDER,CUSTOMER_PTR,CUST_PART_PTR,COMM_ASSIGNED_BY_E_P,CUST_SHIP_ADDR_PTR,CONF_BY_EMPL_PTR,
CSI_USER_PTR,ENTERED_BY_EMPL_PTR,MODIFIED_BY_EMPL_PTR,PURCHASE_ORDER_PTR,P_CODE,STATUS,PROD_REL,CUSTOMER_CONTACT,
PART_PRICE,set_price,TOTAL_ADD_L_PRICE,INVD_ADD_L_PRICE,PARTS_ORDERED,set_ordered,PARTS_SHIPPED,PARTS_RETURNED,
PARTS_ALLOC,PARTS_INVOICED,DISCOUNT,EXCH_RATE,ENT_DATE,DUE_DATE,SCH_DATE,CURR_SHIPMENT,CONF_DATE,MODF_DATE,
STATE_PROD_TAX_FLAG,STATE_TOOL_TAX_FLAG,COMMISION_ON_TOOLING,FOB,SHIPPING_CONTACT,SHIPPING_METHOD,COD_FLAG,
ITEM_NBR,SHIP_CONTACT_PHONE,TOOL_ITEM_NO,CURRENCY_PTR,RUSH_CHARGE,TO_BE_PLANNED,TO_BE_CONFIRMED,RMA_PTR,
ORIG_REQUEST_DATE,ORIG_SCHED_SHIP_DATE,QTY_PLANNNED,MFG_ORDER_DATE,
SO_ACK_PRINT_DATE,RUSH_CHARGE_PCT_USED,CONSUME_FORECASTS,BACKWARD_DAYS,FORWARD_DAYS,QUOTE_PRICE,reg_tax_fixed_unused,QTE_PTR,REPUT_QTY,REPUT_APPR_BY,
REPUT_REMARK,so_tp,supplier_ptr,ISSUED_QTY,so_style,RETURNED_SHIP,so_oldnew,tax_in_price,SHIP_REG_TAX_ID,
complete_date )
select RKEY,SALES_ORDER,CUSTOMER_PTR,CUST_PART_PTR,COMM_ASSIGNED_BY_E_P,CUST_SHIP_ADDR_PTR,CONF_BY_EMPL_PTR,
CSI_USER_PTR,ENTERED_BY_EMPL_PTR,MODIFIED_BY_EMPL_PTR,PURCHASE_ORDER_PTR,P_CODE,STATUS,PROD_REL,CUSTOMER_CONTACT,
PART_PRICE,set_price,TOTAL_ADD_L_PRICE,INVD_ADD_L_PRICE,PARTS_ORDERED,set_ordered,PARTS_SHIPPED,PARTS_RETURNED,
PARTS_ALLOC,PARTS_INVOICED,DISCOUNT,EXCH_RATE,ENT_DATE,DUE_DATE,SCH_DATE,CURR_SHIPMENT,CONF_DATE,MODF_DATE,
STATE_PROD_TAX_FLAG,STATE_TOOL_TAX_FLAG,COMMISION_ON_TOOLING,FOB,SHIPPING_CONTACT,SHIPPING_METHOD,COD_FLAG,
ITEM_NBR,SHIP_CONTACT_PHONE,TOOL_ITEM_NO,CURRENCY_PTR,RUSH_CHARGE,TO_BE_PLANNED,TO_BE_CONFIRMED,RMA_PTR,
ORIG_REQUEST_DATE,ORIG_SCHED_SHIP_DATE,QTY_PLANNNED,MFG_ORDER_DATE,
SO_ACK_PRINT_DATE,RUSH_CHARGE_PCT_USED,CONSUME_FORECASTS,BACKWARD_DAYS,FORWARD_DAYS,QUOTE_PRICE,reg_tax_fixed_unused,QTE_PTR,REPUT_QTY,REPUT_APPR_BY,
REPUT_REMARK,so_tp,supplier_ptr, case when ISSUED_QTY IS null then 0 else ISSUED_QTY end as ISSUED_QTY,so_style,RETURNED_SHIP,so_oldnew,tax_in_price,SHIP_REG_TAX_ID,
complete_date from #D61



SET IDENTITY_INSERT data0060 off

select * from Data0062 


select * from [192.168.1.253].sj_v20_live.dbo.data0062 

set identity_insert data0062 on
 insert into Data0062(RKEY,SO_PTR,ADDL_CAT_PTR,AMOUNT,FREE_AMOUNT)
 select RKEY,SO_PTR,ADDL_CAT_PTR,AMOUNT,FREE_AMOUNT
 from [192.168.1.253].sj_v20_live.dbo.data0062 
 where SO_PTR in(select RKEY from Data0060)
 set identity_insert data0062 off


