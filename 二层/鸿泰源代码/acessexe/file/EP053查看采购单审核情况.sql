--exec ep053;4 723

SELECT user_id,user_full_name,
              auth_date,ranking,user_ptr
FROM data0078 inner join data0073
     On data0078.user_ptr=data0073.rkey
WHERE (po_ptr =723)--�ɹ���ָ��