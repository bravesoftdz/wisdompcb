EP141ȱ�ٸ��»�ˢ�µļ�����Ϣ

����Ϊ�������⣬������RKEY�м�����ֵ���Ȱ��ֶ����ã�������RKEY����������Ҫ�Զ�����


SELECT rkey,* FROM data0004 ORDER BY rkey 
UPDATE data0004 SET rkey=85 WHERE table_name='data0921'
UPDATE data0004 SET rkey=86 WHERE seed_mean='���ϲɹ���������'
SELECT rkey,COUNT(rkey) FROM data0004 GROUP BY rkey HAVING COUNT(rkey)>1