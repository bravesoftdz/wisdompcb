--���ҿ��õİ汾
exec sp_executesql N'select data0050.rkey,data0050.customer_part_number,data0050.cp_rev,
data0059.customer_part_desc,data0050.cp_rev1,data0050.cp_rev2
from data0050,data0059
where data0050.rkey=data0059.cust_part_ptr 
and data0059.customer_part_desc=@P1
and data0059.customer_ptr=@P2
and data0059.onhold_sales_flag<>1  --��Ʒ�ͺ���Ч����ڱ�ʶ ����Ч��1�����ڣ�
',N'@P1 varchar(500),@P2 int',
'PW-6122-0001.B',477

--data0318 ���۶���,���������䶯��¼��
exec sp_executesql N'SET NOCOUNT OFF; INSERT INTO "SJ_V20_Sample".."Data0318" 
("SALES_ORDER_PTR","TRANS_TYPE","TRANS_DESCRIPTION","FROM_STRING","TO_STRING","USER_PTR","TRANS_DATE","PROGRAM_SOURCE") 
VALUES (@P1,@P2,@P3,@P4,@P5,@P6,@P7,@P8);
 SELECT SCOPE_IDENTITY() AS SCOPE_ID_COLUMN',
 N'@P1 int,@P2 smallint,@P3 varchar(16),@P4 varchar(13),@P5 varchar(13),@P6 int,@P7 datetime,@P8 smallint',
 15210,9,'�������۶����汾','P64H0600134A6','P64H0600134A8',1,'2013-05-15 14:30:45',52
 
 --�޸�data0060������ָ����µı������ָ��
 exec sp_executesql N'UPDATE "SJ_V20_Sample"."dbo"."Data0060" 
 SET "cust_part_ptr"=@P1 
 WHERE "cust_part_ptr"=@P2 AND "RKEY"=@P3',N'@P1 int,@P2 int,@P3 int',
 8485,7684,15210