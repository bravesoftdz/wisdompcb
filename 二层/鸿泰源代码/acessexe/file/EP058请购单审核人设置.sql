--�빺�������� data0094
select * from data0094

--Data0275  �빺������Ա��ϸ��
declare @p1 int
set @p1=2
exec sp_prepexec @p1 output,N'@P1 int,@P2 int,@P3 float,@P4 float,@P5 int,@P6 int,@P7 int',
N'INSERT INTO Data0275(AUTH_GROUP_PTR,USER_PTR,LOWER_LIMIT,UPPER_LIMIT,Auth_type,ConfirmType,SEQ_No) 
VALUES (@P1,@P2,@P3,@P4,@P5,@P6,@P7)
',17,1,0,9999999999,0,1,1
select @p1
--AUTH_GROUP_PTR ָ��94�����ָ��
--Auth_type ����ǰ��������ʶ 0������ǰ��1�������
--ConfirmType �������� 1���������ϣ�2����׼���ϣ�3���Ǳ�׼��
--SEQ_No�����Ⱥ�˳��

select * from data0275
join data0094 on data0275.AUTH_GROUP_PTR=data0094.rkey
where --data0275.user_ptr=1 --�û�ָ��
data0094.RKEY=17 --94��ָ��

