DATA0502�������ϣ�DATA0503�����Ϲ��
SELECT data0502.*,
       data0202.* 
FROM   data0502
       LEFT OUTER JOIN data0202
            ON  data0502.rkey = data0202.rkey502_ptr
WHERE  data0502.source_ptr = 36872
