EP082层压图
USE [sj_v20_live]
GO
/****** Object:  StoredProcedure [dbo].[user_defined_sp_ep082_1]    Script Date: 10/30/2013 20:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[user_defined_sp_ep082_1] 
@vptr int
AS
--SELECT [dbo].SF_GET_MO_TIMES(@vptr) as vtimes
SELECT hdi_bmp ,[dbo].SF_GET_MO_TIMES(@vptr) as vtimes
FROM data0552 WHERE SOURCE_PTR IN(
	SELECT rkey FROM data0050 WHERE rkey IN(
		SELECT ancestor_ptr FROM data0025 WHERE rkey IN(
			SELECT bom_ptr FROM data0006 WHERE rkey=24698
			)
		
		)
	)

