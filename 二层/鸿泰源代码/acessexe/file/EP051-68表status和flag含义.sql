 ,case 
     when status=7 then 'δ�ύ'
     when status=1 then '����������'
     when status=2 then '���ɹ�'
     when status=3 then '����׼'
     when status=4 then '���˻�'
     when status=5 then '�빺���ѳ���'
     when status=6 then '�빺���Ѵ���'
     when status=8 then '����ǰ������'
     when status=9 then 
      case when tstate =1 then '����˻�' else '������' end
  end as v_status
 ,case 
     when flag='S' then '��׼����'
     when flag='M' then '�Ǳ�׼����'
     when flag='T' then '��׼�ⷢ'
     when flag='N' then '�Ǳ�׼�ⷢ'
  end as flag1