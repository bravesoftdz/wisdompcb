EP121ECN�����������ͻ�����
exec sp_executesql N'select data0050.customer_part_number,data0050.cp_rev,
data0059.* 
from data0059,data0050
where data0059.cust_part_ptr=data0050.rkey
and data0050.customer_part_number=@P1
and data0050.cp_rev1=@P2
and data0050.cp_rev2=@P3
',N'@P1 varchar(20),@P2 varchar(1),@P3 varchar(1)','P2G018648','A','0'
go
exec sp_executesql N'select data0050.rkey,data0050.customer_part_number,data0050.cp_rev,data0050.ONHOLD_RELEASE_FLAG,data0050.ONHOLD_PLANNING_FLAG
from data0050
where data0050.customer_part_number=@P1
and data0050.cp_rev1=@P2
and data0050.cp_rev2=@P3
',N'@P1 varchar(20),@P2 varchar(1),@P3 varchar(1)','P2G018648','A','0'
go


���customer_part_number\cp_rev1\cp_rev2�пո񣬾ͳ��������У����������ͻ�����
����ü���ģ�鶼��������