�豸Ŀ��ֵ��ѯ
declare @SD datetime,@ED datetime
set @SD=@P1
set @ED=dateadd(Month,1,@SD)
--,ϵͳ��ǰ����>��������+2��,ִ������Ĳ�ѯ��
if getdate()>DateAdd(day,2,@ED)
if getdate()>DateAdd(day,2,@ED)
begin
    select *from 
    (select data0417.warehouse_ptr as WHOUSE_PTR,data0015.rkey as d15rkey,data0015.Abbr_Name ,data0840.rkey,data0840.Location ,
	(select sum(T1.maintain_house )
	from data0567 as T1 join data0417  on  T1.FASSET_PTR=dbo.DATA0417.rkey 
	JOIN data0840 as D40 on data0417.D840_ptr=D40.rkey 
	and T1.complete_date>=@SD and T1.complete_date<@ED
	and data0417.EquiType=1 
	and T1.failure_degree=''����ͣ��''
	WHERE D40.rkey=data0840.rkey and t1.WHOUSE_PTR=Data0015.rkey
	)as TD,	
	(select sum(T1.maintain_house )
	from data0567 as T1 join data0417  on  T1.FASSET_PTR=dbo.DATA0417.rkey 
	JOIN data0840 as D40 on data0417.D840_ptr=D40.rkey 
	and T1.complete_date>=@SD and T1.complete_date<@ED
	and data0417.EquiType=1 
	and T1.failure_degree in (''����ͣ��'',''Ӱ������'',''�Կ�����'')
	WHERE D40.rkey=data0840.rkey and t1.WHOUSE_PTR=Data0015.rkey
	)as YX	,
	(select sum(data0831.TimeCons)
	from data0417 as D831_417  
	join data0831 on data0831.DeviNumb=D831_417.FASSET_CODE
	and data0831.ActuCompTime>=@SD and data0831.ActuCompTime<@ED 
	and D831_417.D840_ptr=data0840.rkey and D831_417.warehouse_ptr=data0015.rkey) SBBY,
	(select sum(data0831.StdTimeCons)
	from data0417 as D831_417  
	join data0831 on data0831.DeviNumb=D831_417.FASSET_CODE
	and data0831.ActuCompTime>=@SD and data0831.ActuCompTime<@ED 
	and D831_417.D840_ptr=data0840.rkey and D831_417.warehouse_ptr=data0015.rkey) StdTimeCons
	,(select sum(datediff(ss,T1.ent_date,T1.complete_date) )/3600 
	from data0567 as T1 join data0417  on  T1.FASSET_PTR=dbo.DATA0417.rkey 
	JOIN data0840 as D40 on data0417.D840_ptr=D40.rkey 
	and T1.complete_date>=@SD and T1.complete_date<@ED
	and data0417.EquiType=1 
	and T1.failure_degree=''����ͣ��''
	WHERE D40.rkey=data0840.rkey and t1.WHOUSE_PTR=Data0015.rkey
	)as TJGZ
	,(select sum(datediff(ss,T1.ent_date,T1.complete_date) )/3600 
	from data0567 as T1 join data0417  on  T1.FASSET_PTR=dbo.DATA0417.rkey 
	JOIN data0840 as D40 on data0417.D840_ptr=D40.rkey 
	and T1.complete_date>=@SD and T1.complete_date<@ED
	and data0417.EquiType=1 
	and T1.failure_degree in (''����ͣ��'',''Ӱ������'',''�Կ�����'')
	WHERE D40.rkey=data0840.rkey and t1.WHOUSE_PTR=Data0015.rkey
	)as FTJGZ
	from data0840
	join  data0417 on data0417.D840_ptr=data0840.rkey
	join Data0015 on data0417.warehouse_ptr=Data0015.rkey
	group by data0417.warehouse_ptr,data0015.rkey,data0015.Abbr_Name,data0840.rkey,data0840.Location)
        as t4
		join 
		(SELECT D17.warehouse_ptr,D17.D840_ptr,COUNT(D17.RKEY) TS
		from data0417 AS D17 WHERE  d17.EquiType=1 and D17.active_flag IN (2,3)
                               and d17.confi_date<@ED
		group by D17.warehouse_ptr,D17.D840_ptr
		)as t3  
        on T3.warehouse_ptr=t4.WHOUSE_PTR and T3.D840_ptr=t4.rkey	
end
else
select Null

ALTER table data0853 alter column  [Scrapped]             [decimal](12, 5) NULL--�����ܱ���
ALTER table data0854 alter column  [Scrapped]             [decimal](12, 5) NULL--�����ܱ���
--��ԭ����4λС����Ϊ5λС��

ALTER table data0853 add  [mainStanTime]         [decimal](12, 1) NULL
DROP TABLE [Data0853]
SELECT * FROM data0853
--[Shutdown] [decimal](12, 2) NULL,--������ͣ����
--[Service] [decimal](12, 2) NULL,--������ά����
--[Plan] [decimal](12, 2) NULL,--�����ƻ������
CREATE TABLE [dbo].[Data0853](
	[Rkey]                 [int] IDENTITY(1,1) NOT NULL,
	[D015_ptr]             [int] NOT NULL,--data0015ָ��
	[D851_ptr]             [int] NOT NULL,--data0851ָ��
	[D840_ptr]             [int] NOT NULL,--data0840ָ��
	[H]                    [int] NULL,--Сʱ
	[D]                    [int] NULL,--����
	[TS]                   [int] NULL,--�豸̨��
    [Downtime_D]           [decimal](12, 5) NULL,--ͣ�����Ϻ�ʱ
    [DowntimeTarget]       [decimal](12, 5) NULL,--ͣ������Ŀ��	
	[Shutdown_D]           [decimal](12, 1) NULL,--ͣ��ά��ʱ��	
	[ShutdownTarget]       [decimal](12, 5) NULL,--ͣ��ά����Ŀ��
    [NotDowntime_D]        [decimal](12, 5) NULL,--δͣ�����Ϻ�ʱ
    [NotDowntimeTarget]    [decimal](12, 5) NULL,--δͣ������Ŀ��	
	[Service_D]            [decimal](12, 1) NULL,--δͣ��ά��ʱ��	
	[ServiceTarget]        [decimal](12, 5) NULL,--δͣ��ά����Ŀ��
    [Scrapped]             [decimal](12, 5) NULL,--�����ܱ���
    [ScrappedTarget]       [decimal](12, 5) NULL,--�����ܱ�����Ŀ��
    [Plan_D]               [decimal](12, 1) NULL,--�����ƻ�ʱ��  
    [mainStanTime]         [decimal](12, 1) NULL,--������׼����ʱ��  
    [PlanTarget]           [decimal](12, 5) NULL,--�����ƻ������Ŀ��
    [Outflow]              [decimal](12, 4) NULL,--��Ա����ʧ��
    [OutflowTarget]        [decimal](12, 5) NULL,--��Ա����ʧ��Ŀ��	
 CONSTRAINT [PK_Data0853] PRIMARY KEY CLUSTERED ([Rkey]),
 CONSTRAINT [FK_Data0853_Data0015]     FOREIGN KEY ([D015_ptr]) REFERENCES [data0015]([RKEY]),
 CONSTRAINT [FK_Data0853_Data0851]     FOREIGN KEY ([D851_ptr]) REFERENCES [data0851]([RKEY]),
 CONSTRAINT [FK_Data0853_Data0840]     FOREIGN KEY ([D840_ptr]) REFERENCES [data0840]([RKEY])
 )
 --�ֶ����˵�� 
--EXEC sp_addextendedproperty 'MS_Description', '����', 'user', dbo, 'table', DATA0853, 'column', [remark]
EXEC sp_addextendedproperty 'MS_Description', 'data0015ָ��', 'user', dbo, 'table', DATA0853, 'column', [D015_ptr]
EXEC sp_addextendedproperty 'MS_Description', 'data0851ָ��', 'user', dbo, 'table', DATA0853, 'column', [D851_ptr]
EXEC sp_addextendedproperty 'MS_Description', 'data0840ָ��', 'user', dbo, 'table', DATA0853, 'column', [D840_ptr]
EXEC sp_addextendedproperty 'MS_Description', 'Сʱ', 'user', dbo, 'table', DATA0853, 'column', [H]
EXEC sp_addextendedproperty 'MS_Description', '����', 'user', dbo, 'table', DATA0853, 'column', [D]
EXEC sp_addextendedproperty 'MS_Description', '�豸̨��', 'user', dbo, 'table', DATA0853, 'column', [TS]
EXEC sp_addextendedproperty 'MS_Description', '������ͣ��ʱ��', 'user', dbo, 'table', DATA0853, 'column', [Shutdown_D]
EXEC sp_addextendedproperty 'MS_Description', '������ͣ����Ŀ��', 'user', dbo, 'table', DATA0853, 'column', [ShutdownTarget]
EXEC sp_addextendedproperty 'MS_Description', '������άʱ��', 'user', dbo, 'table', DATA0853, 'column', [Service_D]
EXEC sp_addextendedproperty 'MS_Description', '������ά����Ŀ��', 'user', dbo, 'table', DATA0853, 'column', [ServiceTarget]
EXEC sp_addextendedproperty 'MS_Description', '�����ܱ���', 'user', dbo, 'table', DATA0853, 'column', [Scrapped]
EXEC sp_addextendedproperty 'MS_Description', '�����ܱ�����Ŀ��', 'user', dbo, 'table', DATA0853, 'column', [ScrappedTarget]
EXEC sp_addextendedproperty 'MS_Description', '�����ƻ������', 'user', dbo, 'table', DATA0853, 'column', [Plan_D]
EXEC sp_addextendedproperty 'MS_Description', '�����ƻ������Ŀ��', 'user', dbo, 'table', DATA0853, 'column', [PlanTarget]
EXEC sp_addextendedproperty 'MS_Description', '��Ա����ʧ��', 'user', dbo, 'table', DATA0853, 'column', [Outflow]
EXEC sp_addextendedproperty 'MS_Description', '��Ա����ʧ��Ŀ��', 'user', dbo, 'table', DATA0853, 'column', [OutflowTarget]
EXEC sp_addextendedproperty 'MS_Description', 'ͣ�����Ϻ�ʱ', 'user', dbo, 'table', DATA0853, 'column', [Downtime_D]
EXEC sp_addextendedproperty 'MS_Description', 'ͣ������Ŀ��', 'user', dbo, 'table', DATA0853, 'column',[DowntimeTarget] 
EXEC sp_addextendedproperty 'MS_Description', 'δͣ�����Ϻ�ʱ', 'user', dbo, 'table', DATA0853, 'column', [NotDowntime_D]
EXEC sp_addextendedproperty 'MS_Description', 'δͣ������Ŀ��', 'user', dbo, 'table', DATA0853, 'column', [NotDowntimeTarget]
--��ӱ�����   
EXEC sp_addextendedproperty  'MS_Description', '�豸Ŀ��ֵ����','user',dbo,'table', DATA0853
DROP TABLE [Data0854]
CREATE TABLE [dbo].[Data0854](
	[Rkey]                 [int] IDENTITY(1,1) NOT NULL,
	[D015_ptr]             [int] NOT NULL,--data0015ָ��
	[D851_ptr]             [int] NOT NULL,--data0851ָ��
	[D840_ptr]             [int] NOT NULL,--data0840ָ��
	[H]                    [int] NULL,--Сʱ
	[D]                    [int] NULL,--����
	[TS]                   [int] NULL,--�豸̨��
    [Downtime_D]           [decimal](12, 5) NULL,--ͣ�����Ϻ�ʱ
    [DowntimeTarget]       [decimal](12, 5) NULL,--ͣ������Ŀ��	
	[Shutdown_D]           [decimal](12, 1) NULL,--ͣ��ά��ʱ��	
	[ShutdownTarget]       [decimal](12, 5) NULL,--ͣ��ά����Ŀ��
    [NotDowntime_D]        [decimal](12, 5) NULL,--δͣ�����Ϻ�ʱ
    [NotDowntimeTarget]    [decimal](12, 5) NULL,--δͣ������Ŀ��	
	[Service_D]            [decimal](12, 1) NULL,--δͣ��ά��ʱ��	
	[ServiceTarget]        [decimal](12, 5) NULL,--δͣ��ά����Ŀ��
    [Scrapped]             [decimal](12, 4) NULL,--�����ܱ���
    [ScrappedTarget]       [decimal](12, 5) NULL,--�����ܱ�����Ŀ��
    [Plan_D]               [decimal](12, 1) NULL,--�����ƻ�ʱ��  
    [mainStanTime]         [decimal](12, 1) NULL,--������׼����ʱ��  
    [PlanTarget]           [decimal](12, 5) NULL,--�����ƻ������Ŀ��
    [Outflow]              [decimal](12, 4) NULL,--��Ա����ʧ��
    [OutflowTarget]        [decimal](12, 5) NULL,--��Ա����ʧ��Ŀ��	
 CONSTRAINT [PK_DATA0854] PRIMARY KEY CLUSTERED ([Rkey]),
 CONSTRAINT [FK_Data0854_Data0015]     FOREIGN KEY ([D015_ptr]) REFERENCES [data0015]([RKEY]),
 CONSTRAINT [FK_Data0854_Data0851]     FOREIGN KEY ([D851_ptr]) REFERENCES [data0851]([RKEY]),
 CONSTRAINT [FK_Data0854_Data0840]     FOREIGN KEY ([D840_ptr]) REFERENCES [data0840]([RKEY])
 )
 --�ֶ����˵�� 
--EXEC sp_addextendedproperty 'MS_Description', '����', 'user', dbo, 'table', DATA0853, 'column', [remark]
EXEC sp_addextendedproperty 'MS_Description', 'data0015ָ��', 'user', dbo, 'table', DATA0854, 'column', [D015_ptr]
EXEC sp_addextendedproperty 'MS_Description', 'data0851ָ��', 'user', dbo, 'table', DATA0854, 'column', [D851_ptr]
EXEC sp_addextendedproperty 'MS_Description', 'data0840ָ��', 'user', dbo, 'table', DATA0854, 'column', [D840_ptr]
EXEC sp_addextendedproperty 'MS_Description', 'Сʱ', 'user', dbo, 'table', DATA0854, 'column', [H]
EXEC sp_addextendedproperty 'MS_Description', '����', 'user', dbo, 'table', DATA0854, 'column', [D]
EXEC sp_addextendedproperty 'MS_Description', '�豸̨��', 'user', dbo, 'table', DATA0854, 'column', [TS]
EXEC sp_addextendedproperty 'MS_Description', '������ͣ��ʱ��', 'user', dbo, 'table', DATA0854, 'column', [Shutdown_D]
EXEC sp_addextendedproperty 'MS_Description', '������ͣ����Ŀ��', 'user', dbo, 'table', DATA0854, 'column', [ShutdownTarget]
EXEC sp_addextendedproperty 'MS_Description', '������άʱ��', 'user', dbo, 'table', DATA0854, 'column', [Service_D]
EXEC sp_addextendedproperty 'MS_Description', '������ά����Ŀ��', 'user', dbo, 'table', DATA0854, 'column', [ServiceTarget]
EXEC sp_addextendedproperty 'MS_Description', '�����ܱ���', 'user', dbo, 'table', DATA0854, 'column', [Scrapped]
EXEC sp_addextendedproperty 'MS_Description', '�����ܱ�����Ŀ��', 'user', dbo, 'table', DATA0854, 'column', [ScrappedTarget]
EXEC sp_addextendedproperty 'MS_Description', '�����ƻ������', 'user', dbo, 'table', DATA0854, 'column', [Plan_D]
EXEC sp_addextendedproperty 'MS_Description', '�����ƻ������Ŀ��', 'user', dbo, 'table', DATA0854, 'column', [PlanTarget]
EXEC sp_addextendedproperty 'MS_Description', '��Ա����ʧ��', 'user', dbo, 'table', DATA0854, 'column', [Outflow]
EXEC sp_addextendedproperty 'MS_Description', '��Ա����ʧ��Ŀ��', 'user', dbo, 'table', DATA0854, 'column', [OutflowTarget]
EXEC sp_addextendedproperty 'MS_Description', 'ͣ�����Ϻ�ʱ', 'user', dbo, 'table', DATA0854, 'column', [Downtime_D]
EXEC sp_addextendedproperty 'MS_Description', 'ͣ������Ŀ��', 'user', dbo, 'table', DATA0854, 'column',[DowntimeTarget] 
EXEC sp_addextendedproperty 'MS_Description', 'δͣ�����Ϻ�ʱ', 'user', dbo, 'table', DATA0854, 'column', [NotDowntime_D]
EXEC sp_addextendedproperty 'MS_Description', 'δͣ������Ŀ��', 'user', dbo, 'table', DATA0854, 'column', [NotDowntimeTarget]
--��ӱ�����   
EXEC sp_addextendedproperty  'MS_Description', '�ؼ��豸Ŀ��ֵ����','user',dbo,'table', DATA0854

select data0840.Location,data0015. ABBR_NAME,Data0853.*
  from Data0853
  join data0840 on Data0853.[D840_ptr]=data0840.rkey
  join data0015 on Data0853.[D015_ptr]=data0015.rkey
  where [D851_ptr]=:vD851_ptr
  order by data0015. ABBR_NAME,data0840.Location
  
--alter table [Data0852]drop FK_Data0852_Data0015_rkey--ɾ�����
alter table [Data0852]alter  column [D015_ptr] [int]  NULL
alter table [Data0853]alter  column [D015_ptr] [int]  NULL
alter table [Data0854]alter  column [D015_ptr] [int]  NULL

CREATE TABLE [dbo].[Data0852](--drop table [Data0852]
	[Rkey] [int] IDENTITY(1,1) NOT NULL,
	[D015_ptr] [int] NOT NULL,
	[D851_ptr] [int] NOT NULL,
	[D840_ptr] [int] NOT NULL,
	[sumA] [decimal](12, 2) NULL,
	[Target] [decimal](12, 2) NULL,
 CONSTRAINT [PK_Data0852] PRIMARY KEY CLUSTERED ([Rkey]))

insert into
declare @sql varchar(8000),@SD datetime,@ED datetime
set @SD='2013-8-1'  set @ED='2013-10-1'
select @sql=isnull(@sql+',','')+Location from data0840 where data0840.[Location]not in ('ʩ����','�յ���ҵ��')
print @sql

select [����],[�豸����С��],isnull(ά�޳ɱ�,0)ά�޳ɱ�,isnull(ά���ɱ�,0)ά���ɱ�,isnull(���̳ɱ�,0)���̳ɱ�,isnull(���óɱ�,0)���óɱ�,
(isnull(ά�޳ɱ�,0)+isnull(ά���ɱ�,0)+isnull(���̳ɱ�,0)+isnull(���óɱ�,0))as [���ܳɱ�] from 
(select [����],[�豸����С��],[����],sum(isnull([���(���Һ�˰)],0))[���(���Һ�˰)] from 
(select data0840.[Location] [�豸����С��],data0015.ABBR_NAME [����],
case dbo.DATA0268.ttype when 2 then 'ά�޳ɱ�' when 3 then 'ά���ɱ�' when 4 then '���̳ɱ�' when 5 then '���óɱ�' end as [����],
[���(���Һ�˰)]=(select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
from data0207 join data0022 on data0022.rkey=data0207.D0022_PTR 
JOIN Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY where  Data0207.D0468_ptr=Data0468.rkey 
and data0207.tdate>=:SD and data0207.tdate<:ED)
FROM dbo.DATA0268 
join data0840 on  DATA0268.[d840_ptr]=dbo.data0840.rkey 
join Data0468 on DATA0268.rkey=Data0468.FLOW_NO
join data0015 on data0268.warehouse_ptr=data0015.rkey
where  data0268.status =4 and dbo.DATA0268.ttype in (2,3,4,5))as t1
group by [����],[�豸����С��],[����] 
)as t2
pivot (sum([���(���Һ�˰)]) for [����] in (ά�޳ɱ�,ά���ɱ�,���̳ɱ�,���óɱ�))a
where [����]='��������'


select*,(isnull(ά�޳ɱ�,0)+isnull(ά���ɱ�,0)+isnull(���̳ɱ�,0)+isnull(���óɱ�,0))as [���ܳɱ�] from 
(select [�豸����С��],[����],sum(isnull([���(���Һ�˰)],0))[���(���Һ�˰)] from 
(select data0840.[Location]   [�豸����С��]      ,
case dbo.DATA0268.ttype when 2 then 'ά�޳ɱ�' when 3 then 'ά���ɱ�' when 4 then '���̳ɱ�' when 5 then '���óɱ�' end as [����],
[���(���Һ�˰)]=(select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
from data0207 join data0022 on data0022.rkey=data0207.D0022_PTR 
JOIN Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY where  Data0207.D0468_ptr=Data0468.rkey
and Data0207.tdate>='2013-1-1'  and Data0207.tdate<'2013-10-1')
FROM dbo.DATA0268 
join data0840 on  DATA0268.[d840_ptr]=dbo.data0840.rkey 
join Data0468 on DATA0268.rkey=Data0468.FLOW_NO
--join data0456 on D0468_ptr=Data0468.rkey
where  data0268.status =4 and dbo.DATA0268.ttype in (2,3,4,5)and data0840.[Location]not in ('ʩ����','�յ���ҵ��'))as t1
group by [�豸����С��],[����] 
)as t2
pivot (sum([���(���Һ�˰)]) for [����] in (ά�޳ɱ�,ά���ɱ�,���̳ɱ�,���óɱ�))a


declare @sql varchar(8000),@SD datetime,@ED datetime,@WHOUSE_PTR int
set @SD='2013-8-1'  set @ED='2013-10-1'  set @WHOUSE_PTR=1
select @sql=isnull(@sql+',','')+EMPLOYEE_NAME from V_0842_0848 
where V_0842_0848.WorkDate>=@SD and V_0842_0848.WorkDate<=@ED and V_0842_0848.WHOUSE_PTR= @WHOUSE_PTR
group by EMPLOYEE_NAME         
set @sql='select * from V_0842_0848 '
+' pivot (sum(WorkTime) for EMPLOYEE_NAME in ('+@sql+'))a'
+' where WorkDate>='
+''''+CONVERT(varchar(100), @SD, 23)+''''+' and  WorkDate<='+''''
+ CONVERT(varchar(100), @ED, 23)+''''+' and WHOUSE_PTR='+ Cast(@WHOUSE_PTR as varchar(10))
select (@sql)

declare @sql varchar(8000),@SD datetime,@ED datetime
set @SD=:SD set @ED=:ED
select @sql=isnull(@sql+',','')+EMPLOYEE_NAME from V_0842_0848 
where V_0842_0848.WorkDate>=@SD and V_0842_0848.WorkDate<=@ED
group by EMPLOYEE_NAME         
set @sql='select * from V_0842_0848 '
+' pivot (sum(WorkTime) for EMPLOYEE_NAME in ('+@sql+'))a'
+' where WorkDate>='
+''''+CONVERT(varchar(100), @SD, 23)+''''+' and  WorkDate<='+''''+ CONVERT(varchar(100), @ED, 23)+''''
exec(@sql)

if not exists(select t1.name from sysobjects t1 inner join
                   syscolumns t2 on t1.id=t2.id
              where t1.name='data0840' and t2.name='grup')
begin
	ALTER  TABLE data0840 ADD grup int null
END 
update data0840
set grup=1
where Location=''
select * from 
(select*,(isnull(ά�޳ɱ�,0)+isnull(ά���ɱ�,0)+isnull(���̳ɱ�,0)+isnull(���óɱ�,0))as [���ܳɱ�] from 
(select [�豸����С��],[����],sum(isnull([���(���Һ�˰)],0))[���(���Һ�˰)] from 
(select data0840.[Location]   [�豸����С��]      ,
case dbo.DATA0268.ttype when 2 then 'ά�޳ɱ�' when 3 then 'ά���ɱ�' when 4 then '���̳ɱ�' when 5 then '���óɱ�' end as [����],
[���(���Һ�˰)]=(select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
from data0207 join data0022 on data0022.rkey=data0207.D0022_PTR 
JOIN Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY where  Data0207.D0468_ptr=Data0468.rkey)
FROM dbo.DATA0268 
join data0840 on  DATA0268.[d840_ptr]=dbo.data0840.rkey 
join Data0468 on DATA0268.rkey=Data0468.FLOW_NO
--join data0456 on D0468_ptr=Data0468.rkey
where  data0268.status =4 and dbo.DATA0268.ttype in (2,3,4,5)and data0840.[Location]not in ('ʩ����','�յ���ҵ��'))as t1
group by [�豸����С��],[����] 
)as t2
pivot (sum([���(���Һ�˰)]) for [����] in (ά�޳ɱ�,ά���ɱ�,���̳ɱ�,���óɱ�))a)as t3
compute  sum(ά�޳ɱ�),sum(ά���ɱ�),sum(���̳ɱ�),sum(���óɱ�),sum([���ܳɱ�])


---------------------------
�豸������Ҫ��Ϣ���� ��������
---------------------------
select * from V_0842_0848  pivot (sum(WorkTime) for EMPLOYEE_NAME in (�����,��))a 
where WorkDate>='2013-11-01' and  WorkDate<='2013-11-30'
---------------------------
OK   
---------------------------

select * from data0268 
select Data0468.* from data0468 
join Data0207  on data0468.rkey=Data0207.D0468_ptr
select top 1000 * from  Data0207 on 
Data0207:���ϼ�¼
Data0022:�Ľ���һ�±�
Data0456:������ⵥ

select * from (select f1.*,data0034.DEPT_NAME [�豸���ڲ���] from(
SELECT dbo.DATA0268.number [���쵥��],         dbo.DATA0268.[DATE]           [��������], 
dbo.DATA0268.auth_date     [�������],          dbo.DATA0268.reference        [��ע], 
dbo.Data0034.DEPT_CODE     [ʹ�ò���],         dbo.Data0034.DEPT_NAME        [��������],
dbo.Data0005.EMPL_CODE     [�����˴���],       dbo.Data0005.EMPLOYEE_NAME AS [����Ա������],
Data0005_1.EMPL_CODE AS    [���Ա������],     Data0005_1.EMPLOYEE_NAME AS   [���Ա������], 
dbo.Data0094.PURCHASE_APPROV_DESC [��������],  dbo.Data0015.ABBR_NAME AS     [����],  
CASE WHEN data0268.status = 0 THEN '���ύ' WHEN data0268.status = 1 THEN '�����'  
WHEN data0268.status = 2 THEN '�����' WHEN data0268.status  = 3 THEN '���˻�'  
WHEN data0268.status = 4 THEN '�ѷ���' END AS ���״̬,dbo.Data0094.CODE [�������̴���],
CASE WHEN data0268.allow_submit = 0 THEN '��ȷ��' WHEN data0268.allow_submit = 1 THEN '��ȷ��'  
WHEN data0268.allow_submit = 2 THEN '��ȷ��'END AS [ȷ��״̬],
case dbo.DATA0268.ttype when 2 then 'ά��' when 3 then 'ά��' when 4 then '����' when 5 then '����' end as [����],
dbo.DATA0268.Prted          [��ӡ��],        dbo.data0835.WorkOrder    [�յ���ҵ����������],
dbo.data0567.NUMBER as      [ά�޵�����],    dbo.data0831.PlanMainDate [��������],    
dbo.data0831.MainCycl       [��������],
Case when dbo.DATA0268.TTYPE=2 then(d17_2.FASSET_CODE) 
     when dbo.DATA0268.TTYPE=3 then(data0831.DeviNumb) end as [�豸���], 
Case when dbo.DATA0268.TTYPE=2 then(d17_2.FASSET_NAME) 
     when dbo.DATA0268.TTYPE=3 then(d17_1.FASSET_NAME) end as [�豸����],   
Case when dbo.DATA0268.TTYPE=2 then(d17_2.DEPT_PTR) 
     when dbo.DATA0268.TTYPE=3 then(d17_1.DEPT_PTR) end as DEPT_PTR,           
data0840.[Location]         [�豸����С��],   data0830.[DeptName]         [��������],
Data0836.[WorkName]         [������������],   data0835.[WorkExpl]         [��������˵��],
dbo.Data0468.QUAN_BOM       [��������],       dbo.Data0468.QUAN_ISSUED    [�ѷ�������],
dbo.Data0468.VENDOR         [��Ӧ��],         dbo.Data0017.INV_PART_NUMBER[���ϱ���],
Data0017.INV_PART_DESCRIPTION [��������/���],data0002.unit_name          [��λ],
case dbo.Data0468.PRINTIT when 'Y'then '��ͨ���' when 'N' then 'VMI���' END AS �Ƿ�VMI,
[���(���Һ�˰)]=(select sum(ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4))       
from data0207 join data0022 on data0022.rkey=data0207.D0022_PTR 
JOIN Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY where  D0468_ptr=Data0468.rkey),
[���(���Ҳ���˰)]=(select sum(ROUND((dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate) / (1 + dbo.Data0022.TAX_2 * 0.01), 4)) 
from data0207 join data0022 on data0022.rkey=data0207.D0022_PTR  
JOIN Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY where  D0468_ptr=Data0468.rkey)
FROM dbo.DATA0268 INNER JOIN dbo.Data0034 ON dbo.DATA0268.dept_ptr = dbo.Data0034.RKEY
and dbo.DATA0268.ttype in (2,3,4,5) /*2ά��;3ά��;4����;5����*/
INNER JOIN dbo.Data0005 ON dbo.DATA0268.EMPL_PTR = dbo.Data0005.RKEY 
LEFT JOIN dbo.Data0005 AS Data0005_1 ON dbo.DATA0268.auth_emplptr = Data0005_1.RKEY
INNER JOIN dbo.Data0094 ON dbo.DATA0268.auth_ptr = dbo.Data0094.RKEY 
INNER JOIN dbo.Data0015 ON dbo.DATA0268.warehouse_ptr = dbo.Data0015.RKEY 
left join dbo.data0831 on DATA0268.[d831_ptr]=dbo.data0831.rkey 
left join data0417 d17_1 on d17_1.FASSET_CODE=data0831.DeviNumb 
left join dbo.data0567 on DATA0268.[d567_ptr]=dbo.data0567.rkey
left join data0417 d17_2 on d17_2.rkey=data0567.FASSET_PTR  
left join dbo.data0835 on DATA0268.[d835_ptr]=dbo.data0835.rkey 
left join data0840 on  DATA0268.[d840_ptr]=dbo.data0840.rkey 
left join dbo.data0830 on data0835.[Dept_ptr]=data0830.rkey  
left join dbo.Data0836 on data0835.[Work_ptr]=data0836.rkey 
join Data0468 on DATA0268.rkey=Data0468.FLOW_NO
join dbo.Data0017 ON dbo.Data0468.INVENT_PTR = dbo.Data0017.RKEY
join data0002 on data0017.STOCK_UNIT_PTR=data0002.rkey 
where data0268.status =4)as f1 
left join data0034 on data0034.rkey=f1.DEPT_PTR)as f2
where 1=2


declare @SD datetime,@ED datetime
set @SD='2013-11-1'
set @ED=dateadd(Month,1,@SD)
--,ϵͳ��ǰ����>��������+2��,ִ������Ĳ�ѯ��
if getdate()>DateAdd(day,2,@ED)
begin
	select T1.WHOUSE_PTR,data0015.Abbr_Name ,data0840.rkey,data0840.Location ,
	sum(T1.maintain_house )TD,sum(T2.maintain_house )YX	,sum(data0831.TimeCons) SBBY,
	TS	
	from data0840
	join  data0417 on data0417.D840_ptr=data0840.rkey
	left join data0567 as T1 ON  T1.FASSET_PTR=dbo.DATA0417.rkey
	--and T1.complete_date>=@SD and T1.complete_date<@ED
	and data0417.EquiType=1 and T1.failure_degree='����ͣ��'
	join data0015 on T1.WHOUSE_PTR=data0015.rkey 
	left join data0567 as T2 ON  T2.FASSET_PTR=dbo.DATA0417.rkey
	--and T2.complete_date>=@SD and T2.complete_date<@ED
	and data0417.EquiType=1 and T2.failure_degree in ('����ͣ��','Ӱ������','�Կ�����')
	and  T2.WHOUSE_PTR=data0015.rkey 
	left join data0417 as D831_417 ON D831_417.D840_ptr=data0840.rkey and D831_417.warehouse_ptr=data0015.rkey
	left join data0831 on data0831.DeviNumb=dbo.DATA0417.FASSET_CODE
	left join (SELECT data0417.warehouse_ptr,data0417.D840_ptr,COUNT(data0417.RKEY) TS
 from data0417 join data0840 on data0417.d840_ptr=data0840.rkey  
group by data0417.warehouse_ptr,data0417.D840_ptr)as t3  
on T3.warehouse_ptr=data0417.warehouse_ptr and T3.D840_ptr=data0840.rkey
	and data0831.ActuCompTime>=@SD and data0831.ActuCompTime<@ED
	group by T1.WHOUSE_PTR,data0015.Abbr_Name,data0840.rkey,data0840.Location,TS	
end	

SELECT data0417.warehouse_ptr,data0417.D840_ptr,data0840.Location,COUNT(data0417.RKEY) ̨��
 from data0417 join data0840 on data0417.d840_ptr=data0840.rkey 
--where data0840.Location='nn'
group by data0417.warehouse_ptr,data0417.D840_ptr,data0840.Location

declare @SD datetime,@ED datetime
set @SD='2013-8-1'
set @ED=dateadd(Month,1,@SD)
	select T1.WHOUSE_PTR,data0015.Abbr_Name ,data0840.rkey,data0840.Location ,
	sum(T1.maintain_house )TD,sum(T2.maintain_house )YX	,sum(data0831.TimeCons) SBBY	
	from data0840
	join  data0417 on data0417.D840_ptr=data0840.rkey
	left join data0567 as T1 ON  T1.FASSET_PTR=dbo.DATA0417.rkey
	--and T1.complete_date>=@SD and T1.complete_date<@ED
	and data0417.EquiType=1 and T1.failure_degree='����ͣ��'
	join data0015 on T1.WHOUSE_PTR=data0015.rkey 
	left join data0567 as T2 ON  T2.FASSET_PTR=dbo.DATA0417.rkey
	--and T2.complete_date>=@SD and T2.complete_date<@ED
	and data0417.EquiType=1 and T2.failure_degree in ('����ͣ��','Ӱ������','�Կ�����')
	and  T2.WHOUSE_PTR=data0015.rkey 
	left join data0417 as D831_417 ON D831_417.D840_ptr=data0840.rkey and D831_417.warehouse_ptr=data0015.rkey
	left join data0831 on data0831.DeviNumb=dbo.DATA0417.FASSET_CODE
	group by T1.WHOUSE_PTR,data0015.Abbr_Name,data0840.rkey,data0840.Location
	
	
	declare @SD datetime,@ED datetime
set @SD='2013-08-01 08:00:00'
set @ED=dateadd(Month,1,@SD)
--,ϵͳ��ǰ����>��������+2��,ִ������Ĳ�ѯ��
if getdate()>DateAdd(day,2,@ED)
begin
    select *from 
    (select T1.WHOUSE_PTR,data0015.Abbr_Name ,data0840.rkey,data0840.Location ,
	sum(T1.maintain_house )TD,sum(T2.maintain_house )YX	,sum(data0831.TimeCons) SBBY
	from data0840
	join  data0417 on data0417.D840_ptr=data0840.rkey
	left join data0567 as T1 ON  T1.FASSET_PTR=dbo.DATA0417.rkey
	and T1.complete_date>=@SD and T1.complete_date<@ED
	and data0417.EquiType=1 and T1.failure_degree='����ͣ��'
	join data0015 on T1.WHOUSE_PTR=data0015.rkey 
	left join data0567 as T2 ON  T2.FASSET_PTR=dbo.DATA0417.rkey
	and T2.complete_date>=@SD and T2.complete_date<@ED
	and data0417.EquiType=1 and T2.failure_degree in ('����ͣ��','Ӱ������','�Կ�����')
	and  T2.WHOUSE_PTR=data0015.rkey 
	left join data0417 as D831_417 ON D831_417.D840_ptr=data0840.rkey and D831_417.warehouse_ptr=data0015.rkey
	left join data0831 on data0831.DeviNumb=dbo.DATA0417.FASSET_CODE
	and data0831.ActuCompTime>=@SD and data0831.ActuCompTime<@ED
	
	group by T1.WHOUSE_PTR,data0015.Abbr_Name,data0840.rkey,data0840.Location
	)as t4
		join 
		(SELECT D17.warehouse_ptr,D17.D840_ptr,COUNT(D17.RKEY) TS
		from data0417 AS D17 WHERE D17.active_flag IN (2,3)
		group by D17.warehouse_ptr,D17.D840_ptr
		)as t3  
        on T3.warehouse_ptr=t4.WHOUSE_PTR and T3.D840_ptr=t4.rkey		
end	