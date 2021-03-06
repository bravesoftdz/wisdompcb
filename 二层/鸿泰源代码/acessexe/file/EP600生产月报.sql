--EP600生产月报
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


ALTER proc [dbo].[ep6007_wip_over]
(
@VWhere1 int=1,
@Vdate1 datetime,
@Vdate2 datetime
)
as
--上月盘点
select cast(data0010.cust_code as varchar(10))cust_code,data0050.customer_part_number+data0050.cp_rev part_no,
  data0050.set_x_qty*data0050.set_y_qty set_qty,data0047.parameter_value,
  cast(data0401.physical_count_qty as float) physical_qty,
  cast(data0401.physical_count_qty*data0047.parameter_value as float) physical_sq,
  cast(0 as float) issued_qty,cast(0 as float) issued_sq,
  cast(0 as float) instock_qty,cast(0 as float) instock_sq,
  cast(0 as float) reject_qty,cast(0 as float) reject_sq,
  cast(0 as float) physical_qty_t,cast(0 as float) physical_sq_t,
  cast(0 as float) over_qty,cast(0 as float) over_sq
 into #temp
from data0401
left join data0006 on data0006.rkey=data0401.wo_ptr
left join data0025 on data0025.rkey=data0006.bom_ptr
left join data0047 on data0047.source_pointer=data0025.rkey and data0047.parameter_ptr=7
left join data0050 on data0050.rkey=data0025.ancestor_ptr
left join data0059 on data0059.cust_part_ptr=data0050.rkey
left join data0010 on data0010.rkey=data0059.customer_ptr
inner join data0400 on data0400.rkey=data0401.header_ptr
where CONVERT(varchar(10),data0400.ent_date,111)=CONVERT(varchar(10),@VDate1,111)



--本月投产
insert into #temp
select data0010.cust_code,data0050.customer_part_number+data0050.cp_rev part_no,
  data0050.set_x_qty*data0050.set_y_qty set_qty,data0047.parameter_value,0,0,
  data0492.issued_qty,
  data0492.issued_qty*data0047.parameter_value issued_sq,0,0,0,0,0,0,0,0
from data0492
left join data0025 on data0025.rkey=data0492.bom_ptr
left join data0047 on data0047.source_pointer=data0025.rkey and data0047.parameter_ptr=7
left join data0050 on data0050.rkey=data0025.ancestor_ptr
left join data0059 on data0059.cust_part_ptr=data0050.rkey
left join data0010 on data0010.rkey=data0059.customer_ptr
where data0492.issue_date>=@VDate1 and data0492.issue_date<=@vdate2


--本月生产入仓
insert into #temp
select data0010.cust_code,data0050.customer_part_number+data0050.cp_rev part_no,
  data0050.set_x_qty*data0050.set_y_qty set_qty,data0047.parameter_value,0,0,0,0,
  data0053.quantity,
  data0053.quantity*data0047.parameter_value instock_sq,0,0,0,0,0,0
from data0053
left join data0006 on data0006.rkey=data0053.work_order_ptr
left join data0025 on data0025.rkey=data0006.bom_ptr
left join data0047 on data0047.source_pointer=data0025.rkey and data0047.parameter_ptr=7
left join data0050 on data0050.rkey=data0025.ancestor_ptr
left join data0059 on data0059.cust_part_ptr=data0050.rkey
left join data0010 on data0010.rkey=data0059.customer_ptr
join data0060 on data0006.so_ptr=data0060.rkey and data0060.customer_ptr=data0010.rkey
where data0053.rma_ptr=0 and data0053.mfg_date>=@vdate1 and data0053.mfg_date<=@vdate2


--本月生产报废
insert into #temp
select data0010.cust_code,data0050.customer_part_number+data0050.cp_rev part_no,
  data0050.set_x_qty*data0050.set_y_qty set_qty,data0047.parameter_value,0,0,0,0,0,0,
  data0058.qty_org_rej reject_qty,
  data0058.qty_org_rej*data0047.parameter_value reject_sq,0,0,0,0
from data0058
left join data0006 on data0006.rkey=data0058.wo_ptr
left join data0025 on data0025.rkey=data0006.bom_ptr
left join data0047 on data0047.source_pointer=data0025.rkey and data0047.parameter_ptr=7
left join data0050 on data0050.rkey=data0025.ancestor_ptr
left join data0059 on data0059.cust_part_ptr=data0050.rkey
left join data0010 on data0010.rkey=data0059.customer_ptr
join data0060 on data0006.so_ptr=data0060.rkey and data0060.customer_ptr=data0010.rkey
where data0058.tdatetime>=@vdate1 and data0058.tdatetime<=@vdate2

--本月盘点
insert into #temp
select data0010.cust_code,data0050.customer_part_number+data0050.cp_rev part_no,
  data0050.set_x_qty*data0050.set_y_qty set_qty,data0047.parameter_value,
  0,0,0,0,0,0,0,0,
  data0401.physical_count_qty physical_qty_t,
  data0401.physical_count_qty*data0047.parameter_value physical_sq_t,
  data0401.wip_system_qty-data0401.physical_count_qty over_qty,
  (data0401.wip_system_qty-data0401.physical_count_qty)*data0047.parameter_value over_sq
from data0401
left join data0006 on data0006.rkey=data0401.wo_ptr
left join data0025 on data0025.rkey=data0006.bom_ptr
left join data0047 on data0047.source_pointer=data0025.rkey and data0047.parameter_ptr=7
left join data0050 on data0050.rkey=data0025.ancestor_ptr
left join data0059 on data0059.cust_part_ptr=data0050.rkey
left join data0010 on data0010.rkey=data0059.customer_ptr
inner join data0400 on data0400.rkey=data0401.header_ptr
where CONVERT(varchar(10),data0400.ent_date,111)=CONVERT(varchar(10),@VDate2,111)

select cust_code 代码,part_no 产品编号,set_qty 拼联,parameter_value 单只净面积,
sum(physical_qty)'上月结转|数量',round(sum(physical_sq),4)'上月结转|面积',
sum(issued_qty)'本月投入|数量',round(sum(issued_sq),4)'本月投入|面积',
sum(instock_qty)'入库|数量',round(sum(instock_sq),4)'入库|面积',
sum(reject_qty)'报废|数量',round(sum(reject_sq),4)'报废|面积',
sum(physical_qty_t)'本月结转|数量',round(sum(physical_sq_t),4)'本月结转|面积',
sum(over_qty)'盈亏|数量',round(sum(over_sq),4)'盈亏|面积'
 from #temp group by cust_code,part_no,set_qty,parameter_value
order by cust_code,part_no,set_qty
drop table #temp


--select * from data0401

