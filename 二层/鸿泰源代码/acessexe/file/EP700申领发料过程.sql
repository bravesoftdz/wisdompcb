--EP700���췢�Ϲ���
--EP700�����쵥
insert data0700(RKEY,DEPT_CODE,TDATE,EDATE,NOTE,Reference_Number,USER_PTR,STATUS,STATUS_RETURN,data0015RKEY,flow_no) 
values ('SL00016946  ',329,'2013-12-22','2013-12-23','dsfds','',1,0,0,2,0)
INSERT INTO data0701 (DATA0700_RKEY, INV_PART_NUMBER, QUAN,CurrentStore,REMARK,LInv_Part_number,supplier_ptr) 
VALUES ('SL00016946  ','1FE0034',30,100,'','',0)
exec sp_executesql N'UPDATE "SJ_V20_live".."Data0004" 
SET "SEED_VALUE"=@P1 WHERE "SEED_VALUE"=@P2',N'@P1 varchar(10),@P2 varchar(10)','SL00016946','SL00016945'

--EP700�ύ���
select top 1 DATA0073_KEY from data0707 
where data0034_rkey='329' and flow_no='0' order by SEQ,RKEY  --883 ��������

update data0700 set Status=1,SK_WaitFor='883',SK_USER_PTR=null  where rkey='SL00016942  ' --ֻд��һ�������
                                                                                          --Status 0 δ�ύ,1  ���ύ/�����,2 ����� ,3 �ѷ��� ,4 ���˻� ELSE ȡ�����
update data0701 set issuedflag=0 where data0700_rkey='SL00016942  '  --0δ����,1���˻�,2�ѷ��� ELSE �ѳ���

--���������Ϣ
--���������
exec sp_executesql N'SELECT     data0707.SEQ, data0707.RKEY, ''('' + Data0073.USER_ID + '') '' + ISNULL(Data0005.EMPLOYEE_NAME, '''') AS UserN,
isnull(data0707.flow_no,0) as flow_no,data0707.remark
FROM         data0707 INNER JOIN
                      Data0073 ON data0707.DATA0073_KEY = Data0073.RKEY LEFT OUTER JOIN
                      Data0005 ON Data0073.EMPLOYEE_PTR = Data0005.RKEY
WHERE     (data0707.DATA0034_RKEY =@P1)
ORDER BY data0707.SEQ, data0707.RKEY
',N'@P1 int',329

--�����Ϣ
exec sp_executesql N'SELECT     ''('' + Data0073.USER_ID + '') '' + ISNULL(Data0005.EMPLOYEE_NAME, '''') AS UserN, Data0710.SKTime, Data0710.SKType, Data0710.SKRmk
FROM         Data0710 INNER JOIN
                      Data0073 ON Data0710.SKUser = Data0073.RKEY LEFT OUTER JOIN
                      Data0005 ON Data0073.EMPLOYEE_PTR = Data0005.RKEY
WHERE     (Data0710.SLRkey =@P1)
ORDER BY Data0710.SKTime
',N'@P1 varchar(12)','SL00016942  '

--EP708���쵥���
select top 1 isnull(SEQ,0) as SEQ,RKEY 
from data0707 where (data0034_rkey='329') and DATA0073_KEY in (1) and (flow_no=0) 
order by SEQ,RKEY --�������
select top 1 DATA0073_KEY 
from data0707 where (data0034_rkey=329) and (SEQ>1) and (flow_no=0) order by SEQ,RKEY --�´��û�


update data0700 set status=2, sk_date=getdate(),sk_user_ptr='1' where rkey='SL00016946'


INSERT INTO Data0710(SLRkey, SKUser, SKType, SKRmk) VALUES ('SL00016946', 1, N'����', N'')

--EP704����Ԥ��
-- �����������exec ep704;2 0,'SL00016947  ','1,2,3,4,5,6,7,8,10,11,12,13,14,15,16',0
--�����η��ŵ���Զ����䰴ť����(����)
--exec ep704;3 0,'1FE0034','1,2,3,4,5,6,7,8,10,11,12,13,14,15,16',N'0',0
CREATE  PROCEDURE [dbo].ep704;3 
@vptr int,
@INV_PART_NUMBER varchar(30),
@HoseList varchar(200),
@barcode nvarchar(20)='0',
@factory int
as
begin


  SELECT Data0022.RKEY, Data0022.INVENTORY_PTR,Data0017.INV_PART_NUMBER,
         Data0017.INV_PART_DESCRIPTION, Data0022.BARCODE_ID,Data0016.location, 
         Data0022.QUAN_ON_HAND, Data0022.EXPIRE_DATE, Data0016.CODE,
         Data0023.ABBR_NAME AS scode,data0023.supplier_name,Data0002.UNIT_CODE, Data0017.STD_COST,
         Round(Data0022.PRICE / Data0022.EXCHANGE_RATE,6) AS unit_price,
         Data0456.REF_NUMBER, Data0022.WHOUSE_PTR, Data0022.SUPPLIER2,data0022.Reference_Number,
         Data0022.OccupyQty,data0022.extra_req,data0022.supplier_ptr,data0022.supplier2,
         CanUseQty=case when Data0022.QUAN_ON_HAND<=0 then 0 
                        when isnull(OccupyQty,0)<0 then 0   
                        when Data0022.QUAN_ON_HAND>(isnull(OccupyQty,0)) then Data0022.QUAN_ON_HAND-isnull(OccupyQty,0) 
                        when Data0022.QUAN_ON_HAND=isnull(OccupyQty,0)   then Data0022.QUAN_ON_HAND-isnull(OccupyQty,0)  
                        when (Data0022.QUAN_ON_HAND<isnull(OccupyQty,0)) then 0 
                   end   
         FROM Data0022 INNER JOIN  
         Data0017 ON Data0022.INVENTORY_PTR = Data0017.RKEY INNER JOIN  
         Data0016 ON Data0022.LOCATION_PTR = Data0016.RKEY  INNER JOIN  
         Data0023 ON Data0022.SUPPLIER_PTR = Data0023.RKEY INNER JOIN  
         Data0002 ON Data0017.STOCK_UNIT_PTR = Data0002.RKEY INNER JOIN  
         Data0456 ON Data0022.GRN_PTR = Data0456.RKEY  
         where(case when Data0022.QUAN_ON_HAND>(isnull(OccupyQty,0)) then Data0022.QUAN_ON_HAND-isnull(OccupyQty,0) 
                    when Data0022.QUAN_ON_HAND=isnull(OccupyQty,0)  then 0 
                    when isnull(OccupyQty,0)<0 then 0 
                    when (Data0022.QUAN_ON_HAND<isnull(OccupyQty,0))and(isnull(OccupyQty,0)>0) then 0 
                end )>0
         and Data0017.INV_PART_NUMBER=@INV_PART_NUMBER
         and isnull(Data0016.ishub,0)=0 and isnull(Data0016.is_prod_store,0)=0
         and(charindex(','+ltrim(rtrim(Data0022.location_ptr))+',',','+ltrim(rtrim(@HoseList))+',')>0)
         and (data0022.barcode_id=@barcode or @barcode='0')
         and (data0022.whouse_ptr=@factory or @factory=0)
         and data0022.expire_date>getdate()
         order by data0017.inv_part_number,case when data0022.invoice_ptr>0 then DATA0456.create_date else data0022.tdate end, 
         data0022.barcode_id



 
end
GO


exec sp_executesql N'UPDATE "SJ_V20_live".."DATA0701" 
SET "TOTAL"=@P1 --��������
WHERE "TOTAL"=@P2 AND "RKEY"=@P3',N'@P1 float,@P2 float,@P3 int',30,0,65214 

update data0701 set total=30, RemarkInfo='',IssuedFlag=2  --����״̬ 0δ����,1���˻�,2�ѷ��� ELSE �ѳ���
where rkey=65214
--����Ԥ�����¼
insert data0706 (RKEY, DATA0022_RKEY, QUAN) values(65214,'8230',30)
--�޸�ռ����
update Data0022      set OccupyQty=isnull(OccupyQty,0)+30      where RKEY='8230' 
update Data0701      set OccupyQty=isnull(OccupyQty,0)+30      where RKEY='65214'

 update data0701 set total=a.sumquan  from data0701,  (  select rkey,cast(sum(quan) as float) as sumquan from data0706 group by rkey  ) a  where data0701.rkey=a.rkey  and sumquan<>total  and data0701.issuedflag=2 

go
 update data0022 set OccupyQty=a.Quan  from data0022,  (  select OccupyQty,  (  select cast(isnull(sum(data0706.Quan),0) as numeric(18,6)) as Quan  from data0706  inner join data0701 on data0706.rkey=data0701.rkey   and data0701.ISSUEDFLAG in (2)  and data0706.data0022_rkey=data0022.rkey  ) as Quan,  data0022.rkey,  data0022.quan_on_hand  from data0022 where   OccupyQty<>  (  select cast(isnull(sum(data0706.Quan),0)as numeric(18,6)) as Quan  from data0706  inner join data0701 on data0706.rkey=data0701.rkey   and data0701.ISSUEDFLAG in (2)  and data0706.data0022_rkey=data0022.rkey  )  ) a  where  data0022.rkey=a.rkey  and data0022.quan_on_hand>0 

go


--EP709 ���쵥ȷ��
--��������δԤ��������������������ˣ���Ҫѡ����ȷ��
--
declare @p8 smallint
set @p8=0
declare @p9 varchar(100)
set @p9='������ȷ�ϳɹ�!�Զ����ɵĳ��ֵ���:1311581'
exec EP701;1 0,'SL00016947  ',0,'',1,1,'',@p8 output,@p9 output
select @p8, @p9

--���쵥���
create  PROCEDURE EP701;1
@type int,--�������ͣ�0:�������ϣ�1:�����
@DATA0700_RKEY varchar(30),--���쵥��
@Data0701_RKEY int=0,--����������
@inv_part_number varchar(30),--������
@create_by int,  --������
@AUDITED_BY int, --�����
@error_id smallint out, --�����
@error_mess varchar(100) out --��������
AS 

/*
declare @error nvarchar(30),
@error_id smallint 
exec ep701;1 0,@DATA0700_RKEY,'',294,294,@error_id,@error
print @error
*/
declare
@da95_207 int,
@da457_207 int,
@recd_bytmp int,
@create_bytmp int,
@AUDITED_BYtmp int,
@a int,
@b varchar(20),
@c int,
@d varchar(20),
@e float,
@f int,
@G float,
@H float,
@I float,
@EXCHANGE_RATE float,
@PRICE float,
@sn  varchar(20),@sn2 varchar(20),
@error_inv varchar(50),
@error0 varchar(20),
@error1 varchar(20),
@error2 varchar(20),
@error3 varchar(20),
@GON_NUMBER varchar(20),
@data0701remark nvarchar(100),
@data0701key int,
@isStockDataCtrls  bit,
@send_qty float,
@quantity float

set @error_id=0
set @error_mess=''
set @error0=''
set @error1=''

IF  EXISTS (SELECT STATUS FROM DATA0700 
    	WHERE RKEY=@DATA0700_RKEY AND STATUS=3)
BEGIN
   set @error_id=5
   set @error_mess='������ȷ��!�������ٽ���ȷ��!'
   return
END

if @type=0 --��������
begin
  if not exists(
       SELECT 1 FROM data0706 
    inner JOIN   data0701 ON data0701.RKEY = data0706.RKEY
    inner JOIN   data0700 ON data0700.RKEY = data0701.DATA0700_RKEY 
    where  (data0700.RKEY=@DATA0700_RKEY) and data0706.quan>0 and isnull(data0701.ISSUEDFLAG,0)=2
  )
  begin  
    set @error_id=5
    set @error_mess='����û�з�����Ϣ,�����Խ���ȷ��!'
    return
  end
--�û��ֿ�Ȩ�޿���
  select @isStockDataCtrls = isnull(isStockDataCtrls,0) from Data0192 
  if @isStockDataCtrls=1 
  begin
    SELECT top 1 @error1=Data0016.LOCATION from data0706 
    inner JOIN data0701 ON data0706.RKEY=data0701.RKEY 
    inner join Data0022 on data0706.Data0022_RKEY=Data0022.RKEY
    inner join Data0016 on Data0022.LOCATION_PTR=Data0016.RKEY
    where data0706.quan>0 and isnull(data0701.ISSUEDFLAG,0)=2 and data0701.DATA0700_RKEY=@DATA0700_RKEY 
     and Data0022.LOCATION_PTR not in(
     select Data0810.Key16 from Data0810  where Data0810.Key73 =@AUDITED_BY)
    if  @error1<>''
    begin  
      set @error_id=5
      set @error_mess='û��'+@error1+'Ȩ��,�����Խ�������ȷ��!'
      return
    end
  end
  
  --��ѯְ����
  set @create_bytmp=(SELECT Data0005.RKEY
         FROM Data0005 RIGHT OUTER JOIN
         Data0073 ON Data0005.RKEY = Data0073.EMPLOYEE_PTR
         WHERE (Data0073.RKEY = @create_by))
  set @recd_bytmp=(SELECT Data0005.RKEY
         FROM Data0700
         inner join data0073 on Data0700.user_ptr=data0073.rkey
         inner join Data0005 ON Data0073.EMPLOYEE_PTR=Data0005.RKEY
         WHERE (data0700.RKEY=@DATA0700_RKEY))

  set @AUDITED_BYtmp=(SELECT Data0005.RKEY
         FROM Data0005 RIGHT OUTER JOIN
         Data0073 ON Data0005.RKEY = Data0073.EMPLOYEE_PTR
         WHERE (Data0073.RKEY =@AUDITED_BY))
 

  set @error1=''
  set @error2=''
  set @error3=''
  SET @error_inv=''

  --�жϿ�棬������������ڿ���������д��󷵻�
  --��õ��з����������ڿ���������Ϻ�\��桢����������

   DECLARE ABC CURSOR FOR  
      SELECT data0706.DATA0022_RKEY,SUM(data0706.QUAN) AS TOTAL_QUAN 
        FROM data0700 
        inner JOIN data0701 ON data0700.RKEY = data0701.DATA0700_RKEY 
           and isnull(data0701.ISSUEDFLAG,0)=2 and data0700.RKEY=@DATA0700_RKEY
        inner JOIN data0706 ON data0701.RKEY = data0706.RKEY 
       GROUP BY data0706.DATA0022_RKEY
   OPEN ABC--���α�
   FETCH NEXT FROM ABC INTO @error0,@send_qty
   WHILE(@@FETCH_STATUS=0)
   BEGIN
     set @error_inv=''
     set @error1='0'
     set @quantity=0
     SELECT @error_inv=Data0017.INV_PART_NUMBER,@quantity=I.QUAN_ON_HAND,
           @error3=I.BARCODE_ID 
        FROM data0022 I 
        inner join DATA0017 ON I.INVENTORY_PTR=Data0017.rkey
        where I.RKEY=@error0 --and I.QUAN_ON_HAND>=@error2 
     
     set @error2=cast(@send_qty as varchar(20))
     set @error1=cast(@quantity as varchar(20))
     if @quantity<@send_qty
     begin
         set @error_id=1
         set @error_mess='����'+@error_inv+'���Ϊ��'+@error1+',����Ϊ'+@error3+'�ķ�������Ϊ��'+@error2+',��ɴ�������˴β���!'
         CLOSE ABC
         DEALLOCATE ABC
         return   
     end
     FETCH NEXT FROM ABC INTO @error0,@send_qty
   END    
   CLOSE ABC
   DEALLOCATE ABC
 
  BEGIN TRAN
    /*�������ⵥ�����㵥��,����Ѵ����Զ���1*/
    select @sn=seed_value from data0004  where  Table_name='Data0457'--����457
    while exists( select 1 from data0457 where GON_NUMBER=@sn)
    begin
         select @sn2=substring(@sn,patindex(N'%[1234567890]%',@sn),len(@sn)- patindex(N'%[1234567890]%',@sn)+1- patindex(N'%[1234567890]%',reverse(@sn))+1)
         select @sn=substring(@sn,1,charindex(@sn2,@sn)-1)+convert(varchar,(convert(int,@sn2)+1))
    end
    set @GON_NUMBER=@sn
       --print '@sn'
       --print @sn
    --д����ⵥ
    INSERT INTO Data0457
          (GON_NUMBER, TTYPE, CREATE_DATE, CREATE_BY,RECD_BY,AUDITED_BY,AUDITED_DATE,REF_NUMBER,STATUS)
    values (@GON_NUMBER ,'2',getdate(),@create_bytmp,@recd_bytmp,@AUDITED_BYtmp,getdate(),@DATA0700_RKEY,0) --from data0004 where rkey=56--����457    
    IF @@error>0
    begin
          set @error_id=2
    	  set @error_mess='��¼���ֵ��ܱ����!'
          ROLLBACK TRAN
          return   
    END
    select @sn2=substring(@sn,patindex(N'%[1234567890]%',@sn),len(@sn)- patindex(N'%[1234567890]%',@sn)+1- patindex(N'%[1234567890]%',reverse(@sn))+1)
    select @sn=substring(@sn,1,charindex(@sn2,@sn)-1)+convert(varchar,(convert(int,@sn2)+1))
    set 
    --���³��ⵥ���ֵ�
    update data0004 set seed_value=@sn where  Table_name='Data0457'
    set @da457_207=(select max(rkey) from data0457)--ȡ��457rkey
    --���巢����ϸ�α�
    DECLARE AB CURSOR FOR 
          SELECT Data0017.RKEY AS wl_id, data0701.INV_PART_NUMBER, 
            data0706.DATA0022_RKEY, data0700.RKEY, SUM(data0706.QUAN) AS TOTAL_QUAN, 
            data0700.DEPT_CODE, Data0017.STD_COST,Data0022.quan_on_hand,Data0022.PRICE,Data0022.tax_2, 
            Data0022.EXCHANGE_RATE,data0701.remark,data0701.rkey
          FROM Data0022 
          inner JOIN data0706 ON Data0022.RKEY = data0706.DATA0022_RKEY 
          inner JOIN data0701 ON data0706.RKEY = data0701.RKEY and isnull(data0701.ISSUEDFLAG,0)=2 
          inner JOIN Data0017  ON data0701.INV_PART_NUMBER=Data0017.INV_PART_NUMBER 
          inner JOIN data0700  ON data0701.DATA0700_RKEY = data0700.RKEY 
          GROUP BY data0700.RKEY, data0706.DATA0022_RKEY, data0700.DEPT_CODE, 
          data0701.INV_PART_NUMBER, Data0017.RKEY, Data0017.STD_COST,Data0022.quan_on_hand,Data0022.PRICE,
          Data0022.tax_2,Data0022.EXCHANGE_RATE,data0701.remark,data0701.rkey
          HAVING (data0700.RKEY =@DATA0700_RKEY)
    --���α�
    OPEN AB
    FETCH NEXT FROM AB INTO @A,@B,@C,@D,@E,@F,@G,@H,@PRICE,@I,@EXCHANGE_RATE,@data0701remark,@data0701key
    WHILE(@@FETCH_STATUS=0)
    BEGIN
      --д�뷢����־
      insert into data0095(tran_tp,invt_ptr,srce_ptr,tran_by,rec_by,tran_date,quantity,quan_on_hand,price,tax_2,EXCHANGE_RATE)
      values(13,@a,@C,@create_bytmp,@recd_bytmp,getdate(),@e,@H,@PRICE,@I,@EXCHANGE_RATE) 
      IF @@error>0
      begin
    		set @error_id=3
    		set @error_mess='��¼����ˮ�ʴ���!'
            ROLLBACK TRAN
            return   
      END 
      --д����ֵ���ϸ
      set @da95_207=(select max(rkey)+1 from data0095)
      insert into data0207(ttype,inventory_ptr,dept_ptr,gon_ptr,transaction_ptr,d0022_ptr,tdate,
        quantity,rtn_quantity,standard_cost,remark_info,src_ptr)
      values(2,@a,@f,@da457_207,@da95_207,@c,getdate(),@e,0,@G,@data0701remark,@data0701key)
      IF @@error>0
      begin
    	set @error_id=4
    	set @error_mess='��¼���ֵ��ӱ����!'
        ROLLBACK TRAN
        return   
      END
      --��д������ϸ�Ŀ��ռ����
      update Data0701 set OccupyQty=case when isnull(OccupyQty,0)<=0 then 0
            when isnull(OccupyQty,0)<@E then 0
            else isnull(OccupyQty,0)-@E end,
            GON_NUMBER=@GON_NUMBER,ISSUEDFLAG=3
            where data0701.rkey=@data0701key
      IF @@error>0
      begin
    	set @error_id=4
    	set @error_mess='��д������ϸռ����ʧ��!'
        ROLLBACK TRAN
        return   
      END
    
      --����data0022�Ŀ��
      update data0022 set QUAN_ON_HAND=QUAN_ON_HAND-@e,
          OccupyQty=case when isnull(OccupyQty,0)<=0 then 0
               when isnull(OccupyQty,0)<@E then 0
               else isnull(OccupyQty,0)-@E end
      where rkey=@c
      IF @@error>0
      begin
    	set @error_id=4
    	set @error_mess='�ۼ����ʧ��!'
        ROLLBACK TRAN
        return   
      END
      
   	  FETCH NEXT FROM AB INTO @A,@B,@C,@D,@E,@F,@G,@H,@PRICE,@I,@EXCHANGE_RATE,@data0701remark,@data0701key
    END    
    CLOSE ab
    DEALLOCATE AB
    --��д���쵥  
    UPDATE  DATA0700  set STATUS=3,FL_USER_PTR=@AUDITED_BY,Aud_DATE=GETDATE(),GON_NUMBER=@GON_NUMBER
    WHERE RKEY=@DATA0700_RKEY --��Ϊ��ǩ
    
   
    IF @@error>0
    begin
      set @error_id=4
      set @error_mess='��д���쵥ʧ�ܣ�'
      ROLLBACK TRAN
      return   
    END
    IF @error_id<>0
    begin
      ROLLBACK TRAN
    end
    else
    begin
      set @error_id=0
      set @error_mess='������ȷ�ϳɹ�!�Զ����ɵĳ��ֵ���:'+@GON_NUMBER
      commit tran 
    end
end 
else --�����
begin
  if not exists(
       SELECT 1 FROM data0706 
    inner JOIN   data0701 ON data0701.RKEY = data0706.RKEY
    inner JOIN   data0700 ON data0700.RKEY = data0701.DATA0700_RKEY 
    where  (data0700.RKEY=@DATA0700_RKEY) and isnull(data0701.ISSUEDFLAG,0)=2 
    and (data0701.INV_PART_NUMBER=@inv_part_number or data0701.RKEY=@Data0701_RKEY)
  )
  begin  
      set @error_id=5
      set @error_mess=@inv_part_number+'û�з�����Ϣ,�����Խ���ȷ��!'
      return
  end
  --�û��ֿ�Ȩ�޿���
  select @isStockDataCtrls = isnull(isStockDataCtrls,0) from Data0192 
  if @isStockDataCtrls=1 
  begin
    SELECT top 1 @error1=Data0016.LOCATION from data0706 
    inner JOIN data0701 ON data0706.RKEY=data0701.RKEY 
    inner join Data0022 on data0706.Data0022_RKEY=Data0022.RKEY
    inner join Data0016 on Data0022.LOCATION_PTR=Data0016.RKEY
    where data0706.quan>0 and isnull(data0701.ISSUEDFLAG,0)=2 
     and data0701.DATA0700_RKEY=@DATA0700_RKEY and (data0701.INV_PART_NUMBER=@inv_part_number or data0701.RKEY=@Data0701_RKEY)
     and Data0022.LOCATION_PTR not in(
     select Data0810.Key16 from Data0810  where Data0810.Key73 =@AUDITED_BY)
    if  @error1<>''
    begin  
      set @error_id=5
      set @error_mess='û��'+@error1+'Ȩ��,�����Խ���ȷ��!'
      return
    end
  end
  
   --��ѯְ����
  set @create_bytmp=(SELECT Data0005.RKEY
         FROM Data0005 RIGHT OUTER JOIN
         Data0073 ON Data0005.RKEY = Data0073.EMPLOYEE_PTR
         WHERE (Data0073.RKEY = @create_by))
  set @recd_bytmp=(SELECT Data0005.RKEY
         FROM Data0700
         inner join data0073 on Data0700.user_ptr=data0073.rkey
         inner join Data0005 ON Data0073.EMPLOYEE_PTR=Data0005.RKEY
         WHERE (data0700.RKEY=@DATA0700_RKEY))

  set @AUDITED_BYtmp=(SELECT Data0005.RKEY
         FROM Data0005 RIGHT OUTER JOIN
         Data0073 ON Data0005.RKEY = Data0073.EMPLOYEE_PTR
         WHERE (Data0073.RKEY =@AUDITED_BY))

  set @error1=''
  set @error2=''
  set @error3=''
  SET @error_inv='';
  --������������ڿ���������д��󷵻�
  --��õ��з����������ڿ���������Ϻ�\��桢����������

  DECLARE ABC CURSOR FOR  
      SELECT data0706.DATA0022_RKEY,SUM(data0706.QUAN) AS TOTAL_QUAN 
        FROM data0700 
        inner JOIN data0701 ON data0700.RKEY = data0701.DATA0700_RKEY 
           and isnull(data0701.ISSUEDFLAG,0)=2 and data0700.RKEY=@DATA0700_RKEY
           and data0701.INV_PART_NUMBER=@inv_part_number 
        inner JOIN data0706 ON data0701.RKEY = data0706.RKEY 
       GROUP BY data0706.DATA0022_RKEY
   OPEN ABC--���α�
   FETCH NEXT FROM ABC INTO @error0,@send_qty
   WHILE(@@FETCH_STATUS=0)
   BEGIN
     set @error_inv=''
     set @error1='0'
     SELECT @error_inv=Data0017.INV_PART_NUMBER,@quantity=I.QUAN_ON_HAND,
           @error3=I.BARCODE_ID 
        FROM data0022 I 
        inner join DATA0017 ON I.INVENTORY_PTR=Data0017.rkey
        where I.RKEY=@error0 -- and I.QUAN_ON_HAND>=@error2  
     
     set @error2=cast(@send_qty as varchar(20))
     set @error1=cast(@quantity as varchar(20))
     if @quantity<@send_qty
     begin
         set @error_id=1
         set @error_mess='����'+@error_inv+'���Ϊ��'+@error1+',����Ϊ'+@error3+'�ķ�������Ϊ��'+@error2+',��ɴ�������˴β���!'
         CLOSE ABC
         DEALLOCATE ABC
         return   
     end
     FETCH NEXT FROM ABC INTO @error0,@send_qty
  END    
  CLOSE ABC
  DEALLOCATE ABC
  BEGIN TRAN
    /*�������ⵥ�����㵥��,����Ѵ����Զ���1*/
    select @sn=seed_value from data0004  where  Table_name='Data0457'--����457
    while exists( select 1 from data0457 where GON_NUMBER=@sn)
    begin
         select @sn2=substring(@sn,patindex(N'%[1234567890]%',@sn),len(@sn)- patindex(N'%[1234567890]%',@sn)+1- patindex(N'%[1234567890]%',reverse(@sn))+1)
         select @sn=substring(@sn,1,charindex(@sn2,@sn)-1)+convert(varchar,(convert(int,@sn2)+1))
    end
    set @GON_NUMBER=@sn
       --print '@sn'
       --print @sn
    --д����ⵥ
    INSERT INTO Data0457
          (GON_NUMBER, TTYPE, CREATE_DATE, CREATE_BY,RECD_BY,AUDITED_BY,AUDITED_DATE,REF_NUMBER,STATUS)
    values (@GON_NUMBER ,'2',getdate(),@create_bytmp,@recd_bytmp,@AUDITED_BYtmp,getdate(),@DATA0700_RKEY,0) --from data0004 where rkey=56--����457    
    IF @@error>0
    begin
          set @error_id=2
    	  set @error_mess='��¼���ֵ��ܱ����!'
          ROLLBACK TRAN
          return   
    END
    select @sn2=substring(@sn,patindex(N'%[1234567890]%',@sn),len(@sn)- patindex(N'%[1234567890]%',@sn)+1- patindex(N'%[1234567890]%',reverse(@sn))+1)
    select @sn=substring(@sn,1,charindex(@sn2,@sn)-1)+convert(varchar,(convert(int,@sn2)+1))
    --���³��ⵥ���ֵ�
    update data0004 set seed_value=@sn where  Table_name='Data0457'
    set @da457_207=(select max(rkey) from data0457)--ȡ��457rkey
    --���巢����ϸ�α�
    DECLARE AB CURSOR FOR 
          SELECT Data0017.RKEY AS wl_id, data0701.INV_PART_NUMBER, 
            data0706.DATA0022_RKEY, data0700.RKEY, SUM(data0706.QUAN) AS TOTAL_QUAN, 
            data0700.DEPT_CODE, Data0017.STD_COST, Data0022.quan_on_hand,Data0022.PRICE,Data0022.tax_2, 
            Data0022.EXCHANGE_RATE,data0701.remark,data0701.rkey
          FROM Data0022 
          inner JOIN data0706 ON Data0022.RKEY = data0706.DATA0022_RKEY 
          inner JOIN data0701 ON data0706.RKEY = data0701.RKEY 
            and (data0701.INV_PART_NUMBER=@inv_part_number  or data0701.RKEY=@Data0701_RKEY) and isnull(data0701.ISSUEDFLAG,0)=2
          inner JOIN Data0017  ON data0701.INV_PART_NUMBER=Data0017.INV_PART_NUMBER 
          inner JOIN data0700  ON data0701.DATA0700_RKEY = data0700.RKEY 
          GROUP BY data0700.RKEY, data0706.DATA0022_RKEY, data0700.DEPT_CODE, 
          data0701.INV_PART_NUMBER, Data0017.RKEY, Data0017.STD_COST, 
          Data0022.quan_on_hand,Data0022.PRICE,Data0022.tax_2,Data0022.EXCHANGE_RATE,data0701.remark,data0701.rkey
          HAVING (data0700.RKEY =@DATA0700_RKEY)
    OPEN AB--���α�
    FETCH NEXT FROM AB INTO @A,@B,@C,@D,@E,@F,@G,@H,@PRICE,@I,@EXCHANGE_RATE,@data0701remark,@data0701key
    WHILE(@@FETCH_STATUS=0)
    BEGIN
      --д������־
      insert into data0095(tran_tp,invt_ptr,srce_ptr,tran_by,rec_by,tran_date,quantity,quan_on_hand,price,tax_2,EXCHANGE_RATE)
      values(13,@a,@C,@create_bytmp,@recd_bytmp,getdate(),@e,@H,@PRICE,@I,@EXCHANGE_RATE) 
      IF @@error>0
      begin
    	set @error_id=3
    	set @error_mess='��¼����ˮ�ʴ���!'
        ROLLBACK TRAN
        return   
      END
      set @da95_207=(select max(rkey)+1 from data0095)
      --д������ϸ
      insert into data0207(ttype,inventory_ptr,dept_ptr,gon_ptr,transaction_ptr,d0022_ptr,tdate,
        quantity,rtn_quantity,standard_cost,remark_info,src_ptr)
      values(2,@a,@f,@da457_207,@da95_207,@c,getdate(),@e,0,@G,@data0701remark,@data0701key)
      IF @@error>0
      begin
    	set @error_id=4
    	set @error_mess='��¼���ֵ��ӱ����!'
        ROLLBACK TRAN
        return   
      END
      --��д���ϵ�ռ����
      update Data0701 set OccupyQty=case when isnull(OccupyQty,0)<=0 then 0
            when isnull(OccupyQty,0)<@E then 0
            else isnull(OccupyQty,0)-@E end,
            GON_NUMBER=@GON_NUMBER,ISSUEDFLAG=3
            where data0701.rkey=@data0701key
      IF @@error>0
      begin
    	set @error_id=4
    	set @error_mess='��д������ϸռ����ʧ��!'
        ROLLBACK TRAN
        return   
      END
       --����data0022�Ŀ��
      update data0022 set QUAN_ON_HAND=QUAN_ON_HAND-@e,
          OccupyQty=case when isnull(OccupyQty,0)<=0 then 0
               when isnull(OccupyQty,0)<@E then 0
               else isnull(OccupyQty,0)-@E end
      where rkey=@c
      IF @@error>0
      begin
    	set @error_id=4
    	set @error_mess='�ۼ����ʧ��!'
        ROLLBACK TRAN
        return   
      END
   
 
      FETCH NEXT FROM AB INTO @A,@B,@C,@D,@E,@F,@G,@H,@PRICE,@I,@EXCHANGE_RATE,@data0701remark,@data0701key
    END    
    CLOSE ab
    DEALLOCATE AB
      
    --��д���쵥
    if not exists(SELECT 1 FROM data0701
       inner JOIN data0700 ON data0700.RKEY = data0701.DATA0700_RKEY
       where data0700.RKEY=@DATA0700_RKEY and isnull(data0701.ISSUEDFLAG,0)in(0,2))
    begin
      UPDATE  DATA0700  set STATUS=3,FL_USER_PTR=@AUDITED_BY,Aud_DATE=GETDATE(),GON_NUMBER=@GON_NUMBER
      WHERE RKEY=@DATA0700_RKEY --��Ϊ��ǩ
    end

   IF @@error>0
   begin
     set @error_id=4
     set @error_mess='��д���ݿ�ʧ�ܣ�'
     ROLLBACK TRAN
     return   
   END
   IF @error_id<>0
   begin
     ROLLBACK TRAN
   end
   else
   begin
     set @error_id=0
     set @error_mess=',�Զ����ɵĳ��ֵ���:'+@GON_NUMBER
     commit tran 
   end
end 
go
--EP702�����˻�
--
exec sp_executesql N'UPDATE "SJ_V20_Sample".."Data0004" SET "SEED_VALUE"=@P1 WHERE "SEED_VALUE"=@P2 AND "RKEY"=@P3',N'@P1 varchar(9),@P2 varchar(9),@P3 int','ST0000065','ST0000064',66
go
insert data0703 values ('ST0000064   ','SL0001360   ','8','2013-12-22','2013-12-23','asdf',1,null,null,0,0,0)

go
INSERT INTO data0704 VALUES ('ST0000064   ','8615',1)

GO

--�ύ

update data0703 set status=3,seq=0,SK_USER_PTR=0 where  rkey='ST0000064'


--EP703�������
--

declare @p1 int
set @p1=1
declare @p4 smallint
set @p4=0
declare @p5 varchar(50)
set @p5='�����������ɹ�!�Զ����ɵĳ��ֵ���:X10010880'
exec sp_prepexecrpc @p1 output,N'ep703;1','ST0000064   ',@p4 output,@p5 output,1
select @p1, @p4, @p5

create PROCEDURE ep703;1
      @data0704 varchar(30),
      @error_id smallint out,
      @error_mess varchar(50)out,
      @USER_PTR int =1
AS 
declare    
    @da95_207 int,
    @da457_207 int,
    @recd_bytmp int,
    @create_bytmp int,
    @a int,
    @b varchar(20),
    @c int,
    @d varchar(20),
    @e float,
    @f int,
    @EXCHANGE_RATE float,
    @PRICE float,
    @sn  varchar(20),@sn2 varchar(20),
    @isStockDataCtrls  bit
    set @error_id=0
    set @error_mess=''
    --�ж��û��ֿ�Ȩ��
    select @isStockDataCtrls = isnull(isStockDataCtrls,0) from Data0192 
    if @isStockDataCtrls=1 
    begin
      if not EXISTS ( 
      select I.LOCATION_PTR FROM data0022 I  
    		INNER JOIN (SELECT data0704.RKEY,data0706.DATA0022_RKEY,SUM(data0704.QUAN) AS TOTAL_QUAN
    		    FROM data0704 INNER JOIN
          		data0706 ON data0704.DATA0706_RKEY = data0706.RKEY1
    		    GROUP BY data0704.RKEY, data0706.DATA0022_RKEY
    		    HAVING (data0704.RKEY =@data0704)
               ) C ON I.RKEY=C.DATA0022_RKEY 
            where I.LOCATION_PTR in (select Data0810.Key16 from Data0810 where Data0810.Key73 = @USER_PTR)
      )
      begin
        set @error_id=1
    	set @error_mess='��û�иòֿ��Ȩ��!'
        return
      end
    end
    --��ѯְ����
    set @create_bytmp=(SELECT Data0005.RKEY
         FROM Data0005 RIGHT OUTER JOIN
         Data0073 ON Data0005.RKEY = Data0073.EMPLOYEE_PTR
         WHERE (Data0073.RKEY =@USER_PTR))
    set @recd_bytmp=@create_bytmp;
    BEGIN TRAN
    --����0022������
    update data0022 set QUAN_ON_HAND=QUAN_ON_HAND+C.TOTAL_QUAN 
       FROM data0022 I INNER JOIN 
    		(SELECT data0704.RKEY, data0706.DATA0022_RKEY, SUM(data0704.QUAN) AS TOTAL_QUAN
    		FROM data0704 INNER JOIN
          		data0706 ON data0704.DATA0706_RKEY = data0706.RKEY1
    		GROUP BY data0704.RKEY, data0706.DATA0022_RKEY
    		HAVING (data0704.RKEY = @data0704)) C
    ON I.RKEY=C.DATA0022_RKEY
    
    --����0706���ѷ�����
    update data0706 set RETURN_QUAN=isnull(RETURN_QUAN,0)+C.total_QUAN 
    	FROM data0706 I right JOIN 
    	(SELECT data0704.RKEY,data0706.RKEY1,SUM(data0704.QUAN) AS TOTAL_QUAN
         	 
    	FROM data0704 INNER JOIN
          	data0706 ON data0704.DATA0706_RKEY = data0706.RKEY1
    	GROUP BY data0704.RKEY,data0706.RKEY1
       	HAVING (data0704.RKEY = @data0704)) C
    ON I.RKEY1=C.RKEY1
    
    IF @@error>0
    begin
    	set @error_id=1
    	set @error_mess='�˻�����������������!'
        ROLLBACK TRAN
        return
    END
    
     /*���㵥��,����Ѵ����Զ���1*/
    select @sn=seed_value from data0004  where  Table_name='Data0457'--����457
    while exists( select 1 from data0457 where GON_NUMBER=@sn)
    begin
      select @sn2=substring(@sn,patindex(N'%[1234567890]%',@sn),len(@sn)- patindex(N'%[1234567890]%',@sn)+1- patindex(N'%[1234567890]%',reverse(@sn))+1)
      select @sn=substring(@sn,1,charindex(@sn2,@sn)-1)+convert(varchar,(convert(int,@sn2)+1))
    end
      --print '@sn'
      --print @sn
       /*���㵥��,����Ѵ����Զ���1*/
    INSERT INTO Data0457
          (GON_NUMBER, TTYPE, CREATE_DATE, CREATE_BY, REF_NUMBER,STATUS)
     values (@sn ,'2',getdate(),@create_bytmp,@data0704,0) --from data0004 where rkey=56--����457    
    IF @@error>0
    begin
      set @error_id=2
      set @error_mess='��¼���ֵ��ܱ����!'+str(@@error)
      ROLLBACK TRAN
      return
    END
    set @da457_207=(select max(rkey) from data0457)--ȡ��457rkey
 
    DECLARE AB CURSOR--�����α�,׼����¼��ˮ��0095�ͳ��ֵ��ӱ�0207
    FOR
       SELECT Data0017.RKEY AS wl_id, Data0017.INV_PART_NUMBER, 
          data0706.DATA0022_RKEY, data0704.RKEY, SUM(data0704.QUAN) AS TOTAL_QUAN, 
          data0703.DEPT_CODE, Data0022.PRICE, Data0022.EXCHANGE_RATE
       FROM Data0017 RIGHT OUTER JOIN
          Data0022 ON Data0017.RKEY = Data0022.INVENTORY_PTR RIGHT OUTER JOIN
          data0706 RIGHT OUTER JOIN
          data0704 ON data0706.RKEY1 = data0704.DATA0706_RKEY LEFT OUTER JOIN
          data0703 ON data0704.RKEY = data0703.RKEY ON 
          Data0022.RKEY = data0706.DATA0022_RKEY
       GROUP BY Data0017.RKEY, data0704.RKEY, Data0017.INV_PART_NUMBER, 
          data0706.DATA0022_RKEY, data0703.DEPT_CODE, Data0022.PRICE, 
          Data0022.EXCHANGE_RATE
       HAVING (data0704.RKEY = @data0704)
    
    
    OPEN AB--���α�
    FETCH NEXT FROM AB INTO @A,@B,@C,@D,@E,@F,@PRICE,@EXCHANGE_RATE
    
    WHILE(@@FETCH_STATUS=0)
    BEGIN
      insert into data0095(tran_tp,invt_ptr,srce_ptr,tran_by,rec_by,tran_date,quantity)
            values(15,@a,@c,@USER_PTR,@USER_PTR,getdate(),0-@e) 
      IF @@error>0
      begin
    	set @error_id=3
    	set @error_mess='��¼��ˮ�ʴ���!'
        ROLLBACK TRAN
        return
      END
      set @da95_207=(select max(rkey) from data0095)
      insert into data0207(ttype,inventory_ptr,dept_ptr,gon_ptr,transaction_ptr,d0022_ptr,tdate,quantity,rtn_quantity,standard_cost)
            values(4,@a,@f,@da457_207,@da95_207,@c,getdate(),0-@e,0,0)
    
      IF @@error>0
      begin
    	set @error_id=4
    	set @error_mess='��¼���ֵ��ӱ����!'
        ROLLBACK TRAN
        return
      END
 
      FETCH NEXT FROM AB INTO @A,@B,@C,@D,@E,@F,@PRICE,@EXCHANGE_RATE
    END
    CLOSE ab
    DEALLOCATE AB
    --��Ϊ��ǩ
    UPDATE DATA0703 set STATUS=4,SK_USER_PTR=@USER_PTR,SK_DATE=GETDATE() 
    WHERE RKEY=@data0704
    IF @@error>0
    begin
      	set @error_id=4
    	set @error_mess='��дData0703ʧ��!'
        ROLLBACK TRAN
        return
    END
    UPDATE  DATA0207 set rtn_quantity=rtn_quantity+@e where d0022_ptr=@c and ttype=2 
         and inventory_ptr=@a and dept_ptr=@f   --ͬһ���ţ�ͬһ���Ͽ��ܴ��ڶ�����ϣ����������ģ�������????�ͼ�����Ҳ���У����Ҫ����207RKEY�����߹�˵���ø�
    IF @@error>0
    begin
    	set @error_id=4
    	set @error_mess='��¼�˲�����ʧ��!'
        ROLLBACK TRAN
        return
    END
   	set @error_mess='�����������ɹ�!�Զ����ɵĳ��ֵ���:'+(select GON_NUMBER from data0457 where rkey=@da457_207)
    commit tran
    GO
    
    
    exec sp_executesql N'UPDATE "SJ_V20_Sample".."Data0004" SET "SEED_VALUE"=@P1 WHERE "SEED_VALUE"=@P2 AND "RKEY"=@P3',N'@P1 varchar(9),@P2 varchar(9),@P3 int','X10010881','X10010880',56

