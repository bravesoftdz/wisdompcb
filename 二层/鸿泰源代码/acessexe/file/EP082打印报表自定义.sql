--EP082打印报表自定义
ALTER PROCEDURE [dbo].[user_defined_sp_ep082_1] 
@vptr int

AS

  select Data0050.CUSTOMER_PART_NUMBER,Data0050.CP_REV,data0059.fin_customer_name,
     DATA0552.HDI_BMP 
  from Data0006 
    --inner join Data0025 on Data0006.BOM_PTR=Data0025.RKEY
    --inner join Data0050 on Data0025.ANCESTOR_PTR=Data0050.RKEY
    inner join data0492 on Data0006.CUT_NO=data0492.cut_no
    inner join Data0060 on data0492.SO_NO=Data0060.sales_order
    inner join Data0050 on Data0060.CUST_PART_PTR=Data0050.rkey
    inner join data0059 on Data0060.CUSTOMER_PTR=data0059.customer_ptr
      and Data0060.cust_part_ptr=data0059.cust_part_ptr
    left join DATA0552 on Data0050.RKEY=DATA0552.SOURCE_PTR
    where Data0006.RKEY=@vptr