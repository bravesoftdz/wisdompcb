--ep149��ߴ��ڲ�ѯ

select * from data0346 --���۲�Ʒ�����۸�����ӱ�
order by row_index

--���⹤�� (�ң�
select * from data0351
where d0346_ptr=5 --data0346.rkey
order by seq_no


exec sp_executesql N'select * from data0351 --���ۻ��ۺͶ���۸������
where d0346_ptr=@P1
order by seq_no
',N'@P1 int',5

select * from data0280 ORDER by Eng_table_name--���̱�

select rkey,adder_name ,selectit from data0348 --���⹤����Ŀѡ��
where ttype=1
order by adder_name
