--EXEC EP100;48 36872
DECLARE @vptr INT

SET @vptr = 36872   /* ����ָ�� */
BEGIN
	SELECT *
	FROM   DATA0029
	WHERE  source_ptr      = @vptr
	       AND flow_no     = 0
	ORDER BY
	       SEQ_NO
END
DATA0029 ��ס���ä��� FLOW_NO���ֵ�
DATA0229������Ƭ���
DATA0230�൶
