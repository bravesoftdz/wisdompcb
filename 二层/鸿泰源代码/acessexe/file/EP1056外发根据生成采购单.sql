--EP1056�ⷢ�������ɲɹ���
--����ⷢ������ҵ�����ɲɹ���
select data0006.rkey,data0006.work_order_number,data0006.prod_status,data0025.manu_part_number,data0006.parts_per_panel,data0006.PANEL_A_B,
data0050.customer_part_number,data0050.cp_rev,data0056.step,data0056.rkey as d0056_rkey,data0056.panels,data0025.parent_ptr,
a.dept_code,a.dept_name,data0056.qty_backlog,cast(0 as bit) as choose_flag,data0025.rkey as d0025_rkey,a.rkey as d0034_rkey,cast(0 as bit) as used_flag

from  data0006 
inner JOIN      data0056 on data0056.wo_ptr=data0006.rkey 
left join     data0034 b on data0056.dept_ptr=b.rkey --����
 left JOIN      data0034 a on b.dept_ptr=a.rkey --��
 left join     data0025 on data0006.bom_ptr=data0025.rkey 
 left join     data0050 on data0025.ancestor_ptr=data0050.rkey
where B.out_source=1  --�ⲿ��Դ(0,1�ⲿ��Դ)
and isnull(pr_ptr,0)=0 --�ⷢ��ʶ    �����ֵ���ʾ�����ⷢ
and isnull(d0071_ptr,0)=0 --�ⷢ�ɹ���ָ��   �����ֵ���ʾ�����ⷢ
order by a.dept_code,data0050.customer_part_number,data0025.manu_part_number,data0006.work_order_number

--ȫ���ⷢ
exec sp_executesql N'declare @vptr int
select @vptr=isnull(ppc_control13,0) from data0192 -- 0:����ȷ��ǰ����Ͷ����1:����ȷ��ǰ������Ͷ��
select data0060.rkey,data0010.cust_code,data0060.sales_order,data0060.ORIG_SCHED_SHIP_DATE as sch_date,data0050.customer_part_number,data0050.cp_rev,
data0060.parts_ordered,data0060.set_ordered,data0060.to_be_planned,data0060.qty_plannned,cast(0 as bit) as choose_flag,data0060.cust_part_ptr,
data0060.so_style,data0023.supplier_name,data0060.to_be_planned*data0050.unit_sq as sqmt
from  data0050,data0010,data0060 left join data0023 on data0060.supplier_ptr=data0023.rkey
where data0060.cust_part_ptr=data0050.rkey
and data0060.customer_ptr=data0010.rkey
and data0060.so_tp=1 --�ӹ���ʽ��0����1�ⷢ2���Ƴ�
and quote_price in (1,3) --�����Ƿ�������(0,1,2,3)(��,��,�˻�,������)
and data0060.to_be_planned>0
and data0060.status=1
and ((@vptr=0) or (@vptr=1 and prod_rel in (2,3)) )--prod_rel ����״̬0��1δȷ��2��ȷ��δͶ��3����ȷ��4��ȡ��
and data0060.ORIG_SCHED_SHIP_DATE>=@P1
and data0060.ORIG_SCHED_SHIP_DATE<=@P2
order by data0010.cust_code,data0060.sales_order,data0060.sch_date,data0050.customer_part_number


 
',N'@P1 datetime,@P2 datetime','2013-10-26 00:00:00','2014-04-25 00:00:00'

 