--EP100��ѹ�ṹͼ
--exec EP100;103 12830

--CREATE PROCEDURE EP100;103
declare 
@vptr int=12830
--with encryption
--AS
begin
declare @vflag int
select @vflag=eng_press_instr_flag2 from data0195
if @vflag=0
select * from data0044
where  source_ptr in (select rkey from data0025 where ancestor_ptr=@vptr)
order by seq_no
if @vflag=1
select * from data0044
where  parent_ptr=@vptr
order by seq_no
end
GO

44���ǲ�ѹ����ͼ ��46���ǲ�ѹͼ���������Ϣ��552���ǲ�ѹʾ��ͼSOURCE_PTR=50���RKEY