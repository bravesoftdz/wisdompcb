--EP082�������
exec EP082;40 13288,13893 --�ɱ���İ汾

SELECT * FROM data0006 WHERE rkey=24538 --����
SELECT data0056.*
from data0056
WHERE data0056.rkey=35887 --������Ϣ
                          --
Select data0034.rkey,data0034.dept_name --�ɱ��λ�ú�һ����
From Data0034 t1 
left JOIN  Data0034 on t1.dept_ptr=Data0034.dept_ptr
Where data0034.ttype=2
  and t1.Rkey=361
  
exec EP082;42 13288  --����
go
exec EP082;41 13902,0 --����
GO
--����ֵ���56��QTY_BACKLOG��0��TO_BE_STOCKED=������53�� QUANTITY=������QTY_ON_HNAD=0
--�����ˣ�56��TO_BE_STOCKED��0��53��QTY_ON_HNAD������
--�´ν�����������ɾ��QTY_BACKLOG��0��TO_BE_STOCKED��0�ļ�¼


