 SELECT DATA0070.PO_NUMBER 
 FROM DATA0070 --�ɹ�������
 INNER JOIN DATA0071 ON DATA0070.RKEY =DATA0071.PO_PTR --�ɹ���׼������ϸ��  
 INNER JOIN DATA0022 ON DATA0071.RKEY = DATA0022.SOURCE_PTR  
 WHERE DATA0070.STATUS =5 --״̬1-8 ,8δ�ύ 1,�����,2���˻�,5�Ѿ����,������˻ص������״̬
 AND DATA0070.PO_NUMBER ='wf12-06-00003'
 
 --�ⷢ�ɹ��������Ϣ��ѯ
select * from Data0070 order by 1 desc 
exec ep053;4 3389

SELECT user_id,user_full_name,
              auth_date,ranking,user_ptr
FROM data0078 inner join data0073
     On data0078.user_ptr=data0073.rkey
WHERE po_ptr =3389 --@po_ptr�ⷢ�ɹ�����
  
ORDER BY
 ranking
