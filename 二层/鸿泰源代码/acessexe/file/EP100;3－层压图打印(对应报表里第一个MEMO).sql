--exec EP100;3 36872
44���ǲ�ѹ����ͼ ��46���ǲ�ѹͼ���������Ϣ��552���ǲ�ѹʾ��ͼSOURCE_PTR=50���RKEY 554��ѹ�Ű�ͼ 564

-- ��ѹ��ӡ�Ļ�������ʾ�ڵ�һ�����ڽ������MEMO�ؼ���

--MI��ѹʾ��ͼ ���÷�ʽ EP100;3
--eng_press_instr_flag  (0 �Բ�Ʒ �� 1 �Բ�����
-- DATA0046  ѹ����Ϣ��
DECLARE @vflag INT
SELECT @vflag = eng_press_instr_flag
FROM   data0195;

PRINT @vflag;

IF @vflag = 0
    SELECT DATA0046.*
    FROM   data0046
    WHERE  srce_ptr IN (SELECT rkey
                        FROM   DATA0025
                        WHERE  DATA0025.ANCESTOR_PTR = 1844)  --��Ʒ�ͺ�ָ��

IF @vflag = 1
    SELECT DATA0046.*
    FROM   data0046
    WHERE  srce_ptr = 36872  --����ָ��
