--exec EP100;105 36872 �൶�ߴ�
DECLARE @vptr INT
SET @vptr = 36872 
BEGIN
	SELECT *
	FROM   DATA0230
	WHERE  source_ptr = @vptr --data0025.rkey
	ORDER BY
	       SEQ_NO
END

DATA0029 ��ס���ä��� FLOW_NO���ֵ�
DATA0229������Ƭ���
DATA0230�൶
