SELECT STATUS,--״̬1-8 ,8δ�ύ 1,�����,2���˻�,5�Ѿ����,������˻ص������״̬
SECOND_WHSE_PTR,--��ǰ����û�              --
 * FROM Data0070 
 
 select STATUS ,* from Data0070 where PO_NUMBER like 'PUR13-05-0075'

UPDATE Data0070 SET STATUS=5 where PO_NUMBER like 'PUR13-05-0075'--�ɹ�����

select RKEY,STATUS,* from data0071 where PO_PTR  ( SELECT RKEY where PO_NUMBER like 'PUR13-05-0075'--�ɹ�����)
�ٰ�71���status=0�Ϳ����йر���