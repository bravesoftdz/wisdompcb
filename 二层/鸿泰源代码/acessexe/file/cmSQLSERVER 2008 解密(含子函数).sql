ר�ù���Աadmin:.          admin:������\ʵ����
����1����������0���� 
1\exec DecryProc �洢������,1
2\exec DecryProc �洢������,0

ALTER PROCEDURE [dbo].[DecryProc]
(@procedure SYSNAME = NULL, @revfl INT = 1)
AS
	/**//*
	���ɻԷ�������ת����ע������΢��BI������www.windbi.com
	������ʽΪ��
	exec dbo.sp__windbi$decrypt @procedure,0
	����ڶ�������ʹ��1�Ļ���������ô洢���̵�һЩ��ʾ��
	--�汾4.0  �����洢���̹������ܳ����ǿհ׵�����
	*/
	SET NOCOUNT ON
	IF @revfl = 1
	BEGIN
	    PRINT '���棺�ô洢���̻�ɾ�����ؽ�ԭʼ�Ĵ洢���̡�'
	    PRINT ' �����иô洢����֮ǰȷ��������ݿ���һ�����ݡ�'
	    PRINT ' �ô洢����ͨ��Ӧ�������ڲ�Ʒ������һ�����ݵķǲ�Ʒ�����¡�'
	    PRINT ' Ϊ����������洢���̣�������@refl��ֵ����Ϊ0��'
	    RETURN 0
	END
	
	DECLARE @intProcSpace       BIGINT,
	        @t                  BIGINT,
	        @maxColID           SMALLINT,
	        @procNameLength     INT
	
	SELECT @maxColID = MAX(subobjid)
	FROM   sys.sysobjvalues
	WHERE  objid = OBJECT_ID(@procedure)  /* @maxColID = 2  */
	--select @maxColID as 'Rows in sys.sysobjvalues'
	
	DECLARE @real_01 NVARCHAR(MAX)
	DECLARE @fake_01 NVARCHAR(MAX)
	DECLARE @fake_encrypt_01 NVARCHAR(MAX)
	DECLARE @real_decrypt_01 NVARCHAR(MAX),
	        @real_decrypt_01a NVARCHAR(MAX)
	
	DECLARE @objtype        VARCHAR(2),
	        @ParentName     NVARCHAR(MAX)
	
	SELECT @real_decrypt_01a = ''
	--��ȡ������������Ǵ洢���̻��Ǻ���������Ǵ���������Ҫ�õ��丸���������
	SELECT @objtype = TYPE,
	       @parentname     = OBJECT_NAME(parent_object_id)
	FROM   sys.objects
	WHERE  [object_id]     = OBJECT_ID(@procedure)
	-- ��sys.sysobjvalues��������ܵ�imageval��¼
	-- 
		--����һ����ʱ��
	CREATE TABLE #output
	(
		[ident]            [int] IDENTITY(1, 1) NOT NULL,
		[real_decrypt]     NVARCHAR(MAX)
	)
	CREATE TABLE #CommentText
	(
		LineId     INT,
		TEXT       NVARCHAR(255) COLLATE database_default
	)
	
		DECLARE myc1 CURSOR  
	FOR
	 	        SELECT  imageval
	        FROM   sys.sysobjvalues
	        WHERE  objid            = OBJECT_ID(@procedure)
	               AND valclass     = 1
	        ORDER BY
	               subobjid asc 
	               
	DECLARE @dbname              SYSNAME,
	        @BlankSpaceAdded     INT,
	        @BasePos             INT,
	        @CurrentPos          INT,
	        @TextLength          INT,
	        @LineId              INT,
	        @AddOnLen            INT,
	        @LFCR                INT --�س����еĳ���
	        ,
	        @DefinedLength       INT,
	        @SyscomText          NVARCHAR(MAX),
	        @Line                NVARCHAR(MAX)
	        
	SELECT @LFCR = 2
	SELECT @LineId = 1    
	    
	open  myc1   
	declare  @p1 int 
	set @p1 = 0   

	          
	--FETCH NEXT FROM myc1 INTO @real_01
	--WHILE @@fetch_status >= 0 
	--begin
	--print @p1
	--set @p1 = @p1 + 1 ;
	--BEGIN TRAN
	--end ;    
	--��ʼһ�������Ժ�ع�
	BEGIN TRAN
	     
	FETCH NEXT FROM myc1 INTO @real_01
	WHILE @@fetch_status >= 0          
	BEGIN
		
    --IF @p1= 0  FETCH NEXT FROM myc1 INTO @real_01 ;
	print @p1
	set @p1 = @p1 + 1 ;


	print '1' + convert(varchar,@real_01)  + '2'   
	SELECT @procNameLength = DATALENGTH(@procedure + ';' + CONVERT(VARCHAR,@p1)) + 29
	--SET @real_01 = (
	--        SELECT TOP 1 imageval
	--        FROM   sys.sysobjvalues
	--        WHERE  objid            = OBJECT_ID(@procedure)
	--               AND valclass     = 1
	--        ORDER BY
	--               subobjid asc 
	--    )
	


	--����ԭʼ�Ĵ洢���̣��ö̺����滻
	IF @objtype = 'P'
	    SET @fake_01 = 'ALTER PROCEDURE ' + @procedure  + ';'+ CONVERT(VARCHAR,@p1) +
	        ' WITH ENCRYPTION AS select 1
  /**//*' + REPLICATE(
	            CAST('*'AS NVARCHAR(MAX)),
	            DATALENGTH(@real_01) / 2 - @procNameLength
	        ) + '*/'
	ELSE 
	IF @objtype = 'FN'
	    SET @fake_01 = 'ALTER FUNCTION ' + @procedure + 
	        '() RETURNS INT WITH ENCRYPTION AS BEGIN RETURN 1
  /**//*' + REPLICATE(
	            CAST('*'AS NVARCHAR(MAX)),
	            DATALENGTH(@real_01) / 2 - @procNameLength
	        ) + '*/ END'
	ELSE 
	IF @objtype = 'V'
	    SET @fake_01 = 'ALTER view ' + @procedure + ';'+CONVERT(VARCHAR,@p1) +
	        ' WITH ENCRYPTION AS select 1 as col
  /**//*' + REPLICATE(
	            CAST('*'AS NVARCHAR(MAX)),
	            DATALENGTH(@real_01) / 2 - @procNameLength
	        ) + '*/'
	ELSE 
	IF @objtype = 'TR'
	    SET @fake_01 = 'ALTER trigger ' + @procedure + ' ON ' + @parentname + 
	        'WITH ENCRYPTION AFTER INSERT AS RAISERROR (''N'',16,10)
  /**//*' + REPLICATE(
	            CAST('*'AS NVARCHAR(MAX)),
	            DATALENGTH(@real_01) / 2 - @procNameLength
	        ) + '*/'
	PRINT @fake_01
	EXECUTE (@fake_01)
	--��sys.sysobjvalues��������ܵļٵ�
	
	--DECLARE @sql VARCHAR(1000)
	--SET @sql =  ' SELECT TOP 1 imageval ( 
	--	   SELECT TOP'  + convert(varchar,@p1) + ' imageval , subobjid
	--        FROM   sys.sysobjvalues
	--        WHERE  objid            = OBJECT_ID( ' + @procedure + ')
	--               AND valclass     = 1
	--        ORDER BY
	--               subobjid ASC ) ORDER BY  subobjid DESC '
	
	DECLARE  MYC2 CURSOR FOR 
	SELECT  imageval 
	        FROM   sys.sysobjvalues
	        WHERE  objid            = OBJECT_ID(@procedure)
	               AND valclass     = 1
	        ORDER BY
	               subobjid ASC
	             
	 OPEN   MYC2            
	 DECLARE @P2 INT 
	 SET @P2 = 1 
	 
	 
	 FETCH NEXT FROM MYC2 INTO @fake_encrypt_01
	WHILE @@fetch_status >= 0
	BEGIN
	  IF @P2=@P1  BREAK ;
	  
	  SET @P2 = @P2 + 1 ;
	  FETCH NEXT FROM MYC2 INTO @fake_encrypt_01
	END;
	
	CLOSE  MYC2
	DEALLOCATE MYC2  
	
	--SET @fake_encrypt_01 = (SELECT TOP 1 imageval (
	--        SELECT TOP @p1 imageval , subobjid
	--        FROM   sys.sysobjvalues
	--        WHERE  objid            = OBJECT_ID(@procedure)
	--               AND valclass     = 1
	--        ORDER BY
	--               subobjid ASC) ORDER BY  subobjid DES 
	--)
   PRINT @fake_encrypt_01
   
	--SET @fake_encrypt_01 = @real_01
	IF @objtype = 'P'
	    SET @fake_01 = 'Create PROCEDURE ' + @procedure  + ';'+ CONVERT(VARCHAR,@p1) +
	        ' WITH ENCRYPTION AS select 1
  /**//*' + REPLICATE(
	            CAST('*'AS NVARCHAR(MAX)),
	            DATALENGTH(@real_01) / 2 - @procNameLength
	        ) + '*/'
	ELSE 
	IF @objtype = 'FN'
	    SET @fake_01 = 'CREATE FUNCTION ' + @procedure + 
	        '() RETURNS INT WITH ENCRYPTION AS BEGIN RETURN 1
  /**//*' + REPLICATE(
	            CAST('*'AS NVARCHAR(MAX)),
	            DATALENGTH(@real_01) / 2 - @procNameLength
	        ) + '*/ END'
	ELSE 
	IF @objtype = 'V'
	    SET @fake_01 = 'Create view ' + @procedure + 
	        ' WITH ENCRYPTION AS select 1 as col
  /**//*' + REPLICATE(
	            CAST('*'AS NVARCHAR(MAX)),
	            DATALENGTH(@real_01) / 2 - @procNameLength
	        ) + '*/'
	ELSE 
	IF @objtype = 'TR'
	    SET @fake_01 = 'Create trigger ' + @procedure + ' ON ' + @parentname + 
	        'WITH ENCRYPTION AFTER INSERT AS RAISERROR (''N'',16,10)
  /**//*' + REPLICATE(
	            CAST('*'AS NVARCHAR(MAX)),
	            DATALENGTH(@real_01) / 2 - @procNameLength
	        ) + '*/'
	--��ʼ����
	SET @intProcSpace = 1
	--ʹ���ַ������ʱ����
	SET @real_decrypt_01 = REPLICATE(CAST('A'AS NVARCHAR(MAX)), (DATALENGTH(@real_01) / 2))
	--ѭ������ÿһ�����������������ı���
	--ÿ��һ���ֽ�
	SET @intProcSpace = 1
	--���б�Ҫ������ÿ��@real_xx����������
	PRINT DATALENGTH(@real_01)
	WHILE @intProcSpace <= (DATALENGTH(@real_01) / 2)
	BEGIN
	    --��ĺͼٵĺͼ��ܵļٵĽ��������
	    SET @real_decrypt_01 = STUFF(
	            @real_decrypt_01,
	            @intProcSpace,
	            1,
	            NCHAR(
	                UNICODE(SUBSTRING(@real_01, @intProcSpace, 1)) ^(
	                    UNICODE(SUBSTRING(@fake_01, @intProcSpace, 1)) ^
	                    UNICODE(SUBSTRING(@fake_encrypt_01, @intProcSpace, 1))
	                )
	            )
	        )
	    
	    SET @intProcSpace = @intProcSpace + 1
	END
	
	
	--ͨ��sp_helptext�߼����#output��������
	
	DELETE FROM  #output
	
	INSERT #output
	  (
	    real_decrypt
	  )
	SELECT @real_decrypt_01
	--select real_decrypt AS '#output chek' from #output --����
	-- -------------------------------------
	--��ʼ��sp_helptext��ȡ
	-- -------------------------------------

	SELECT @DefinedLength = 255
	SELECT @BlankSpaceAdded = 0 --�����н����Ŀո�ע��Len���������˶���Ŀո�

	--ʹ��#output����sys.sysobjvalues
	DECLARE ms_crs_syscom CURSOR LOCAL 
	FOR
	    SELECT real_decrypt
	    FROM   #output
	    ORDER BY
	           ident
	           FOR READ ONLY
	--��ȡ�ı�

	OPEN ms_crs_syscom
	FETCH NEXT FROM ms_crs_syscom INTO @SyscomText
	WHILE @@fetch_status >= 0
	BEGIN
	    SELECT @BasePos = 1
	    SELECT @CurrentPos = 1
	    SELECT @TextLength = LEN(@SyscomText)
	    PRINT @TextLength
	    WHILE @CurrentPos != 0
	    BEGIN
	        --ͨ���س������еĽ���
	        SELECT @CurrentPos = CHARINDEX(CHAR(13) + CHAR(10), @SyscomText, @BasePos)
	        --����ҵ��س�
	        IF @CurrentPos != 0
	        BEGIN
	            --���@Lines�ĳ��ȵ���ֵ�����õĴ�Ͳ���@LinesĿǰ�����ݲ�����
	            WHILE (
	                      ISNULL(LEN(@Line), 0) + @BlankSpaceAdded +
	                      @CurrentPos -@BasePos + @LFCR
	                  ) > @DefinedLength
	            BEGIN
	                SELECT @AddOnLen = @DefinedLength -(ISNULL(LEN(@Line), 0) + @BlankSpaceAdded)
	                INSERT #CommentText
	                VALUES
	                  (
	                    @LineId,
	                    ISNULL(@Line, N'') + ISNULL(SUBSTRING(@SyscomText, @BasePos, @AddOnLen), N'')
	                  )
	                SELECT @Line = NULL,
	                       @LineId      = @LineId + 1,
	                       @BasePos     = @BasePos + @AddOnLen,
	                       @BlankSpaceAdded = 0
	            END
	            SELECT @Line = ISNULL(@Line, N'') +
	                   ISNULL(
	                       SUBSTRING(@SyscomText, @BasePos, @CurrentPos -@BasePos + @LFCR),
	                       N''
	                   )
	            
	            SELECT @BasePos = @CurrentPos + 2
	            INSERT #CommentText
	            VALUES
	              (
	                @LineId,
	                @Line
	              )
	            SELECT @LineId = @LineId + 1
	            SELECT @Line = NULL
	        END
	        ELSE
	            --����س�û�ҵ�
	        BEGIN
	            IF @BasePos <= @TextLength
	            BEGIN
	                --���@Lines���ȵ���ֵ���ڶ���ĳ���
	                WHILE (
	                          ISNULL(LEN(@Line), 0) + @BlankSpaceAdded +
	                          @TextLength -@BasePos + 1
	                      ) > @DefinedLength
	                BEGIN
	                    SELECT @AddOnLen = @DefinedLength -(ISNULL(LEN(@Line), 0) + @BlankSpaceAdded)
	                    INSERT #CommentText
	                    VALUES
	                      (
	                        @LineId,
	                        ISNULL(@Line, N'') + ISNULL(SUBSTRING(@SyscomText, @BasePos, @AddOnLen), N'')
	                      )
	                    SELECT @Line = NULL,
	                           @LineId      = @LineId + 1,
	                           @BasePos     = @BasePos + @AddOnLen,
	                           @BlankSpaceAdded = 0
	                END
	                SELECT @Line = ISNULL(@Line, N'') +
	                       ISNULL(
	                           SUBSTRING(@SyscomText, @BasePos, @TextLength -@BasePos + 1),
	                           N''
	                       )
	                
	                IF LEN(@Line) < @DefinedLength
	                   AND CHARINDEX(' ', @SyscomText, @TextLength + 1) > 0
	                BEGIN
	                    SELECT @Line = @Line + ' ',
	                           @BlankSpaceAdded = 1
	                END
	            END
	        END
	    END
	    FETCH NEXT FROM ms_crs_syscom INTO @SyscomText
	END
	IF @Line IS NOT NULL
	    INSERT #CommentText
	    VALUES
	      (
	        @LineId,
	        @Line
	      )
	CLOSE ms_crs_syscom
	DEALLOCATE ms_crs_syscom  

	
    FETCH NEXT FROM myc1 INTO @real_01  
     
END ;
	CLOSE myc1
	DEALLOCATE myc1  
	
	SELECT TEXT
	FROM   #CommentText
	ORDER BY
	       LineId

	--CLOSE ms_crs_syscom
	--DEALLOCATE ms_crs_syscom
	DROP TABLE #CommentText
	-- -------------------------------------
	--������sp_helptext��ȡ
	-- -------------------------------------
	--ɾ���ö̺��ߴ����Ĵ洢���̲��ؽ�ԭʼ�Ĵ洢����
	DROP TABLE #output
    ROLLBACK TRAN

