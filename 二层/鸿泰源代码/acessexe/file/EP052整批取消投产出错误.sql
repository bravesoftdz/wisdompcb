EP052����ȡ��Ͷ��������
1ȡ��Ͷ��ʱ��ʾ�ɹ�����ɾ�����ϵ���û��ɾ��LOT��������ΪDATA006����һ�����DATA0006��492��,ͨ��cut_NO,ɾ���淶������,2005�ò����
select data0006.rkey from daata0006 where cut_no not in(select cut_no from data0492 )

select distinct ent_datetime, data0006.rkey,data0492.cut_no,data0006.cut_no 
from data0006 
left join data0492 on data0492.cut_no =data0006.cut_no 
where data0492.cut_no is null

delete from data0006 where rkey in(
select data0006.rkey 
from data0006 
left join data0492 on data0492.cut_no =data0006.cut_no 
where data0492.cut_no is null)

2ȡ���������6����492��
a.48������ת��¼
b.���������������
C���ٿ������������