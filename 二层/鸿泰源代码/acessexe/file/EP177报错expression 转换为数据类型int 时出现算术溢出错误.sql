EP177����expression ת��Ϊ��������int ʱ���������������

������100 * isnull(Data0060.ISSUED_QTY,0)����INT��Χ
create PROCEDURE EP177;1 
case when (data0060.parts_ordered>0) then round(100 * isnull(Data0060.ISSUED_QTY,0)/data0060.parts_ordered,2) else 0 end as ratio1,
��Ϊ
case when (data0060.parts_ordered>0) then round(isnull(Data0060.ISSUED_QTY,0)/data0060.parts_ordered,4)*100 else 0 end as ratio1,