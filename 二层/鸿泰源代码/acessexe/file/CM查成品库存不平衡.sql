data0052��(��Ʒ����)  data0465��Ʒ����/������ϸ��
--���Ʒ��治������Щ
select data0053.MFG_DATE,data0053.RKEY,data0053.QUANTITY,data0053.QTY_ON_HAND,
(select isnull(SUM(QUAN_SHP),0) from Data0052 where DATA0053_PTR=data0053.rkey)
+(select isnull(SUM(QUANTITY),0) from Data0465 where D0053_PTR=data0053.rkey) as outqty,
 QUANTITY-
 (select isnull(SUM(QUAN_SHP),0) from Data0052 where DATA0053_PTR=data0053.rkey)
 -(select isnull(SUM(QUANTITY),0) from Data0465 where D0053_PTR=data0053.rkey) as cyqty
 
 from Data0053 
where QUANTITY-
 (select isnull(SUM(QUAN_SHP),0) from Data0052 where DATA0053_PTR=data0053.rkey)
 -(select isnull(SUM(QUANTITY),0) from Data0465 where D0053_PTR=data0053.rkey)
<>data0053.QTY_ON_HAND

select * from data0052 where DATA0053_PTR= --Data0053.rkey

select * from data0465 where DATA0053_PTR= --Data0053.rkey