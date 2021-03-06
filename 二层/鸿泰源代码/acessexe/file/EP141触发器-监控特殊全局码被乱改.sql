ALTER TRIGGER Data0004Update
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
				IF RTRIM(@SEED_MEAN) = 'RMA 代码'
		   AND CHARINDEX('RMA', @NEW_SEED_VALUE) = 0
		BEGIN
		    SELECT *
		    FROM   RMA代码必须为RMA开头
		END;
		
				IF RTRIM(@SEED_MEAN) = 'MRB处理编号'
		   AND CHARINDEX('MRB', @NEW_SEED_VALUE) = 0
		BEGIN
		    SELECT *
		    FROM   MRB处理编号必须为MRB开头
		END;
	END ;                     