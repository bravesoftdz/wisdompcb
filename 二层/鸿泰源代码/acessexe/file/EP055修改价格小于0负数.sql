--EP055�޸ļ۸�С��0����
--�òɹ������һ���Ѿ���˵���������д
SELECT data0028.SUPPLIER_PTR,data0028.INVENTORY_PTR,data0028.PRICE_1,(CASE when data0028.TAX_FLAG='Y' THEN tmp.tax_price else tmp.PRICE end)AS �޸ĺ�ļ۸�
FROM data0028 ,(
SELECT data0070.SUPPLIER_POINTER,data0071.INVT_PTR,data0071.PRICE,data0071.TAX_2,data0071.tax_price
  FROM data0071
JOIN data0070 ON data0071.PO_PTR=data0070.RKEY WHERE data0070.[STATUS] IN(5,6,7) AND data0071.RKEY
IN (
SELECT MIN(data0071.rkey) d71rkey FROM data0071
JOIN data0070 ON data0071.PO_PTR=data0070.RKEY WHERE data0070.[STATUS] IN(5,6,7)
--1�����,2���˻�,3�ѱ���,4���ݻ�,5 �����,6���ջ�,7�����,8δ�ύ,9��ȡ��
GROUP BY data0070.SUPPLIER_POINTER,data0071.INVT_PTR)
	
) tmp

WHERE data0028.price_1<0 and
  data0028.SUPPLIER_PTR=tmp.SUPPLIER_POINTER AND data0028.INVENTORY_PTR=tmp.INVT_PTR
  
  
  ---------------------
 UPDATE data0028 SET price_1=(CASE when data0028.TAX_FLAG='Y' THEN tmp.tax_price else tmp.PRICE end)
FROM data0028 ,(
SELECT data0070.SUPPLIER_POINTER,data0071.INVT_PTR,data0071.PRICE,data0071.TAX_2,data0071.tax_price
  FROM data0071
JOIN data0070 ON data0071.PO_PTR=data0070.RKEY WHERE data0070.[STATUS] IN(5,6,7) AND data0071.RKEY
IN (
SELECT MIN(data0071.rkey) d71rkey FROM data0071
JOIN data0070 ON data0071.PO_PTR=data0070.RKEY WHERE data0070.[STATUS] IN(5,6,7)
--1�����,2���˻�,3�ѱ���,4���ݻ�,5 �����,6���ջ�,7�����,8δ�ύ,9��ȡ��
GROUP BY data0070.SUPPLIER_POINTER,data0071.INVT_PTR)
	
) tmp

WHERE data0028.price_1<0 and
  data0028.SUPPLIER_PTR=tmp.SUPPLIER_POINTER AND data0028.INVENTORY_PTR=tmp.INVT_PTR