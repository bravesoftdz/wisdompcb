--Ͷ����Ϣ��ѯ����
select * from(
SELECT '���ϵ���' AS value,'���ϵ���' AS text,'' AS parent,10 as sortno union
SELECT '���۶�����' AS value,'������' AS text,'' AS parent,20 as sortno union
SELECT '�������' AS value,'�������' AS text,'' AS parent,30 as sortno union
SELECT '�ͻ�����' AS value,'�ͻ�����' AS text,'' AS parent,40 as sortno union 
SELECT '�ͻ����' AS value,'�ͻ����' AS text,'' AS parent,50 as sortno union
SELECT '��������' AS value,'��������' AS text,'' AS parent,60 as sortno  
) a order by sortno