--ep083
--����Ȩ������
select * from Data0486 where EMPL_PTR =834 --data0005.rkey
--priv 1���� 2�������� 3����+��������ipqc_prev_flag IPQC��� scp_prev_flagȷ�ϱ�������

--����Ȩ����ϸ��

select * from data0487 where USER_PTR in --����Ȩ��ָ��(Data0486.rkey)
(
select rkey from Data0486 where EMPL_PTR =834 
)


select data0486.*,data0005.empl_code,data0005.employee_name,
data0034.dept_code,data0034.dept_name,data0005.tpostion,
data0005.active_flag
 from data0486,data0005,data0034
where data0486.empl_ptr=data0005.rkey
and data0005.employee_id=data0034.rkey
order by 
data0034.dept_name,data0005.empl_code
