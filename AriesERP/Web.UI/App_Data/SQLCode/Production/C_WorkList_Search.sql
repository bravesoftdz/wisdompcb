--�����б��ѯ����
select * from(
SELECT '��ҵ����' AS value,'��ҵ����' AS text,'' AS parent,10 as sortno union
SELECT '���ϵ���' AS value,'���ϵ���' AS text,'' AS parent,20 as sortno union
SELECT '���۶�����' AS value,'���۶�����' AS text,'' AS parent,30 as sortno union 
SELECT '�������' AS value,'�������' AS text,'' AS parent,40 as sortno union
SELECT '�ͻ��ͺ�' AS value,'�ͻ��ͺ�' AS text,'' AS parent,50 as sortno union
SELECT '�ͻ�����' AS value,'�ͻ�����' AS text,'' AS parent,60 as sortno union 
SELECT '�ͻ����' AS value,'�ͻ����' AS text,'' AS parent,70 as sortno union
SELECT '����ԭ�ͻ�' AS value,'����ԭ�ͻ�' AS text,'' AS parent,80 as sortno union
SELECT '��������' AS value,'��������' AS text,'' AS parent,90 as sortno union
SELECT '�����' AS value,'��/���' AS text,'' AS parent,100 as sortno
) a order by sortno