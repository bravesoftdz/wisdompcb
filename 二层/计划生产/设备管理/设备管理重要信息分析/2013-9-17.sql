drop view V_0837

create view V_0837
as 
SELECT TOP (100) PERCENT 
Case when datepart(HH,BeginTime)>=8 then dbo.Data0837.WorkDate 
else DateAdd(day,-1,dbo.Data0837.WorkDate) end as WorkDate, 
dbo.Data0837.WorkTime, dbo.Data0005.EMPLOYEE_NAME
FROM  dbo.Data0837 INNER JOIN
        dbo.Data0005 ON dbo.Data0837.Empl_ptr = dbo.Data0005.RKEY
ORDER BY dbo.Data0005.EMPLOYEE_NAME, dbo.Data0837.WorkDate
/*��������Ŀ�ʼ���ڵ�ʱ�䲿��>=8Сʱ���������ھ��ǵ��죬����������-1�죬��ͳ�Ƶ�ǰһ��*/

select * from V_0837
��ʱ��ѯ
declare @sql varchar(8000),@SD datetime,@ED datetime
set @SD='2013-8-1' set @ED='2013-12-1'
select @sql=isnull(@sql+',','')+EMPLOYEE_NAME from V_0842_0848 
where V_0842_0848.WorkDate>=@SD and V_0842_0848.WorkDate<=@ED
group by EMPLOYEE_NAME         
set @sql='select * from V_0842_0848 '
+' pivot (sum(WorkTime) for EMPLOYEE_NAME in ('+@sql+'))a'
+' where WorkDate>='
+''''+CONVERT(varchar(100), @SD, 23)+''''+' and  WorkDate<='+''''+ CONVERT(varchar(100), @ED, 23)+''''
select (@sql)

select WorkDate as [����],* from V_0842_0848  
pivot (sum(WorkTime) for EMPLOYEE_NAME in (test,�����,�����,��,������))a 
where WorkDate>='2013-08-01' and  WorkDate<='2013-12-01'

drop view V_0842_0848
go
create view V_0842_0848
as 
select TOP (100) PERCENT 
Case when datepart(HH,BeginTime)>=8 then dbo.data0842.WorkDate 
else DateAdd(day,-1,dbo.data0842.WorkDate) end as WorkDate, 
data0842.WorkTime,data0005.EMPLOYEE_NAME ,data0567.WHOUSE_PTR
from data0842 join data0005 on data0842.Empl_ptr=data0005.rkey
join data0567 on data0567.rkey=data0842.Work_ptr
order by data0567.WHOUSE_PTR,data0005.EMPLOYEE_NAME, data0842.WorkDate
union 
select TOP (100) PERCENT 
Case when datepart(HH,BeginTime)>=8 then dbo.data0848.WorkDate 
else DateAdd(day,-1,dbo.data0848.WorkDate) end as WorkDate, 
data0848.WorkTime,data0005.EMPLOYEE_NAME ,data0417.warehouse_ptr
from data0848 join data0005 on data0848.Empl_ptr=data0005.rkey
join data0831 on data0831.rkey=data0848.Work_ptr
join data0417 on data0831.DeviNumb=data0417.FASSET_CODE
order by data0417.warehouse_ptr,data0005.EMPLOYEE_NAME, data0848.WorkDate

select * from V_0842_0848

declare @sql varchar(8000)--��ÿγ̼���
select WorkDate,
 sum(case EMPLOYEE_NAME when'�̳���'then WorkTime else 0 end)�̳���,
 sum(case EMPLOYEE_NAME when'test'  then WorkTime else 0 end)test,
 sum(case EMPLOYEE_NAME when'��ʱ��'then WorkTime else 0 end)��ʱ��
from V_0842
group by WorkDate


select @sql=isnull(@sql+',','')+�γ� from tb group by �γ� 
select  @sql         
set @sql='select * from tb pivot (max(����) for �γ� in ('+@sql+'))a'
exec(@sql)
exec P_0842_0848 '2013-1-1','2013-12-1'
drop proc P_0842_0848
create proc P_0842_0848(
@SD datetime,
@ED datetime)
as
declare @sql varchar(8000)
select @sql=isnull(@sql+',','')+EMPLOYEE_NAME from V_0842_0848 
where V_0842_0848.WorkDate>=@SD and V_0842_0848.WorkDate<=@ED
group by EMPLOYEE_NAME         
set @sql='select * from V_0842_0848 '
+' pivot (sum(WorkTime) for EMPLOYEE_NAME in ('+@sql+'))a'
+' where WorkDate>='
+''''+CONVERT(varchar(100), @SD, 23)+''''+' and  WorkDate<='+''''+ CONVERT(varchar(100), @ED, 23)+''''
exec(@sql)

select * from V_0842_0848 
pivot (sum(WorkTime) for EMPLOYEE_NAME in (test,����վ1,����»,��ʱ��,�����,�����,�����,��,������))a
where WorkDate>='2013-08-01' and WorkDate<='2013-12-01' 

if object_id('tempdb..#TempDATA0207') is not null     drop table #TempDATA0207
declare @price dec(9,2),@DiffMinu int,@SD datetime ,@ED Datetime
set @price=100 set @DiffMinu=6000 set @SD='2013-1-1' set @ED='2014-1-1'
SELECT DATA0468.rkey,data0468.INVENT_PTR,
 dbo.DATA0268.number    [���쵥��],
 dbo.DATA0268.[DATE]    [��������], 
 dbo.Data0034.DEPT_CODE [���첿��], 
 dbo.Data0034.DEPT_NAME [��������], 
 dbo.Data0005.EMPL_CODE [�����˴���], 
 dbo.Data0005.EMPLOYEE_NAME AS [����Ա������], 
 CASE WHEN data0268.status = 0 THEN '���ύ' WHEN data0268.status = 1 THEN '�����'  
 WHEN data0268.status = 2 THEN '�����' WHEN data0268.status  = 3 THEN '���˻�'  
 WHEN data0268.status = 4 THEN '�ѷ���' END AS [���״̬],
 dbo.Data0015.ABBR_NAME AS [����],
 case dbo.DATA0268.ttype when 2 then 'ά��' when 3 then 'ά��' when 4 then '����' when 5 then '����' end as [����],
 dbo.data0567.NUMBER as    [ά�޵�����],
 dbo.data0831.PlanMainDate [��������],
 dbo.data0831.MainCycl     [��������],
 Case when dbo.DATA0268.TTYPE=2 then(d17_2.FASSET_CODE) 
      when dbo.DATA0268.TTYPE=3 then(data0831.DeviNumb) end as [�豸���], 
 Case when dbo.DATA0268.TTYPE=2 then(d17_2.FASSET_NAME) 
      when dbo.DATA0268.TTYPE=3 then(d17_1.FASSET_NAME) end as [�豸����],   
 Case when dbo.DATA0268.TTYPE=2 then(d17_2.DEPT_PTR) 
      when dbo.DATA0268.TTYPE=3 then(d17_1.DEPT_PTR) end as DEPT_PTR,           
 data0840.[Location]    [�豸����С��],
 dbo.data0835.WorkOrder [�յ���ҵ����������],
 data0830.[DeptName]    [��������],
 Data0836.[WorkName]    [������������],
 data0835.[WorkExpl]    [��������˵��],
 Data0468.QUAN_BOM      [��������],
 Data0468.QUAN_ISSUED   [��������],
 (select sum(ROUND( dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	where  data0207.D0468_ptr = Data0468.rkey
   )as[����] 
  into #TempDATA0207
from data0268
 join DATA0468 on DATA0468.FLOW_NO = DATA0268.RKEY 
 INNER JOIN dbo.Data0034 ON dbo.DATA0268.dept_ptr = dbo.Data0034.RKEY and dbo.DATA0268.ttype in (2,3,4,5) /*2ά��;3ά��;4����;5����*/
 INNER JOIN dbo.Data0005 ON dbo.DATA0268.EMPL_PTR = dbo.Data0005.RKEY 
 INNER JOIN dbo.Data0015 ON dbo.DATA0268.warehouse_ptr = dbo.Data0015.RKEY 
 left join dbo.data0831 on DATA0268.[d831_ptr]=dbo.data0831.rkey 
 left join data0417 d17_1 on d17_1.FASSET_CODE=data0831.DeviNumb 
 left join dbo.data0567 on DATA0268.[d567_ptr]=dbo.data0567.rkey 
 left join data0417 d17_2 on d17_2.rkey=data0567.FASSET_PTR 
 left join dbo.data0835 on DATA0268.[d835_ptr]=dbo.data0835.rkey 
 left join data0840 on  DATA0268.[d840_ptr]=dbo.data0840.rkey 
 left join dbo.data0830 on data0835.[Dept_ptr]=data0830.rkey  
 left join dbo.Data0836 on data0835.[Work_ptr]=data0836.rkey  
 where dbo.DATA0268.[DATE]>=@SD and dbo.DATA0268.[DATE]<@ED and data0268.status =4
 select *  from (select INV_PART_NUMBER [���ϱ��],INV_PART_DESCRIPTION [�������ƹ��],data0002.unit_name [��λ],#TempDATA0207.* 
 from 	#TempDATA0207 
 join data0017 on data0017.rkey=#TempDATA0207.INVENT_PTR
 join data0002 on data0017.STOCK_UNIT_PTR=data0002.rkey  
where exists(
	select * from #TempDATA0207 t1 where (t1.INVENT_PTR=#TempDATA0207.INVENT_PTR) 
	and (t1.rkey<> #TempDATA0207.rkey)
	and (datediff(minute,t1.[��������],#TempDATA0207.[��������])Between -@DiffMinu and @DiffMinu)
)and [����]>@price)as t1
order by [���ϱ��],[��������]	



select data0268.[date],data0468.* from data0468 
join data0268 ON  DATA0468.FLOW_NO = DATA0268.RKEY AND DATA0268.ttype in (2,3,4) AND DATA0268.STATUS IN(2,4)
where data0268.[date]>='2013-1-1'
�ظ���������
DATA0268:�������뵥
Data0468:���Ϸ��ŵ����ϵ�
Data0207:���ϼ�¼
Data0456:������ⵥ
if object_id('tempdb..#TempDATA0207') is not null     drop table #TempDATA0207
declare @price dec(9,2),@DiffMinu int,@SD datetime ,@ED Datetime
set @price=50
set @DiffMinu=300
set @SD='2013-1-1'
set @ED='2014-1-1'
select DATA0268.[DATE] [��������],DATA0268.number[���뵥��],DATA0468.RKEY,DATA0468.INVENT_PTR,data0207.Tdate[��������], 
DATA0268.D835_ptr,DATA0268.D567_ptr,D831_ptr,D840_ptr,
Data0207.QUANTITY[��������],(ROUND(dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))[����] into #TempDATA0207
from data0207 
	JOIN DATA0022 ON  DATA0022.RKEY      = DATA0207.D0022_PTR 
	JOIN DATA0456 ON  DATA0022.GRN_PTR   = DATA0456.RKEY
	JOIN DATA0468 ON  DATA0207.D0468_PTR = DATA0468.RKEY
	JOIN DATA0268 ON  DATA0468.FLOW_NO   = DATA0268.RKEY AND DATA0268.ttype in (2,3,4) AND DATA0268.STATUS IN(2,4)
	where DATA0268.[DATE] >=@SD and DATA0268.[DATE]<@ED
select *
, data0830.[DeptName]     [��������],
 Data0836.[WorkName]     [������������], 
 data0835.[WorkExpl]     [��������˵��]  
from 	#TempDATA0207
left join data0835 on #TempDATA0207.D835_ptr= data0835.rkey
left join data0830 on data0835.Dept_ptr=data0830.rkey
left join data0836 on data0835.Work_ptr=data0836.rkey
where exists(
	select * from #TempDATA0207 t1 where (t1.INVENT_PTR=#TempDATA0207.INVENT_PTR) 
	and (t1.rkey<> #TempDATA0207.rkey)
	and (datediff(minute,t1.[��������],#TempDATA0207.[��������])Between -@DiffMinu and @DiffMinu)
)	

ͬ�豸����ͬ����
declare @price dec(9,2),@DiffMinu int,@SD datetime ,@ED Datetime
set @price=50
set @DiffMinu=300
set @SD='2000-1-1'
set @ED='2014-1-1'
if object_id('tempdb..#TempDATA0831') is not null     drop table #TempDATA0831
if object_id('tempdb..#TempDATA0268') is not null     drop table #TempDATA0268
if object_id('tempdb..#TempDATA0567') is not null     drop table #TempDATA0567
select DATA0268.number[���뵥��],DATA0468.RKEY,DATA0468.INVENT_PTR,data0207.Tdate[��������], 
DATA0268.D835_ptr,DATA0268.D567_ptr,DATA0268.D831_ptr,data0417.rkey as data0417rkey,
data0417.FASSET_CODE[�豸���],data0417.FASSET_NAME[�豸����],data0831.MainCycl[����],data0831.PlanMainDate[�����ƻ�����],
null [ά�޵���],Data0207.QUANTITY[��������],
    (ROUND(dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))[����] into  #TempDATA0831    
    from data0207 
	JOIN DATA0022 ON  DATA0022.RKEY      = DATA0207.D0022_PTR 
	JOIN DATA0456 ON  DATA0022.GRN_PTR   = DATA0456.RKEY
	JOIN DATA0468 ON  DATA0207.D0468_PTR = DATA0468.RKEY
	JOIN DATA0268 ON  DATA0468.FLOW_NO   = DATA0268.RKEY AND DATA0268.STATUS IN(2,4)
	join data0831 on  DATA0268.D831_ptr  = DATA0831.rkey
	join data0417 on  data0831.DeviNumb  = data0417.FASSET_CODE
	where data0207.Tdate >=@SD and data0207.Tdate<@ED
	--select * from #TempDATA0831
/*�������ƻ����ظ����ò��ϵļ�¼������ʱ��*/
select * into #TempDATA0268 from 	#TempDATA0831
where exists(
	select * from #TempDATA0831 t1 where (t1.INVENT_PTR=#TempDATA0831.INVENT_PTR) 
	and (t1.data0417rkey=#TempDATA0831.data0417rkey)  and (t1.rkey<> #TempDATA0831.rkey)
	and (datediff(minute,t1.[��������],#TempDATA0831.[��������])Between -@DiffMinu and @DiffMinu)
)
and [����]>=@price
ALTER TABLE #TempDATA0268  ALTER COLUMN [�����ƻ�����]  [datetime] NULL  
ALTER TABLE #TempDATA0268  ALTER COLUMN [����]  varchar(10) NULL 
ALTER TABLE #TempDATA0268  ALTER COLUMN [ά�޵���]  varchar(30) NULL 
select DATA0268.number[���뵥��],DATA0468.RKEY,DATA0468.INVENT_PTR,data0207.Tdate[��������], 
DATA0268.D835_ptr,DATA0268.D567_ptr,DATA0268.D831_ptr,data0417.rkey as data0417rkey,
data0417.FASSET_CODE,data0417.FASSET_NAME,null [����],null [�����ƻ�����],
DATA0567.NUMBER [ά�޵���],Data0207.QUANTITY[��������],
    (ROUND(dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))[����] into  #TempDATA0567    
    from data0207 
	JOIN DATA0022 ON  DATA0022.RKEY      = DATA0207.D0022_PTR 
	JOIN DATA0456 ON  DATA0022.GRN_PTR   = DATA0456.RKEY
	JOIN DATA0468 ON  DATA0207.D0468_PTR = DATA0468.RKEY
	JOIN DATA0268 ON  DATA0468.FLOW_NO   = DATA0268.RKEY AND DATA0268.STATUS IN(2,4)
	join DATA0567 on  DATA0268.D567_ptr  = DATA0567.rkey
	join data0417 on  DATA0567.FASSET_PTR  = data0417.rkey
	where data0207.Tdate >=@SD and data0207.Tdate<@ED
/*��ά�޵����ظ����ò��ϵļ�¼������ʱ��*/	
insert into #TempDATA0268	
select *   from 	#TempDATA0567
where exists(
	select * from #TempDATA0567 t1 where (t1.INVENT_PTR=#TempDATA0567.INVENT_PTR) 
	and (t1.data0417rkey=#TempDATA0567.data0417rkey)  and (t1.rkey<> #TempDATA0567.rkey)
	and (datediff(minute,t1.[��������],#TempDATA0567.[��������])Between -@DiffMinu and @DiffMinu)
)
and [����]>=@price
select INV_PART_NUMBER [���ϱ��],INV_PART_DESCRIPTION [��������/���],data0002.unit_name ��λ,#TempDATA0268.* from #TempDATA0268 
join data0017 on #TempDATA0268.INVENT_PTR=data0017.rkey
join data0002 on data0017.STOCK_UNIT_PTR=data0002.rkey 



select * from (select 
data0835.rkey,
data0835.WorkOrder [��������],
data0835.WorkExpl  [��������˵��],
data0830.DeptName  [ʩ����/��ҵ��],
data0835.AdmiTime  [����ʱ��],
d73_2.USER_FULL_NAME as [������],
d73_3.USER_FULL_NAME as [������],
    (select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	join data0268 on  data0468.FLOW_NO   = data0268.rkey and dbo.DATA0268.ttype = 4 and data0268.status in(2,4)
	and data0268.[d835_ptr]=data0835.rkey)as[���(���Һ�˰)]
from data0835 
join data0830 on data0835.Dept_ptr=data0830.rkey
join data0836 on data0835.Work_ptr=data0836.rkey
join data0073 on data0835.Applican=data0073.rkey
left join data0073 d73_2 on data0835.AdmiPeop=d73_2.rkey 
left join data0073 d73_3 on data0835.AccePeop=d73_3.rkey 
where (Data0835.AdmiTime>=:SD and Data0835.AdmiTime<=:ED) and Data0835.status in (1,3,4,6))as t1
where [���(���Һ�˰)]>=:TotalAmount
union
select * from (select 
DATA0567.RKEY DATA0567RKEY,
DATA0567.NUMBER      AS [ά�޵�����],
DATA0417.FASSET_CODE AS [�豸���], 
DATA0417.FASSET_NAME AS [�豸����],             
DATA0840.[LOCATION]  AS [�豸����С��],
DATA0034.DEPT_CODE   AS [ʹ�ò���], 
DATA0034.DEPT_NAME   AS [��������], 
DATA0015.ABBR_NAME   AS [����],
DATA0567.FAILURE_DATE   [��������] ,
NULL                    [DATA0835RKEY],
NULL                    [��������],
NULL                    [��������˵��],
null                    [ʩ����/��ҵ��],
null                    [����ʱ��],
null                    [������],
null                    [������],
null                    [��������],
    (select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	join data0268 on  data0468.FLOW_NO   = data0268.rkey and dbo.DATA0268.ttype = 2 and data0268.status in(2,4)
	and data0268.[d567_ptr]=data0567.rkey)as[���(���Һ�˰)]
from data0567 
join data0417  on data0417.rkey=data0567.FASSET_PTR
INNER JOIN dbo.Data0015 ON dbo.data0417.warehouse_ptr = dbo.Data0015.RKEY 
INNER JOIN dbo.Data0034 ON dbo.data0417.dept_ptr = dbo.Data0034.RKEY
left join data0840 on  data0567.[d840_ptr]=dbo.data0840.rkey
where data0567.failure_date>=@SD and data0567.failure_date<@ED
)as t1

declare @TotalAmount dec(9,2),@SD datetime ,@ED Datetime
set @TotalAmount=300 set @SD='2000-1-1' set @ED='2014-1-1'
select * from (select * from ( select  
data0831.rkey data0831rkey,
data0831.PlanMainDate as[��������],
data0831.StarMainTime as[��ʼ����ʱ��],
data0831.MainCycl     as[��������],
null DATA0567RKEY,
null   AS [ά�޵�����],
null  AS [�豸����С��], 
data0417.FASSET_CODE  as [�豸���], 
data0417.FASSET_NAME  as [�豸����], 
null [��������] ,            
Data0015.ABBR_NAME    AS [����], 
Data0034.DEPT_CODE    as [ʹ�ò���], 
Data0034.DEPT_NAME    as [��������],  
(select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	join data0268 on  data0468.FLOW_NO   = data0268.rkey and dbo.DATA0268.ttype = 3 and data0268.status in(2,4)
	and data0268.[d831_ptr]=data0831.rkey)as[���(���Һ�˰)]/* */
from data0831
join data0417  on data0417.FASSET_CODE=data0831.DeviNumb
INNER JOIN dbo.Data0015 ON dbo.data0417.warehouse_ptr = dbo.Data0015.RKEY 
INNER JOIN dbo.Data0034 ON dbo.data0417.dept_ptr = dbo.Data0034.RKEY
where data0831.StarMainTime>=@SD and data0831.StarMainTime<@ED)as t1
where [���(���Һ�˰)]>=@TotalAmount
union
select * from (select 
null data0831rkey,
null[��������],
null[��ʼ����ʱ��],
null[��������],
DATA0567.RKEY DATA0567RKEY,
DATA0567.NUMBER      AS [ά�޵�����],
DATA0840.[LOCATION]  AS [�豸����С��],
DATA0417.FASSET_CODE AS [�豸���], 
DATA0417.FASSET_NAME AS [�豸����],             
DATA0567.FAILURE_DATE   [��������] ,
DATA0015.ABBR_NAME   AS [����],
DATA0034.DEPT_CODE   AS [ʹ�ò���], 
DATA0034.DEPT_NAME   AS [��������], 
    (select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	join data0268 on  data0468.FLOW_NO   = data0268.rkey and dbo.DATA0268.ttype = 3 and data0268.status in(2,4)
	and data0268.[d567_ptr]=data0567.rkey)as[���(���Һ�˰)]
from data0567 
join data0417  on data0417.rkey=data0567.FASSET_PTR
INNER JOIN dbo.Data0015 ON dbo.data0417.warehouse_ptr = dbo.Data0015.RKEY 
INNER JOIN dbo.Data0034 ON dbo.data0417.dept_ptr = dbo.Data0034.RKEY
left join data0840 on  data0567.[d840_ptr]=dbo.data0840.rkey
where data0567.failure_date>=@SD and data0567.failure_date<@ED
)as t1
where [���(���Һ�˰)]>@TotalAmount)as t2


declare TotalAmount dec(9,2),@SD datetime ,@ED Datetime
set @TotalAmount=:TotalAmount
set @SD='2000-1-1'
set @ED='2014-1-1'
select *from (
select * from (select 
DATA0567.RKEY DATA0567RKEY,
DATA0567.NUMBER      AS [ά�޵�����],
DATA0417.FASSET_CODE AS [�豸���], 
DATA0417.FASSET_NAME AS [�豸����],             
DATA0840.[LOCATION]  AS [�豸����С��],
DATA0034.DEPT_CODE   AS [ʹ�ò���], 
DATA0034.DEPT_NAME   AS [��������], 
DATA0015.ABBR_NAME   AS [����],
DATA0567.FAILURE_DATE   [��������] ,
NULL                    [DATA0835RKEY],
NULL                    [��������],
NULL                    [��������˵��],
null                    [ʩ����/��ҵ��],
null                    [����ʱ��],
null                    [������],
null                    [������],
null                    [��������],
    (select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	join data0268 on  data0468.FLOW_NO   = data0268.rkey and dbo.DATA0268.ttype = 2 and data0268.status in(2,4)
	and data0268.[d567_ptr]=data0567.rkey)as[���(���Һ�˰)]
from data0567 
join data0417  on data0417.rkey=data0567.FASSET_PTR
INNER JOIN dbo.Data0015 ON dbo.data0417.warehouse_ptr = dbo.Data0015.RKEY 
INNER JOIN dbo.Data0034 ON dbo.data0417.dept_ptr = dbo.Data0034.RKEY
left join data0840 on  data0567.[d840_ptr]=dbo.data0840.rkey
where data0567.failure_date>=@SD and data0567.failure_date<@ED
)as t1
where [���(���Һ�˰)]>@TotalAmount
union
select * from (select 
null data0567rkey,
null [ά�޵�����],
null [�豸���], 
null [�豸����],             
null [�豸����С��],
null [ʹ�ò���], 
null [��������], 
null [����],
null [��������],
data0835.rkey [data0835rkey],
data0835.WorkOrder [��������],
data0835.WorkExpl  [��������˵��],
data0830.DeptName  [ʩ����/��ҵ��],
data0835.AdmiTime  [����ʱ��],
d73_2.USER_FULL_NAME as [������],
d73_3.USER_FULL_NAME as [������],
Data0835.AdmiTime [��������],
    (select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	join data0268 on  data0468.FLOW_NO   = data0268.rkey and dbo.DATA0268.ttype = 2 and data0268.status in(2,4)
	and data0268.[d835_ptr]=data0835.rkey)as[���(���Һ�˰)]
from data0835 
join data0830 on data0835.Dept_ptr=data0830.rkey
join data0836 on data0835.Work_ptr=data0836.rkey
join data0073 on data0835.Applican=data0073.rkey
left join data0073 d73_2 on data0835.AdmiPeop=d73_2.rkey 
left join data0073 d73_3 on data0835.AccePeop=d73_3.rkey 
where Data0835.AdmiTime>=@SD and Data0835.AdmiTime<@ED
)as t1
where [���(���Һ�˰)]>@TotalAmount)as t2



 
  select * from (select * from (
 
 SELECT 
 data0567.rkey,
 data0567.NUMBER      as [ά�޵�����],
 data0835.WorkOrder      [�յ���ҵ����������],
 data0417.FASSET_CODE as [�豸���], 
 data0417.FASSET_NAME as [�豸����],             
 data0840.[Location]  as [�豸����С��],
 Data0034.DEPT_CODE   as [ʹ�ò���], 
 Data0034.DEPT_NAME   as [��������], 
 Data0015.ABBR_NAME   AS [����], 
 data0830.[DeptName]     [��������],
 Data0836.[WorkName]     [������������], 
 data0835.[WorkExpl]     [��������˵��],
    (select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	where  data0468.FLOW_NO   = data0268.rkey 
	)as[���(���Һ�˰)]
from DATA0268
left join dbo.data0831 on DATA0268.[d831_ptr]=dbo.data0831.rkey 
left join dbo.data0567 on DATA0268.[d567_ptr]=dbo.data0567.rkey 
 -- and (data0567.failure_date>='2013-1-1' and data0567.failure_date<'2013-10-1')
left join dbo.data0835 on DATA0268.[d835_ptr]=dbo.data0835.rkey 
 -- and (data0835.AdmiTime>='2013-1-1' and data0835.AdmiTime<'2013-10-1')
left join data0417  on data0417.rkey=data0567.FASSET_PTR
left JOIN dbo.Data0015 ON dbo.data0417.warehouse_ptr = dbo.Data0015.RKEY 
left JOIN dbo.Data0034 ON dbo.data0417.dept_ptr = dbo.Data0034.RKEY
left join data0840 on  data0567.[d840_ptr]=dbo.data0840.rkey
left join dbo.data0830 on data0835.[Dept_ptr]=data0830.rkey  
left join dbo.Data0836 on data0835.[Work_ptr]=data0836.rkey 
where DATA0268.ttype = 2 and data0268.status in(2,4)
order by data0567.NUMBER , data0835.WorkOrder
 and
DATA0268.date>='2013-1-1' and DATA0268.date<'2013-10-1'
data0207.tdate>=:SD and data0207.tdate<:ED)as t1
where [���(���Һ�˰)]>:TotalAmount)as t2

select * from data0268 
left join dbo.data0831 on DATA0268.[d831_ptr]=dbo.data0831.rkey 
left join dbo.data0567 on DATA0268.[d567_ptr]=dbo.data0567.rkey 
 -- and (data0567.failure_date>='2013-1-1' and data0567.failure_date<'2013-10-1')
left join dbo.data0835 on DATA0268.[d835_ptr]=dbo.data0835.rkey 
 -- and (data0835.AdmiTime>='2013-1-1' and data0835.AdmiTime<'2013-10-1')
left join data0417  on data0417.rkey=data0567.FASSET_PTR
left JOIN dbo.Data0015 ON dbo.data0417.warehouse_ptr = dbo.Data0015.RKEY 
--left JOIN dbo.Data0034 ON dbo.data0417.dept_ptr = dbo.Data0034.RKEY
--left join data0840 on  data0567.[d840_ptr]=dbo.data0840.rkey
--left join dbo.data0830 on data0835.[Dept_ptr]=data0830.rkey  
--left join dbo.Data0836 on data0835.[Work_ptr]=data0836.rkey 
where DATA0268.date>='2013-1-26' and DATA0268.date<'2013-10-1'
and data0268.number ='GX174678'

DATA0268:�������뵥
Data0468:���Ϸ��ŵ����ϵ�
Data0207:���ϼ�¼
Data0456:������ⵥ
 
 select * from (select * from (SELECT 
 data0567.rkey,
 data0567.NUMBER      as [ά�޵�����],
 data0417.FASSET_CODE as [�豸���], 
 data0417.FASSET_NAME as [�豸����],             
 data0840.[Location]  as [�豸����С��],
 Data0034.DEPT_CODE   as [ʹ�ò���], 
 Data0034.DEPT_NAME   as [��������], 
 Data0015.ABBR_NAME   AS [����],
    (select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	join data0268 on  data0468.FLOW_NO   = data0268.rkey and dbo.DATA0268.ttype = 2 and data0268.status in(2,4)
	and data0268.[d567_ptr]=data0567.rkey)as[���(���Һ�˰)]
from data0567 
join data0417  on data0417.rkey=data0567.FASSET_PTR
INNER JOIN dbo.Data0015 ON dbo.data0417.warehouse_ptr = dbo.Data0015.RKEY 
INNER JOIN dbo.Data0034 ON dbo.data0417.dept_ptr = dbo.Data0034.RKEY
left join data0840 on  data0567.[d840_ptr]=dbo.data0840.rkey
where failure_date>=:SD and failure_date<:ED)as t1
where [���(���Һ�˰)]>:TotalAmount)as t2

--#######
declare @price dec(9,2),@DiffMinu int,@SD datetime ,@ED Datetime
set @price=50
set @DiffMinu=600
set @SD='2013-1-1'
set @ED='2014-1-1'
if object_id('tempdb..#TempDATA0831') is not null     drop table #TempDATA0831
if object_id('tempdb..#TempDATA0268') is not null     drop table #TempDATA0268
if object_id('tempdb..#TempDATA0567') is not null     drop table #TempDATA0567
select DATA0268.number[���뵥��],DATA0468.RKEY,DATA0468.INVENT_PTR,data0207.Tdate[��������], 
DATA0268.D835_ptr,DATA0268.D567_ptr,DATA0268.D831_ptr,
data0417.FASSET_CODE[�豸���],data0417.FASSET_NAME[�豸����],data0831.MainCycl[����],data0831.PlanMainDate[�����ƻ�����],
'                     ' [ά�޵���],Data0207.QUANTITY[��������],
    (ROUND(dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))[����] into  #TempDATA0831    
    from data0207 
	JOIN DATA0022 ON  DATA0022.RKEY      = DATA0207.D0022_PTR 
	JOIN DATA0456 ON  DATA0022.GRN_PTR   = DATA0456.RKEY
	JOIN DATA0468 ON  DATA0207.D0468_PTR = DATA0468.RKEY
	JOIN DATA0268 ON  DATA0468.FLOW_NO   = DATA0268.RKEY AND DATA0268.STATUS IN(2,4)
	join data0831 on  DATA0268.D831_ptr  = DATA0831.rkey
	join data0417 on  data0831.DeviNumb  = data0417.FASSET_CODE
	where data0831.StarMainTime >=@SD and data0831.StarMainTime<@ED
/*�������ƻ����ظ����ò��ϵļ�¼������ʱ��*/
select * into #TempDATA0268 from 	#TempDATA0831
where exists(
	select * from #TempDATA0831 t1 where (t1.INVENT_PTR=#TempDATA0831.INVENT_PTR) 
	and (t1.D831_ptr=#TempDATA0831.D831_ptr)  and (t1.rkey<> #TempDATA0831.rkey)
	and (datediff(minute,t1.[��������],#TempDATA0831.[��������])Between -@DiffMinu and @DiffMinu)
)
and [����]>=@price
select DATA0268.number[���뵥��],DATA0468.RKEY,DATA0468.INVENT_PTR,data0207.Tdate[��������], 
DATA0268.D835_ptr,DATA0268.D567_ptr,DATA0268.D831_ptr,
data0417.FASSET_CODE,data0417.FASSET_NAME,'' [����],'' [�����ƻ�����],
DATA0567.NUMBER [ά�޵���],Data0207.QUANTITY[��������],
    (ROUND(dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))[����] into  #TempDATA0567    
    from data0207 
	JOIN DATA0022 ON  DATA0022.RKEY      = DATA0207.D0022_PTR 
	JOIN DATA0456 ON  DATA0022.GRN_PTR   = DATA0456.RKEY
	JOIN DATA0468 ON  DATA0207.D0468_PTR = DATA0468.RKEY
	JOIN DATA0268 ON  DATA0468.FLOW_NO   = DATA0268.RKEY AND DATA0268.STATUS IN(2,4)
	join DATA0567 on  DATA0268.D567_ptr  = DATA0567.rkey
	join data0417 on  DATA0567.FASSET_PTR  = data0417.rkey
	where DATA0567.failure_date >=@SD and DATA0567.failure_date<@ED
/*��ά�޵����ظ����ò��ϵļ�¼������ʱ��*/	
insert into #TempDATA0268	
select *   from 	#TempDATA0567
where exists(
	select * from #TempDATA0567 t1 where (t1.INVENT_PTR=#TempDATA0567.INVENT_PTR) 
	and (t1.D567_ptr=#TempDATA0567.D567_ptr)  and (t1.rkey<> #TempDATA0567.rkey)
	and (datediff(minute,t1.[��������],#TempDATA0567.[��������])Between -@DiffMinu and @DiffMinu)
)
and [����]>=@price
select * from #TempDATA0268

--#######

select DATA0268.number,DATA0468.RKEY,DATA0468.INVENT_PTR,data0207.Tdate, 
DATA0268.D835_ptr,DATA0268.D567_ptr,DATA0268.D831_ptr,
    (ROUND(dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))TotalAmount into  #TempDATA0835    
    from data0207 
	JOIN DATA0022 ON  DATA0022.RKEY      = DATA0207.D0022_PTR 
	JOIN DATA0456 ON  DATA0022.GRN_PTR   = DATA0456.RKEY
	JOIN DATA0468 ON  DATA0207.D0468_PTR = DATA0468.RKEY
	JOIN DATA0268 ON  DATA0468.FLOW_NO   = DATA0268.RKEY AND DATA0268.STATUS IN(2,4)
	join data0835 on  DATA0268.D835_ptr  = DATA0835.rkey
/*����ҵ�����ظ����ò��ϵļ�¼������ʱ��*/	
insert into #TempDATA0268	
select *   from 	#TempDATA0835
where exists(
	select * from #TempDATA0835 t1 where (t1.INVENT_PTR=#TempDATA0835.INVENT_PTR) 
	and (t1.D835_ptr=#TempDATA0835.D835_ptr)  and (t1.rkey<> #TempDATA0835.rkey)
	and (datediff(minute,t1.Tdate,#TempDATA0835.[��������])Between -300 and 300)
)
and TotalAmount>50


join data0831 on 
911109
select datediff(minute,'2013-09-24 10:08:00','2013-09-24 10:07:00')
select top 1000 * from Data0207: 
DATA0268:�������뵥
Data0468:���Ϸ��ŵ����ϵ�
Data0207:���ϼ�¼
Data0456:������ⵥ

SELECT dbo.DATA0268.number [���쵥��],
 dbo.DATA0268.[DATE] [��������], 
 dbo.Data0034.DEPT_CODE [���첿��], 
 dbo.Data0034.DEPT_NAME [��������], 
 dbo.Data0005.EMPL_CODE [�����˴���], 
 dbo.Data0005.EMPLOYEE_NAME AS [����Ա������], 
 CASE WHEN data0268.status = 0 THEN '���ύ' WHEN data0268.status = 1 THEN '�����'  
 WHEN data0268.status = 2 THEN '�����' WHEN data0268.status  = 3 THEN '���˻�'  
 WHEN data0268.status = 4 THEN '�ѷ���' END AS [���״̬],
 dbo.Data0015.ABBR_NAME AS [����],
 case dbo.DATA0268.ttype when 2 then 'ά��' when 3 then 'ά��' when 4 then '����' when 5 then '����' end as [����],
 dbo.data0567.NUMBER as [ά�޵�����],
 dbo.data0831.PlanMainDate [��������],
 dbo.data0831.MainCycl [��������],
 Case when dbo.DATA0268.TTYPE=2 then(d17_2.FASSET_CODE) 
      when dbo.DATA0268.TTYPE=3 then(data0831.DeviNumb) end as [�豸���], 
 Case when dbo.DATA0268.TTYPE=2 then(d17_2.FASSET_NAME) 
      when dbo.DATA0268.TTYPE=3 then(d17_1.FASSET_NAME) end as [�豸����],   
 Case when dbo.DATA0268.TTYPE=2 then(d17_2.DEPT_PTR) 
      when dbo.DATA0268.TTYPE=3 then(d17_1.DEPT_PTR) end as DEPT_PTR,           
 data0840.[Location] [�豸����С��],
 dbo.data0835.WorkOrder [�յ���ҵ����������],
 data0830.[DeptName] [��������],
 Data0836.[WorkName] [������������],
 data0835.[WorkExpl] [��������˵��],
(select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
from data0207 join data0022 on data0022.rkey=data0207.D0022_PTR 
JOIN Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY
join data0468 on  data0207.D0468_ptr=Data0468.rkey where data0468.FLOW_NO=data0268.rkey)[���(���Һ�˰)]
from data0268
 INNER JOIN dbo.Data0034 ON dbo.DATA0268.dept_ptr = dbo.Data0034.RKEY and dbo.DATA0268.ttype in (2,3,4,5) /*2ά��;3ά��;4����;5����*/
 INNER JOIN dbo.Data0005 ON dbo.DATA0268.EMPL_PTR = dbo.Data0005.RKEY 
 INNER JOIN dbo.Data0015 ON dbo.DATA0268.warehouse_ptr = dbo.Data0015.RKEY 
 left join dbo.data0831 on DATA0268.[d831_ptr]=dbo.data0831.rkey 
 left join data0417 d17_1 on d17_1.FASSET_CODE=data0831.DeviNumb 
 left join dbo.data0567 on DATA0268.[d567_ptr]=dbo.data0567.rkey 
 left join data0417 d17_2 on d17_2.rkey=data0567.FASSET_PTR 
 left join dbo.data0835 on DATA0268.[d835_ptr]=dbo.data0835.rkey 
 left join data0840 on  DATA0268.[d840_ptr]=dbo.data0840.rkey 
 left join dbo.data0830 on data0835.[Dept_ptr]=data0830.rkey  
 left join dbo.Data0836 on data0835.[Work_ptr]=data0836.rkey  
 where data0268.status =4
 
 --�������ó���1000Ԫ��
 select * from (
 select  
 data0831.rkey,
 data0831.PlanMainDate as[��������],
 data0831.MainCycl     as[��������],
 data0417.FASSET_CODE  as [�豸���], 
 data0417.FASSET_NAME  as [�豸����],             
 Data0034.DEPT_CODE    as [ʹ�ò���], 
 Data0034.DEPT_NAME    as [��������], 
 Data0015.ABBR_NAME    AS [����], 
 (select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	join data0268 on  data0468.FLOW_NO   = data0268.rkey and dbo.DATA0268.ttype = 3 and data0268.status in(2,4)
	and data0268.[d831_ptr]=data0831.rkey)as[���(���Һ�˰)]/* */
from data0831
join data0417  on data0417.FASSET_CODE=data0831.DeviNumb
INNER JOIN dbo.Data0015 ON dbo.data0417.warehouse_ptr = dbo.Data0015.RKEY 
INNER JOIN dbo.Data0034 ON dbo.data0417.dept_ptr = dbo.Data0034.RKEY
where data0831.PlanMainDate>=:SD and data0831.PlanMainDate<:ED)as t1
where [���(���Һ�˰)]>=:TotalAmount

--left join data0840 on  data0831.[d840_ptr]=dbo.data0840.rkey 
 --ά�����ó���300Ԫ��
 
 select * from (SELECT 
 data0567.rkey,
 data0567.NUMBER      as [ά�޵�����],
 data0417.FASSET_CODE as [�豸���], 
 data0417.FASSET_NAME as [�豸����],             
 data0840.[Location]  as [�豸����С��],
 Data0034.DEPT_CODE   as [ʹ�ò���], 
 Data0034.DEPT_NAME   as [��������], 
 Data0015.ABBR_NAME   AS [����],
    (select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	join data0268 on  data0468.FLOW_NO   = data0268.rkey and dbo.DATA0268.ttype = 3 and data0268.status in(2,4)
	and data0268.[d567_ptr]=data0567.rkey)as[���(���Һ�˰)]
from data0567 
join data0417  on data0417.rkey=data0567.FASSET_PTR
INNER JOIN dbo.Data0015 ON dbo.data0417.warehouse_ptr = dbo.Data0015.RKEY 
INNER JOIN dbo.Data0034 ON dbo.data0417.dept_ptr = dbo.Data0034.RKEY
left join data0840 on  data0567.[d840_ptr]=dbo.data0840.rkey
where failure_date>=:SD and failure_date<:ED)as t1
where [���(���Һ�˰)]>:TotalAmount

select * from data0567 where rkey=26982


select * 
from data0268
where data0268.[d831_ptr]>0
select * 
from data0831
where rkey=3702

select dbo.Data0207.QUANTITY , dbo.Data0022.tax_price , dbo.Data0456.exch_rate
 --sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
	from data0207 
	join data0022 on  data0022.rkey      = data0207.D0022_PTR 
	JOIN Data0456 ON  Data0022.GRN_PTR   = Data0456.RKEY
	join data0468 on  data0207.D0468_ptr = Data0468.rkey
	join data0268 on  data0468.FLOW_NO   = data0268.rkey --and dbo.DATA0268.ttype = 2 and data0268.status in(2,4)
	and data0268.[d831_ptr]=3702
	select * from data0268
	join 
	where data0268.[d831_ptr]=3702