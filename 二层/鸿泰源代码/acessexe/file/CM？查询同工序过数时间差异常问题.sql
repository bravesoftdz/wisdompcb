--intime  ���հ�ʱ��  outtime���Ͱ�ʱ��  Ԥ����ʱ���� sendtime
select work_order_number ��ҵ����, CUSTOMER_PART_NUMBER AS ��Ʒ�ͺ�, c.dept_code �������,c.DEPT_NAME as �������� , 
INTIME �Ӱ�ʱ��,sendtime Ԥ��������ʱ��,e.EMPLOYEE_NAME as ����Ա,

* from data0048 a --0048��ת��
join data0006 b on a.WO_PTR=b.rkey 
join data0034 c on a.WORK_CENTER_PTR=c.rkey and c.ttype=1 
join data0034 d on c.DEPT_PTR=d.rkey 
join Data0005 e on a.EMPL_PTR=e.RKEY
join Data0025 f on b.BOM_PTR=f.RKEY
join Data0050 j on f.ANCESTOR_PTR=j.RKEY AND J.CUSTOMER_PART_NUMBER='DS10291'

 where  (a.sendtime-a.INTIME)<0.0007 and c.BARCODE_ENTRY_FLAG='Y'--BARCODE_ENTRY_FLAG='Y'Ϊ���������������
 --������ʱ���С��1���ӵ�;
 and INTIME>='2016-03-10 00:00:00'
 and INTIME<='2016-03-21 23:00:00'
-- and work_order_number='151226008-0-5-5T'
  order by work_order_number 

/*------�Զ����ѯ����ͬʱ��������---
select top 100 percent 
 work_order_number ��ҵ����,c.dept_code ������� ,c.DEPT_NAME  ��������,INTIME �Ӱ�ʱ��,sendtime Ԥ��������ʱ��,
QUAN_SCH  Ͷ������, QUAN_REJ ��������, QUAN_PROD �깤����,e.EMPLOYEE_NAME ����Ա,

case b.PROD_STATUS
  when 1 then '�ȴ����'  when 2 then '�ȴ�����'  
  when 3 then '������'  when 9 then '��������' 
  when 103 then '�������ݻ�'  when 202 then '����ȡ��'  end as ����״̬

 from data0048

inner join data0006 b on data0048.WO_PTR=b.rkey  
inner join data0034 c on data0048.WORK_CENTER_PTR=c.rkey 
inner join data0034 d on c.DEPT_PTR=d.rkey and d.ttype=1 
inner join Data0005 e on data0048.EMPL_PTR=e.RKEY    

WHERE 1=:VWhere1 

and (data0048.sendtime-data0048.INTIME)<0.0007
and c.BARCODE_ENTRY_FLAG='Y'
and data0048.INTIME >=:VDate1
and data0048.sendtime<=:VDate2

 order by c.dept_code
 */