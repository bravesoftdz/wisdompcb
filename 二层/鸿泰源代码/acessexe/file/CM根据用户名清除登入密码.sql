UPDATE DATA0074 SET USER_RIGHTS = 4 ,RIGHT_VALUE_STR = '1111111111111111' WHERE USER_PTR=1
UPDATE data0073 SET USER_PASSWORD = NULL,COMPUTER = NULL,NETWORK_ID = null

--���û�����ĳ̨������ʹ��
update Data0073 set NETWORK_ID=null computer=null,login_time=null where lower(USER_LOGIN_NAME)='admin'

--���ȫ������
update Data0073 set USER_PASSWORD=null   where lower(USER_LOGIN_NAME)='admin'

----------------------------------
--�����û��������������
update Data0073 set USER_PASSWORD =null where EMPLOYEE_PTR in
( select RKEY from Data0005 where EMPLOYEE_NAME like '֣����%'
)

--�����û������������Ϣ
select * from data0073 
where EMPLOYEE_PTR in
( select RKEY from Data0005 where EMPLOYEE_NAME like '֣����%'
)

update Data0073 set ACTIVE_FLAG=0 where RKEY=1 --0Ϊ���ã�1������


UPDATE DATA0073 SET COMPUTER='',NETWORK_ID=''���԰������û�������


UPDATE data0314 SET hread='T' WHERE emp_ptr= --73��RKEY  �����Ϣ

�޸����ݿ�����
1�޸����ݿ�����
2����Encrypt.exe����
3������KMERP.ini�ڶ��У�����ڶ���Ϊ�գ�Ĭ��Ϊkoimy1234

----
�����޸�Ȩ��
UPDATE Data0074 SET RIGHT_VALUE_STR='1111111111111111'  WHERE user_ptr=1


--------------
73��ָ��5���û���
SELECT data0005.EMPL_CODE,data0073.rkey,user_group_flag 
FROM data0073 --user_group_flag 1Ϊ�û���0Ϊ�飨EMPLOYEE_PTRҲΪNULL��
JOIN data0005 ON data0073.EMPLOYEE_PTR= data0005.RKEY
WHERE data0073.RKEY=294 --data0005.EMPL_CODE=��Ա����



-------------------------------------------------
--����5���û�����ѯ73���û�������
select * from Data0073 
join Data0005 on data0005.RKEY =data0073.EMPLOYEE_PTR
where data0005.EMPLOYEE_NAME like '֣����%'

select * from Data0005 
