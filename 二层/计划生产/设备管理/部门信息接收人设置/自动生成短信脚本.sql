--���ɶ���
insert into [172.18.9.10].[WzSmsCenter].dbo.[tblsms_outbox](phonenumber,messagecontent,sendername,companyid)  
select distinct data0834.Phone,ABBR_NAME+' ���ţ�'+DEPT_NAME+' �豸���룺'+FASSET_CODE+'�豸���ƣ�'+FASSET_NAME+'��Ԥ��'
 +CONVERT(varchar(100),data0831.PlanMainDate, 23)+'���б�����'as msg,
'ϵͳ����',9
from data0417 
join data0034 on data0417.Dept_Ptr=data0034.rkey 
join data0834 on data0834.DeptCode=data0034.Dept_Code and  data0834.warehouse_ptr=data0417.warehouse_ptr
join data0831 on data0831.DeviNumb=data0417.Fasset_Code and data0831.RKEY832=1 /*1=��ִ��*/
join data0514 on data0514.rkey=data0417.FASSET_TYPE_PTR
join data0015 on data0417.warehouse_ptr=data0015.rkey
where (DATEADD(Day,-1,PlanMainDate)=(SELECT CONVERT(VARCHAR(10),GETDATE(),120))and(data0514.Fasset_type<>'�����豸'))
/*�������'�����豸',��ǰһ��֪ͨ����*/
or(DATEADD(Day,-4,PlanMainDate)=(SELECT CONVERT(VARCHAR(10),GETDATE(),120))and(data0514.Fasset_type='�����豸'))
/*�����'�����豸',��ǰ4��֪ͨ����*/

--�޸ı����ƻ�״ֵ̬
update data0831                      
set RKEY832=5  /*״̬��Ϊ��֪ͨ*/
from data0417 
--join data0034 on data0417.Dept_Ptr=data0034.rkey 
--join data0834 on data0834.DeptCode=data0034.Dept_Code  
join data0831 on data0831.DeviNumb=data0417.Fasset_Code and data0831.RKEY832=1 /*1=��ִ��*/
join data0514 on data0514.rkey=data0417.FASSET_TYPE_PTR
where (DATEADD(Day,-1,PlanMainDate)=(SELECT CONVERT(VARCHAR(10),GETDATE(),120))and(data0514.Fasset_type<>'�����豸'))
or(DATEADD(Day,-4,PlanMainDate)=(SELECT CONVERT(VARCHAR(10),GETDATE(),120))and(data0514.Fasset_type='�����豸'))

