--ep0000����������Ų�

--�������ù����Ų�����

select data0034.RKEY,data0034.ppc_seq_nr as SEQ_NR,data0034.DEPT_CODE,data0034.DEPT_NAME,
ppc_unit_ptr,schedule_flag,yield_object,ppc_dept_qty,PPC_dept_ptr,ppc_dept_qty2
from data0034 Where data0034.TTYPE=1 
and BARCODE_ENTRY_FLAG='Y' --�Ƿ����
order by data0034.ppc_seq_nr,data0034.dept_code

exec sp_executesql N'select dept_code,dept_name from data0034
where ppc_dept_ptr=@P1
and ttype=1  --exec sp_executesql N'select dept_code,dept_name from data0034
where ppc_dept_ptr=@P1
and ttype=1  --1����,2������,3��������,4����,����
order by dept_code
',N'@P1 int',348
order by dept_code
',N'@P1 int',348

--��Ʒ������ȼ�

SELECT p_code, * FROM data0008

