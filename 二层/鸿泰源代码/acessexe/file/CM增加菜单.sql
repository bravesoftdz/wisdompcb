declare @vnum INT,@program VARCHAR(20),@descr VARCHAR(50)
SElect @program='ep799.exe',@descr='���Ϸ�IQC'
select @vnum=count(*) from  data0419 where program=@program
if @vnum=0
INSERT INTO data0419([TTYPE], [ANCESTOR_PTR], [PARENT_PTR], [SEQ_NO], [EXE_FLAG], [DESCRIPTION], [BIG5_DESCRPT], 
	[PREV_TP], [PROGRAME], [IMAGE_INDEX], [program], [flag], [ERP_NODE_CODE], 
	[RIGHT_TITLE_01], [RIGHT_TITLE_02], [RIGHT_TITLE_03], [RIGHT_TITLE_04], [RIGHT_TITLE_05], [RIGHT_TITLE_06], 
	[RIGHT_TITLE_07], [RIGHT_TITLE_08], [RIGHT_TITLE_09], [RIGHT_TITLE_10], [RIGHT_TITLE_11], [RIGHT_TITLE_12], 
	[RIGHT_TITLE_13], [RIGHT_TITLE_14], 
	[RIGHT_TITLE_15], [RIGHT_TITLE_16], 
	[RIGHT_01], [RIGHT_02], [RIGHT_03], [RIGHT_04], [RIGHT_05], [RIGHT_06], [RIGHT_07], [RIGHT_08], 
	[RIGHT_09], [RIGHT_10], [RIGHT_11], [RIGHT_12], [RIGHT_13], [RIGHT_14], [RIGHT_15], [RIGHT_16])
SELECT [TTYPE], [ANCESTOR_PTR], [PARENT_PTR],0, [EXE_FLAG], @descr,@descr, 
	[PREV_TP], @program,  [IMAGE_INDEX],@program, [flag], [ERP_NODE_CODE], 
	[RIGHT_TITLE_01], [RIGHT_TITLE_02], [RIGHT_TITLE_03], [RIGHT_TITLE_04], [RIGHT_TITLE_05], [RIGHT_TITLE_06], 
	[RIGHT_TITLE_07], [RIGHT_TITLE_08], [RIGHT_TITLE_09], [RIGHT_TITLE_10], [RIGHT_TITLE_11], [RIGHT_TITLE_12], 
	[RIGHT_TITLE_13], [RIGHT_TITLE_14], [RIGHT_TITLE_15], [RIGHT_TITLE_16], 
	[RIGHT_01], [RIGHT_02], [RIGHT_03], [RIGHT_04], [RIGHT_05], [RIGHT_06], [RIGHT_07], [RIGHT_08], 
	[RIGHT_09], [RIGHT_10], [RIGHT_11], [RIGHT_12], [RIGHT_13], [RIGHT_14], [RIGHT_15], [RIGHT_16] 
 from data0419 where program='ep017.exe'
go

------------------------------------------------------------------------------------------

--���Ӵ�����ײ�ģ��˵�
declare @rf_program VARCHAR(30),--ͬ���ο�������
        @new_program VARCHAR(30) ,--��ִ�г����� 
        @new_DESCRIPTION VARCHAR(50),--�²˵���
        @user_name VARCHAR(30) --Ҫ��Ȩ�ĵ�¼��
SELECT  @rf_program ='EP013.EXE', 
        @new_program='EP411.EXE',
        @new_DESCRIPTION='IPQC',
 --       @user_name='admin'
 --�Ǳ�׼�����빺�� ep2051.exe      
 --�Ǳ�׼�����빺����� ep2057.exe
 --�Ǳ�׼�����빺������ ep2054.exe
 --�Ǳ�׼���ϲɹ� ep2056.exe
 --�Ǳ�׼���ϲɹ���� ep2053.exe
---------------------------------------------------
declare @ncount int,@ocount int,@rf_key int,@new_key int,@max_seq_no INT,@user_ptr VARCHAR(30)
select @ncount=0,@ocount=0,@rf_key=0,@new_key=0,@max_seq_no=0,@user_ptr=0;

select @ncount=count(*) from data0419 where upper(programe)=upper(@new_program)

if @ncount<1--����������
  begin
select @ocount=count(*) from data0419 where upper(programe)=upper(@rf_program)
if @ocount>0--�ɵĴ���
begin  
  select @rf_key=rkey from data0419 where programe=@rf_program
  select @max_seq_no=max(seq_no)+1 from data0419 where parent_ptr in (select parent_ptr from data0419 where rkey=@rf_key)--��˳��� 
  --����ģ��˵�
  --

INSERT INTO data0419([TTYPE], [ANCESTOR_PTR], [PARENT_PTR], [SEQ_NO], [EXE_FLAG], [DESCRIPTION], [BIG5_DESCRPT], 
	[PREV_TP], [PROGRAME], [IMAGE_INDEX], [program], [flag], [ERP_NODE_CODE], 
	[RIGHT_TITLE_01], [RIGHT_TITLE_02], [RIGHT_TITLE_03], [RIGHT_TITLE_04], [RIGHT_TITLE_05], [RIGHT_TITLE_06], 
	[RIGHT_TITLE_07], [RIGHT_TITLE_08], [RIGHT_TITLE_09], [RIGHT_TITLE_10], [RIGHT_TITLE_11], [RIGHT_TITLE_12], 
	[RIGHT_TITLE_13], [RIGHT_TITLE_14], 
	[RIGHT_TITLE_15], [RIGHT_TITLE_16], 
	[RIGHT_01], [RIGHT_02], [RIGHT_03], [RIGHT_04], [RIGHT_05], [RIGHT_06], [RIGHT_07], [RIGHT_08], 
	[RIGHT_09], [RIGHT_10], [RIGHT_11], [RIGHT_12], [RIGHT_13], [RIGHT_14], [RIGHT_15], [RIGHT_16])

SELECT [TTYPE], [ANCESTOR_PTR], [PARENT_PTR],@max_seq_no, [EXE_FLAG], @new_DESCRIPTION, @new_DESCRIPTION, 
	[PREV_TP], @new_program, [IMAGE_INDEX], @new_program, [flag], [ERP_NODE_CODE], 
	[RIGHT_TITLE_01], [RIGHT_TITLE_02], [RIGHT_TITLE_03], [RIGHT_TITLE_04], [RIGHT_TITLE_05], [RIGHT_TITLE_06], 
	[RIGHT_TITLE_07], [RIGHT_TITLE_08], [RIGHT_TITLE_09], [RIGHT_TITLE_10], [RIGHT_TITLE_11], [RIGHT_TITLE_12], 
	[RIGHT_TITLE_13], [RIGHT_TITLE_14], 
	[RIGHT_TITLE_15], [RIGHT_TITLE_16], 
	[RIGHT_01], [RIGHT_02], [RIGHT_03], [RIGHT_04], [RIGHT_05], [RIGHT_06], [RIGHT_07], [RIGHT_08], 
	[RIGHT_09], [RIGHT_10], [RIGHT_11], [RIGHT_12], [RIGHT_13], [RIGHT_14], [RIGHT_15], [RIGHT_16]

 from data0419 
where program=@rf_program --��program='ep065.exe'

select top 1 @new_key=rkey from data0419 where programe=@new_program order by rkey desc

  --�����û�ָ��
 --SELECT @user_ptr=rkey FROM data0073 WHERE USER_LOGIN_NAME=@user_name
 SELECT @new_key


  
  --����Ȩ��,
INSERT INTO data0074(USER_PTR, FUNCTION_ID, USER_RIGHTS, FAVORIATE,
            RIGHT_VALUE_STR)
SELECT  USER_PTR,@new_key ,--FUNCTION_ID������data0073���ܲ˵�ָ��
USER_RIGHTS, FAVORIATE, RIGHT_VALUE_STR 
from DATA0074 
WHERE user_ptr IN (SELECT rkey FROM data0073 )
--USER_PTR=@user_ptr --�û�ָ��,ֻ��һ���û���Ȩ��
AND FUNCTION_ID=@rf_key--data0073���ܲ˵�ָ��*/
 select @ocount,@rf_program,@rf_key,@new_key,@max_seq_no --@user_ptr
end

end


----------------------------------------------------------------------------

declare @vnum int
select @vnum=count(*) from  data0419 where program='ep289.exe'
if @vnum=0
INSERT INTO data0419([TTYPE], [ANCESTOR_PTR], [PARENT_PTR], [SEQ_NO], [EXE_FLAG], [DESCRIPTION], [BIG5_DESCRPT], 
	[PREV_TP], [PROGRAME], [IMAGE_INDEX], [program], [flag], [ERP_NODE_CODE], 
	[RIGHT_TITLE_01], [RIGHT_TITLE_02], [RIGHT_TITLE_03], [RIGHT_TITLE_04], [RIGHT_TITLE_05], [RIGHT_TITLE_06], 
	[RIGHT_TITLE_07], [RIGHT_TITLE_08], [RIGHT_TITLE_09], [RIGHT_TITLE_10], [RIGHT_TITLE_11], [RIGHT_TITLE_12], 
	[RIGHT_TITLE_13], [RIGHT_TITLE_14], 
	[RIGHT_TITLE_15], [RIGHT_TITLE_16], 
	[RIGHT_01], [RIGHT_02], [RIGHT_03], [RIGHT_04], [RIGHT_05], [RIGHT_06], [RIGHT_07], [RIGHT_08], 
	[RIGHT_09], [RIGHT_10], [RIGHT_11], [RIGHT_12], [RIGHT_13], [RIGHT_14], [RIGHT_15], [RIGHT_16])

SELECT [TTYPE], [ANCESTOR_PTR], [PARENT_PTR], [SEQ_NO], [EXE_FLAG], '������Ŀ���','������Ŀ���', 
	[PREV_TP], 'ep289.exe',  [IMAGE_INDEX], 'ep289.exe', [flag], [ERP_NODE_CODE], 
	[RIGHT_TITLE_01], [RIGHT_TITLE_02], [RIGHT_TITLE_03], [RIGHT_TITLE_04], [RIGHT_TITLE_05], [RIGHT_TITLE_06], 
	[RIGHT_TITLE_07], [RIGHT_TITLE_08], [RIGHT_TITLE_09], [RIGHT_TITLE_10], [RIGHT_TITLE_11], [RIGHT_TITLE_12], 
	[RIGHT_TITLE_13], [RIGHT_TITLE_14], [RIGHT_TITLE_15], [RIGHT_TITLE_16], 
	[RIGHT_01], [RIGHT_02], [RIGHT_03], [RIGHT_04], [RIGHT_05], [RIGHT_06], [RIGHT_07], [RIGHT_08], 
	[RIGHT_09], [RIGHT_10], [RIGHT_11], [RIGHT_12], [RIGHT_13], [RIGHT_14], [RIGHT_15], [RIGHT_16] 
 from data0419 where program='ep089.exe'
go

                               
                                     
                                                          