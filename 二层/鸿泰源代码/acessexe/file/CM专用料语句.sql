CMר�������
/*����ר�����б�*/
select rkey into #tmplist from
(
    select Data0017.rkey from data0496
	inner join Data0017 on data0496.rkey=data0017.GROUP_PTR
	where isnull(data0496.DEP_Flag,0)=0 
    and isnull(data0017.dptuserflag,0)=0--�Ȳ��������ר����Ҳ���ǵ���ר����
    union all--���ר����
	select Data0017.rkey from data0496 
	inner join Data0837 on data0496.rkey=data0837.key496
	inner join Data0017 on data0496.rkey=data0017.GROUP_PTR
	where data0837.key34=@dept_id 
    and data0496.DEP_Flag=1
	union all--����ר����
	select data0017.rkey from data0017 
	inner join Data0837 on Data0837.rkey17=data0017.rkey
	where Data0837.key34=@dept_id 
    and data0017.dptuserflag=1
) invtmplist