--ep210���Ͽ����ҵ���EP076�Ҳ���
SELECT * FROM data0058 WHERE MRB_NO IN ('1309090183','1309090184') 
--EP076
exec EP076;1 0,'U','0',0,4,1,'0',2,'2013-09-09 00:00:00','2013-09-10 00:59:59','%','0',0,0,0,'%',0,0,'%',2,'204'
--EP210
exec EP210;1 '2013-09-09 00:00:00','2013-09-10 01:59:59',2,'0','U',2,' ORDER BY data0050.customer_part_number',0,0


--exec EP076;1 0,'U','0',0,4,1,'0',2,'2013-09-09 00:00:00','2013-09-10 00:59:59','%','0',0,0,0,'%',0,0,'%',2,'204'
--P2G204017
--create PROCEDURE EP076;1  --��ϸ
declare
  @inde int=0,   --���ձ�����������,(1,0)
  @tp CHAR(1)='U',  --��������,U��,P��
  @vindex varchar(100)='0',  --���β���,0ȫ��,��������ָ��
  @vindex2 int=0,--@vindex2=0��������Ų�@vindex2=1���ͻ��ͺŲ�
  @vptr1 int=4,--��Ʒ����,����,������,ȫ��
  @vptr2 int=1,--����ָ��
  @vptr3 varchar(100)='0',--��Ʒ���ָ��
  @vtype INT=2,  --��ʾ0�����1���ڲ�2��ȫ��
  @vdate1 varchar(20)='2013-09-09 00:00:00',--��������ʱ�䷶Χ
  @vdate2 varchar(20)='2013-09-10 00:59:59',--��������ʱ�䷶Χ
  @vproj varchar(20)='%',--���������ͻ��ͺ�
  @Rject1 varchar(100)='0', --����ԭ��
  @vlot float=0, --����ֵ
  @Whse_ptr int=0,--����
  @LotScrap int=0,--�̵㱨��ȱ��
  @Work_Order_Number varchar(30)='%', --��ҵ����
  @flag int=0,  --��ѯʱ�䣬0����ʱ�䣬1������ʱ��
  @flag1 int=0,
  @so_no varchar(50)='%',--���۶�����
  @vindex3 int=2,  --���ε�λ��0:����1������;2:ȫ��
  @cust1 varchar(32)='204' 		--�ͻ�����
--WITH ENCRYPTION
--AS
declare @sql2 varchar(8000),@sql3 varchar(8000)
declare @JUnit varchar(5),@MUnit varchar(5) 
select @flag=Search_Unit_flag from Data0195
  if @flag = 0  --ƽ����
  begin
    set @JUnit='L'  --�����
    set @MUnit='D'  --ë���
  end
  else   --ƽ����
  begin
    set @JUnit='K'
    set @MUnit='E'
  end


set @sql2=' If exists(Select 1 From tempdb..sysobjects Where id=object_id(''tempdb..#tmp''))  drop table #tmp '
set @sql2=@sql2+' If exists(Select 1 From tempdb..sysobjects Where id=object_id(''tempdb..#Result''))  drop table #Result '
/*�ȼ���Ͷ����*/
set @sql2=@sql2+'SELECT Data0492.SO_NO/*���۶�����*/,Data0492.CUT_NO/*Ͷ�ϵ���*/,Data0025.MANU_PART_NUMBER,
                data0492.ISSUED_QTY as ISSUED_QTYpcs /*Ͷ��PCS��*/'
 if @tp='U' 
 begin 
   set @sql2=@sql2+' ,(data0492.ISSUED_QTY / IsNull(Data0047.PARAMETER_VALUE,1)) AS QTY_PLANNED /*Ͷ������*/  '
 end 
 if @tp='P' 
 begin
   set @sql2=@sql2+' ,(data0492.ISSUED_QTY * Data0047.PARAMETER_VALUE) AS QTY_PLANNED /*Ͷ������*/ '
 end
set @sql2=@sql2+' into #tmp '
 set @sql2=@sql2+' From Data0058 Left Join
                        Data0158 on Data0058.mrb_no = Data0158.mrb_no left join 
                        Data0006 On Data0058.WO_PTR=Data0006.RKey Left Join 
                        Data0492 On Data0006.CUT_NO=Data0492.CUT_NO Left Join
                        Data0025 On Data0006.BOM_PTR=Data0025.RKey Left Join
                        Data0050 On Data0025.ANCESTOR_PTR=Data0050.RKey Left Join
                        Data0047 On Data0025.RKey=Data0047.SOURCE_POINTER Left Join
                        Data0034 On Data0058.RESP_DEPT_PTR=Data0034.Rkey left join
                        Data0008 on Data0025.PROD_CODE_PTR=Data0008.Rkey left join
                        Data0039 on Data0058.REJECT_PTR=Data0039.Rkey left join
                        Data0059 on Data0050.Rkey=Data0059.cust_part_ptr
                          and Data0492.customer_ptr=Data0059.customer_ptr 
                        left join data0010 on data0492.customer_ptr=data0010.rkey --20130525 LLL �ӿͻ� 
           
                   where ' --2006-5-7����
  if @vindex3 = 0 
    set @sql2=@sql2+' Data0034.ttype<>4 and '
  else
  if @vindex3 = 1
    set @sql2=@sql2+' Data0034.ttype=4 and '

 set @sql2=@sql2+' Data0039.spec_type=0 AND DATA0047.PARAMETER_PTR = '+convert(varchar(4),@VPTR2) --����ָ��

  if @VPTR1<>4 --������ȫ��ʱ LLL 20120517
 set @sql2=@sql2+' and DATA0050.TTYPE = '+convert(char(1),@VPTR1)  --1����,0������,ȫ��
 else 
 set @sql2=@sql2+' and (DATA0050.TTYPE=0 or DATA0050.TTYPE=1) ' --����ȫ�������������������

-- set @sql2=@sql2+' and DATA0050.TTYPE <> '+convert(char(1),@VPTR1)  --����,������,ȫ��

 if @flag = 0 
 begin
   set @sql2=@sql2+' AND DATA0058.TDATETIME >= '''+@VDATE1  +''''--convert(char(20),@VDATE1)+''''--ʱ�����
   set @sql2=@sql2+' AND DATA0058.TDATETIME <= '''+@VDATE2  +''''--+'  23:59:59'''--convert(char(20),@VDATE2)+''''--ʱ�����
 end
 else
 begin
   set @sql2=@sql2+' AND Data0158.AUDIT_DATETIME >= '''+@VDATE1  +''''--convert(char(20),@VDATE1)+''''--ʱ�����
   set @sql2=@sql2+' AND Data0158.AUDIT_DATETIME <= '''+@VDATE2  +''''--+'  23:59:59'''--convert(char(20),@VDATE2)+''''--ʱ�����
 end
 
 if @flag1 = 0 
 begin
   if @tp='U'
     set @sql2=@sql2+' and DATA0058.QTY_REJECT / IsNull(DATA0047.PARAMETER_VALUE,1) >= '+convert(char(12),@vlot) --��������
   if @tp='P'
     set @sql2=@sql2+' and DATA0058.QTY_REJECT * DATA0047.PARAMETER_VALUE >= '+convert(char(12),@vlot)
 end
 else
 begin
   if @tp='U'
     set @sql2=@sql2+' and (DATA0058.QTY_REJECT/isnull(Data0025.parts_num,1) )/ IsNull(DATA0047.PARAMETER_VALUE,1) >= '+convert(char(12),@vlot) --��������
   if @tp='P'
     set @sql2=@sql2+' and (DATA0058.QTY_REJECT/isnull(Data0025.parts_num,1) )* DATA0047.PARAMETER_VALUE >= '+convert(char(12),@vlot)
 end
  
 if @vindex3 <> 2
 begin
  if @vindex <> '0'
  set @sql2=@sql2+' and  data0058.RESP_DEPT_PTR  in ('+convert(varchar(20), @vindex) +')' --���β��Ź��� ��ԭDATA0034.dept_ptr�ĳ�data0058.RESP_DEPT_PTR 20130702ǿ��ת�� LLL 
 end

  if @vptr3 <> '0'
    set @sql2=@sql2+' AND DATA0008.PR_GRP_POINTER in ('+ convert(varchar(20), @vptr3) +')'--��Ʒ���
  if @Rject1 <> '0'
    set @sql2=@sql2+' and DATA0058.REJECT_PTR in ('+ convert(varchar(20),  @Rject1) +')' --����ԭ�����

   if @vindex2=0          
      set @sql2=@sql2+' and Data0050.CUSTOMER_PART_NUMBER LIKE '''+@VPROJ+''''--��������Ź���
   if @vindex2=1         
      set @sql2=@sql2+' and Data0059.CUSTOMER_PART_DESC LIKE '''+@VPROJ+''''--���ͻ��ͺŹ���
   set @sql2=@sql2+' and Data0006.work_order_number like '''+@work_order_number+''''--����ҵ������

  
   --set @sql2=@sql2+' and Data0058.reject_ptr<>'+convert(varchar(5),@LotScrap)--�����̵㱨��

    if @LotScrap=1  -- �粻�����̵㱨�ϣ��������ӯ���̿�  20130720 LLL  
    SET @sql2 = @sql2+'  and (Data0058.reject_ptr<>(select custfedship from data0192)) and (Data0058.reject_ptr<>(select CUSTFEDSHIP_loss from data0192)) '  
     


   if @Whse_ptr>0
     set @sql2=@sql2+' and Data0006.whouse_ptr='+convert(varchar(5),@Whse_ptr)--���˹���
  if @so_no <> '%'
   set @sql2=@sql2+' and Data0492.so_no LIKE '''+@so_no+''''  

  if @cust1<>''
  set @sql2=@sql2+'and data0010.cust_code like '''+ @cust1+'%'''  --20130525 LLL �ӿͻ� 



/*����Ͷ����*/
 set @sql2=@sql2+' SELECT SO_NO,MANU_PART_NUMBER,
                  ISSUED_QTYpcs=sum(ISSUED_QTYpcs) /*Ͷ��PCS��*/
                 ,QTY_PLANNED=sum(QTY_PLANNED) /*Ͷ������*/  '
Set @sql2=@sql2+' into #Result'
set @sql2=@sql2+' From (select distinct * from #tmp) a '
Set @sql2=@sql2+' Group by SO_NO,MANU_PART_NUMBER'

/*���㱨��������������Ͷ����*/
 set @sql2=@sql2+' SELECT ABBR_NAME=data0010.cust_code /*�ͻ����*/, Data0050.CUSTOMER_PART_NUMBER /*�������*/,Data0050.Layers /*����*/,Data0050.mat_tp /*��������*/,
                  Data0050.CP_REV /*�汾*/,Data0050.eng_tp, Data0025.MANU_PART_NUMBER /**/, Data0059.CUSTOMER_PART_DESC /*��Ʒ����*/, 
                  Data0008.PRODUCT_NAME /*��Ʒ���*/, data0492.SO_NO /*���۶�����*/,data0492.SCH_COMPL_DATE /*Ͷ������*/,
                  Data0034.DEPT_NAME /*���β���*/,Data0039.REJECT_DESCRIPTION /*ȱ������*/,Data0008.Product_Name /*����*/,
                  t1.ISSUED_QTYpcs,/*Ͷ��PCS��*/t1.QTY_PLANNED/*Ͷ������*/,factory=Data0015.abbr_name,Data0047.PARAMETER_VALUE,
                  (case Data0050.ttype when 0 then Data0008.EST_SCRAP_LTM when 1 then Data0008.EST_SCRAP1_LMT end) as rej_rate'

 if @flag1 = 0
 begin
   if @tp='U'
   begin 
     set @sql2=@sql2+' ,parts_order=data0060.parts_ordered/IsNull(Data0047.PARAMETER_VALUE,1) ,SUM(Data0058.QTY_REJECT/ IsNull(Data0047.PARAMETER_VALUE,1)) AS QUANTITY /*��������*/ '
   end
   if @tp='P'
   begin
     set @sql2=@sql2+' ,parts_order=data0060.parts_ordered*Data0047.PARAMETER_VALUE,SUM(Data0058.QTY_REJECT * Data0047.PARAMETER_VALUE) AS QUANTITY /*��������*/'
     
   end
  set  @sql2=@sql2+' ,D47C.PARAMETER_VALUE as JmianJiUnit,round(isnull(sum(Data0058.QTY_REJECT* D47C.PARAMETER_VALUE),0),5) AS JmianJi  ' --20130703 LLL �Ӿ�������أ��;����  
 end
 else
 begin
   if @tp='U'
   begin 
     set @sql2=@sql2+' ,parts_order=data0060.parts_ordered/IsNull(Data0047.PARAMETER_VALUE,1) ,SUM((Data0058.QTY_REJECT/isnull(Data0025.parts_num,1))/ IsNull(Data0047.PARAMETER_VALUE,1)) AS QUANTITY /*��������*/'
   end
   if @tp='P'
   begin
     set @sql2=@sql2+' ,parts_order=data0060.parts_ordered*Data0047.PARAMETER_VALUE,SUM((Data0058.QTY_REJECT/isnull(Data0025.parts_num,1) )* Data0047.PARAMETER_VALUE) AS QUANTITY /*��������*/'
   end
   set  @sql2=@sql2+' ,D47C.PARAMETER_VALUE as JmianJiUnit,round(isnull(sum(Data0058.QTY_REJECT/isnull(Data0025.parts_num,1)* D47C.PARAMETER_VALUE),0) ,5) AS JmianJi  ' --20130703 LLL �Ӿ�������أ��;����  
 end

 set @sql2=@sql2+',Data0050.Customer_part_number+'''+' '+'''+data0050.cp_rev as cust_part_number '
 
--Set @sql2=@sql2+' into #Result1'
 set @sql2=@sql2+' From Data0058 left join
     Data0158 on Data0058.mrb_no = Data0158.mrb_no left join 
     Data0006 on Data0058.WO_PTR=Data0006.Rkey left join 
     Data0492 on Data0006.cut_no=Data0492.cut_no left join
     Data0060 on Data0492.so_no=Data0060.sales_order left join
     Data0025 on Data0006.bom_ptr=Data0025.Rkey left join
     Data0050 on Data0025.ancestor_ptr=Data0050.Rkey left join
     Data0059 on Data0050.Rkey=Data0059.cust_part_ptr
             and Data0060.customer_ptr=Data0059.customer_ptr left join
     Data0010 on Data0060.customer_ptr=Data0010.Rkey left join
     Data0008 on Data0025.PROD_CODE_PTR=Data0008.Rkey left join
     Data0039 on Data0058.REJECT_PTR=Data0039.Rkey left join
     Data0034 on Data0058.RESP_DEPT_PTR=Data0034.Rkey left join
     #Result t1 On Data0492.SO_NO=t1.SO_NO and t1.MANU_PART_NUMBER =Data0025.MANU_PART_NUMBER left join
     Data0015 on Data0006.whouse_ptr=Data0015.Rkey 
     LEFT JOIN DATA0047 D47C ON DATA0025.RKEY=D47C.SOURCE_POINTER AND D47C.PARAMETER_PTR=(select top 1 rkey from data0278 where SPEC_RKEY='''+@JUnit+''' ) --20130703 LLL 
     left join   Data0047 on Data0025.RKEY = Data0047.SOURCE_POINTER 
     AND DATA0047.PARAMETER_PTR = '+convert(varchar(4),@VPTR2) --����ָ��'
set @sql2=@sql2+' where '
  if @vindex3 = 0 
    set @sql2=@sql2+' Data0034.ttype<>4 and '
  else
  if @vindex3 = 1
    set @sql2=@sql2+' Data0034.ttype=4 and '

 set @sql2=@sql2+' Data0039.spec_type=0 '
 if @VPTR1<>4 --������ȫ��ʱ LLL 20120517
 set @sql2=@sql2+' and DATA0050.TTYPE = '+convert(char(1),@VPTR1)  --1����,0������,ȫ��
 else 
 set @sql2=@sql2+' and (DATA0050.TTYPE=0 or DATA0050.TTYPE=1) ' --����ȫ�������������������

 if @flag = 0 
 begin
   set @sql2=@sql2+' AND DATA0058.TDATETIME >= '''+@VDATE1  +''''--convert(char(20),@VDATE1)+''''--ʱ�����
   set @sql2=@sql2+' AND DATA0058.TDATETIME <= '''+@VDATE2  +''''--+'  23:59:59'''--convert(char(20),@VDATE2)+''''--ʱ�����
 end
 else
 begin
   set @sql2=@sql2+' AND Data0158.AUDIT_DATETIME >= '''+@VDATE1  +''''--convert(char(20),@VDATE1)+''''--ʱ�����
   set @sql2=@sql2+' AND Data0158.AUDIT_DATETIME <= '''+@VDATE2  +''''--+'  23:59:59'''--convert(char(20),@VDATE2)+''''--ʱ�����
 end
 
 if @flag1 =0 
 begin
   if @tp='U'
     set @sql2=@sql2+' and DATA0058.QTY_REJECT / IsNull(DATA0047.PARAMETER_VALUE,1) >= '+convert(char(12),@vlot) --��������
   if @tp='P'
     set @sql2=@sql2+' and DATA0058.QTY_REJECT * DATA0047.PARAMETER_VALUE >= '+convert(char(12),@vlot)
 
 end
 else
 begin
   if @tp='U'
     set @sql2=@sql2+' and (DATA0058.QTY_REJECT/isnull(Data0025.parts_num,1) )/ IsNull(DATA0047.PARAMETER_VALUE,1) >= '+convert(char(12),@vlot) --��������
   if @tp='P'
     set @sql2=@sql2+' and (DATA0058.QTY_REJECT/isnull(Data0025.parts_num,1) )* DATA0047.PARAMETER_VALUE >= '+convert(char(12),@vlot)
 end 
 
  if @vindex3 <> 2
  begin
    if @vindex<> '0' 
    --  set @sql2=@sql2+' and  DATA0034.dept_ptr in ('+ @vindex +')' --���β��Ź���
      set @sql2=@sql2+' and  data0058.RESP_DEPT_PTR  in ('+convert(varchar(20), @vindex) +')'  --���β��Ź��� ��ԭDATA0034.dept_ptr�ĳ�data0058.RESP_DEPT_PTR 20130528 LLL  
  end

  if @vptr3 <>'0'
    set @sql2=@sql2+' AND DATA0008.PR_GRP_POINTER in ('+ convert(varchar(20), @vptr3)  +')'--��Ʒ���
  if @Rject1 <> '0'
    set @sql2=@sql2+' and DATA0058.REJECT_PTR in ('+ convert(varchar(20), @Rject1) +')' --����ԭ�����

   if @vindex2=0          
      set @sql2=@sql2+' and Data0050.CUSTOMER_PART_NUMBER LIKE '''+@VPROJ+''''--��������Ź���
   if @vindex2=1         
      set @sql2=@sql2+' and Data0059.CUSTOMER_PART_DESC LIKE '''+@VPROJ+''''--���ͻ��ͺŹ���
if @vtype=0
     set @sql2=@sql2+' and data0025.parent_ptr=0'
if @vtype=1 
     set @sql2=@sql2+' and data0025.parent_ptr>0'
   set @sql2=@sql2+' and Data0006.work_order_number like '''+@work_order_number+''''--����ҵ������

  -- set @sql2=@sql2+' and Data0058.reject_ptr<>'+convert(varchar(5),@LotScrap)--�����̵㱨��  

    if @LotScrap=1  -- �粻�����̵㱨�ϣ��������ӯ���̿�  20130720 LLL  
    SET @sql2 = @sql2+'  and (Data0058.reject_ptr<>(select custfedship from data0192)) and (Data0058.reject_ptr<>(select CUSTFEDSHIP_loss from data0192)) '  
     

   if @Whse_ptr>0
     set @sql2=@sql2+' and Data0006.whouse_ptr='+convert(varchar(5),@Whse_ptr)--���˹���
     --set @sql2=@sql2+' and ((Data0025.parent_ptr=0 and @vtype2=0)OR(Data0025.parent_ptr>0 and @vtype2=1)OR(@vtype2=2))'
  if @so_no <> '%'
    set @sql2=@sql2+' and Data0492.so_no LIKE '''+@so_no+''''
    if @cust1<>''
  set @sql2=@sql2+'and data0010.cust_code like '''+ @cust1+'%'''  --20130525 LLL �ӿͻ� 

Set @Sql2=@sql2+' Group by Data0010.Cust_code,Data0050.CUSTOMER_PART_NUMBER,Data0050.CP_REV,Data0050.Layers,Data0025.MANU_PART_NUMBER,
                Data0059.CUSTOMER_PART_DESC,Data0008.PRODUCT_NAME,data0492.SO_NO,data0492.SCH_COMPL_DATE,Data0034.DEPT_NAME,
                Data0039.REJECT_DESCRIPTION,Data0008.Product_Name,t1.ISSUED_QTYpcs,t1.QTY_PLANNED,data0060.parts_ordered,Data0050.mat_tp,
                Data0047.PARAMETER_VALUE,D47C.PARAMETER_VALUE,Data0015.abbr_name,Data0050.eng_tp,(case Data0050.ttype when 0 then Data0008.EST_SCRAP_LTM when 1 then Data0008.EST_SCRAP1_LMT end)'
 if @inde=0
    set @sql2=@sql2+' order by Data0050.CUSTOMER_PART_NUMBER,Data0050.CP_REV,Data0025.MANU_PART_NUMBER,data0492.so_no '
 --��������������20120618lll


if @inde=1 
begin
  if @tp='U'
     set @sql2=@sql2+' order by SUM((Data0058.QTY_REJECT/isnull(Data0025.parts_num,1))/ IsNull(Data0047.PARAMETER_VALUE,1)),Data0050.CUSTOMER_PART_NUMBER,Data0050.CP_REV,Data0025.MANU_PART_NUMBER,data0492.so_no '
   if @tp='P'
     set @sql2=@sql2+' order by SUM((Data0058.QTY_REJECT/isnull(Data0025.parts_num,1) )* Data0047.PARAMETER_VALUE),Data0050.CUSTOMER_PART_NUMBER,Data0050.CP_REV,Data0025.MANU_PART_NUMBER,data0492.so_no  ' 
end
exec (@sql2)
print (@sql2)

go

