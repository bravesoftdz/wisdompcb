select WORK_ORDER_NUMBER,SALES_ORDER from Data0006 
join Data0060 on data0060.RKEY=data0006.SO_PTR
join Data0025 on data0006.BOM_PTR=data0025.RKEY and PARENT_PTR>0
where data0006.SCH_COMPL_DATE<data0060.ENT_DATE AND SALES_ORDER LIKE 's%'