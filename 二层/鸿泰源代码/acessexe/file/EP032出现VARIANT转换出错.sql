EP032����VARIANTת������

COULD NOT CONVERT VARIANT OF TYPE (NULL) INTO TYPE (DOUBLE)
��Ҫ����һ��
�����ӵ��

��
����
�ͻ�����

 ������-������ 16:26:18 
update Data0012 set Data0012.SREP_PTR_5='84'   where Data0012.CUSTOMER_PTR in 
(select a.CUSTOMER_PTR from data0012 a  left join Data0010  b 
on a.CUSTOMER_PTR=b.RKEY  WHERE    b.CUST_CODE LIKE 'sz0%' and  a.SREP_PTR_4<>'84')
��������Ĵ�

����ͨ���޸�

UPDATE data0012 SET SREP_PTR_4=0,SREP_4_COMM=0, SREP_PTR_5=0,SREP_5_COMM=0 
from data0012 JOIN data0012.cust_ptr=data0010.rkey WHERE CUST_CODE LIKE 'sz0%'  