--���º�˰�۸�
update data0022 set tax_price=a.jsprice
from data0022,
(select data0022.rkey,data0070.po_number,data0071.price,
data0071.tax_price,data0071.tax_2,data0022.price as data0022price, 
(data0071.tax_price*(1-data0071.discount/100))/data0071.conversion_factor as jsprice
from data0022 
inner join data0071 on data0022.source_ptr=data0071.rkey
inner join data0070 on data0070.rkey=data0071.po_ptr
where 
data0022.source_ptr is not null
and (data0071.tax_price*(1-data0071.discount/100))/data0071.conversion_factor<>data0022.tax_price) a
where data0022.rkey=a.rkey


update data0022 set tax_price=price*(1+tax_2/100) where tax_price is null and source_ptr is NULL

Ҫ��Ӧ����EP016���,EP122���ɹ�����EP125�Ǳ�׼�����ջ��� ������,EP648�ֿ�ҵ������ά����EP176ԭ���̵�,ep290����ջ�
