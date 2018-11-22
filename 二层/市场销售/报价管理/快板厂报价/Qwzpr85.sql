

if exists (select * from sysobjects where id = object_id(N'Qwzpr85') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
    drop PROCEDURE Qwzpr85
GO


CREATE PROCEDURE Qwzpr85;1  --ѡ�񱨼۵�������
  @vdate1 datetime,
  @vdate2 datetime,
  @CUST_PART_NO varchar(40), --�ͻ��ͺ�
  @tnumber varchar(10), --���۵���
  @CUST_NAME varchar(100),--�ͻ�����
  @CUSTOMER_PART_NUMBER  varchar(20),--�������
  @EMPLOYEE_NAME varchar(16) --�޶���
AS 
BEGIN
   declare @vdate1_1 datetime,
           @vdate2_1 datetime
   set @vdate1_1 = @vdate1  --+' 00:00:00'
   set @vdate2_1 =@vdate2   --+' 23:59:59'
   SELECT Data0085.*   --,Data0001.CURR_CODE,Data0001.CURR_NAME
     FROM Data0085 --LEFT OUTER JOIN
          --Data0005 ON 
          --Data0085.QBY_EMPL_PTR = Data0005.RKEY LEFT OUTER JOIN
          --Data0001 ON Data0085.CURR_PTR = Data0001.RKEY
     where data0085.TTYPE in (2,3)
          and ENTER_DATE>=@VDATE1_1 AND ENTER_DATE<@VDATE2_1
          --and data0085.REF_PART_NO like @REF_PART_NO
          and data0085.CUST_PART_NO like @CUST_PART_NO
          and data0085.tnumber like @tnumber
          and data0085.CUST_NAME like @CUST_NAME
           --and data0085.CUST_PTR in (select data0010.rkey FROM data0010 where CUSTOMER_NAME like @CUST_NAME)
          and data0085.ref_part_no like @CUSTOMER_PART_NUMBER
          --and data0085.CUST_PART_PTR in (select data0050.rkey FROM data0050 where CUSTOMER_PART_NUMBER like @CUSTOMER_PART_NUMBER)
          and data0085.QBY_EMPL_PTR in (select data0005.rkey FROM data0005 where EMPLOYEE_NAME like @EMPLOYEE_NAME)
     ORDER BY Data0085.TNUMBER
/* ����������
SELECT Data0085.*
FROM Data0010 RIGHT OUTER JOIN
      Data0085 LEFT OUTER JOIN
      Data0008 ON 
      Data0085.PROD_CODE_PTR = Data0008.RKEY LEFT OUTER JOIN
      Data0050 ON 
      Data0085.CUST_PART_PTR = Data0050.RKEY LEFT OUTER JOIN
      Data0001 ON 
      Data0085.CURR_PTR = Data0001.RKEY LEFT OUTER JOIN
      Data0005 ON Data0085.QBY_EMPL_PTR = Data0005.RKEY ON 
      Data0010.RKEY = Data0085.CUST_PTR LEFT OUTER JOIN
      Data0009 ON Data0085.SREP_PTR = Data0009.RKEY

where data0085.TTYPE in (2,3)
          and ENTER_DATE>=@VDATE1_1 AND ENTER_DATE<@VDATE2_1
          --and data0085.REF_PART_NO like @REF_PART_NO
          and data0085.CUST_PART_NO like @CUST_PART_NO
          and data0085.tnumber like @tnumber
          and data0085.CUST_NAME like @CUST_NAME
           --and data0085.CUST_PTR in (select data0010.rkey FROM data0010 where CUSTOMER_NAME like @CUST_NAME)
          and data0085.ref_part_no like @CUSTOMER_PART_NUMBER
          --and data0085.CUST_PART_PTR in (select data0050.rkey FROM data0050 where CUSTOMER_PART_NUMBER like @CUSTOMER_PART_NUMBER)
          --and data0085.QBY_EMPL_PTR in (select data0005.rkey FROM data0005 where EMPLOYEE_NAME like @EMPLOYEE_NAME)
          and data0005.EMPLOYEE_NAME like @EMPLOYEE_NAME
     ORDER BY Data0085.TNUMBER
*/

END
go
CREATE PROCEDURE Qwzpr85;2 --ѡ����ҵ�λ
AS 
BEGIN
  select RKEY,CURR_CODE,CURR_NAME from Data0001
  union all 
  select null,null,null
END
GO 
CREATE PROCEDURE Qwzpr85;3 --ѡ���Ա
AS 
BEGIN
  select RKEY,EMPLOYEE_NAME from Data0005
  union all 
  select null,null
END
GO 
CREATE PROCEDURE Qwzpr85;4
AS 
BEGIN
  select RKEY,PROD_CODE,PRODUCT_NAME from Data0008
  union all 
  select null,null,null
END
GO
CREATE PROCEDURE Qwzpr85;5
AS 
BEGIN
  select RKEY,REP_CODE,SALES_REP_NAME,ABBR_NAME from Data0009
  union all 
  select null,null,null,null
END
GO
CREATE PROCEDURE Qwzpr85;6
AS 
BEGIN
  select RKEY, CUST_CODE, CUSTOMER_NAME, ABBR_NAME from Data0010
  union all 
  select null,null,null,null
END
GO

CREATE PROCEDURE Qwzpr85;7
AS 
BEGIN
  select RKEY,TTYPE, MANU_PART_NUMBER,MANU_PART_DESC from Data0025
      where (PARENT_PTR = 0) or (PARENT_PTR is null)
  union all 
  select null,null,null,null
END
GO
CREATE PROCEDURE Qwzpr85;8  --�����۲�Ʒ���ѡ���ر���
  @RKEY346 INT -- 047;2
AS 
BEGIN
    SELECT  Data0346.ROW_NAME, Data0348.ADDER_NAME, 
          Data0351.DEFT_SELECTED,Data0351.D0348_PTR,Data0351.seq_no
          ,Data0351.D0346_PTR
    FROM Data0351 INNER JOIN
          Data0346 ON Data0351.D0346_PTR = Data0346.RKEY INNER JOIN
          Data0348 ON Data0351.D0348_PTR = Data0348.RKEY
    WHERE (data0348.ttype=1) and (Data0346.RKEY = @RKEY346)
    ORDER BY Data0351.seq_no
END
GO  
CREATE PROCEDURE Qwzpr85;9  --���ر��ղ��ҹ�ʽ��Ҫ�õ��Ĳ���
  @RKEY348 INT  --�ر���ָ��
AS 
BEGIN
    SELECT UNIT_PTR 
    FROM Data0430
    WHERE (SOURCE_PTR = @RKEY348)
END
GO  
CREATE PROCEDURE Qwzpr85;10  --�����õ��Ĳ������ر����
  @RKEY085 INT  --���۵�λָ��
AS 
BEGIN  
    SELECT * 
    FROM Data0431
    WHERE (qte_ptr = @RKEY085)
END
GO  

CREATE PROCEDURE Qwzpr85;11
AS 
BEGIN
  select RKEY,PARAMETER_NAME,PARAMETER_DESC,DATA_TYPE,UNIT_PTR,SPEC_RKEY
  from Data0278
  union all 
  select null,null,null,null,null,null
END
GO

CREATE PROCEDURE Qwzpr85;12 --ѡ���ر����
AS 
BEGIN
  --select RKEY,rtrim(ENG_TABLE_NAME)+'['+rtrim(ENG_TABLE_DESC)+']' as EngTable from Data0280
  select * from Data0348 where TTYPE = 2
END
GO

CREATE PROCEDURE Qwzpr85;13 --��348������ѡ�񱨼۵���ѡ�е��ر����
  @QTE_PTR int , --���۵�ָ��
  @ADDER_NAME varchar(20)
AS 
BEGIN
  select * from data0432 where QTE_PTR = @QTE_PTR
     and SOURCE_PTR in (select rkey from data0348 where ADDER_NAME = @ADDER_NAME)
END
GO

CREATE PROCEDURE Qwzpr85;14 --ѡ�񱾳����
  @TTYPE int
AS 
BEGIN
  SELECT  Data0025.RKEY, 
        Data0025.MANU_PART_NUMBER, Data0025.MANU_PART_DESC, 
        Data0010.CUST_CODE
  FROM Data0025 INNER JOIN
        Data0010 ON Data0025.CUSTOMER_PTR = Data0010.RKEY
  WHERE (Data0025.TTYPE = @TTYPE)
  --ORDER BY Data0025.MANU_PART_NUMBER
END
GO

CREATE PROCEDURE Qwzpr85;15 --��鱾������Ƿ����
  @CUSTOMER_PART_NUMBER varchar(20)
AS 
BEGIN
     SELECT TOP 1 Data0025.RKEY, 
             Data0025.MANU_PART_NUMBER, Data0025.MANU_PART_DESC, 
             --Data0050.CP_REV, 
             Data0010.CUST_CODE
     FROM Data0025 INNER JOIN
             Data0010 ON Data0025.CUSTOMER_PTR = Data0010.RKEY
     WHERE (Data0025.rkey = (select top 1 rkey from Data0025 where MANU_PART_NUMBER=@CUSTOMER_PART_NUMBER))
END
GO

CREATE PROCEDURE Qwzpr85;16 --���ͻ��Ƿ����
  @CUST_CODE varchar(20)
AS 
BEGIN
    select top 1 * from data0010 where rkey =(
     select top 1 rkey from Data0010 where CUST_CODE = @CUST_CODE)    
END
GO

CREATE PROCEDURE Qwzpr85;17
AS 
BEGIN
  select * from Data0010

END
GO
CREATE PROCEDURE Qwzpr85;18 --ѡ����ҵ�λ
AS 
BEGIN --EXCH_RATE���õ�
  select RKEY,CURR_CODE,CURR_NAME, qte_base_to_other as EXCH_RATE,base_to_other as QTE_EXCH_RATE from Data0001
END
GO 
CREATE PROCEDURE Qwzpr85;19
AS 
BEGIN
  select RKEY,REP_CODE,SALES_REP_NAME,ABBR_NAME from Data0009
END
GO

CREATE PROCEDURE Qwzpr85;20
AS 
BEGIN
  select rkey,prod_code,product_name from data0008 --order by prod_code
END
GO

CREATE PROCEDURE Qwzpr85;21 --
  @source_ptr int --432�е�348ָ��
AS 
BEGIN  --ȡ����352
  select * from data0348 where  rkey = @source_ptr
END
GO

CREATE PROCEDURE Qwzpr85;22 --ѡ�񱨼۲�Ʒ���
AS 
BEGIN
  select * from data0346
END
GO

CREATE PROCEDURE Qwzpr85;23 --ѡ�񱨼۵��ر�����������
   @rkey085 int --data0085ָ��
AS 
BEGIN
    select * from data0432 where QTE_PTR = @rkey085
END
GO

CREATE PROCEDURE Qwzpr85;24 --ѡ�񱨼��е����в���
AS 
BEGIN
    select RKEY,DATA_TYPE,PARAMETER_NAME,PARAMETER_DESC,SPEC_RKEY from data0278
END
GO

CREATE PROCEDURE Qwzpr85;25 --ѡ���
AS 
BEGIN
    select RKEY,ENG_TABLE_NAME,DATA_TYPE from data0280
END
GO

CREATE PROCEDURE Qwzpr85;26 --ѡ�������Ա
 @parameter_ptr int --����ָ��
AS 
BEGIN
    select * from data0338 
      where parameter_ptr = @parameter_ptr
      order by sequence_no    
END
GO

CREATE PROCEDURE Qwzpr85;28 --ɾ�����۵�
 @rkey0085 int --���۵�ָ��
AS 
BEGIN

  delete data0431 where QTE_PTR =  @rkey0085

  delete data0432 where QTE_PTR =  @rkey0085

  --delete data0085 where rkey =  @rkey0085

 
END
GO


CREATE PROCEDURE Qwzpr85;29 --
AS 
BEGIN
  select * from data0348 
END
GO


CREATE PROCEDURE Qwzpr85;30 --��ʾ����������Ϣ
 @rkey0085 int --���۵�ָ��
AS 
BEGIN
  SELECT user_id,user_full_name,
       auth_date,ranking,user_ptr
  FROM data0274 inner join data0073
     On data0274.user_ptr=data0073.rkey
  WHERE (qte_ptr = @rkey0085)
END
GO

CREATE PROCEDURE Qwzpr85;31 --ѡ��λ
AS 
BEGIN
  SELECT RKEY,UNIT_CODE,UNIT_NAME,ltrim(rtrim(UNIT_CODE))+'['+ltrim(rtrim(UNIT_NAME))+']' as myunit
  FROM data0002
END
GO

CREATE PROCEDURE Qwzpr85;32 --ѡ�����
AS 
BEGIN
  SELECT  Data0023.CODE, Data0023.ABBR_NAME, 
      Data0017.INV_PART_NUMBER, Data0017.INV_NAME, 
      Data0017.INV_DESCRIPTION,Data0028.QTE_PRICE1,
      Data0028.QTE_PRICE1 * Data0001.QTE_BASE_TO_OTHER AS price1, 
      Data0028.qte_price2 * Data0001.QTE_BASE_TO_OTHER AS price2, 
      Data0028.TDATE, Data0028.RKEY, Data0017.RKEY AS d0017_rkey, 
      Data0002.UNIT_NAME, Data0001.CURR_NAME, 
      Data0001.QTE_BASE_TO_OTHER,Data0028.qte_price2
  FROM Data0002 INNER JOIN
      Data0028 INNER JOIN
      Data0023 ON Data0028.SUPPLIER_PTR = Data0023.RKEY INNER JOIN
      Data0017 ON Data0028.INVENTORY_PTR = Data0017.RKEY INNER JOIN
      Data0001 ON Data0028.CURRENCY_PTR = Data0001.RKEY INNER JOIN
      Data0496 ON Data0017.GROUP_PTR = Data0496.RKEY ON 
      Data0002.RKEY = Data0028.PURCHASE_UNIT_PTR
  WHERE (Data0028.QTE_PRICE1 > 0) AND 
              (Data0496.quote_flag = 1)
END
GO

CREATE PROCEDURE Qwzpr85;33 --ѡ����ϼ۸�
 @rkey0085 int --���۵�ָ��
AS 
BEGIN
  SELECT --Data0017.INV_PART_NUMBER ,  Data0017.INV_PART_DESCRIPTION , 
       Data0253.*
  FROM Data0253 --INNER JOIN
      --Data0017 ON Data0253.STD_INVENT_PTR = Data0017.RKEY
  WHERE (quote_ptr = @rkey0085)
END
GO

CREATE PROCEDURE Qwzpr85;34 --ѡ�����
 @rkey0017 int --���۵�ָ��
AS 
BEGIN
  SELECT Data0017.INV_PART_NUMBER ,  Data0017.INV_PART_DESCRIPTION  
  FROM Data0017 
  WHERE (rkey = @rkey0017)
END
GO

CREATE PROCEDURE Qwzpr85;35 --ѡ�����
AS 
BEGIN
  select * from data0348
  
END
GO


/*
CREATE PROCEDURE Qwzpr85

AS 
BEGIN
    
    
    
END
GO   */