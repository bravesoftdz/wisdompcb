select * from (select 
data0417.FASSET_CODE   [�豸����],
data0417.FASSET_NAME   [�豸����],
Data0034.DEPT_CODE     [���Ŵ���],
Data0034.DEPT_NAME     [��������],
data0417.LOCATION      [λ��],
data0831.PlanMainDate  [�ƻ�����ʱ��],
data0831.MainCycl	   [��������],
data0831.StarMainTime  [��ʼ����ʱ��],
data0831.ActuCompTime  [ʵ�����ʱ��],
data0831.TimeCons	   [��������ʱ��],
data0831.StdTimeCons   [��׼����ʱ��],
data0831.TimeCons/data0831.StdTimeCons [�����],
data0567.NUMBER        [������],
case data0567.status when 0 then 'δ�ύ' when 1 then '������' when 2 then '������'
                     when 3 then '���깤' when 4 then '������' when 5 then '���˻�' 
                     when 6 then '����ͣ' when 8 then '�����˻�'  end as [״̬],
data0567.failure_degree	  [Ӱ��̶�],   
data0567.failure_circs	  [����˵��], 
data0567.validate_appraise[��������],   
data0567.disposal_date	  [��������],
data0567.maintain_text	  [ά�޼�¼],
data0567.complete_date	  [�깤����], 
data0567.stop_house	      [��ͣСʱ],
data0567.maintain_house	  [ʵ��ά��ʱ��],            
dateDiff(day, data0831.StarMainTime,data0567.disposal_date)[���ʱ��],
data0005.EMPL_CODE ��Ա����,
data0005.EMPLOYEE_NAME ��Ա����,
data0842.WorkDate ��������,
data0842.BeginTime ��ʼʱ��,
data0842.EndTime ����ʱ��,
data0842.TimeRest ��;��Ϣʱ��,
data0842.WorkTime ��Ա����ʱ��
from data0417 
join data0034 on data0417.DEPT_PTR=data0034.rkey
join data0831 on data0417.FASSET_CODE=data0831.DeviNumb 
and data0831.TimeCons/data0831.StdTimeCons<=:vAccomplish /*�����ƻ�.�����*/ 
join data0567 on data0417.rkey=data0567.FASSET_PTR 
and data0567.maintain_house>=:vMaintain_house --and data0567.failure_degree='����ͣ��'
 /*ά��.ʵ��ά��ʱ��>=2Сʱ*/ 
left join Data0842 on Data0842.[Work_ptr]=data0567.rkey
left join data0005 on Data0842.[Empl_ptr]=data0005.rkey
where dateDiff(day, data0831.StarMainTime,data0567.disposal_date)<=:vDisposal_date    
 /*�豸ά��.��������-�����ƻ�.��ʼ����ʱ��<=30*/ )as t1

---------------------------
�豸ά������ ��������
---------------------------
select Data0842.*,data0005.EMPL_CODE,data0005.EMPLOYEE_NAME,MainexecStat from Data0842
left join data0005 on Data0842.[Empl_ptr]=data0005.rkey
join data0832 on Data0842.[Status]=data0832.rkey
where [Work_ptr]= :vWork_ptr
---------------------------
OK   
---------------------------


---------------------------
�豸ά������ ��������
---------------------------
select * from (select NUMBER [������],data0417.FASSET_CODE [�豸����],data0417.FASSET_NAME [�豸����],
case data0567.status when 0 then 'δ�ύ' when 1 then '������' when 2 then '������'
                     when 3 then '���깤' when 4 then '������' when 5 then '���˻�' 
                     when 6 then '����ͣ' when 8 then '�����˻�'  end as ״̬,
Data0034.DEPT_NAME ��������, Data0005.EMPLOYEE_NAME �걨��,data0015.abbr_name ����,
Data0005_1.EMPLOYEE_NAME as ������,Data0005_2.EMPLOYEE_NAME as �깤��Ա,   
DATA0567.equipment_grade	[�豸����],failure_degree	[Ӱ��̶�],
referring_date	�ύ����,CONTACT_NAME	������,CONTACT_PHONE	�����˵绰,failure_circs	����˵��,
disposal_date	��������,maintain_text	ά�޼�¼,complete_date	�깤����,
validate_appraise	[��������],fail_type	�쳣���,maintain_house	ʵ��ά��ʱ��,
Data0842.WorkDate [��������],d5.EMPLOYEE_NAME[��Ա],data0832.MainexecStat ������״̬,
Data0842.BeginTime[��ʼʱ��],Data0842.EndTime[����ʱ��],data0846.FaultName	[��������],data0846.stdDate	[��׼ά��ʱ��],
Data0842.TimeRest[��;��Ϣʱ��],Data0842.WorkTime[��Ա����ʱ��],Data0842.TimeCons [��ͣʱ��],
case when data0846.stdDate>0 and DATA0567.Staff_Sum_house>0 then
data0846.stdDate/DATA0567.Staff_Sum_house else 0 end [�����],
'Ͷ������'=convert(varchar(500),STUFF((SELECT '��' + remark from data0841
       where data0841.D567_ptr=data0567.rkey and Status_ptr=7
       FOR XML PATH('')), 1, 1, '')),Data0842.Remark[��ע],data0840.Location as[����С��],Data0417.EquiType ���豸����
from DATA0567
join data0417 on DATA0567.FASSET_PTR=data0417.rkey
join  Data0034 ON DATA0567.DEPT_PTR = Data0034.RKEY 
join  Data0005 ON DATA0567.EMPL_PTR = Data0005.RKEY left outer JOIN
       Data0005 AS Data0005_1 ON DATA0567.disposal_emplptr = Data0005_1.RKEY left outer join
       Data0005 AS Data0005_2 ON Data0567.completion_emplptr=Data0005_2.RKEY left outer join
       Data0015 ON DATA0567.whouse_ptr=data0015.rkey
left join Data0842 on Data0842.[Work_ptr]=DATA0567.rkey
left join data0005 d5 on Data0842.[Empl_ptr]=d5.rkey
join data0832 on Data0842.[Status]=data0832.rkey
left join data0846 on data0846.rkey=DATA0567.d846_ptr 
left join data0840 on DATA0567.D840_ptr=data0840.rkey)W1 
where  
��������>=getDate()-30

---------------------------
OK   
---------------------------


---------------------------
�����ƻ� ��������
---------------------------
select *from 
(select d31.PlanMainDate	�ƻ�����ʱ��,d15.ABBR_NAME ����,d34.DEPT_NAME ����,
d17.FASSET_NAME �豸����,d31.DeviNumb	�豸���,d32.MainExecStat ״̬,
d17.equipment_grade	�豸�ȼ�,d17.LOCATION ����λ��,
d31.DeviType	��������,d31.MainCycl	��������,
d31.StarMainTime	��ʼ����ʱ��,
d31.ActuCompTime	ʵ�����ʱ��,d31.MainImpl	������,
d31.TimeCons	��������ʱ��,
d31.StdTimeCons	��׼����ʱ��,
TimeCons/StdTimeCons �����,
d73.User_Full_Name ������,
d40.Location as [����С��],
d05.EMPLOYEE_NAME ��Ա,d48.WorkDate ��������,
d48.BeginTime ��ʼʱ��,d48.EndTime ����ʱ��,
d48.TimeRest ��;��Ϣʱ��,d48.WorkTime ��Ա����ʱ��,
d31.Remarks	������¼����
from data0831 d31
join data0417 d17 on d31.DeviNumb=d17.FASSET_CODE
join data0034 d34 on d17.DEPT_PTR=d34.rkey
join data0015 d15 on d17.warehouse_ptr=d15.rkey
join data0832 d32 on d31.RKEY832=d32.rkey
left join data0073 d73 on d31.MainAcce_UserPtr=d73.rkey
join Data0848 d48 on d31.rkey=d48.Work_ptr
join data0005  d05 on d48.[Empl_ptr]=d05.rkey

left join data0840 d40 on d17.D840_ptr=d40.rkey

where d31.StarMainTime>:SD and d31.StarMainTime<:ED
)as t1

where �����<=0.6
---------------------------
OK   
---------------------------


select data0417.FASSET_CODE,FASSET_NAME,data0567.* from data0567 
join data0417 on data0417.rkey=data0567.FASSET_PTR
where maintain_house>2 and failure_degree='����ͣ��'
select dateDiff(day ,'2013-9-1',getdate())

select * from data0417 where rkey=26891
update data0567
set disposal_date='2013-9-04 10:22' --'2012-11-12 16:01:00'
where rkey=26891

select top 100 *from data0567 where fail_type='��������'