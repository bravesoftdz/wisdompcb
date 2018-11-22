use master
go
create procedure sp_who_lock
as
begin
declare @spid int,@bl int,
 @intTransactionCountOnEntry  int,
        @intRowcount    int,
        @intCountProperties   int,
        @intCounter    int

 create table #tmp_lock_who (
 id int identity(1,1),
 spid smallint,
 bl smallint)
 
 IF @@ERROR<>0 RETURN @@ERROR
 
 insert into #tmp_lock_who(spid,bl) select  0 ,blocked
   from (select * from sysprocesses where  blocked>0 ) a 
   where not exists(select * from (select * from sysprocesses where  blocked>0 ) b 
   where a.blocked=spid)
   union select spid,blocked from sysprocesses where  blocked>0

 IF @@ERROR<>0 RETURN @@ERROR 
  
-- �ҵ���ʱ��ļ�¼��
 select  @intCountProperties = Count(*),@intCounter = 1
 from #tmp_lock_who
 
 IF @@ERROR<>0 RETURN @@ERROR 
 
 if @intCountProperties=0
  select '����û��������������Ϣ' as message

-- ѭ����ʼ
while @intCounter <= @intCountProperties
begin
-- ȡ��һ����¼
  select  @spid = spid,@bl = bl
  from #tmp_lock_who where Id = @intCounter 
 begin
  if @spid =0 
            select '�������ݿ���������: '+ CAST(@bl AS VARCHAR(10)) + '���̺�,��ִ�е�SQL�﷨����'
 else
            select '���̺�SPID��'+ CAST(@spid AS VARCHAR(10))+ '��' + '���̺�SPID��'+ CAST(@bl AS VARCHAR(10)) +'����,�䵱ǰ����ִ�е�SQL�﷨����'
 DBCC INPUTBUFFER (@bl )
 end 

-- ѭ��ָ������
 set @intCounter = @intCounter + 1
end

drop table #tmp_lock_who

return 0
end


----------------------------------------------------------------------------------
use master

select spid ����,STATUS ״̬, ��¼�ʺ�=SUBSTRING(SUSER_SNAME(sid),1,30)
,�û���������=SUBSTRING(hostname,1,12)
,�Ƿ���ס=convert(char(3),blocked)
,���ݿ�����=SUBSTRING(db_name(dbid),1,20),cmd ����,waittype as �ȴ�����
,last_batch ���������ʱ��,open_tran δ�ύ���������
from master.sys.sysprocesses
Where  status='sleeping' and waittype=0x0000 and open_tran>0



select t1.resource_type [��Դ��������],DB_NAME(resource_database_id) as ���ݿ���
,t1.resource_associated_entity_id ��������,t1.request_mode as �ȴ������������ģʽ
,t1.request_session_id �ȴ���SID
,t2.wait_duration_ms �ȴ�ʱ��
,(select TEXT from sys.dm_exec_requests r cross apply
sys.dm_exec_sql_text(r.sql_handle) where r.session_id=t1.request_session_id) as �ȴ���Ҫִ�е�SQL
,(select SUBSTRING(qt.text,r.statement_start_offset/2+1,
(case when r.statement_end_offset=-1 then DATALENGTH(qt.text) else r.statement_end_offset end -r.statement_start_offset)/2+1
)
from sys.dm_exec_requests r cross apply sys.dm_exec_sql_text(r.sql_handle)qt
where r.session_id=t1.request_session_id) �ȴ�����Ҫִ�е����
,t2.blocking_session_id [������SID]
,(select TEXT from sys.sysprocesses p cross apply
sys.dm_exec_sql_text(p.sql_handle)
where p.spid=t2.blocking_session_id
) ������ִ�����
from sys.dm_tran_locks t1,sys.dm_os_waiting_tasks t2
where t1.lock_owner_address=t2.resource_address
