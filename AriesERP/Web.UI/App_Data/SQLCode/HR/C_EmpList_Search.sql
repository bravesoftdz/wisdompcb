--�����б��ѯ����
select * from(
SELECT '����' AS value,'����' AS text,'' AS parent,10 as sortno union
SELECT '����' AS value,'����' AS text,'' AS parent,20 as sortno union 
SELECT 'ְ��' AS value,'ְ��' AS text,'' AS parent,30 as sortno UNION
SELECT '����' AS value,'����' AS text,'' AS parent,40 as sortno union
SELECT '���֤��' AS value,'���֤��' AS text,'' AS parent,50 as sortno union
SELECT '����' AS value,'����' AS text,'' AS parent,60 as sortno union
SELECT '��������' AS value,'��������' AS text,'' AS parent,70 as sortno union 
SELECT 'ѧ��' AS value,'ѧ��' AS text,'' AS parent,80 as sortno
) a order by sortno  
