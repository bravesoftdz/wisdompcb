------�ų�---�Ѿ���
SELECT data0028.exp_flag,DATA0028.ACTIVE_FLAG, Data0028.[status], * FROM Data0028 
JOIN data0023 ON data0028.SUPPLIER_PTR=data0023.RKEY 
JOIN data0017 ON data0028.INVENTORY_PTR=data0017.RKEY
WHERE data0023.CODE='BAZJ' --�ͻ�����
AND data0017.INV_PART_NUMBER IN ('199-02-020','199-02-054','199-02-126')--���ϱ��
                                         --DATA0028.ACTIVE_FLAG 0��ʾ��Ч��1��Ч �����ܵ����ɹ���������PR������ôҪ��ģ� û�⵽
                                         --status 0��δ�ύ��1������2������3���˻�,���޸ģ��ٰ�����ص�δ�ύ��
                                         --exp_flag 0��������1��ʧЧ��  
--UPDATE data0028 SET ACTIVE_FLAG = 1 WHERE RKEY=14988
--SELECT * FROM data0073 WHERE RKEY=294  


-----��Ӧ��---�Ѿ���
SELECT supplier_active_flag,--���״̬ 0��δ��1���˻أ�2������3������4:�����
Sup_Type, --supplier_active_flag,0����ʽ��1�����ã�û�⵽
isbad,          --0 ������2����
*  FROM data0023  

--------������Ŀ
SELECT CONF_FLAG,--��˱�־,0δ�ˣ�1�����,2�˻أ�3����ˣ�ȡ���ύ�ص�0
STOP_PURCH --ֹͣ�ɹ�Y��N����
,* FROM data0017                                