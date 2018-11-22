declare @tablelist varchar(100),
   @idflag int
exec sp_MSFOREACHTABLE 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
exec sp_MSFOREACHTABLE 'ALTER TABLE ? DISABLE TRIGGER ALL'
    
declare table_list cursor  for
  select name from sysobjects where type='U'
    and name not in 
  ('data0034','data0506','data0031',--������Դ���Ƴ̲���������
   'data0504','data0505',--�����������
   'data0193','data0194',--��ѹͼģ��
  'data0017',
   'data0019','data0496',--�������,����
   --'data0010','data0059','data0050','data0025',--�ͻ���Ϣ
 -- 'data0036',--���̱�ע��Ϣ
  'data0498','data0495','Data0497','data0510','Data0104',--BOM�ɱ�����,0510��׼��ƿ�Ŀ,Data0104����ƾ֤Ĭ�Ͽ�Ŀ��(����ҵ�������趨EP173)
  --'data0038','data0502','data0047','data0029','data0026','data0044','data0046',--��������,����ͼ,��������,��ױ�,BOM��,��ѹ��Ϣ,
 -- 'data0494',--����IES����,
  'data0279',--��Ʒȫ�ֲ���
  --'data0554','data0564','data0552','data0413',--ѹ��ָʾͼ,V-CUTͼ�����б�
 -- 'data0273',--���̸���
  --'data0032','data0042',--���߹���
  'data0005','data0002','data0073','data0074','data0493',--��Ա����λ���û�����˾��������
  --'data0496','','data0499',--�������IES�����ͳɱ������������
  'data0192','Data0195','Data0419','data0004',--���ƿ��ء���˾��Ϣ
  'data0277','data0278','Data0338',--ies���̲������⡢����������ֵ��Ĭ��ȡֵ�� 
  'data0503','data0196','data0197','data0198'--ƴ������
  ,'Data0007','Data0008',--��Ʒ���͡����
  'Data0504','Data0505',--��Ʒ���͹���ģ��
  'Data0280','Data0282'
--���̱�
)  
  order by name

open table_list
fetch next from table_list into @tablelist
while @@fetch_status=0
  begin
   -- exec('select * into ' +@tablelist+'_100916bk from '+@tablelist)
    exec('delete from '+@tablelist)

  if OBJECTPROPERTY(OBJECT_ID(@tablelist),'TableHasIdentity')=1
      begin
       dbcc checkident (@tablelist, reseed, 0) 
       dbcc checkident (@tablelist, reseed, 0) 
     end

    fetch next from table_list into @tablelist
  end
close table_list  
deallocate table_list

/*
delete from data0074 where user_ptr<>1
delete from data0073 where rkey<>1
delete from data0005 where rkey<>1
*/

exec sp_MSFOREACHTABLE 'ALTER TABLE ? CHECK CONSTRAINT ALL'
exec sp_MSFOREACHTABLE 'ALTER TABLE ? ENABLE TRIGGER ALL'


--dbcc checkident ('data0279', reseed, 0)  
 /*
exec sp_MSFOREACHTABLE 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
exec sp_MSFOREACHTABLE 'ALTER TABLE ? DISABLE TRIGGER ALL'
*/


 /*
exec sp_MSFOREACHTABLE 'ALTER TABLE ? CHECK CONSTRAINT ALL'
exec sp_MSFOREACHTABLE 'ALTER TABLE ? ENABLE TRIGGER ALL'
*/

