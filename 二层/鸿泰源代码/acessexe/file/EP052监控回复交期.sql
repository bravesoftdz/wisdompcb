ep052����ظ����ڲ��Եļ����
����ֻؽ���Ϊ1899-12-30
����SMALLDATETIME����
alter TRIGGER Data0360schdate
ON data0360
FOR  UPDATE
AS
	IF 
	    UPDATE (sch_date)
	
	BEGIN
		DECLARE @old_value DATETIME
		DECLARE @new_vale DATETIME
		
		SELECT @new_vale = sch_date
   
		FROM   INSERTED
		
		SELECT @old_value = sch_date
   
		FROM   deleted		
		
		IF (@old_value IS NOT NULL) and  (@new_vale IS  NULL)
		BEGIN
		    SELECT *
		    FROM   DATA0360��������ʾ,�Ƿ��޸Ļظ�����,����ϵ����Ա
		END;

				
	END;