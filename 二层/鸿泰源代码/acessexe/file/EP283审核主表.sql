
�������
SELECT * FROM data0264 
SELECT * FROM data0265
SELECT * FROM data0266
���������Ա
exec ep283;1 6

��˹����
exec sp_executesql N'select dept_code,dept_name,d264_ptr 
from data0034 where ttype in (1,4)
and d264_ptr=@P1
order by dept_code
',N'@P1 int',6

exec ep283;2 1

exec sp_executesql N'select * from data0266
where d265_ptr=@P1
',N'@P1 int',1

