--���۶�������������������

select * from Data0320


--����������÷���
select * from Data0858

--ƽʱ��Ա

select data0091.*,data0034.dept_code,data0034.dept_name,data0073.user_login_name,data0073.user_full_name  
from data0091 
left join data0034 on data0091.dept_ptr=data0034.rkey  
left join data0073 on data0091.sysuser_ptr=data0073.rkey  
where data0091.group_ptr=1 order by data0091.seq_no,data0091.rkey 


--��Ʒ���
SELECT data0566.prod_ptr,data0008.PROD_CODE,data0008.PRODUCT_NAME
FROM Data0566 INNER JOIN
Data0008 ON Data0566.prod_ptr = Data0008.RKEY 
where Data0566.auth_ptr=1

--�������
SELECT so_style from data0567 where auth_ptr=1