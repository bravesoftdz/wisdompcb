--替代流提交

exec sp_executesql N'UPDATE "SJ_V20_live".."Data0054" 
SET "Tstatus"=@P1 --0未提交，1：待一审；2：待二审；5：一审退；6:二审退；7：三审退；9：通过
WHERE "RKEY"=@P2 AND "Tstatus"=@P3',N'@P1 smallint,@P2 int,@P3 smallint',1,1103,0

--查看
exec sp_executesql N'SELECT Data0050.RKEY, Data0050.CUSTOMER_PART_NUMBER,data0054.remark,
      Data0059.CUSTOMER_PART_DESC, Data0050.CP_REV,Data0054.bom_appr_by,Data0054.bom_appr_date,Data0054.BOM_STATUS,
      Data0059.CUSTOMER_PTR,Data0050.sub_flow_Num,
      Data0054.rkey as rkey_1,Data0054.cust_part_ptr,Data0054.flow_no,
      Data0054.Audited_by_ptr,Data0054.Audited_date,data0054.Tstatus,
      Data0054.MODIFIed_by_ptr,Data0054.MODIFIed_date,data0054.audited_by_ptr_2,
      data0054.audited_by_ptr_3,data0054.check_by_ptr,data0054.check_date,
      data0054.audited_date_2,data0054.audited_date_3
FROM Data0059,Data0050 INNER JOIN
      Data0054 ON Data0050.RKEY = Data0054.CUST_PART_PTR
where ((modified_date>=@P1 and modified_date<=@P2) or modified_date is null) and data0059.cust_part_ptr=data0050.rkey
ORDER BY Data0050.CUSTOMER_PART_NUMBER,Data0054.flow_no
 
 
 
 
',N'@P1 datetime,@P2 datetime','2013-04-17 00:00:00','2013-06-16 00:00:00'