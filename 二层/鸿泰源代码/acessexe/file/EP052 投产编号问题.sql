EP052 Ͷ���������

����DATA0492.CUT_NO

��һ�����ð���������
exec sp_executesql N'select top 1 cut_no 
from data0492 
where cut_no like @P1
order by cut_no desc
',N'@P1 varchar(7)','1310%'

�����ָĻذ�����ˮ
exec sp_executesql N'select top 1 cut_no 
from data0492 
where cut_no like @P1
order by len(cut_no) desc,cut_no desc
',N'@P1 varchar(7)','140217%'

��ֻҪ��һ��140217009��05��ʽ,������140217009��5
���������е�9��Ͷ�����ţ��������ֻҪ�鵽���ֵ��140217009��05��������
û�취֪��Ϊʲô��140217009��05��ʽ


exec sp_executesql N'select top 1 cut_no 
from data0492 
where cut_no like @P1
order by len(substring(cut_no,1,patindex(''%-%'',cut_no))) desc,cut_no desc
',N'@P1 varchar(7)','131012%'  