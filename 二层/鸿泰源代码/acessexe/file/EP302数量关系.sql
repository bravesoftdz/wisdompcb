EP302������ϵ
parts_margin (��Ƿ�ƻ�װ������)=Data0060.PARTS_ORDERED(��������)-Data0060.PARTS_SHIPPED(��������=������+��װ+��Ʒ)+Data0060.quan_to_re_delivery(�˻��貹����)-Data0060.returned_ship(�˻��ѽ�����)  
parts_margin2(�ܾ�Ƿ������)    =Data0060.PARTS_ORDERED(��������)-Data0060.PARTS_SHIPPED(��������=������+��װ+��Ʒ)+Data0060.quan_to_re_delivery(�˻��貹����)-Data0060.returned_ship(�˻��ѽ�����) + part_ovsh(������ָ����װ����)  
ship_size(�����ߴ缰��ʽ)=LTRIM(STR(data0050.set_lngth, 18, 2)) + 'mm*' + LTRIM(STR(data0050.set_width, 18, 2)) + 'mm' + '(/' + LTRIM(STR(data0050.set_x_qty * data0050.set_y_qty, 8, 0)) + ')'
Strips_order��������(SET)=data0060.PARTS_ORDERED / NULLIF(data0050.set_y_qty, 0) / NULLIF(data0050.set_x_qty, 0)
ROUND(parts_ordered * part_price + TOTAL_ADD_L_PRICE, 4) AS SO_Sum_money --�����ܷ���=�������+�������
                                                                         --
                                                                         
 
 EP032��Ƿ���������⼸���ֶμ���İ���������-�ѽ���������������Ʒ����װ��+�˻��貹����-�˻��ѽ�����+��ָ����װ����(������Ʒ��


part_ovsh=(CONVERT([int],(isnull([ovsh_qty1],(0))+isnull([Returned_ovsh],(0)))+isnull([Spare_shipped],(0)),(0)))





 Data0060.PARTS_ORDERED-Data0060.PARTS_SHIPPED+Data0060.quan_to_re_delivery-Data0060.returned_ship as parts_margin

EP032��Ƿ�ƻ�װ���������⼸���ֶμ���İ���������-�ѽ���������������Ʒ����װ��+�˻��貹����-�˻��ѽ�����

                                                                        