--ep004特殊入仓单号被改触发器
CREATE TRIGGER Data0004Update
ON data0004
FOR  UPDATE
AS
	IF 
	    UPDATE (SEED_VALUE)
	
	BEGIN
		DECLARE @NEW_SEED_VALUE VARCHAR(30) 
		DECLARE @SEED_MEAN VARCHAR(30) 
		
		SELECT @NEW_SEED_VALUE = SEED_VALUE,
		       @SEED_MEAN = SEED_MEAN
		FROM   INSERTED
		
		IF RTRIM(@SEED_MEAN) = '成品特殊入仓单码'
		   AND CHARINDEX('SG', @NEW_SEED_VALUE) = 0
		BEGIN
		    SELECT *
		    FROM   成品特殊入仓单码必须为SG开头
		END;
	END ;                     