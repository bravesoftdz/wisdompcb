EP100mi���������ӡ
--exec EP100;57 279318,''
-CREATE PROCEDURE EP100;57
DECLARE 
@rkey int,
@vptr varchar(30)
-with encryption
-AS
SELECT @rkey=279318,@vptr=''
IF @vptr=''
select data0278.parameter_desc,data0494.parameter_value,data0002.unit_name as unit_code,
data0002.rkey,data0494.production_flag
 from data0278,data0002,Data0494 left join data0506 on 
 data0506.rkey=data0494.source_ptr
where data0494.route_step_ptr=@rkey  --ָ��38��RKEY
and data0494.parameter_ptr=data0278.rkey
--and data0506.doc_flag='Y' 
and (data0506.doc_flag='Y' or isnull(data0506.rkey,0)=0)  --�������ʾ��ǰ����Ŀǰ����Ҫ�Ĳ���
and data0002.rkey=data0278.unit_ptr
and data0494.parameter_value<>@vptr
--and data0494.parameter_value<>'0'
ORDER BY 
data0506.seq_no
IF @vptr<>''
select data0278.parameter_desc,data0494.parameter_value,data0002.unit_name as unit_code,
data0002.rkey,data0494.production_flag
 from data0278,data0002,Data0494 left join data0506 on 
 data0506.rkey=data0494.source_ptr 
where data0494.route_step_ptr=@rkey
and data0494.parameter_ptr=data0278.rkey
--and data0506.doc_flag='Y' 
and (data0506.doc_flag='Y' or isnull(data0506.rkey,0)=0)  --�������ʾ��ǰ����Ŀǰ����Ҫ�Ĳ���
and data0002.rkey=data0278.unit_ptr
ORDER BY 
data0506.seq_no
go

-----------------------------
���ɾ�������������MI��Ĭ���ǲ���ʾ��
������룬�������ӣ����޸�494��ص�ָ�뵽�µ�ָ
EP062�Ƴ̲���

SELECT * FROM data0034 WHERE rkey=348

select data0278.rkey,data0278.parameter_name,data0278.parameter_desc,data0506.* from data0506
LEFT join data0278 ON data0506.parameter_ptr=data0278.rkey
where data0506.ttype=3 and data0506.source_ptr=348 --data0034.rkey����
ORDER by seq_no

UPDATE data0494 SET SOURCE_PTR=1372 --�µ�506��RKEY
WHERE PARAMETER_PTR=925 --278����RKEY

