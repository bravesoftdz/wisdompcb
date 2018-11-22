
if exists (select * from sysobjects where id = object_id(N'[dbo].[wzcx98]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
  drop PROCEDURE wzcx98
GO


CREATE PROCEDURE wzcx98
  @wher1 varchar(100),
  @wher2 varchar(100),
  @wher3 varchar(100),
  @wher4 varchar(100),
  @wher5 varchar(100),
  @wher6 varchar(100),
  @wher7 varchar(100),

  @ISSUE_DATE1 varchar(20),
  @ISSUE_DATE2 varchar(20),
  @finished int , --�Ƿ����
  @so_tp int, --����,�ⷢ,���Ƴ�,ȫ��
  @vrkey278 int  --����ָ��

--with encryption
AS
begin
  set @ISSUE_DATE1 =ltrim(rtrim(@ISSUE_DATE1))
  set @ISSUE_DATE2 =ltrim(rtrim(@ISSUE_DATE2))
  declare @sql varchar(4000) 
  set @sql=''

   declare @sql3 varchar(1000)
   set @sql3=ltrim(rtrim(@wher1))+' '+ltrim(rtrim(@wher2))+' '+ltrim(rtrim(@wher3))+' '+ltrim(rtrim(@wher4))+' '
             +ltrim(rtrim(@wher5))+' '+ltrim(rtrim(@wher6))+' '+ltrim(rtrim(@wher7))           




     set @sql=@sql+'SELECT Data0098.RMA_NUMBER,'   --�˻�������
                        +' Data0010.CUST_CODE,'    --�ͻ�����
                        +' Data0010.abbr_name,'   --�ͻ�
                        +' Data0025.MANU_PART_DESC,'  --�ͻ��ͺ�
                        +' Data0025.MANU_PART_NUMBER,'  --�������
                        -- +' Data0050.CP_REV,'   --
                        +' Data0060.SALES_ORDER,'  --��������
                        +' Data0098.RMA_DATE,'   --�˻�����
                        +' Data0098.QTY_AUTH,'   --�ƻ��˻�
                        +' Data0098.QTY_RECD,'   --�ѽ���
                        --+' Data0098.QTY_REMAKED,'   ---�Ѳ���
                        --+' Data0098.QTY_REWORKED,'   --�ѷ���
                        --+' Data0098.QTY_SCRAP,'  --��������
                        --+' Data0098.QTY_TO_MOVE_FIN_GOOD,'   --�û�
                        +' Data0060.PARTS_RETURNED - Data0060.RETURNED_SHIP AS to_be_ship,'  --Ƿ��PCS

                        +' Data0005.EMPLOYEE_NAME,'   --¼����
                        +' Data0023.ABBR_NAME AS ABBR_NAME1,'  --�ⷢ��
                        +' round((data0060.part_price / data0060.exch_rate),6) as price,' -- ���ۣ�ԭ�ң�
                        +' Data0001.CURR_NAME,' --����
                        +' Data0008.PRODUCT_NAME,' --��Ʒ���

                        +' Data0025.unit_sq as value,'  --��ֻ���
                        +' DATA0098.qty_recd*Data0025.unit_sq as ca'  --�����  --ͳ�����
                        +' ,case data0098.RMA_STATUS when 1 then ''δ�ύ'' when 2 then ''�����'' when 3 then ''�����'' when 4 then ''�ѳ���'' end as MyRMA_STATUS'
                        +' ROUND(DATA0098.qty_recd*Data0025.REPORT_UNIT_VALUE1*0.0001,4) as cw'--������
                    +' FROM Data0023 RIGHT OUTER JOIN'  
                        +' Data0060 LEFT OUTER JOIN'  
                        +' Data0001 ON '  
                        +' Data0060.CURRENCY_PTR = Data0001.RKEY RIGHT OUTER JOIN'  
                        +' Data0008 INNER JOIN'  
                        +' Data0098 INNER JOIN'  
                        +' Data0005 ON '  
                        +' Data0098.AUTH_BY_EMPL_PTR = Data0005.RKEY INNER JOIN'  
                        +' Data0025 ON Data0098.CUSTOMER_PART_PTR = Data0025.RKEY ON '  
                        +' Data0008.RKEY = Data0025.PROD_CODE_PTR INNER JOIN'  
                        +' Data0010 ON Data0098.CUSTOMER_PTR = Data0010.RKEY ON '  
                        +' Data0060.RKEY = Data0098.SO_PTR ON '  
                        +' Data0023.RKEY = Data0060.supplier_ptr'  



                   + ' WHERE rma_date>='''+@ISSUE_DATE1+''''
                           + ' and rma_date<='''+@ISSUE_DATE2+''''




         if @finished = 0
           select @sql = @sql + ' and data0060.status = 1 and data0060.parts_returned-data0060.returned_ship>0'
         else if @finished = 1
           select @sql = @sql + ' and data0060.parts_returned-data0060.returned_ship=0' 


         if @so_tp <> 3
            set @sql=@sql+' and data0060.so_tp='+cast(@so_tp as varchar(1))  
         if ltrim(rtrim(@sql3))<>'' 
            set @sql=@sql+ltrim(rtrim(@sql3))


  --select @sql
  --print @sql3
  --print @sql
  --print len(@sql)
  exec(@sql)
end
go



CREATE PROCEDURE wzcx98;2
  @rkey0006 int
--with encryption
AS
begin
 SELECT AVG(DATEDIFF(hh,Data0048.INTIME,Data0048.OUTTIME)) as hours, --ƽ��ͣ��Сʱ
       AVG(DATEDIFF(mi,Data0048.INTIME,Data0048.OUTTIME)) as minutes, --ƽ��ͣ������
       AVG(Data0048.QTY_PROD) as QTY_PROD,  --ƽ������������PCS��
      FrData0034.DEPT_CODE AS frDEPT_CODE, --�Ӳ��Ŵ���
      FrData0034.DEPT_NAME AS frDEPT_NAME, --�Ӳ�������
      case when data0048.TO_DEPT_PTR is null then '' else  ToData0034.DEPT_CODE end AS toDEPT_CODE, --�����Ŵ���
      case when data0048.TO_DEPT_PTR is null then '�ֿ�' else  ToData0034.DEPT_NAME end AS toDEPT_NAME --����������
 FROM Data0034 ToData0034 RIGHT OUTER JOIN
      Data0034 Data0034_2 ON 
      ToData0034.RKEY = Data0034_2.DEPT_PTR RIGHT OUTER JOIN
      data0492 INNER JOIN
      Data0006 ON data0492.CUT_NO = Data0006.CUT_NO INNER JOIN
      Data0048 ON Data0006.RKEY = Data0048.WO_PTR INNER JOIN
      Data0060 ON data0492.SO_NO = Data0060.SALES_ORDER INNER JOIN
      Data0034 ON Data0048.FM_DEPT_PTR = Data0034.RKEY INNER JOIN
      Data0034 FrData0034 ON Data0034.DEPT_PTR = FrData0034.RKEY ON 
      Data0034_2.RKEY = Data0048.TO_DEPT_PTR

where data0060.rkey=@rkey0006
group by FrData0034.DEPT_CODE,FrData0034.DEPT_NAME,
      case when data0048.TO_DEPT_PTR is null then '' else  ToData0034.DEPT_CODE end, --�����Ŵ���
      case when data0048.TO_DEPT_PTR is null then '�ֿ�' else  ToData0034.DEPT_NAME end --����������
end
go




CREATE PROCEDURE wzcx98;3
  @rkey0006 int
--with encryption
AS
begin
 SELECT data0060.rkey,
       data0006.WORK_ORDER_NUMBER, --��ҵ���š���
       --Data0048.FM_DEPT_PTR , 
       --Data0048.TO_DEPT_PTR, 
       Data0048.INTIME, 
       Data0048.OUTTIME, 
       DATEDIFF(hh,Data0048.INTIME,Data0048.OUTTIME) as hours,--ͣ��Сʱ
       DATEDIFF(mi,Data0048.INTIME,Data0048.OUTTIME) as minutes,--ͣ������


       Data0048.QTY_PROD,  --��������


      FrData0034.DEPT_CODE AS frDEPT_CODE, --�Ӳ��Ŵ���
      FrData0034.DEPT_NAME AS frDEPT_NAME, --�Ӳ�������
      case when data0048.TO_DEPT_PTR is null then '' else  ToData0034.DEPT_CODE end AS toDEPT_CODE, --�����Ŵ���
      case when data0048.TO_DEPT_PTR is null then '�ֿ�' else  ToData0034.DEPT_NAME end AS toDEPT_NAME --����������
 FROM Data0034 ToData0034 RIGHT OUTER JOIN
      Data0034 Data0034_2 ON 
      ToData0034.RKEY = Data0034_2.DEPT_PTR RIGHT OUTER JOIN
      data0492 INNER JOIN
      Data0006 ON data0492.CUT_NO = Data0006.CUT_NO INNER JOIN
      Data0048 ON Data0006.RKEY = Data0048.WO_PTR INNER JOIN
      Data0060 ON data0492.SO_NO = Data0060.SALES_ORDER INNER JOIN
      Data0034 ON Data0048.FM_DEPT_PTR = Data0034.RKEY INNER JOIN
      Data0034 FrData0034 ON Data0034.DEPT_PTR = FrData0034.RKEY ON 
      Data0034_2.RKEY = Data0048.TO_DEPT_PTR

 where data0060.rkey=@rkey0006
end 
go

CREATE PROCEDURE wzcx98;4 --�������˻��Ķ�����
--with encryption
AS
begin
  SELECT DISTINCT Data0060.SALES_ORDER
  FROM Data0060 INNER JOIN
      Data0098 ON Data0060.RKEY = Data0098.SO_PTR
  WHERE (Data0060.SALES_ORDER <> '')

  --select DISTINCT sales_order from data0060 where sales_order<>''
end
go

CREATE PROCEDURE wzcx98;5
--with encryption
AS
begin
  select DISTINCT CUT_NO from data0492 where CUT_NO<>''
end
go

CREATE PROCEDURE wzcx98;6
--with encryption
AS
begin
  SELECT DISTINCT Data0025.MANU_PART_NUMBER  --, Data0050.CP_REV
  FROM Data0025 INNER JOIN
       Data0098 ON 
       Data0025.RKEY = Data0098.CUSTOMER_PART_PTR
  WHERE (Data0025.MANU_PART_NUMBER <> '') --AND (Data0025.CP_REV <> '')
  --select DISTINCT CUSTOMER_PART_NUMBER,CP_REV from data0050 where CUSTOMER_PART_NUMBER<>'' and CP_REV<>''
end
go

CREATE PROCEDURE wzcx98;7  --�����˻��Ŀͻ��ͺ�
--with encryption
AS
begin
  SELECT DISTINCT Data0025.MANU_PART_DESC
  FROM Data0025 INNER JOIN
      Data0098 ON 
      Data0025.RKEY = Data0098.CUSTOMER_PART_PTR
  WHERE (Data0025.MANU_PART_DESC <> '')

  --select DISTINCT CUSTOMER_PART_DESC from data0050 where CUSTOMER_PART_DESC<>''
end
go

CREATE PROCEDURE wzcx98;8 --���ҿͻ�����,ֻ���˻��Ŀͻ�����ʾ
--with encryption
AS
begin
  SELECT DISTINCT Data0010.CUST_CODE, Data0010.ABBR_NAME
  FROM Data0010 INNER JOIN
      Data0098 ON Data0010.RKEY = Data0098.CUSTOMER_PTR
  WHERE (Data0010.CUST_CODE <> '')
  --select DISTINCT CUST_CODE from data0010 where CUST_CODE<>''
end
go

CREATE PROCEDURE wzcx98;9
--with encryption
AS
begin
  select DISTINCT INV_PART_NUMBER,INV_PART_DESCRIPTION from data0017  where INV_PART_NUMBER<>''
end
go

CREATE PROCEDURE wzcx98;10
--with encryption
AS
begin
  select DISTINCT CODE,REJECT_DESCRIPTION from data0076 where CODE<>''
  union all
  SELECT   '�̵�','�̵�'
end
go

CREATE PROCEDURE wzcx98;11 --ѡ�񹤳��еĻ�����λ
--with encryption
AS
begin
  SELECT Data0278.RKEY, Data0278.PARAMETER_NAME, 
      Data0278.PARAMETER_DESC, Data0278.Prod_Unit_base
  FROM Data0277 INNER JOIN
      Data0278 ON Data0277.RKEY = Data0278.CATEGORY_PTR
  WHERE (Data0277.CATEGORY_TYPE = 1)  and (Data0278.Prod_Unit_base='P')
end
go

CREATE PROCEDURE wzcx98;12 --ѡ�񱨷ϵ���
--with encryption
AS
begin
  SELECT RMA_NUMBER
  FROM data0098
  WHERE (RMA_NUMBER <> '' )
end
go

--select * from #table_a1

--drop table #table_a1
/*

--����
 SELECT a.[value] AS ����,b.name AS �ֶ���, c.name AS ����, a.smallid
 into #a2
 FROM sysproperties a INNER JOIN
      syscolumns b ON a.id = b.id AND a.smallid = b.colid INNER JOIN
      sysobjects c ON b.id = c.id
 WHERE (a.type = 4)

 insert into #a2(����,�ֶ���,����,smallid)
 SELECT a.[value] AS Expr2, '' AS Expr3, d.name AS Expr1, a.smallid
 FROM sysproperties a INNER JOIN
      sysobjects d ON a.id = d.id
 WHERE (a.type = 3)

 select ����,�ֶ���,���� from #a2 where ���� in ('data0060','data0492','data0048') order by ����,smallid
/*

 select 'set @tabl2='''+���� +'''' as a1,'set @column2='''+�ֶ���+'''' as a2,
'set @Description2='''+ltrim(rtrim(convert(varchar(1000),����)))+'''' as a3,
'set @smallid2='''+ltrim(rtrim(convert(varchar(10),smallid)))+'''' as a4 
 from #a2 where ���� in ('data0445','data0448','data0449','data0459','data0442','data0447','data0446','data0372','data0454','data0453','data0421','data0422','data0452','data0441','data0411','data0410','data0464')
 order by ����,smallid 
*/
 drop table #a2



select * from data0419 where description like '%�˻�%'

SELECT *, PROGRAME AS Expr1, ANCESTOR_PTR AS Expr2, PARENT_PTR AS Expr3, 
      SEQ_NO AS Expr4
FROM Data0419
WHERE (ANCESTOR_PTR = 70) AND (PARENT_PTR = 77)
ORDER BY SEQ_NO
*/
