--ͨ�����ϲ�WIP�̵����
select data0058.mrb_no,data0058.PANELS ,data0058.QTY_ORG_REJ ,data0400.wip_code �̵����
from data0058
join Data0401 on data0058.wo_ptr=data0401.wo_ptr
join data0400 on data0401.header_ptr =data0400.rkey
where data0058.MRB_NO like '1305310009'--���ϵ���