
--ep082�ڹ�������鹤���� ������ȡ34��
exec sp_executesql N'select data0038.rkey,step_number,data0038.def_rout_inst,data0034.dept_code,
data0034.dept_name,data0034.barcode_entry_flag
from data0038,data0034
where data0038.flow_no=@P1
and data0038.source_ptr=@P2 --data0025.rkey
and data0038.dept_ptr=data0034.rkey
order by data0038.step_number
',N'@P1 int,@P2 int',0,12548

---------------------------------------------------------

--ep100��MI���ÿ��ؼ����жϣ� �������ݿ���ȡ34����38��barcode_entry_flag
CREATE PROCEDURE EP100;5
@vptr int
with encryption
AS
begin
declare @vflag int
select @vflag=isnull(BCODE_FLAG,0) from data0195 --����
select data0038.*,data0034.TOOLING_FLAG,data0034.output_sys_formula,def_rout_inst_flag,case when @vflag=0 then data0034.barcode_entry_flag else (case when data0038.BCODE_ENTRY_FLAG=1 then 'Y' else '' end) end as barcode_entry_flag,
Data0308.app_date,Data0308.app_down_date,Data0308.app_down_reason,Data0308.app_down_statu
from data0038 inner join data0034 on data0038.dept_ptr =data0034.rkey
left join Data0308 on Data0308.SOURCE_PTR=Data0038.RKEY
where data0038.flow_no=0  
and data0038.source_ptr=@vptr
order by data0038.step_number
end
GO

-------------------------------------------------------

--EP075���ϵ�ǰ���� ��������38��barcode_entry_flag

--��ʾ step_number+dept_code
--copy(inttostr(1000+FrmMain.Adoquery9.fieldbyname('step_number').Asinteger),2,3)+'. '+FrmMain.Adoquery9.Fieldbyname('dept_code').AsString);
select data0034.dept_code,data0038.dept_ptr,a.barcode_entry_flag,--38�����жϹ���
data0038.step_number --���� ��ǰ���ҵ����һ��Ҫ������
from data0038,data0034,data0034 a --����
where source_ptr=3623--:vptr data0025.rkey
and data0034.rkey=data0038.dept_ptr
and data0034.dept_ptr=a.rkey
and data0038.step_number<=9--:vstep 
and data0038.flow_no=0--:vflow 
order by data0038.step_number desc