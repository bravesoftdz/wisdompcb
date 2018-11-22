-- EP100;56 
DECLARE @vptr1 INT
DECLARE @vptr2 INT

SET @vptr1 = 36872   /* ����RKEY */
SET @vptr2 = 36872
DECLARE @vflag INT
SELECT @vflag = ISNULL(mi_rpt_sort_flag, 0)
FROM   data0195

PRINT @vflag

-- mi_rpt_sort_flag  ���ƿ���,MI����ȫ�ֲ���˳���Ƿ񵥶����� 
-- 0 ���������� 1 ��������

IF @vflag = 0
    SELECT data0278.mark,
           data0278.sequence_no,
           data0278.parameter_desc,
           CONVERT(CHAR(30), Data0047.PARAMETER_VALUE) AS parameter_value,
           data0278.production_flag,
           data0002.unit_name AS unit_code,
           data0002.rkey
    FROM   data0002,	--��λ��
           data0277,	--�������ͱ�
           data0278 --������ϸ��
           
           LEFT OUTER JOIN data0047 --����������
                ON  data0047.source_pointer = @vptr1
                AND data0047.parameter_ptr = data0278.rkey
    WHERE  data0278.category_ptr = data0277.rkey
           AND data0277.category_type = 1
               --category_type 1-������λ;2-ȫ�ֲ���;3-����
           AND data0278.unit_ptr = data0002.rkey
           AND data0278.status = 0
    --STATUS	����ʾ��MI(ȫ�ֲ���)  0��ʾ  1����ʾ
    
    UNION

SELECT data0278.mark,
       data0278.sequence_no,
       data0278.parameter_desc,
       data0279.parameter_value,
       data0279.production_flag,
       data0002.unit_name AS unit_code,
       data0002.rkey
FROM   data0277,	--�������
       data0002,	--��λ
       data0278,	--���̲���
       data0279 --ȫ�ֲ���IES����
WHERE  data0278.category_ptr = data0277.rkey
       AND data0277.category_type = 2
           --category_type 1-������λ;2-ȫ�ֲ���;3-����
       AND data0278.unit_ptr = data0002.rkey
       AND data0278.status = 0
           --STATUS	����ʾ��MI(ȫ�ֲ���)  0��ʾ  1����ʾ
       AND data0279.parameter_ptr = data0278.rkey
       AND data0279.ies_prod = 1
           --  data0279.ies_prod (0:����ȫ�ֲ���;1:ȫ�ֲ���)
       AND data0279.source_ptr = @vptr2
ORDER BY
       data0278.mark,
       data0278.sequence_no,
       data0278.parameter_desc

IF @vflag = 1
    SELECT data0278.mark,
           data0278.rpt_sequence_no,
           data0278.parameter_desc,
           CONVERT(CHAR(30), Data0047.PARAMETER_VALUE) AS parameter_value,
           data0278.production_flag,
           data0002.unit_name AS unit_code,
           data0002.rkey
    FROM   data0002,	--��λ
           data0277,	--�������
           data0278 --������ϸ
           
           LEFT OUTER JOIN data0047 -- ��Ʒ��������������(ÿ����ͬ�Ĺ�˾��������������˳��ģ�
                ON  data0047.source_pointer = @vptr1
                AND data0047.parameter_ptr = data0278.rkey
    WHERE  data0278.category_ptr = data0277.rkey
           AND data0277.category_type = 1
               --category_type 1-������λ;2-ȫ�ֲ���;3-����
           AND data0278.unit_ptr = data0002.rkey
           AND data0278.status = 0
    --STATUS	����ʾ��MI(ȫ�ֲ���)  0��ʾ  1����ʾ
    UNION

SELECT data0278.mark,
       data0278.rpt_sequence_no,
       data0278.parameter_desc,
       data0279.parameter_value,
       data0279.production_flag,
       data0002.unit_name AS unit_code,
       data0002.rkey
FROM   data0277,
       data0002,
       data0278,
       data0279 ---ȫ�ֲ���IES����
WHERE  data0278.category_ptr = data0277.rkey
       AND data0277.category_type = 2
           --category_type 1-������λ;2-ȫ�ֲ���;3-����
       AND data0278.unit_ptr = data0002.rkey
       AND data0278.status = 0
           --STATUS	����ʾ��MI(ȫ�ֲ���)  0��ʾ  1����ʾ
       AND data0279.parameter_ptr = data0278.rkey
       AND data0279.ies_prod = 1
           --  data0279.ies_prod (0:����ȫ�ֲ���;1:ȫ�ֲ���)
       AND data0279.source_ptr = @vptr2
ORDER BY
       data0278.rpt_sequence_no,
       data0278.parameter_desc
