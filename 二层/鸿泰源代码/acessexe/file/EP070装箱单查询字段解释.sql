װ�˲ο����������ROUND((Data0064.QUAN_SHIPPED + Data0064.ovsh_qty) * Data0050.unit_sq, 4) AS JingMianJi,--JingMianJiװ�˲ο����  ��װ�˵�����,��װ����,ȡ50������
װ��ë���round((Data0064.QUAN_SHIPPED+data0064.ovsh_qty) * a.PARAMETER_value,4)  AS mianji_tot,--��װ�˵�����,��װ����,MIƽ����(����) 
��Ԫ�ο���� round(Data0050.unit_sq,6) as DYMianJi,ȡ50������
��Ԫë���round(a.parameter_value,4) as unit_area, ƽ����(����)SQMT      
��Ԫ�����ROUND(C.PARAMETER_value,4) AS DYJMJ,ƽ����(����)SQMT2
װ�˾����������װ��round((Data0064.QUAN_SHIPPED+data0064.ovsh_qty) * C.PARAMETER_value,4)  AS JMJ_tot   
װ�˾����������װ��round(Data0064.QUAN_SHIPPED * C.PARAMETER_value,4)  AS JMJ_ship,--װ�˾����������װ  
                                                                                       