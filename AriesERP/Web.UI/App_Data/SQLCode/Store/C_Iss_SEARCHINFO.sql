--VMI����б��ѯ����
select * from(
SELECT '���ⵥ��' AS value,'���ⵥ��' AS text,'' AS parent,10 as sortno union
SELECT '���ϱ���' AS value,'���ϱ���' AS text,'' AS parent,20 as sortno union 
SELECT '�������' AS value,'�������' AS text,'' AS parent,30 as sortno union
SELECT '���ϵ���' AS value,'���ϵ���' AS text,'' AS parent,40 as sortno union
SELECT '���ϲ�������' AS value,'���ϲ�������' AS text,'' AS parent,50 as sortno union 
SELECT '�������' AS value,'�������' AS text,'' AS parent,60 as sortno union 
SELECT '���Ϲ���' AS value,'���Ϲ���' AS text,'' AS parent,70 as sortno union 
SELECT '���ϵ���' AS value,'���ϵ���' AS text,'' AS parent,80 as sortno union 
SELECT '��Ӧ�̼��' AS value,'��Ӧ�̼��' AS text,'' AS parent,90 as sortno union 
SELECT '������Ա' AS value,'������Ա' AS text,'' AS parent,100 as sortno union 
SELECT '���Ųֿ�����' AS value,'���Ųֿ�����' AS text,'' AS parent,110 as sortno union
SELECT '��ֵ���' AS value,'��ֵ���' AS text,'' AS parent,120 as sortno union
SELECT '�������' AS value,'�������' AS text,'' AS parent,130 as sortno union 
SELECT '��湤��' AS value,'��湤��' AS text,'' AS parent,140 as sortno union 
SELECT '��������' AS value,'��������' AS text,'' AS parent,150 as sortno union
SELECT 'ֱ�ӻ���' AS value,'ֱ�ӻ���' AS text,'' AS parent,160 as sortno 
) a order by sortno