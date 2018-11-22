set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER proc [dbo].[SP_HMFS_CUSTQUERY_110]
(
@VWhere1 int=1
)
as
select identity(int,1,1)as P,t2.rkey,data0419.description as menu,t1.description as menu1,t2.description as module,t2.program 
into #module_name 
from data0419
left join data0419 t1 on t1.ancestor_ptr=data0419.rkey 
left join data0419 t2 on t2.parent_ptr=t1.rkey
where data0419.ttype=1 and t1.ttype=2 
order by data0419.seq_no,t1.seq_no
select data0073.USER_ID,data0073.USER_full_name,menu,menu1,module,program,
       case substring(right_value_str,1,1) when 1 then 'Y'
            when 0 then 'N' end as ��Ч, 
       case substring(right_value_str,2,1) when 1 then 'Y'
            when 0 then 'N' end as ����,
       case substring(right_value_str,3,1) when 1 then 'Y'
            when 0 then 'N' end as ����, 
       case substring(right_value_str,4,1) when 1 then 'Y'
            when 0 then 'N' end as �޸�, 
       case substring(right_value_str,5,1) when 1 then 'Y'
            when 0 then 'N' end as ɾ��, 
       case substring(right_value_str,6,1) when 1 then 'Y'
            when 0 then 'N' end as �ύ, 
       case substring(right_value_str,7,1) when 1 then 'Y'
            when 0 then 'N' end as ���,
       case substring(right_value_str,8,1) when 1 then 'Y'
            when 0 then 'N' end as �˻�, 
       case substring(right_value_str,9,1) when 1 then 'Y'
            when 0 then 'N' end as ����, 
       case substring(right_value_str,10,1) when 1 then 'Y'
            when 0 then 'N' end as ��ӡ, 
       case substring(right_value_str,11,1) when 1 then 'Y'
            when 0 then 'N' end as �������, 
       case substring(right_value_str,12,1) when 1 then 'Y'
            when 0 then 'N' end as ��չ1, 
       case substring(right_value_str,13,1) when 1 then 'Y'
            when 0 then 'N' end as ��չ2, 
       case substring(right_value_str,14,1) when 1 then 'Y'
            when 0 then 'N' end as ��չ3, 
       case substring(right_value_str,15,1) when 1 then 'Y'
            when 0 then 'N' end as ��չ4, 
       case substring(right_value_str,16,1) when 1 then 'Y'
            when 0 then 'N' end as ��չ5
from data0074
inner join #module_name on data0074.FUNCTION_ID=#module_name.rkey
left join data0073 on data0074.user_ptr=data0073.rkey
where USER_RIGHTS<>0 and data0073.active_flag<>'1'
order by #module_name.p
drop table #module_name

