--exec EP100;132 36872  -- FLOW_NO-��ס���ä���   (0-1�ꡢ1-2��\2-3��\3-��ä1�ꡢ4-��ä2��)
DECLARE @vptr INT

BEGIN
	SELECT *
	FROM   DATA0029
	WHERE  source_ptr = @vptr
	       AND flow_no >= 1
	ORDER BY
	       flow_no,
	       SEQ_NO
END

DATA0029 ��ס���ä��� FLOW_NO���ֵ�
DATA0229������Ƭ���
DATA0230�൶
