--��73���û�1��Ȩ1095
--�빺����Ȩ
update data0073 set rpl_pr_ptr=1095
where rkey=1
insert into Data0011(SOURCE_TYPE,file_pointer,memo_text) values(
73,1,'2013-07-04 14:28:37��ʱ��Ȩ1095�����빺����Ȩ��')
--�빺��ȡ����Ȩ
update data0073 set rpl_pr_ptr=1
where rkey=1

--�ɹ�����Ȩ
update data0073 set rpl_po_ptr=1095
where rkey=1
insert into Data0011(SOURCE_TYPE,file_pointer,memo_text) values(
73,1,'2013-07-04 14:27:32��ʱ��Ȩ1095����ɹ�����Ȩ��')

--���۵���Ȩ
update data0073 set RPL_QO_PTR=1095
where rkey=1
insert into Data0011(SOURCE_TYPE,file_pointer,memo_text) values(
73,1,'2013-07-04 14:26:39��ʱ��Ȩ1095�����۵���Ȩ��')


--���쵥��Ȩ
update data0073 set RPL_BO_PTR=1095
where rkey=1
insert into Data0011(SOURCE_TYPE,file_pointer,memo_text) values(
73,1,'2013-07-04 14:19:30��ʱ��Ȩ1095�������쵥��Ȩ��')


--����������Ȩ
update data0073 set RPL_SO_PTR=1095
where rkey=1
insert into Data0011(SOURCE_TYPE,file_pointer,memo_text) values(
73,1,'2013-07-04 14:22:20ȡ����Ȩ1095�������������Ȩ��')

--�˻�������Ȩ
update data0073 set Return_SO_PTR=1095
where rkey=1
insert into Data0011(SOURCE_TYPE,file_pointer,memo_text) values(
73,1,'2013-07-04 14:32:26��ʱ��Ȩ1095����ͻ��˻������Ȩ��')

--����������Ȩ
update data0073 set packing_out_ptr=1095
where rkey=1
insert into Data0011(SOURCE_TYPE,file_pointer,memo_text) values(
73,1,'2013-07-04 14:33:44��ʱ��Ȩ1095������������Ȩ��')












