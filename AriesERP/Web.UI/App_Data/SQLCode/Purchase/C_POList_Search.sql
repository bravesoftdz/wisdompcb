--�����б��ѯ����
select * from(
SELECT '�ɹ�������' AS value,'�ɹ�������' AS text,'' AS parent,10 as sortno union
SELECT '���ϱ���' AS value,'���ϱ���' AS text,'' AS parent,20 as sortno union 
SELECT '��������' AS value,'��������' AS text,'' AS parent,30 as sortno union
SELECT '���Ϲ��' AS value,'���Ϲ��' AS text,'' AS parent,40 as sortno union
SELECT '��Ӧ�̼��' AS value,'��Ӧ�̼��' AS text,'' AS parent,50 as sortno union 
SELECT '����' AS value,'��������' AS text,'' AS parent,60 as sortno union 
SELECT '״̬' AS value,'״̬' AS text,'' AS parent,60 as sortno union 
SELECT '�빺����' AS value,'�빺����' AS text,'' AS parent,70 as sortno
) a order by sortno