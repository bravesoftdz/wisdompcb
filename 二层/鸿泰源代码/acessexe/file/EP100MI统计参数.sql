--MIͳ�Ʋ���
select PARAMETER_VALUE,* from Data0047
join Data0278 on data0047.PARAMETER_PTR=Data0278.rkey
where data0278.SPEC_RKEY in ('L') --D���������L�������
and SOURCE_POINTER in(
select data0025.RKEY from data0050
join Data0025 on data0025.ANCESTOR_PTR=data0050.RKEY and data0025.PARENT_PTR=0
where data0050.RKEY= 3575--�������
)


select SPEC_RKEY,* from data0278 where spec_rkey >='A' and  spec_rkey <='L' order by 1 --D���������L�������
