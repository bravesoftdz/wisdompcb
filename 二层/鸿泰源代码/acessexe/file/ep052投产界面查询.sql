--ep052Ͷ�������ѯ
--exec EP052;19 '',2,0,0,2,'2013-10-07','2013-11-06',0,0,1

declare @vflag int
select @vflag=isnull(ppc_control13,0) from data0192
SELECT data0050.layers,data0060.so_style,data0050.etest_tp,data0050.cnc_tp,data0010.cust_code,data0010.abbr_name,data0050.rkey,data0060.ent_date,data0050.cp_rev1,data0050.cp_rev2,data0060.ttype,
data0050.customer_part_number,data0050.cp_rev,data0050.onhold_planning_flag,data0060.conf_date,data0060.cust_part_ptr,
data0059.customer_part_desc,data0059.customer_matl_desc,data0060.sales_order,data0060.parts_ordered,data0060.sales_dept_list,data0060.fob,
data0060.PROD_REL,data0060.rkey as d060_RKEY,data0097.po_number,data0060.PUTHMAT_DESC,data0059.onhold_sales_flag,data0060.whse_ptr,data0060.so_tp,
case when data0050.usheet>0 then data0060.parts_ordered*data0050.psheet/data0050.usheet else 0 end as pnls_ordered,
data0060.qty_plannned,data0060.to_be_planned as orig_to_be_planned,cast(case when @vflag=0 then data0060.to_be_planned else data0060.to_be_planned+data0060.qty_sure-data0060.parts_ordered end as int) as to_be_planned,data0060.orig_sched_ship_date,data0060.sch_date,data0060.quote_price,data0050.eq_appl_date,data0050.eq_close_date,
data0060.sch_date-data0050.shelf_life as planned_date,data0060.reput_qty,data0060.so_oldnew,data0050.audited_date,DATA0050.bom_status,DATA0050.tstatus,
data0010.rkey as rkey10,data0060.parts_shipped+data0060.returned_ship as total_ship,data0060.qty_socx_plan,data0050.eq_status,
data0060.parts_returned,data0060.parts_ordered + data0060.parts_returned -data0060.parts_shipped - data0060.returned_ship as total_rq,
case when data0060.ttype=0 then '����' else '����' end as prod_type,data0060.ppc_remark,data0025.grs_sq,
case when data0060.status=2 then '�ݻ�' else '��Ч' end as sostatus, data0060.qty_cancel_plan,data0060.qty_reput,data0060.reference_number,data0025.product_name,
case when data0050.onhold_planning_flag=0 then 'Yes' end as MI,data0060.parts_ordered*data0050.unit_sq as so_sq,data0050.risk_info
FROM dbo.Data0060(nolock) 
INNER JOIN dbo.Data0010(nolock) ON   dbo.Data0060.CUSTOMER_PTR = dbo.Data0010.RKEY 
LEFT OUTER JOIN  dbo.Data0097(nolock) ON   dbo.Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.RKEY 
INNER JOIN dbo.Data0050(nolock) ON dbo.Data0060.CUST_PART_PTR = dbo.Data0050.RKEY 
LEFT OUTER JOIN dbo.data0059(nolock) ON  dbo.data0059.cust_part_ptr = dbo.Data0050.RKEY 
LEFT OUTER JOIN Vdata0025_ep052 as data0025 on data0025.ancestor_ptr=data0050.rkey
WHERE 
 (data0060.to_be_planned>0 or data0060.reput_qty>0 )  --��Ͷ������Ͷ����
 --and (data0060.so_style <> 2  or data0060.reput_qty>0)  
and (data0060.status<=2 or (data0060.status=4 and data0060.so_style=3))
--status 1 then '��Ч' when 2 then '�ݻ�' when 3 then '�ر�' when 4 then '���' when 5 then 'ȡ��' else ''
--0��ʽ����1��Ѷ���2 �˻�����3���϶���4�������5Ԥ���Ѷ���6�ڲ�����7��ʱ����8���۶���
and data0059.customer_ptr=data0060.customer_ptr
and data0060.so_tp in (0,2) 
--0����1�ⷢ2���Ƴ�
order by data0060.sch_date ,data0050.customer_part_number





--CREATE PROCEDURE EP052;19
declare
@vwhse_ptr varchar(10)='',
@vtype TINYINT=2,
@ontime TINYINT=0,  --�Ƿ���
@onhold TINYINT=0, -- �Ƿ�MI OK
@datetype TINYINT=2,  --��������
@date1 varchar(20)='2013-10-07',  --����1
@date2 varchar(20)='2013-11-06',  -- ����2
@vtp INT=0,
@vso_tp INT=0,
@order TINYINT=1  --����
--with encryption
--AS
declare @flag int
select @flag=isnull(ppc_control13,0) from data0192

declare @cond varchar(4000)
set @cond = '
declare @vflag int
select @vflag=isnull(ppc_control13,0) from data0192
SELECT data0050.layers,data0060.so_style,data0050.etest_tp,data0050.cnc_tp,data0010.cust_code,data0010.abbr_name,data0050.rkey,data0060.ent_date,data0050.cp_rev1,data0050.cp_rev2,data0060.ttype,
data0050.customer_part_number,data0050.cp_rev,data0050.onhold_planning_flag,data0060.conf_date,data0060.cust_part_ptr,
data0059.customer_part_desc,data0059.customer_matl_desc,data0060.sales_order,data0060.parts_ordered,data0060.sales_dept_list,data0060.fob,
data0060.PROD_REL,data0060.rkey as d060_RKEY,data0097.po_number,data0060.PUTHMAT_DESC,data0059.onhold_sales_flag,data0060.whse_ptr,data0060.so_tp,
case when data0050.usheet>0 then data0060.parts_ordered*data0050.psheet/data0050.usheet else 0 end as pnls_ordered,
data0060.qty_plannned,data0060.to_be_planned as orig_to_be_planned,cast(case when @vflag=0 then data0060.to_be_planned else data0060.to_be_planned+data0060.qty_sure-data0060.parts_ordered end as int) as to_be_planned,data0060.orig_sched_ship_date,data0060.sch_date,data0060.quote_price,data0050.eq_appl_date,data0050.eq_close_date,
data0060.sch_date-data0050.shelf_life as planned_date,data0060.reput_qty,data0060.so_oldnew,data0050.audited_date,DATA0050.bom_status,DATA0050.tstatus,
data0010.rkey as rkey10,data0060.parts_shipped+data0060.returned_ship as total_ship,data0060.qty_socx_plan,data0050.eq_status,
data0060.parts_returned,data0060.parts_ordered + data0060.parts_returned -data0060.parts_shipped - data0060.returned_ship as total_rq,
case when data0060.ttype=0 then ''����'' else ''����'' end as prod_type,data0060.ppc_remark,data0025.grs_sq,
case when data0060.status=2 then ''�ݻ�'' else ''��Ч'' end as sostatus, data0060.qty_cancel_plan,data0060.qty_reput,data0060.reference_number,data0025.product_name,
case when data0050.onhold_planning_flag=0 then ''Yes'' end as MI,data0060.parts_ordered*data0050.unit_sq as so_sq,data0050.risk_info
FROM dbo.Data0060(nolock) INNER JOIN
      dbo.Data0010(nolock) ON 
      dbo.Data0060.CUSTOMER_PTR = dbo.Data0010.RKEY LEFT OUTER JOIN
      dbo.Data0097(nolock) ON 
      dbo.Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.RKEY INNER JOIN
      dbo.Data0050(nolock) ON 
      dbo.Data0060.CUST_PART_PTR = dbo.Data0050.RKEY LEFT OUTER JOIN
      dbo.data0059(nolock) ON 
      dbo.data0059.cust_part_ptr = dbo.Data0050.RKEY LEFT OUTER JOIN
	Vdata0025_ep052 as data0025 on data0025.ancestor_ptr=data0050.rkey
WHERE '
if @vtp <>1 
  set @cond=@cond+'
 (data0060.to_be_planned>0 or data0060.reput_qty>0 )  
 --and (data0060.so_style <> 2  or data0060.reput_qty>0)  
and (data0060.status<=2 or (data0060.status=4 and data0060.so_style=3)) and data0059.customer_ptr=data0060.customer_ptr'
else
if @vtp =1 
  set @cond=@cond+'
 data0060.qty_cancel_plan>0 and data0060.so_style <> 2   
and (data0060.status<=2 or (data0060.status=4 and data0060.so_style=3)) and data0059.customer_ptr=data0060.customer_ptr'

if @ontime =1 
  set @cond=@cond+'
and data0060.sch_date-data0050.shelf_life <='''+convert(varchar(10),getdate(),102)+''''

if @vso_tp=0
  set @cond=@cond+'
and data0060.so_tp in (0,2)'
if @vso_tp=1
  set @cond=@cond+'
and data0060.so_tp = 0'
if @vso_tp=2
  set @cond=@cond+'
and data0060.so_tp = 2'
if @vso_tp=3
  set @cond=@cond+'
and data0060.so_tp = 1'

if @onhold =1 
  set @cond=@cond+'
and data0060.quote_price<>0 and data0060.quote_price<>2 and onhold_planning_flag = 0 and data0060.status=1 and data0060.sch_date is not null '
if @onhold =1 
if @flag=1  set @cond=@cond+' and data0060.prod_rel in (2,3) '

if @datetype =0 
  set @cond=@cond+'
and ent_date>='''+@date1+''' and ent_date<='''+ @date2+' 23:59:59'''

if @datetype =1
  set @cond=@cond+'
and data0060.sch_date>='''+@date1+''' and data0060.sch_date<='''+ @date2+' 23:59:59'''

if @vtype =0
 set @cond=@cond+' and data0060.ttype=0'
if @vtype =1
 set @cond=@cond+' and data0060.ttype=1'

if @vwhse_ptr<>'0' and @vwhse_ptr<>''	select @cond=@cond+'and (data0060.whse_ptr='+@vwhse_ptr+' or isnull(data0060.whse_ptr,0)=0)'

if @order = 0   
set @cond=@cond+'
order by 
data0060.sch_date-data0050.shelf_life-data0050.mfg_lead_time  ,
data0050.customer_part_number
'
if @order = 1   
set @cond=@cond+'
order by 
data0060.sch_date ,
data0050.customer_part_number'
exec (@cond)
PRINT (@cond)

go
