USE [wisdompcb]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_GetSmsContent_DGGDC]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		钟祥
-- Create date: 2013-04-17
-- Description:	获取生产数据短信内容
-- =============================================
CREATE function [dbo].[fun_GetSmsContent_DGGDC] 
(@RightString varchar(50))
returns varchar(400)
--with encryption 
As
Begin
DECLARE @stringLen int
SELECT  @stringLen = len(@rightString) + 1
DECLARE @msgContent AS varchar(400)
SELECT  @msgContent = b.短信内容
From
 (SELECT  TOP (1)  
          '东莞高多层' + CONVERT(varchar(10), DATEADD(d, - 1, GETDATE()), 102) 
        + '信息：' 
        + CASE WHEN substring(@rightString, @stringLen-1, 1) = '1' OR substring(@rightString, @stringLen-2, 1) = '1' 
               THEN '①' ELSE '' END
        + CASE WHEN substring(@rightString, @StringLen-1, 1) = '1'
               THEN '入库' + convert(varchar, 当日入库面积)  
                 + '平米(白班：' + convert(varchar,当日白班入库面积) + '平米，晚班：' + convert(varchar,当日晚班入库面积) + '平米)'
                 + '/' + convert(varchar, 月累计入库面积) + '平米，'
               ELSE '' 
          END        
        + CASE WHEN substring(@rightString, @stringLen-2, 1) = '1'
               THEN '入库产值' + convert(varchar, 当日入库产值)
                  + '万元'
                  + '/' + convert(varchar, 月累计入库产值) + '万元，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-3, 1) = '1' OR substring(@rightString, @stringLen-4, 1) = '1' 
               THEN '②' ELSE '' END 
        + CASE WHEN substring(@rightString, @stringLen-3, 1) = '1'
               THEN '出库' + convert(varchar, 当日出库面积) + '/' + convert(varchar, 月累计出库面积)+ '平米，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-4, 1) = '1'
               THEN '出库产值' + convert(varchar, 当日出库产值) + '/' + convert(varchar, 月累计出库产值) + '万元，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-5, 1) = '1' OR substring(@rightString, @stringLen-6, 1) = '1' 
                OR  substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1' 
               THEN '③' ELSE '' END 
        + CASE WHEN substring(@rightString, @stringLen-5, 1) = '1'
               THEN '库存' + convert(VARCHAR, 当前库存面积) + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-6, 1) = '1'
               THEN '金额' + convert(varchar, 当前库存金额) + '万元'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1'
               THEN '(其中：周期超六个月库存'
               ELSE ''
          END 
        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1'
               THEN convert(varchar, 超周期库存面积)  + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-8, 1) = '1'
               THEN '金额' + convert(varchar, 超周期库存金额) + '万元'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1'
               THEN ')，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-9, 1) = '1' OR substring(@rightString, @stringLen-10, 1) = '1' 
               THEN '④' ELSE '' END
        + CASE WHEN substring(@rightString, @stringLen-9, 1) = '1'
               THEN '订单' + convert(varchar, 当日订单面积) + '/' + convert(varchar, 月累计订单面积) + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-10, 1) = '1'
               THEN '订单未投' + convert(varchar, 当日订单未投面积) + '/' + convert(varchar, 月累计订单未投面积) + '平米，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-11, 1) = '1' OR substring(@rightString, @stringLen-12, 1) = '1'
               THEN '⑤' ELSE '' END
        + CASE WHEN substring(@rightString, @stringLen-11, 1) = '1'
               THEN '报废' + convert(varchar, 当日报废面积) + '/' + convert(varchar, 月累计报废面积) + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-12, 1) = '1'
               THEN '报废率' + convert(varchar, 当日报废率) + '%/' + convert(varchar, 月报废率)+ '%，'
               ELSE ''
          END 
        + CASE WHEN substring(@rightString, @stringLen-13, 1) = '1' OR substring(@rightString, @stringLen-14, 1) = '1'
                OR  substring(@rightString, @stringLen-15, 1) = '1' 
               THEN '⑥' ELSE '' END
        + CASE WHEN substring(@rightString, @stringLen-13, 1) = '1'
               THEN '在线' /*+ convert(varchar, 当前在线面积) + '平米'*/ 
                  + '(外层：' + convert(varchar,当前外层在线面积) + '平米，'
                  + '内芯：' + convert(varchar,当前内芯在线面积) + '平米，'
				  + '半制程：' + convert(varchar,当前半制程在线面积) + '平米)，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-14, 1) = '1'
               THEN '在线暂缓' + convert(varchar, 当前在线暂缓面积) + '平米，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-15, 1) = '1'
               THEN ' 退货' + convert(varchar, 当日退货面积) + '/' + convert(varchar, 月累计退货面积) + '平米' 
               ELSE ''
          END 
                AS 短信内容
   FROM	tblTemp_View_SMS_DGGDC) as b

IF len(@msgContent) = 17 SET @msgContent = ''

return @msgContent
End
GO
/****** Object:  UserDefinedFunction [dbo].[F_LowerToUpper]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[F_LowerToUpper] (@num numeric(14,2))
RETURNS varchar(100) --WITH ENCRYPTION
AS
BEGIN
  DECLARE @n_data VARCHAR(20),@c_data VARCHAR(100),@n_str VARCHAR(10),@i int

  SET @n_data=RIGHT(SPACE(14)+CAST(CAST(ABS(@num*100) AS bigint) AS varchar(20)),14)
  SET @c_data=''
  SET @i=1
  WHILE @i<=14
  BEGIN
    SET @n_str=SUBSTRING(@n_data,@i,1)
    IF @n_str<>' '
    BEGIN
      IF not ((SUBSTRING(@n_data,@i,2)='00') or
        ((@n_str='0') and ((@i=4) or (@i=8) or (@i=12) or (@i=14))))
        SET @c_data=@c_data+SUBSTRING('零壹贰叁肆伍陆柒捌玖',CAST(@n_str AS int)+1,1)
      IF not ((@n_str='0') and (@i<>4) and (@i<>8) and (@i<>12))
        SET @c_data=@c_data+SUBSTRING('仟佰拾亿仟佰拾万仟佰拾圆角分',@i,1)
      IF SUBSTRING(@c_data,LEN(@c_data)-1,2)='亿万'
        SET @c_data=SUBSTRING(@c_data,1,LEN(@c_data)-1)
    END
    SET @i=@i+1
  END
  IF @num<0
    SET @c_data='（负数）'+@c_data
  IF @num=0
    SET @c_data='零圆'
  IF @n_str='0'
    SET @c_data=@c_data+'整'
  RETURN(@c_data)
END
GO
/****** Object:  UserDefinedFunction [dbo].[fun_GetSmsContent_DGHDI]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		钟祥
-- Create date: 2013-04-17
-- Description:	获取生产数据短信内容
-- =============================================
CREATE function [dbo].[fun_GetSmsContent_DGHDI] 
(@RightString varchar(50))
returns varchar(400)
--with encryption 
As
Begin
DECLARE @stringLen int
SELECT  @stringLen = len(@rightString) + 1
DECLARE @msgContent AS varchar(400)
SELECT  @msgContent = b.短信内容
From
 (SELECT  TOP (1)  
          '东莞HDI' + CONVERT(varchar(10), DATEADD(d, - 1, GETDATE()), 102) 
        + '信息：' 
        + CASE WHEN substring(@rightString, @stringLen-1, 1) = '1' OR substring(@rightString, @stringLen-2, 1) = '1' 
               THEN '①' ELSE '' END
        + CASE WHEN substring(@rightString, @StringLen-1, 1) = '1'
               THEN '入库' + convert(varchar, 当日入库面积)  
                 + '平米(白班：' + convert(varchar,当日白班入库面积) + '平米，晚班：' + convert(varchar,当日晚班入库面积) + '平米)'
                 + '/' + convert(varchar, 月累计入库面积) + '平米，'
               ELSE '' 
          END        
        + CASE WHEN substring(@rightString, @stringLen-2, 1) = '1'
               THEN '入库产值' + convert(varchar, 当日入库产值)
                  + '万元'
                  + '/' + convert(varchar, 月累计入库产值) + '万元，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-3, 1) = '1' OR substring(@rightString, @stringLen-4, 1) = '1' 
               THEN '②' ELSE '' END 
        + CASE WHEN substring(@rightString, @stringLen-3, 1) = '1'
               THEN '出库' + convert(varchar, 当日出库面积) + '/' + convert(varchar, 月累计出库面积)+ '平米，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-4, 1) = '1'
               THEN '出库产值' + convert(varchar, 当日出库产值) + '/' + convert(varchar, 月累计出库产值) + '万元，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-5, 1) = '1' OR substring(@rightString, @stringLen-6, 1) = '1' 
                OR  substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1' 
               THEN '③' ELSE '' END 
        + CASE WHEN substring(@rightString, @stringLen-5, 1) = '1'
               THEN '库存' + convert(VARCHAR, 当前库存面积) + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-6, 1) = '1'
               THEN '金额' + convert(varchar, 当前库存金额) + '万元'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1'
               THEN '(其中：周期超六个月库存'
               ELSE ''
          END 
        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1'
               THEN convert(varchar, 超周期库存面积)  + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-8, 1) = '1'
               THEN '金额' + convert(varchar, 超周期库存金额) + '万元'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1'
               THEN ')，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-9, 1) = '1' OR substring(@rightString, @stringLen-10, 1) = '1' 
               THEN '④' ELSE '' END
        + CASE WHEN substring(@rightString, @stringLen-9, 1) = '1'
               THEN '订单' + convert(varchar, 当日订单面积) + '/' + convert(varchar, 月累计订单面积) + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-10, 1) = '1'
               THEN '订单未投' + convert(varchar, 当日订单未投面积) + '/' + convert(varchar, 月累计订单未投面积) + '平米，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-11, 1) = '1' OR substring(@rightString, @stringLen-12, 1) = '1'
               THEN '⑤' ELSE '' END
        + CASE WHEN substring(@rightString, @stringLen-11, 1) = '1'
               THEN '报废' + convert(varchar, 当日报废面积) + '/' + convert(varchar, 月累计报废面积) + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-12, 1) = '1'
               THEN '报废率' + convert(varchar, 当日报废率) + '%/' + convert(varchar, 月报废率)+ '%，'
               ELSE ''
          END 
        + CASE WHEN substring(@rightString, @stringLen-13, 1) = '1' OR substring(@rightString, @stringLen-14, 1) = '1'
                OR  substring(@rightString, @stringLen-15, 1) = '1' 
               THEN '⑥' ELSE '' END
        + CASE WHEN substring(@rightString, @stringLen-13, 1) = '1'
               THEN '在线' /*+ convert(varchar, 当前在线面积) + '平米'*/ 
                  + '(外层：' + convert(varchar,当前外层在线面积) + '平米，'
                  + '内芯：' + convert(varchar,当前内芯在线面积) + '平米，'
				  + '半制程：' + convert(varchar,当前半制程在线面积) + '平米)，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-14, 1) = '1'
               THEN '在线暂缓' + convert(varchar, 当前在线暂缓面积) + '平米，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-15, 1) = '1'
               THEN ' 退货' + convert(varchar, 当日退货面积) + '/' + convert(varchar, 月累计退货面积) + '平米' 
               ELSE ''
          END 
                AS 短信内容
   FROM	tblTemp_View_SMS_DGHDI) as b

IF len(@msgContent) = 17 SET @msgContent = ''

return @msgContent
End
GO
/****** Object:  UserDefinedFunction [dbo].[funcDecToABC36]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[funcDecToABC36]

	(@Dec bigint)
returns	varchar(50)
AS
BEGIN

DECLARE
	@out_ABC36 varchar(50),

	@LMod36 bigint,
	@LTmp bigint,
	@RetStr varchar(50)
	
	set @LTmp = @Dec
	set @RetStr = ''
	
	WHILE 1>0
	BEGIN
		SET @LMod36 = (@LTmp % 36)
		
		IF @LMod36 <= 9 
			SET @RetStr = @RetStr + cast(@LMod36 AS VARCHAR(50))
		ELSE
			SET @RetStr = @RetStr + CHAR(@LMod36 - 10 + 65);
		
		
		SET @LTmp = @LTmp / 36
		
		IF @LTmp < 36
			Break;	
	END
	
	IF @LTmp <> 0 
	BEGIN
		IF @LTmp <= 9
			SET @RetStr = @RetStr + cast(@LTmp AS VARCHAR(50))
		ELSE
			SET @RetStr = @RetStr + CHAR(@LTmp - 10 + 65);
	END
	
	SELECT @out_ABC36 = REVERSE(@RetStr)
	
	return @out_ABC36
	
END
GO
/****** Object:  UserDefinedFunction [dbo].[fun_GetSmsContent_Total]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		钟祥
-- Create date: 2013-04-17
-- Description:	获取生产数据短信内容
-- =============================================
CREATE function [dbo].[fun_GetSmsContent_Total] 
(@RightString varchar(50))
returns varchar(400)
--with encryption 
As
Begin
DECLARE @stringLen int
SELECT  @stringLen = len(@rightString) + 1
DECLARE @msgContent AS varchar(400)
SELECT  @msgContent = b.短信内容
From
 (SELECT  TOP (1)  
          '集团汇总' + CONVERT(varchar(10), DATEADD(d, - 1, GETDATE()), 102) 
        + '信息：' 
        + CASE WHEN substring(@rightString, @stringLen-1, 1) = '1' OR substring(@rightString, @stringLen-2, 1) = '1' 
               THEN '①' ELSE '' END
        + CASE WHEN substring(@rightString, @StringLen-1, 1) = '1'
               THEN '入库' + convert(varchar, 当日入库面积)  
                 + '平米，'
               ELSE '' 
          END        
        + CASE WHEN substring(@rightString, @stringLen-2, 1) = '1'
               THEN '入库产值' + convert(varchar, 当日入库产值)
                  + '万元，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-3, 1) = '1' OR substring(@rightString, @stringLen-4, 1) = '1' 
               THEN '②' ELSE '' END 
        + CASE WHEN substring(@rightString, @stringLen-3, 1) = '1'
               THEN '出库' + convert(varchar, 当日出库面积) + '/' + convert(varchar, 月累计出库面积)+ '平米，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-4, 1) = '1'
               THEN '出库产值' + convert(varchar, 当日出库产值) + '/' + convert(varchar, 月累计出库产值) + '万元，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-5, 1) = '1' OR substring(@rightString, @stringLen-6, 1) = '1' 
                OR  substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1' 
               THEN '③' ELSE '' END 
        + CASE WHEN substring(@rightString, @stringLen-5, 1) = '1'
               THEN '库存' + convert(VARCHAR, 当前库存面积) + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-6, 1) = '1'
               THEN '金额' + convert(varchar, 当前库存金额) + '万元'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1'
               THEN '(其中：周期超六个月库存'
               ELSE ''
          END 
        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1'
               THEN convert(varchar, 超周期库存面积)  + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-8, 1) = '1'
               THEN '金额' + convert(varchar, 超周期库存金额) + '万元'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1'
               THEN ')，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-9, 1) = '1' OR substring(@rightString, @stringLen-10, 1) = '1' 
               THEN '④' ELSE '' END
        + CASE WHEN substring(@rightString, @stringLen-9, 1) = '1'
               THEN '订单' + convert(varchar, 当日订单面积) + '/' + convert(varchar, 月累计订单面积) + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-10, 1) = '1'
               THEN '订单未投' + convert(varchar, 当日订单未投面积) + '/' + convert(varchar, 月累计订单未投面积) + '平米，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-11, 1) = '1' OR substring(@rightString, @stringLen-12, 1) = '1'
               THEN '⑤' ELSE '' END
        + CASE WHEN substring(@rightString, @stringLen-11, 1) = '1'
               THEN '报废' + convert(varchar, 当日报废面积) + '/' + convert(varchar, 月累计报废面积) + '平米，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-12, 1) = '1'
               THEN '报废率' + convert(varchar, 当日报废率) + '%/' + convert(varchar, 月报废率)+ '%，'
               ELSE ''
          END 
        + CASE WHEN substring(@rightString, @stringLen-13, 1) = '1' OR substring(@rightString, @stringLen-14, 1) = '1'
                OR  substring(@rightString, @stringLen-15, 1) = '1' 
               THEN '⑥' ELSE '' END
        + CASE WHEN substring(@rightString, @stringLen-13, 1) = '1'
               THEN '在线'/* + convert(varchar, 当前在线面积) + '平米' */
                  + '(外层：' + convert(varchar,当前外层在线面积) + '平米，'
                  + '内芯：' + convert(varchar,当前内芯在线面积) + '平米)，'
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-14, 1) = '1'
               THEN '在线暂缓' + convert(varchar, 当前在线暂缓面积) + '平米，' 
               ELSE ''
          END
        + CASE WHEN substring(@rightString, @stringLen-15, 1) = '1'
               THEN ' 退货' + convert(varchar, 当日退货面积) + '/' + convert(varchar, 月累计退货面积) + '平米' 
               ELSE ''
          END 
                AS 短信内容
   FROM	tblTemp_View_SMS_Total) as b

IF len(@msgContent) = 17 SET @msgContent = ''

return @msgContent
End
GO
/****** Object:  UserDefinedFunction [dbo].[funcABC36ToDec]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[funcABC36ToDec]

	(@ABC36 varchar(50))
returns	bigint
AS
BEGIN
	--declare
	--	@ABC36 varchar(50)
	--	set @ABC36= 'R4H6'
	
	declare
		@outRet bigint,
		@tmpABC varchar(50),
		@I int,
		@n int,
		@tmpInt int,
		@tmpChar varchar(5)
	set @n = 0
	set @outRet = 0
	
	set @tmpABC = upper(@ABC36)
	set @I = len(@tmpABC) 
	
	while @I > 0
	BEGIN
		set @tmpChar = substring(@tmpABC,@I,1)
		
		set @tmpInt = ascii(@tmpChar)
		if (@tmpInt >= 48) and (@tmpInt <= 57) 
		BEGIN
			set @outRet = @outRet + cast(@tmpChar AS INT) * Power(36,@n)
		end else
		if (@tmpInt >= 65) and (@tmpInt <= 90)
		BEGIN
			set @outRet = @outRet + (@tmpInt + 10 - 65) * Power(36,@n)
		end
		set @I = @I - 1
		set @n = @n + 1
	end
	
	return @outret
end
GO
/****** Object:  UserDefinedFunction [dbo].[Get_wagetype]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Function [dbo].[Get_wagetype]
(@employeeid int,
@yearmonth nvarchar(10),
@wagetype int)
Returns int
As
begin

----declare @employeeid int
----declare @yearmonth nvarchar(10)
----declare @wagetype int

----set @employeeid=1661
----set @yearmonth='2012-04'
----set @wagetype=9


declare @wagetype1 int
declare @now_date  datetime

set @wagetype1=isnull(@wagetype,0)
set @now_date = cast (@yearmonth+'-01' as datetime)

---select @wagetype1,@now_date
------ 查询是否存在工资项目调动的情况
if EXISTS 
(select  *
 from dbo.employee_alteration 
where orginal_accountid is not null 
and employeeid=@employeeid   
)
	begin
		if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
			select new_accountid from dbo.employee_alteration 
			where employeeid=@employeeid  and  orginal_accountid is not null 
			and alterdate<=@now_date) 
		begin  ----如果存在就取最大日期记录中的新值
			set  @wagetype1=(select top 1 new_accountid
			from dbo.employee_alteration 
			where employeeid=@employeeid  and  orginal_accountid is not null 
			and alterdate<=@now_date
			order by alterdate desc)
		end
		else 
		begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
				-----表示最早的一条记录的原值是 激活月份时期的值
			set  @wagetype1=(select top 1 orginal_accountid
			from dbo.employee_alteration 
			where employeeid=@employeeid  and  orginal_accountid is not null 
			and alterdate>@now_date
			order by alterdate )				
		end		
	end
----薪资调动没有记录的，沿用当前帐套。
---select @wagetype1,@now_date	

return @wagetype1

end
---select  dbo.Get_workdays('24103','2012-04-01','2012-04-30')

---- select orginal_accountid from employee_alteration order by alterdate

----- select * from resttypemsg
GO
/****** Object:  UserDefinedFunction [dbo].[get_classforonoffdutydata]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***该过程用于将班组里的班次链名称查找出来**/  --   Written   by:   xwj    

CREATE  function  [dbo].[get_classforonoffdutydata] 
 (@employeeid int ,
@classgroupbegintime datetime,
@checkdate datetime,
@change_flag int,
@classstring nvarchar(200))
returns   int   
  AS                   
BEGIN
declare @class_id int
set @class_id=NULL
/**
declare @employeeid int  
declare @classgroupid int 
declare @classgroupbegintime datetime 
declare @checkdate datetime 
declare @change_flag int 
declare @classstring nvarchar 
set @employeeid=12
set @classgroupid=41
set @classgroupbegintime='2011-09-16'
set @checkdate='2011-12-10'
set @change_flag=1
set @classstring='58,59,90,92,91'
--
--判断@change_flag,确定时间间隔单位**/
--判断逗号的个数,确定循环模的值
declare @t_class table(id int,classid int)
declare @i int----班次个数
declare @j int
declare @k int
declare @current int
set @i=0
set @j=1
while @j<>0 
begin
	set @current=@j
	if @current>1 
		begin
			set @current=@current+1
		end
	if @j<>1  -----开头为1时,J不累加 
		begin
			set @j=@j+1
		end
	select @j=charindex(',',@classstring,@j) -----寻找下一个逗号的位置
	set @i=@i+1------班次个数加1
	if @i=1 and @j=0
		begin
			insert into @t_class 
			select @i,cast(@classstring as int)
		end
	if @j>1 ---@j<>0 and @j>1
		begin
			insert into @t_class
			select @i,cast(substring(@classstring,@current,(@j-@current)) as int)
		end
	if @i<>1 and @j=0
		begin
			insert into @t_class
			select @i,cast(substring(@classstring,@current,(len(@classstring)+1-@current))as int)
		end
end
--select @i
---select * from @t_class
if @i=1 
begin
set @class_id=cast(@classstring as int)
end
if @i<>1
begin
	if @change_flag = 0
		begin
			set @k=datediff(dd,@classgroupbegintime,@checkdate)%@i 
			if @k=0	
				begin
					select @class_id=classid from @t_class	where id=1
				end  
			if @k<>0
				begin
					select @class_id=classid from @t_class	where id=@k+1
				end
		end
	if @change_flag = 1  ---每周转
		begin
			set @k=datediff(wk,@classgroupbegintime,@checkdate)%@i 
			if @k=0	
				begin
					select @class_id=classid from @t_class	where id=1
				end  
			if @k<>0
				begin
					select @class_id=classid from @t_class	where id=@k+1
				end			
		end
	if @change_flag = 2  ---15日和月底转
		begin
			declare @l int
            declare @current_date datetime
			set @l=0
			set @current_date=@classgroupbegintime
			if @current_date=@checkdate
				begin
					select @class_id=classid from @t_class	where id=1	
				end
			if @current_date<@checkdate
				begin
					while @current_date<=@checkdate 
						begin					
							if (substring(convert(nvarchar(20),@current_date,120),1,10)=substring(convert(nvarchar(20),@current_date,120),1,8)+'15')
							or (substring(convert(nvarchar(20),dateadd(day,1,@current_date),120),1,10)=substring(convert(nvarchar(20),dateadd(month,1,@current_date),120),1,8)+'01')
							begin
								set @l=@l+1
							end
							set @current_date=dateadd(day,1,@current_date)
						end
					set @k=@l%@i
					if @k=0
						begin
							select @class_id=classid from @t_class	where id=1
						end
					if @k<>0
						begin
							select @class_id=classid from @t_class where id=@k+1
						end
						
				end
		end
	if @change_flag = 3
		begin
			declare @ll int
            declare @current_date_3 datetime
			set @ll=0
			set @current_date_3=@classgroupbegintime
			if @current_date_3=@checkdate
				begin
					select @class_id=classid from @t_class	where id=1	
				end
			if @current_date_3<@checkdate
				begin
					while @current_date_3<=@checkdate 
						begin					
							if (substring(convert(nvarchar(20),@current_date_3,120),1,10)=substring(convert(nvarchar(20),@current_date_3,120),1,8)+'16')
							or (substring(convert(nvarchar(20),dateadd(day,1,@current_date_3),120),1,10)=substring(convert(nvarchar(20),dateadd(month,1,@current_date_3),120),1,8)+'01')
							begin
								set @ll=@ll+1
							end
							set @current_date_3=dateadd(day,1,@current_date_3)
						end
					set @k=@ll%@i
					if @k=0
						begin
							select @class_id=classid from @t_class	where id=1
						end
					if @k<>0
						begin
							select @class_id=classid from @t_class where id=@k+1
						end
						
				end
		
		end
	if @change_flag = 4 ----每月转
		begin
			set @k=datediff(mm,@classgroupbegintime,@checkdate)%@i 
			if @k=0	
				begin
					select @class_id=classid from @t_class	where id=1
				end  
			if @k<>0
				begin
					select @class_id=classid from @t_class	where id=@k+1
				end		
		
		end
end

return(@class_id)   
end  
-- exec dbo.get_departments
GO
/****** Object:  UserDefinedFunction [dbo].[Fun_V_onoffduty_report]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    function [dbo].[Fun_V_onoffduty_report]
(@BeginDate datetime,
@EndDate datetime
)
returns @V_onoffduty_report table 
(
flag	varchar(2),
dy	int,
年	int,
月	int,
日	int,
ChineseName	nvarchar(40),
employeeid	int	,	
position	int	,
position_item	nvarchar(100),
out1	nvarchar(10),
in1	nvarchar(10),
in2	nvarchar(10),
out2	nvarchar(10),
in3	nvarchar(10),
out3	nvarchar(10),
in4	nvarchar(10),
out4	nvarchar(10),
DepartmentName	nvarchar(40),
EmployeeCode	nvarchar(40),
ondutytime	datetime,
outdutytime	datetime,
outduty_flag	int,
ClassName	nvarchar(40),
CheckDate	datetime,
accountname	nvarchar(100),
SumCN	real,
SumCT	real,
SumZN	real,
SumZT	real,
SumKN	real,
sumkt	real,
SumWN	real,
SumWT	real,
SumJN	real,
SumJT	real,
SumEN	real,
SumET	real,
SumLN	real,
SumLT	float,
YTnote	nvarchar(100),
ClassGroupID	int,		
RestType	int	,	
OWT	real,
SWT	real,
NCN	int,
RWT	real,
ROT	real,
RWTROT	float,
work1	float,
work1_day	float,
work1_night	float,
work2	float,
work3	float,
work4	float,
work10	float,
restday	real,
workday	float,
orginal_workday	numeric(18,2),
week_workday	numeric(18,2),
p_week_workday	numeric(18,2),
festival	numeric(18,2),
R_festival	numeric(18,2),
qj	int,	
yearj	int		
)
as

begin

insert into @V_onoffduty_report
SELECT TOP 100 PERCENT    
     case when datepart(weekday,checkdate) in (1,7) then '*'  
     when  resttype in (2) then '休'  
  when isnull(resttype,0) in (3) then '节'  
  else '' end   
  as flag, ----显示标识  
 DAY(CheckDate)AS dy,    
 YEAR(CheckDate) AS 年,   
 MONTH(CheckDate) AS 月,   
 DAY(CheckDate) as 日,  
 ChineseName,--------姓名  
 employeeid,  
 position,-----职务ID  
position_item,----职务名称   
 SUBSTRING(CONVERT(nvarchar(20), OffDutyTime1, 120), 12, 5) AS out1,-----------  
 SUBSTRING(CONVERT(nvarchar(20), ondutytime1, 120), 12, 5) AS in1,-------------  
 SUBSTRING(CONVERT(nvarchar(20), ondutytime2, 120), 12, 5) AS in2,-------------  
 SUBSTRING(CONVERT(nvarchar(20), OffDutyTime2, 120), 12, 5) AS out2,------------  
 SUBSTRING(CONVERT(nvarchar(20), ondutytime3, 120), 12, 5) AS in3,--------------  
 SUBSTRING(CONVERT(nvarchar(20), OffDutyTime3, 120), 12, 5) AS out3,-------------  
 SUBSTRING(CONVERT(nvarchar(20), OnDutyTime4, 120), 12, 5) AS in4,  
 SUBSTRING(CONVERT(nvarchar(20), OffDutyTime4, 120), 12, 5) AS out4,  
DepartmentName, ----部门名称  
EmployeeCode,-----工号  
ondutytime,  
outdutytime,------离职日期  
case when outdutytime is not null then 1 else 0 end as outduty_flag,  
ClassName,------班次名称  
CheckDate,------考勤日期  
d.accountname,  
SumCN,   
SumCT, ----迟到分钟  
SumZN,  
SumZT,----早退分钟  
SumKN,   
isnull(SumKT,0)/15/4.0/8.0 as sumkt,----- 旷工天   
SumWN,  
SumWT, -----  
SumJN,   
SumJT,-----   
SumEN,   
SumET, -----  
SumLN,  
 case when ln1 not in (9)   
 and ln2 not in (9) then   
 round(isnull(SumLT,0)/10.00,0)*10/30/2.0 else 0 end as SumLT ,------请假小时  
 YTnote,   
 ClassGroupID,  
 RestType,------假日类型,0 是工作日  
 OWT,  
 SWT,  
 NCN,  
---select * from resttypemsg  
 (case when isnull(resttype,0)<>4 then  isnull(RWT,0)  else 0 end )  as RWT ,-----当天主工时  
 (case when isnull(resttype,0)<>4  then  isnull(ROT,0)  else 0 end ) as ROT, -----当天附工时  
  
 case when isnull(resttype,0)<>4  then ( round((isnull(RWT,0)+isnull(ROT,0)),2)) else 0 end as RWTROT,----当天总工时  
  
case when isnull(resttype,0)=0  then round(isnull(rwt,0),2) else 0 end  
 as work1,--正班(周一至周五无色)  
  
case when isnull(resttype,0)=0 and c.isoverzero=0 and isnull(rwt,0)>=4 then   
 round(isnull(rwt,0)/8.0,2) else 0 end  
  
as work1_day, --正班白班  
case when isnull(resttype,0)=0 and c.isoverzero=1 and isnull(rwt,0)>=4 then   
 round(isnull(rwt,0)/8.0,2) else 0 end  
  
as work1_night,---正班夜班  
case when isnull(resttype,0)=0 then round(isnull(rot,0),2)   
  when isnull(resttype,0)=1 then round((isnull(rot,0)+isnull(rwt,0)),2)  
  when isnull(resttype,0)=3 then round((isnull(rot,0)+isnull(rwt,0)),2) else 0 end  
 as work2,--加班,  
  
case when isnull(resttype,0)=0 then round(isnull(rot,0),2) else 0 end   
 as work3,--平时加班（灰色加班）  
  
case when isnull(resttype,0)=1 and owtflag=1  then round((isnull(rot,0)+isnull(rwt,0)),2) else 0 end   
 as work4,--周六日加班（绿色加班）  
  
case when isnull(resttype,0)=3 and owtflag=1   then round((isnull(rot,0)+isnull(rwt,0)),2) else 0 end    
as work10,--法假加班（蓝色加班）  
  
(case when a.locked=1 and isnull(rwt,0)=4.0    
      then 0.50      ---已锁  
   when a.locked=1 and isnull(rot,0)>0 and isnull(rwt,0)<=8.0    
      then (8.0-isnull(rwt,0))/8.0 ---已锁  
   when isnull(resttype,0) in (0,2,4) and isnull(rwt,0)=0 then 1.00  -----深圳区域特定rkey  
   when isnull(resttype,0)=0 and rwt=4.0 and  
  (isnull(ln1,0)=3 or isnull(ln2,0)=3 or isnull(ln3,0)=3)   
      then 0.50  
      when isnull(resttype,0)=0 and  (swt=4) and (rwt between 0 and 4) then 0.50  
   when isnull(resttype,0)=0 and  (swt=6) and (rwt between 4 and 6) then 0.25     
 else 0 end )   
as restday,--调休天数, 优先判断第一个条件  
  
case when isnull(resttype,0)=0  then round(isnull(rwt,0)/8.0,2)   
  else 0 end  
as workday,--正班出勤天(周一至周五无色)  
  
case when  isnull(resttype,0) in (0,1) and  isnull(rwt,0)>7.0 then 1   
else (case when  isnull(resttype,0) in (0,1) and  isnull(rwt,0)>=3.5 then 0.5 else 0 end ) end  
    
as orginal_workday,--实际出勤天   

case when   isnull(resttype,0)=1     and isnull(rwt,0)>7.0 then 1   
else (case when isnull(resttype,0)=1 and isnull(rwt,0)>=3.5 then 0.5 else 0 end )  
end    
as week_workday,--实际周末出勤天  
  
case when   isnull(resttype,0)=1  then 1   
else  0
end    
as P_week_workday,--总周末天

  
case when isnull(resttype,0)=3 then 1.0   
  else 0 end  
as festival ,--法定假天(天蓝色)  
  
case when   isnull(resttype,0)=3    and isnull(rwt,0)>7.0 then 1   
else (case when isnull(resttype,0)=3 and isnull(rwt,0)>=3.5 then 0.5 else 0 end )  
end    
as R_festival,--实际法定假天(add by lisa) 
  
case when   
(  
(case when isnull(resttype,0)=0 and (isnull(ln1,0)=6 )   
then   round(isnull(lt1,0)/10,0)*10 else 0 end  
+case when isnull(resttype,0)=0 and (isnull(ln2,0)=6 )  
 then  round(isnull(lt2,0)/10,0)*10  else 0 end  
+ case when isnull(resttype,0)=0 and (isnull(ln3,0)=6 )   
then  round(isnull(lt3,0)/10,0)*10 else 0 end  
)/15/4  
)>8 then 8   
else (  
(case when isnull(resttype,0)=0 and (isnull(ln1,0)=6 )   
then  round(isnull(lt1,0)/10,0)*10 else 0 end  
+case when isnull(resttype,0)=0 and (isnull(ln2,0)=6 )   
then  round(isnull(lt2,0)/10,0)*10 else 0 end  
+ case when isnull(resttype,0)=0 and (isnull(ln3,0)=6 )  
 then  round(isnull(lt3,0)/10,0)*10 else 0 end  
)/15/4  
) end  as qj, ---请假小时  
  
round(  
  
(case when   
(  
(case when isnull(resttype,0)=0 and (isnull(ln1,0)=11 )   
 then   round(isnull(lt1,0)/10,0)*10 else 0 end  
+case when isnull(resttype,0)=0 and (isnull(ln2,0)=11 )   
 then  round(isnull(lt2,0)/10,0)*10  else 0 end  
+ case when isnull(resttype,0)=0 and (isnull(ln3,0)=11 )   
then  round(isnull(lt3,0)/10,0)*10 else 0 end  
)/15/4 )>8 then 8  
else   
(  
(case when isnull(resttype,0)=0 and (isnull(ln1,0)=11 )   
then  round(isnull(lt1,0)/10,0)*10 else 0 end  
+case when isnull(resttype,0)=0 and (isnull(ln2,0)=11 )  
 then  round(isnull(lt2,0)/10,0)*10 else 0 end  
+ case when isnull(resttype,0)=0 and (isnull(ln3,0)=11 )  
 then  round(isnull(lt3,0)/10,0)*10 else 0 end  
)/15/4) end   
),2)  as yearj ---年假小时  
 FROM dbo.onoffdutydata a  
left join FV_employeemsg() b on a.employeeid=b.rkey   
left join class c on a.classid=c.rkey   
left join salaryaccount d on d.rkey=a.editmode  
where  left(convert(varchar(10),a.checkdate,120),10) between @begindate and @enddate 

--order by employeecode,checkdate   
return

end

-- select * from FV_onoffduty_report('2015-11-01','2015-11-06')
GO
/****** Object:  UserDefinedFunction [dbo].[get_hrVerification_IdenNo]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****************************************************************************************************
   函数名称: Verification_IdenNo
   参数：@Iden_No 身份证号码
   备注：目前中国的身份证号码有18位和15位.
	1、18位身份证号码的组成:6位地区编码＋8位出生年月日＋3位编号（奇男偶女）＋1位校验码
	2、15位身份证号码的组成:6位地区编码＋6位出生年月日＋3位编号（奇男偶女）
	3、15位身份证没有字母，18位身份证最后一位要是字母，只能是X
	4、前六位必须是区县代码
	5、18位身份证最后一位是验证码，需要验证
	6、15位身份证只需要验证区域代码，年月日

第十八位数字的计算方法为：
 1.将前面的身份证号码17位数分别乘以不同的系数。
从第一位到第十七位的系数分别为：7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2 
2.将这17位数字和系数相乘的结果相加。 
3.用加出来和除以11，看余数是多少？ 
4余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。
其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2。 
5.通过上面得知如果余数是2，就会在身份证的第18位数字上出现罗马数字的Ⅹ。
如果余数是10，身份证的最后一位号码就是2。
 
例如：某男性的身份证号码是34052419800101001X。
我们要看看这个身份证是不是合法的身份证。 
首先：我们得出，前17位的乘积和是189 然后：用189除以11得出的结果是17 + 2/11，也就是说余数是2。 
最后：通过对应规则就可以知道余数2对应的数字是x。所以，这是一个合格的身份证号码。 
***************************************************************************************************/
CREATE FUNCTION [dbo].[get_hrVerification_IdenNo]
( 
@IDEN_NO VARCHAR(200) =''
)
RETURNS VARCHAR(1000)
AS 
BEGIN
	IF LEN(@IDEN_NO)!=15 AND LEN(@IDEN_NO)!=18 
		BEGIN
		RETURN '身份证位数不对'
		END
	IF LEN(@IDEN_NO)= 15 -- 十五位身份证，验证字母和日期
		BEGIN
			IF ISNUMERIC (@IDEN_NO) = 0
				BEGIN
				RETURN '15位身份证不包含字母'
				END 
			IF ISDATE('19'+SUBSTRING(@IDEN_NO,7,6))=0 
				BEGIN
				RETURN '十五位身份证日期不对'
				END
		END
	IF LEN(@IDEN_NO) =18
		BEGIN
			IF ISNUMERIC (LEFT(@IDEN_NO,17)) = 0 
				BEGIN
				RETURN '18位身份证前17位不包含字母'
				END
			IF ISDATE (SUBSTRING (@IDEN_NO,7,8)) =0
				BEGIN
				RETURN '18位身份证日期不对'
				END 
			IF CONVERT(INT,SUBSTRING (@IDEN_NO,7,4))  NOT BETWEEN  YEAR(GETDATE())-70 AND YEAR(GETDATE())-16
				BEGIN 
				RETURN '十八位身份证年龄不对'
				END 
 /*
				Declare @Q Varchar(22),@YZM Varchar(1)
				Set @Q='1,0,X,9,8,7,6,5,4,3,2,'
				Set @YZM=Right(@IDEN_NO ,1) 
				
				Declare @X Varchar(40)
				Set @X='7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,'
				
				Declare @S int,@I int
				Set @S=0
				Set @I=1
				
				While @I<18
				Begin
					Set @S=@S+Convert(int,SUBSTRING(@IDEN_NO,@I,1))*Left(@X,CharIndex(',',@X)-1)
					Set @X=Substring(@X,CharIndex(',',@X)+1,40)
					Set @I=@I+1
				End
				
                 
				Set @S=@S%11
				If (Substring(@Q,CharIndex(',' ,@Q ,@S*2)+1 ,1)!=@YZM)
					BEGIN
					Return '身份证错误'
					END 	
       */     
               		
		END
RETURN '正确'
END
GO
/****** Object:  UserDefinedFunction [dbo].[fun_GetSmsContent_DGHDI_20]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		钟祥
-- Create date: 2013-03-21
-- Description:	获取生产数据短信内容
-- =============================================
CREATE function [dbo].[fun_GetSmsContent_DGHDI_20] 
(@RightString varchar(50))
returns varchar(400)
--with encryption 
As
Begin
DECLARE @stringLen int
SELECT  @stringLen = len(@rightString) + 1
DECLARE @msgContent AS varchar(400)
SELECT  @msgContent = b.短信内容
From
 (SELECT  TOP (1)  
          '东莞五株' + CONVERT(varchar(10), GETDATE(), 102) 
        + '信息：' 
        + CASE WHEN substring(@rightString, @stringLen-1, 1) = '1' OR substring(@rightString, @stringLen-2, 1) = '1' 
               THEN '①' ELSE '' END
        + CASE WHEN substring(@rightString, @StringLen-1, 1) = '1'
               THEN '入库' + convert(varchar, 当日入库面积)  
                 + '平米(白班：' + convert(varchar,当日白班入库面积) + '平米)'
                 + '/' + convert(varchar, 月累计入库面积) + '平米，'
               ELSE '' 
          END        
        + CASE WHEN substring(@rightString, @stringLen-2, 1) = '1'
               THEN '入库产值' + convert(varchar, 当日入库产值)
                  + '万元(白班：' + convert(varchar,当日白班入库产值) + '万元)'
                  + '/' + convert(varchar, 月累计入库产值) + '万元，'
               ELSE ''
          END
--        + CASE WHEN substring(@rightString, @stringLen-3, 1) = '1' OR substring(@rightString, @stringLen-4, 1) = '1' 
--               THEN '②' ELSE '' END 
--        + CASE WHEN substring(@rightString, @stringLen-3, 1) = '1'
--               THEN '出库' + convert(varchar, 当日出库面积) + '/' + convert(varchar, 月累计出库面积)+ '平米，' 
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-4, 1) = '1'
--               THEN '出库产值' + convert(varchar, 当日出库产值) + '/' + convert(varchar, 月累计出库产值) + '万元，' 
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-5, 1) = '1' OR substring(@rightString, @stringLen-6, 1) = '1' 
--                OR  substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1' 
--               THEN '③' ELSE '' END 
--        + CASE WHEN substring(@rightString, @stringLen-5, 1) = '1'
--               THEN '库存' + convert(VARCHAR, 当前库存面积) + '平米，'
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-6, 1) = '1'
--               THEN '金额' + convert(varchar, 当前库存金额) + '万元'
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1'
--               THEN '(其中：周期超六个月库存'
--               ELSE ''
--          END 
--        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1'
--               THEN convert(varchar, 超周期库存面积)  + '平米，'
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-8, 1) = '1'
--               THEN '金额' + convert(varchar, 超周期库存金额) + '万元'
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-7, 1) = '1' OR substring(@rightString, @stringLen-8, 1) = '1'
--               THEN ')，'
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-9, 1) = '1' OR substring(@rightString, @stringLen-10, 1) = '1' 
--               THEN '④' ELSE '' END
--        + CASE WHEN substring(@rightString, @stringLen-9, 1) = '1'
--               THEN '订单' + convert(varchar, 当日订单面积) + '/' + convert(varchar, 月累计订单面积) + '平米，'
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-10, 1) = '1'
--               THEN '订单未投' + convert(varchar, 当日订单未投面积) + '/' + convert(varchar, 月累计订单未投面积) + '平米，' 
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-11, 1) = '1' OR substring(@rightString, @stringLen-12, 1) = '1'
--               THEN '⑤' ELSE '' END
--        + CASE WHEN substring(@rightString, @stringLen-11, 1) = '1'
--               THEN '报废' + convert(varchar, 当日报废面积) + '/' + convert(varchar, 月累计报废面积) + '平米，'
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-12, 1) = '1'
--               THEN '报废率' + convert(varchar, 当日报废率) + '%/' + convert(varchar, 月报废率)+ '%，'
--               ELSE ''
--          END 
--        + CASE WHEN substring(@rightString, @stringLen-13, 1) = '1' OR substring(@rightString, @stringLen-14, 1) = '1'
--                OR  substring(@rightString, @stringLen-15, 1) = '1' 
--               THEN '⑥' ELSE '' END
--        + CASE WHEN substring(@rightString, @stringLen-13, 1) = '1'
--               THEN '在线' + convert(varchar, 当前在线面积) + '平米，'
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-14, 1) = '1'
--               THEN '在线暂缓' + convert(varchar, 当前在线暂缓面积) + '平米，' 
--               ELSE ''
--          END
--        + CASE WHEN substring(@rightString, @stringLen-15, 1) = '1'
--               THEN ' 退货' + convert(varchar, 当日退货面积) + '/' + convert(varchar, 月累计退货面积) + '平米' 
--               ELSE ''
--          END 
                AS 短信内容
   FROM	View_SMS_DGHDI_20) as b

IF len(@msgContent) = 17 SET @msgContent = ''

return @msgContent
End
GO
/****** Object:  UserDefinedFunction [dbo].[UserWaterCount]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[UserWaterCount]
(
@rootDg decimal(18,3),
@leafDg decimal(18,3),
@realDg decimal(18,3),
@config decimal(18,3)
)
returns decimal(18,3)
as
begin
	declare @value decimal(18,3)
		set @value=((@rootDg/(case @leafDg when 0 then 1 else @leafDg end))*isnull(@realDg,0)*@config)
	return @value
end
GO
/****** Object:  UserDefinedFunction [dbo].[RegexMatch]    Script Date: 11/27/2018 15:47:47 ******/
CREATE FUNCTION [dbo].[RegexMatch](@input [nvarchar](4000), @pattern [nvarchar](4000), @ignoreCase [bit])
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SqlServerProject1].[UserDefinedFunctions].[RegexMatch]
GO
EXEC sys.sp_addextendedproperty @name=N'AutoDeployed', @value=N'yes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'RegexMatch'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFile', @value=N'Test Scripts\RegexMatch.cs' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'RegexMatch'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFileLine', @value=17 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'RegexMatch'
GO
/****** Object:  UserDefinedFunction [dbo].[GetRegexMatchGroups]    Script Date: 11/27/2018 15:47:47 ******/
CREATE FUNCTION [dbo].[GetRegexMatchGroups](@input [nvarchar](4000), @pattern [nvarchar](4000), @groupId [int], @maxReturnLength [int])
RETURNS [nvarchar](4000) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SqlServerProject1].[UserDefinedFunctions].[GetRegexMatchGroups]
GO
EXEC sys.sp_addextendedproperty @name=N'AutoDeployed', @value=N'yes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'GetRegexMatchGroups'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFile', @value=N'Test Scripts\GetRegexMatchGroups.cs' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'GetRegexMatchGroups'
GO
EXEC sys.sp_addextendedproperty @name=N'SqlAssemblyFileLine', @value=18 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'GetRegexMatchGroups'
GO
/****** Object:  UserDefinedFunction [dbo].[Fun_V_employeemsg]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function  [dbo].[Fun_V_employeemsg]()
returns 
--declare 
 @V_employeemsg  table
(rkey int,chinesename varchar(20) ,employeecode varchar(20), departmentid int ,
ondutytime datetime, outdutytime datetime , employ_type int , position int , [Rank] int,Politics_face int ,
education int ,marriage int ,sex int , addr varchar(500),province varchar(50), IDCard varchar(40)
,  
Cardno varchar(30), phone varchar(30),attendance int,wagetype int,accountname varchar(30),roomcode  varchar(50),
nation varchar(30),[resume] varchar(800),others_contacts varchar(50),birthday datetime, [status] int,classgroupid  int,
departmentname varchar(40),insurance_code varchar(20) ,position_item varchar(20),classgroupcode  varchar(30) ,
marriage_item  varchar(10)

)

as 
begin 
 
insert into @V_employeemsg
select  
a.rkey,  a.chinesename,  
a.employeecode  ,  a.departmentid, a.ondutytime,  
isnull(cast (convert (nvarchar(10), a.outdutytime,120) as datetime) ,NULL) as outdutytime ,  
a.employ_type,  isnull(a.Position,0) as position,  
a.[Rank],  a.Politics_face,  a.education,  a.marriage,  a.sex,  a.addr,  a.province,  
a.IDCard , 
 a.Cardno,  a.phone,  a.attendance,  a.wagetype,  
isnull(f.accountname,'暂无') as accountname,  
a.roomcode,  a.nation,  a.resume,  a.others_contacts,  
a.birthday,  a.status,  a.classgroupid,  b.departmentname,  
isnull((select top 1 code from dbo.employee_insurance   
where employeeid=a.rkey order by startdate desc),' ') as insurance_code,   
isnull(c.item,'') as position_item,  
isnull(d.classgroupcode,'') as  classgroupcode,  
isnull(e.item,'') as marriage_item  --*/
from employeemsg a  
left join datadepartment b  on a.departmentid=b.rkey  
left join datadetail c  on a.position=c.rkey  
left join classgroup d  on a.classgroupid=d.rkey  
left join datadetail e  on a.marriage=e.rkey  
left join salaryaccount f  on a.wagetype=f.rkey  
where  isnull(outdutytime,'2999-12-31')>='2015-01-01'

return 

end

--   select *  from  FV_employeemsg()
GO
/****** Object:  UserDefinedFunction [dbo].[AvgResult3]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[AvgResult3]
(	
@gongxu varchar(10),@time varchar(10)
)
RETURNS TABLE 
AS
RETURN (
select convert(varchar(20),convert(decimal(10,0),((理论成本+理论品质+理论用水+理论用电+物料等)*1.1)),0) as ad from 
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, 
         (dbo._amibashuju.canzhi / dbo._amibamubiao.rengong * dbo._amibachengben.chengben)*1.1 as '理论成本'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji*dbo._amibamubiao.baofei*dbo._amibachengben.baofei AS '理论品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji*dbo._amibamubiao.yongshui*
                dbo._amibachengben.yongshui AS '理论用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji/dbo._amibamubiao.yongdian* 
                dbo._amibachengben.yongdian AS '理论用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu,dbo._amibashuju.wuliao+dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ dbo._amibashuju.suopei as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e.gongxu = d.gongxu
on d.gongxu = c.gongxu
on c.gongxu = b.gongxu
on b.gongxu = a.gongxu

union all

select convert(varchar(20),convert(decimal(10,0),人工+品质+用水+用电+物料等)) as chengben from 
(
SELECT   dbo._amibamainOne._time,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time


union all

select convert(varchar(20),convert(decimal(10,0),a1.shouru-b1.chengben,0)) from 
(select convert(decimal(10,2),((理论成本+理论品质+理论用水+理论用电+物料等)*1.1)) as shouru,a._time,a.gongxu from 
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, 
         (dbo._amibashuju.canzhi / dbo._amibamubiao.rengong * dbo._amibachengben.chengben)*1.1 as '理论成本'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji*dbo._amibamubiao.baofei*dbo._amibachengben.baofei AS '理论品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji*dbo._amibamubiao.yongshui*
                dbo._amibachengben.yongshui AS '理论用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji/dbo._amibamubiao.yongdian* 
                dbo._amibachengben.yongdian AS '理论用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu,dbo._amibashuju.wuliao+dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ dbo._amibashuju.suopei as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e.gongxu = d.gongxu
on d.gongxu = c.gongxu
on c.gongxu = b.gongxu
on b.gongxu = a.gongxu) a1

inner join 
(select convert(varchar(20),人工+品质+用水+用电+物料等) as chengben,a.gongxu from 
(
SELECT   dbo._amibamainOne._time,dbo._amibashuju.gongxu,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time
)b1 on a1.gongxu = b1.gongxu


union all


select convert(varchar(20),CONVERT(decimal(10,2),(a1.shouru-b1.chengben)/a1.shouru),0)+'%' from 
(select convert(decimal(10,2),((理论成本+理论品质+理论用水+理论用电+物料等)*1.1)) as shouru,a.gongxu from 
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, 
         (dbo._amibashuju.canzhi / dbo._amibamubiao.rengong * dbo._amibachengben.chengben)*1.1 as '理论成本'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji*dbo._amibamubiao.baofei*dbo._amibachengben.baofei AS '理论品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji*dbo._amibamubiao.yongshui*
                dbo._amibachengben.yongshui AS '理论用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji/dbo._amibamubiao.yongdian* 
                dbo._amibachengben.yongdian AS '理论用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu,dbo._amibashuju.wuliao+dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ dbo._amibashuju.suopei as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e.gongxu = d.gongxu
on d.gongxu = c.gongxu
on c.gongxu = b.gongxu
on b.gongxu = a.gongxu) a1


inner join 
(select 人工+品质+用水+用电+物料等 as chengben,a.gongxu from 
(
SELECT   dbo._amibamainOne._time,dbo._amibashuju.gongxu,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time
)b1 on a1.gongxu = b1.gongxu


union all




select convert(varchar(20),convert(decimal(10,0),(isnull(a2.lirun,0)-isnull(b2.lirun,0)))) from 
(select convert(varchar(20),convert(decimal(10,2),a1.shouru-b1.chengben,0)) as lirun,a1.gongxu from 
(select convert(decimal(10,2),((理论成本+理论品质+理论用水+理论用电+物料等)*1.1)) as shouru,a._time,a.gongxu from 
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, 
         (dbo._amibashuju.canzhi / dbo._amibamubiao.rengong * dbo._amibachengben.chengben)*1.1 as '理论成本'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji*dbo._amibamubiao.baofei*dbo._amibachengben.baofei AS '理论品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji*dbo._amibamubiao.yongshui*
                dbo._amibachengben.yongshui AS '理论用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji/dbo._amibamubiao.yongdian* 
                dbo._amibachengben.yongdian AS '理论用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu,dbo._amibashuju.wuliao+dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ dbo._amibashuju.suopei as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e.gongxu = d.gongxu
on d.gongxu = c.gongxu
on c.gongxu = b.gongxu
on b.gongxu = a.gongxu) a1

inner join 
(select convert(varchar(20),人工+品质+用水+用电+物料等) as chengben,a.gongxu from 
(
SELECT   dbo._amibamainOne._time,dbo._amibashuju.gongxu,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time
)b1 on a1.gongxu = b1.gongxu
) a2





FULL OUTER JOIN



(select convert(decimal(10,0),a1.shouru-b1.chengben) as lirun,a1.gongxu from 
(select convert(decimal(10,2),((理论成本+理论品质+理论用水+理论用电+物料等)*1.1)) as shouru,a._time,a.gongxu from 
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, 
         (dbo._amibashuju.canzhi / dbo._amibamubiao.rengong * dbo._amibachengben.chengben)*1.1 as '理论成本'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)a
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji*dbo._amibamubiao.baofei*dbo._amibachengben.baofei AS '理论品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji*dbo._amibamubiao.yongshui*
                dbo._amibachengben.yongshui AS '理论用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu, dbo._amibashuju.mianji/dbo._amibamubiao.yongdian* 
                dbo._amibachengben.yongdian AS '理论用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.gongxu,dbo._amibashuju.wuliao+dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ dbo._amibashuju.suopei as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)e
on e.gongxu = d.gongxu
on d.gongxu = c.gongxu
on c.gongxu = b.gongxu
on b.gongxu = a.gongxu) a1

inner join 
(select convert(varchar(20),人工+品质+用水+用电+物料等) as chengben,a.gongxu from 
(
SELECT   dbo._amibamainOne._time,dbo._amibashuju.gongxu,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time
)b1 on a1.gongxu = b1.gongxu) b2 
on a2.gongxu = b2.gongxu 

)
GO
/****** Object:  UserDefinedFunction [dbo].[AvgResult]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[AvgResult](

@gongxu varchar(10),@time varchar(10)

)

Returns table 

As


Return (
SELECT   convert(varchar(20),convert(decimal(10,0),dbo._amibashuju.canzhi)) as ad
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102)) 

union all

select convert(varchar(20),convert(decimal(10,0),人工+品质+用水+用电+物料等)) from 
(
SELECT   dbo._amibamainOne._time,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 
                INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName 
                CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time



union all

select convert(varchar(20),convert(decimal(10,0),a1.shouru-b1.chengben,0)) from 
(SELECT   convert(varchar(20),convert(decimal(10,0),dbo._amibashuju.canzhi)) as shouru,_amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID
WHERE   (dbo._amibashuju.gongxu =@gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))) a1

inner join 
(select 人工+品质+用水+用电+物料等 as chengben,a.gongxu from 
(
SELECT   dbo._amibashuju.gongxu,dbo._amibamainOne._time,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 
                INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName 
                CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time

)b1 on a1.gongxu = b1.gongxu


union all


select convert(varchar(20),CONVERT(decimal(10,2),(a1.shouru-b1.chengben)/a1.shouru),0)+'%' from 
(SELECT   convert(varchar(20),convert(decimal(10,0),dbo._amibashuju.canzhi)) as shouru,_amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID
WHERE   (dbo._amibashuju.gongxu =@gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))) a1

inner join 
(select 人工+品质+用水+用电+物料等 as chengben,a.gongxu from 
(
SELECT   dbo._amibashuju.gongxu,dbo._amibamainOne._time,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 
                INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName 
                CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time
)b1 on a1.gongxu = b1.gongxu


union all




select convert(varchar(20),convert(decimal(10,0),(isnull(a2.lirun,0)-isnull(b2.lirun,0)))) from 
(select convert(varchar(20),convert(decimal(10,0),a1.shouru-b1.chengben,0)) as lirun,a1.gongxu from 
(SELECT   convert(varchar(20),convert(decimal(10,0),dbo._amibashuju.canzhi)) as shouru,_amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID
WHERE   (dbo._amibashuju.gongxu =@gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))) a1

inner join 
(select 人工+品质+用水+用电+物料等 as chengben,a.gongxu from 
(
SELECT   dbo._amibashuju.gongxu,dbo._amibamainOne._time,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 
                INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName 
                CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time

)b1 on a1.gongxu = b1.gongxu) a2





FULL OUTER JOIN



(select convert(decimal(10,0),a1.shouru-b1.chengben) as lirun,b1.gongxu from 
(SELECT   convert(varchar(20),convert(decimal(10,0),dbo._amibashuju.canzhi)) as shouru,_amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID
WHERE   (dbo._amibashuju.gongxu =@gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))) a1

inner join 
(select 人工+品质+用水+用电+物料等 as chengben,a.gongxu from 
(
SELECT   dbo._amibashuju.gongxu,dbo._amibamainOne._time,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 
                INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName 
                CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time

)b1 on a1.gongxu = b1.gongxu) b2 
on a2.gongxu = b2.gongxu )
GO
/****** Object:  UserDefinedFunction [dbo].[AvgResult2]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[AvgResult2]
(	
	@gongxu varchar(10),@time varchar(10)
)
RETURNS TABLE 
AS
RETURN 
(
select  convert(varchar(20),CONVERT(decimal(10,0),(a.mianji * b.jiagong)),0) as ad from 
(SELECT   dbo._amibashuju.mianji ,dbo._amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 

WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME,@time, 102)))a
inner join            
(SELECT   dbo._amibamubiao.jiagong ,dbo._amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID  
INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME,@time, 102)))b 

on a.gongxu = b.gongxu

union all

select convert(varchar(20),convert(decimal(10,0),人工+品质+用水+用电+物料等)) from 
(
SELECT   dbo._amibamainOne._time,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 
                INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName 
                CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time



union all

select convert(varchar(20),convert(decimal(10,0),a1.shouru-b1.chengben,0)) from 
(select  CONVERT(decimal(9,2),(a.mianji * b.jiagong)) as shouru,a.gongxu from 
(SELECT   dbo._amibashuju.mianji ,dbo._amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 


WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME,@time, 102)))a
inner join            
(SELECT   dbo._amibamubiao.jiagong ,dbo._amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID  
INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME,@time, 102)))b 

on a.gongxu = b.gongxu) a1

inner join 
(select 人工+品质+用水+用电+物料等 as chengben,a.gongxu from 
(
SELECT   dbo._amibashuju.gongxu,dbo._amibamainOne._time,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 
                INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName 
                CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time

)b1 on a1.gongxu = b1.gongxu


union all


select convert(varchar(20),CONVERT(decimal(10,2),(a1.shouru-b1.chengben)/a1.shouru),0)+'%' from 
(select  CONVERT(decimal(9,2),(a.mianji * b.jiagong)) as shouru,a.gongxu from 
(SELECT   dbo._amibashuju.mianji ,dbo._amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 

WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102)))a
inner join            
(SELECT   dbo._amibamubiao.jiagong ,dbo._amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID  
INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102)))b 

on a.gongxu = b.gongxu) a1

inner join 
(select 人工+品质+用水+用电+物料等 as chengben,a._time,a.gongxu from 
(
SELECT   dbo._amibamainOne._time,dbo._amibashuju.gongxu,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 
                INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName 
                CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time
)b1 on a1.gongxu = b1.gongxu


union all




select convert(varchar(20),convert(decimal(10,0),(isnull(a2.lirun,0)-isnull(b2.lirun,0)))) from 
(select a1.shouru-b1.chengben as lirun,a1.gongxu from 
(select  CONVERT(decimal(10,2),(a.mianji * b.jiagong)) as shouru,a.gongxu from 
(SELECT   dbo._amibashuju.mianji ,dbo._amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 


WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME,@time, 102)))a
inner join            
(SELECT   dbo._amibamubiao.jiagong ,dbo._amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID  
INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME,@time, 102)))b 

on a.gongxu = b.gongxu) a1

inner join 
(select 人工+品质+用水+用电+物料等 as chengben,a.gongxu from 
(
SELECT   dbo._amibashuju.gongxu,dbo._amibamainOne._time,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 
                INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName 
                CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = CONVERT(DATETIME, @time, 102))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time

)b1 on a1.gongxu = b1.gongxu) a2





FULL OUTER JOIN



(select a1.shouru-b1.chengben as lirun,a1.gongxu from 
(select  CONVERT(decimal(10,0),(a.mianji * b.jiagong)) as shouru,a.gongxu from 
(SELECT   dbo._amibashuju.mianji ,dbo._amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 


WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102)))))a
inner join            
(SELECT   dbo._amibamubiao.jiagong ,dbo._amibashuju.gongxu
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID  
INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102)))))b 

on a.gongxu = b.gongxu) a1

inner join 
(select 人工+品质+用水+用电+物料等 as chengben,a.gongxu from 
(
SELECT   dbo._amibashuju.gongxu,dbo._amibamainOne._time,dbo._amibashuju.gongshi*dbo._amibachengben.chengben as '人工'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID 
                INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName 
                CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)a
join 
(
SELECT   dbo._amibamainOne._time,(dbo._amibashuju.baofeiOne+dbo._amibashuju.baofeiTwo)* dbo._amibachengben.baofei as '品质'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)b
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.yongshui* dbo._amibachengben.yongshui as '用水'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)c
join
(
SELECT   dbo._amibamainOne._time, dbo._amibachengben.yongdian* dbo._amibashuju.yongdian as '用电'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)d
join
(
SELECT   dbo._amibamainOne._time, dbo._amibashuju.zhejiu+dbo._amibashuju.fentan+ 
                dbo._amibashuju.suopei+dbo._amibashuju.wuliao as '物料等'
FROM      dbo._amibashuju INNER JOIN
                dbo._amibamainOne ON dbo._amibashuju.IDpar = dbo._amibamainOne.ID INNER JOIN
                dbo._amibamubiao ON dbo._amibashuju.gongxu = dbo._amibamubiao.gongxuName CROSS JOIN
                dbo._amibachengben
WHERE   (dbo._amibashuju.gongxu = @gongxu) AND (dbo._amibamainOne._time = dateadd(day,-1,(CONVERT(DATETIME, @time, 102))))
)e
on e._time = d._time
on d._time = c._time
on c._time = b._time
on b._time = a._time

)b1 on a1.gongxu = b1.gongxu) b2 
on a2.gongxu = b2.gongxu 
)
GO
/****** Object:  UserDefinedFunction [dbo].[fCalcDateDiffNotExistsOffDutyTime]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****传入开始结束时间返回期间耗时分钟数****/
/*需扣除中间的下班时间(不考虑周末和节假日)*/
/******* Create By LRL 2014-06-05 11:33:52.480 *******/
CREATE Function [dbo].[fCalcDateDiffNotExistsOffDutyTime](@B Datetime,@E Datetime,@Rkey243 int)
Returns INT
AS
BEGIN
Declare @FZ INT  --返回分钟数
Declare @Time1 Varchar(12),@Time2 Varchar(12),@Time3 Varchar(12),@Time4 Varchar(12)
declare @XunWen datetime,@HuiFuQueRen datetime
declare @XunWenLong int --返回回复确认的中间的时间差，扣除了休息时间
Set @Time1='08:00:00.000'
Set @Time2='12:00:00.000'
Set @Time3='13:30:00.000'
Set @Time4='17:30:00.000'
set @XunWenLong = 0

--先将开始时间、结束时间调整至上班时间段内
IF @B<Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time1) Set @B=Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time1)  --IF开始时间在8点之前,将开始之间设置为8点
IF ((@B>=Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time2)) and (@B<Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time3))) Set @B=Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time3)  --IF开始时间在12点~13:30之间,将开始时间设置为13:30
IF @B>=Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time4) Set @B=DateAdd(Day,1,Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time1))  --IF开始时间在17:30之后,将开始时间设置为次日8点

IF @E<=Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time1) Set @E=DateAdd(Day,-1,Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time4))  --IF结束时间在08:00之前,将结束时间设置为前一日17:30点
IF ((@E>Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time2)) and (@E<=Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time3))) Set @E=Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time2)  --IF结束时间在12点~13:30之间,将结束时间设置为12:00
IF @E>Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time4) Set @E=Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time4)  --IF结束时间在17:30之后,将结束时间设置为17:30

--计算耗时
IF DateDiff(day,@B,@E)<0 Set @FZ=0
ELSE
BEGIN
  IF (((@B >=Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time1)) and (@B <=Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time2)))  --开始时间在8点~12点之间
  and ((@E >=Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time1)) and (@E <=Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time2))))  --结束时间在8点~12点之间
    Set @FZ=DateDiff(mi,@B,@E)-960*DateDiff(day,@B,@E)
  ELSE  IF (((@B >=Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time3)) and (@B <=Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time4)))  --开始时间在13:30~17:30之间
  and ((@E >=Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time3)) and (@E <=Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time4))))  --结束时间在13:30~17:30之间
    Set @FZ=DateDiff(mi,@B,@E)-960*DateDiff(day,@B,@E)
  ELSE IF (((@B >=Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time1)) and (@B <=Convert(Datetime,Convert(Varchar(10),@B,120)+' '+@Time2)))  --开始时间在8点~12点之间
  and ((@E >=Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time3)) and (@E <=Convert(Datetime,Convert(Varchar(10),@E,120)+' '+@Time4))))  --结束时间在13:30~17:30之间
    Set @FZ=DateDiff(mi,@B,@E)-90-960*DateDiff(day,@B,@E)
  ELSE
    Set @FZ=DateDiff(mi,@B,@E)+90-960*DateDiff(day,@B,@E)
END

--计算回复确认时间
SELECT @XunWen=isnull(AskTime,0),@HuiFuQueRen=isnull(AnswerRecveTime,0) from Data0243 WHERE RKEY = @Rkey243
if @XunWen > @HuiFuQueRen SET @XunWenLong = 0

  IF (((@XunWen >=Convert(Datetime,Convert(Varchar(10),@XunWen,120)+' '+@Time1)) and (@XunWen <=Convert(Datetime,Convert(Varchar(10),@XunWen,120)+' '+@Time2)))  --询问时间时间在8点~12点之间
  and ((@HuiFuQueRen >=Convert(Datetime,Convert(Varchar(10),@HuiFuQueRen,120)+' '+@Time1)) and (@HuiFuQueRen <=Convert(Datetime,Convert(Varchar(10),@HuiFuQueRen,120)+' '+@Time2))))  --回复确认时间在8点~12点之间
    Set @XunWenLong=DateDiff(mi,@XunWen,@HuiFuQueRen)-960*DateDiff(day,@XunWen,@HuiFuQueRen)
  ELSE  IF (((@XunWen >=Convert(Datetime,Convert(Varchar(10),@XunWen,120)+' '+@Time3)) and (@XunWen <=Convert(Datetime,Convert(Varchar(10),@XunWen,120)+' '+@Time4)))  --询问时间时间在13:30~17:30之间
  and ((@HuiFuQueRen >=Convert(Datetime,Convert(Varchar(10),@HuiFuQueRen,120)+' '+@Time3)) and (@HuiFuQueRen <=Convert(Datetime,Convert(Varchar(10),@HuiFuQueRen,120)+' '+@Time4))))  --回复确认在13:30~17:30之间
    Set @XunWenLong=DateDiff(mi,@XunWen,@HuiFuQueRen)-960*DateDiff(day,@XunWen,@HuiFuQueRen)
  ELSE IF (((@XunWen >=Convert(Datetime,Convert(Varchar(10),@XunWen,120)+' '+@Time1)) and (@XunWen <=Convert(Datetime,Convert(Varchar(10),@XunWen,120)+' '+@Time2)))  --询问时间时间在8点~12点之间
  and ((@HuiFuQueRen >=Convert(Datetime,Convert(Varchar(10),@HuiFuQueRen,120)+' '+@Time3)) and (@HuiFuQueRen <=Convert(Datetime,Convert(Varchar(10),@HuiFuQueRen,120)+' '+@Time4))))  --回复确认在13:30~17:30之间
    Set @XunWenLong=DateDiff(mi,@XunWen,@HuiFuQueRen)-90-960*DateDiff(day,@XunWen,@HuiFuQueRen)
--  ELSE
--    Set @XunWenLong=DateDiff(mi,@XunWen,@HuiFuQueRen)+90-960*DateDiff(day,@XunWen,@HuiFuQueRen)
IF @XunWenLong < 0 SET @XunWenLong = 0

SET @FZ= @FZ - isnull(@XunWenLong,0)

--RETURN(@XunWenLong)

IF @FZ<0 Set @FZ=0

Return(@FZ)

END
GO
/****** Object:  UserDefinedFunction [dbo].[SumDateValue]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SumDateValue](@D06RKEY int, @StepNum int,@TType int)
RETURNS decimal(9, 2)
AS
BEGIN	
	DECLARE @result decimal(9, 2)

	SELECT	TOP (100) PERCENT @result=SUM(ISNULL(D586.DataValues,0)+ISNULL(D587.PROCESS_Add_TIME, 0))
	FROM	dbo.Data0025 AS D25 INNER JOIN
			dbo.Data0006 AS D06 ON D25.RKEY = D06.BOM_PTR INNER JOIN
			dbo.Data0038 AS D38 ON D25.RKEY = D38.SOURCE_PTR INNER JOIN
			dbo.Data0034 AS D34 ON D38.DEPT_PTR = D34.RKEY LEFT OUTER JOIN
          (SELECT     Rkey34, DataValues
            FROM          dbo.data0586
           where TType=@TType ) AS D586 ON D34.RKEY = D586.Rkey34  LEFT OUTER JOIN
          (select Rkey06,STEP_NUMBER,PROCESS_Add_TIME 
          from data0587 ) as D587 on D38.STEP_NUMBER=D587.STEP_NUMBER and D06.RKey=D587.Rkey06
	WHERE (D34.BARCODE_ENTRY_FLAG = 'Y') AND (D34.ACTIVE_FLAG = 0) 
	  AND (D06.RKEY = @D06RKEY) AND (D38.STEP_NUMBER <= @StepNum)

	RETURN @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[SumDateValue3]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SumDateValue3](@D06RKEY int, @StepNum int,@TType int)
RETURNS decimal(9, 2)
AS
BEGIN	
	DECLARE @result decimal(9, 2)

	SELECT	TOP (100) PERCENT @result=SUM(ISNULL(D586.DataValues,0))
	FROM	dbo.Data0025 AS D25 INNER JOIN
			dbo.Data0006 AS D06 ON D25.RKEY = D06.BOM_PTR INNER JOIN
			dbo.Data0038 AS D38 ON D25.RKEY = D38.SOURCE_PTR INNER JOIN
			dbo.Data0034 AS D34 ON D38.DEPT_PTR = D34.RKEY LEFT OUTER JOIN
          (SELECT     Rkey34, DataValues
            FROM          dbo.data0586
           where TType=@TType ) AS D586 ON D34.RKEY = D586.Rkey34 
	WHERE (D34.BARCODE_ENTRY_FLAG = 'Y') AND (D34.ACTIVE_FLAG = 0) 
	  AND (D06.RKEY = @D06RKEY) AND (D38.STEP_NUMBER >= @StepNum)

	RETURN @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[SumDateValue2]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SumDateValue2](@D06RKEY int, @StepNum int,@TType int)
RETURNS decimal(9, 2)
AS
BEGIN	
	DECLARE @result decimal(9, 2)

	SELECT	TOP (100) PERCENT @result=SUM(ISNULL(D586.DataValues,0))
	FROM	dbo.Data0025 AS D25 INNER JOIN
			dbo.Data0006 AS D06 ON D25.RKEY = D06.BOM_PTR INNER JOIN
			dbo.Data0038 AS D38 ON D25.RKEY = D38.SOURCE_PTR INNER JOIN
			dbo.Data0034 AS D34 ON D38.DEPT_PTR = D34.RKEY LEFT OUTER JOIN
          (SELECT     Rkey34, DataValues
            FROM          dbo.data0586
           where TType=@TType ) AS D586 ON D34.RKEY = D586.Rkey34 
	WHERE (D34.BARCODE_ENTRY_FLAG = 'Y') AND (D34.ACTIVE_FLAG = 0) 
	  AND (D06.RKEY = @D06RKEY) AND (D38.STEP_NUMBER <= @StepNum)

	RETURN @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetCurrTime]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[func_GetCurrTime](@D06RKEY int,@StepNum int)  
RETURNS int  
AS  
BEGIN   
 DECLARE @result int
    
 SELECT TOP (100) PERCENT @result=(ISNULL(D586.DataValues,0))  
 FROM dbo.Data0025 AS D25  
	INNER JOIN dbo.Data0006 AS D06 ON D25.RKEY = D06.BOM_PTR
	INNER JOIN dbo.Data0038 AS D38 ON D25.RKEY = D38.SOURCE_PTR  
	INNER JOIN   dbo.Data0034 AS D34 ON D38.DEPT_PTR = D34.RKEY 
	LEFT  JOIN  dbo.data0586   D586 ON D34.RKEY = D586.Rkey34  and d06.PRIORITY_CODE=d586.ttype 
 WHERE  (D06.RKEY = @D06RKEY) AND (D34.BARCODE_ENTRY_FLAG = 'Y') AND (D34.ACTIVE_FLAG = 0)   
    AND (D38.STEP_NUMBER=@StepNum)  
  
 RETURN @result  
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetCurrTimeALl]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_GetCurrTimeALl](@rkey25 int,@ttype int)  
RETURNS  int
AS  
BEGIN   
 DECLARE @result int 
   
  
 SELECT TOP (100) PERCENT @result=SUM(ISNULL(D586.DataValues,0))  
 FROM dbo.Data0025 AS D25  
	INNER JOIN dbo.Data0038 AS D38 ON D25.RKEY = D38.SOURCE_PTR  
	INNER JOIN   dbo.Data0034 AS D34 ON D38.DEPT_PTR = D34.RKEY 
	LEFT  JOIN  dbo.data0586   D586 ON D34.RKEY = D586.Rkey34  and d586.ttype=@ttype 
 WHERE  d25.rkey=@rkey25 and  (D34.BARCODE_ENTRY_FLAG = 'Y') AND (D34.ACTIVE_FLAG = 0)     
 RETURN @result  
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetCurrStep]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_GetCurrStep](@D06RKEY int)  
RETURNS int 
AS  
BEGIN     
  DECLARE @result int
 SELECT TOP (100) PERCENT @result=d38.STEP_NUMBER 
	FROM  data0056 d56
	inner join  dbo.Data0006   D06(NOLOCK)  ON d56.WO_PTR = D06.RKEY 
	inner join Data0025   D25 ON D25.RKEY = D06.BOM_PTR  
	INNER JOIN dbo.Data0038  D38 ON D25.RKEY = D38.SOURCE_PTR  and d56.DEPT_PTR=d38.DEPT_PTR   
	WHERE   (D06.RKEY = @D06RKEY) 
 RETURN @result  
END
GO
/****** Object:  UserDefinedFunction [dbo].[SumDateValue4]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[SumDateValue4](@D25RKEY int, @StepNum int,@TType int)
RETURNS decimal(9, 2)
AS
BEGIN	
	DECLARE @result decimal(9, 2)
	DECLARE @time decimal(9, 2)
	DECLARE @ROW INT
	DECLARE @i int
	DECLARE @Rkeys TABLE
	(
		keys int
	) 
	;with cte(PARENT_PTR) as
	(
	  SELECT PARENT_PTR FROM Data0025 d25 where d25.PARENT_PTR IS NOT NULL and  d25.rkey=@D25RKEY 
	  UNION ALL
	  SELECT d25_1.PARENT_PTR FROM Data0025 d25_1 INNER JOIN CTE t25 ON t25.PARENT_PTR=d25_1.rkey where d25_1.PARENT_PTR is Not NUll
	)
	--insert into @Rkeys
 --   SELECT (select stuff((select distinct ','+ltrim(PARENT_PTR) from cte for xml path('')),1,1,''))
	insert into @Rkeys
	select * from cte
	
	
	set @time=0
	DECLARE @Rky int   
	DECLARE My_Cursor CURSOR --定义游标  
	FOR (SELECT keys FROM @Rkeys) --查出需要的集合放到游标中  
	OPEN My_Cursor; --打开游标  
	FETCH NEXT FROM My_Cursor INTO @Rky; --读取第一行数据(将MemberAccount表中的UserId放到@UserId变量中)  
	WHILE @@FETCH_STATUS = 0  
	BEGIN
		
		SELECT	TOP (100) PERCENT @time= @time + SUM(ISNULL(D586.DataValues,0))
		FROM	dbo.Data0025 AS D25 INNER JOIN
				dbo.Data0038 AS D38 ON D25.RKEY = D38.SOURCE_PTR INNER JOIN
				dbo.Data0034 AS D34 ON D38.DEPT_PTR = D34.RKEY LEFT OUTER JOIN
			  (SELECT     Rkey34, DataValues
				FROM          dbo.data0586
			   where TType=@TType ) AS D586 ON D34.RKEY = D586.Rkey34 
		WHERE (D34.BARCODE_ENTRY_FLAG = 'Y') AND (D34.ACTIVE_FLAG = 0) 
		  AND (D25.RKEY in(@rky)) AND (D38.STEP_NUMBER >= @StepNum)

	FETCH NEXT FROM My_Cursor INTO @Rky; --读取下一行数据  
	END  
	CLOSE My_Cursor; --关闭游标  
	DEALLOCATE My_Cursor; --释放游标  
	   
	RETURN @time
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetParentNum]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetParentNum](@InPutRKey25 int) 
returns int
as
begin
DECLARE @RetNum int,@TmpInt int

IF not exists(SELECT 1 FROM Data0025 WHERE rkey = @InPutRKey25)
	return 0;

SELECT @RetNum = count(*) from Data0025 WHERE parent_ptr = (SELECT parent_ptr FROM Data0025 WHERE rkey = @InPutRKey25)	

if @RetNum = 0
BEGIN
	Set @RetNum = 1
end

while ISNULL(@InPutRKey25,0) > 0 
BEGIN
	SELECT @InPutRKey25 = parent_ptr FROM Data0025 WHERE rkey = @InPutRKey25
	IF @InPutRKey25 is not null 
	begin
		select @TmpInt = count(*) from Data0025 where parent_ptr = (SELECT parent_ptr from Data0025 where rkey = @InPutRKey25)
		IF @TmpInt > 0
			SET @RetNum = @RetNum * @TmpInt
	end
end

RETURN @RetNum
end
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetCurrTime_prior]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[func_GetCurrTime_prior](@D06RKEY int,@StepNum int)  
RETURNS int  
AS  
BEGIN   
 DECLARE @result int
    
 SELECT TOP (100) PERCENT @result=SUM(ISNULL(D586.DataValues,0))  
 FROM dbo.Data0025  D25  
	INNER JOIN dbo.Data0006  D06(NOLOCK) ON D25.RKEY = D06.BOM_PTR
	INNER JOIN dbo.Data0038  D38 ON D25.RKEY = D38.SOURCE_PTR  
	INNER JOIN   dbo.Data0034 D34 ON D38.DEPT_PTR = D34.RKEY 
	LEFT  JOIN  dbo.data0586  D586 ON D34.RKEY = D586.Rkey34  and d06.PRIORITY_CODE=d586.ttype 
 WHERE  (D06.RKEY = @D06RKEY) AND (D34.BARCODE_ENTRY_FLAG = 'Y') AND (D34.ACTIVE_FLAG = 0)   
    AND D38.STEP_NUMBER<=@StepNum  
  
 RETURN @result  
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetCurrTime_after]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[func_GetCurrTime_after](@D06RKEY int,@StepNum int,@StepNum2 int)  
RETURNS int  
AS  
BEGIN   
 DECLARE @result int
    
 SELECT TOP (100) PERCENT @result=SUM(ISNULL(D586.DataValues,0))  
 FROM dbo.Data0025   D25  
	INNER JOIN dbo.Data0006   D06(NOLOCK) ON D25.RKEY = D06.BOM_PTR
	INNER JOIN dbo.Data0038   D38 ON D25.RKEY = D38.SOURCE_PTR  
	INNER JOIN   dbo.Data0034   D34 ON D38.DEPT_PTR = D34.RKEY 
	LEFT  JOIN  dbo.data0586   D586 ON D34.RKEY = D586.Rkey34  and d06.PRIORITY_CODE=d586.ttype 
 WHERE  (D06.RKEY = @D06RKEY) AND (D34.BARCODE_ENTRY_FLAG = 'Y') AND (D34.ACTIVE_FLAG = 0)   
    AND (D38.STEP_NUMBER>=@StepNum and D38.STEP_NUMBER<=@StepNum2)  
  
 RETURN @result  
END
GO
/****** Object:  UserDefinedFunction [dbo].[Get_departmentid_history]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[Get_departmentid_history]
(@employeeid int,
@checkdate datetime)
Returns int
As
begin

----declare @employeeid int
----declare @checkdate datetime
----declare @departmentid int
----set @employeeid=81
----set @checkdate='2012-05-02'
----set @departmentid=37

declare @departmentid1 int


set @departmentid1=(select isnull(departmentid,0) from employeemsg 
where rkey=@employeeid)
set @departmentid1=isnull(@departmentid1,0)
---set @now_date = cast (@checkdate as datetime)
---select @departmentid1
---select @wagetype1,@now_date
------ 查询是否存在部门调动的情况
if EXISTS 
(select  *
 from dbo.employee_alteration 
where orginal_departmentid is not null 
and employeeid=@employeeid   
)
	begin
		if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
			select new_departmentid from dbo.employee_alteration 
			where employeeid=@employeeid  
            and  orginal_departmentid is not null 
			and alterdate<=@checkdate) 
		begin  ----如果存在就取最大日期记录中的新值
			set  @departmentid1=          
          (select top 1 isnull(new_departmentid,orginal_departmentid)
			from dbo.employee_alteration 
			where employeeid=@employeeid  
            and  orginal_departmentid is not null 
			and alterdate<=@checkdate
			order by alterdate desc) 

		end
		else 
		begin----如果部门调动记录中不存在调动日期小于
             ----或者等于 激活月份-01的记录
			 -----表示最早的一条记录的原值是 激活月份时期的值
            if EXISTS (select top 1 orginal_departmentid
			from dbo.employee_alteration 
			where employeeid=@employeeid  and  orginal_departmentid is not null 
			and alterdate>@checkdate order by alterdate ) 
	        begin
			 set  @departmentid1=(select top 1 orginal_departmentid
			 from dbo.employee_alteration 
			 where employeeid=@employeeid  and  orginal_departmentid is not null 
			 and alterdate>@checkdate
			 order by alterdate )
			end	
		end		
	end
----部门调动没有记录的，沿用当前部门。
---select @wagetype1,@now_date	

return @departmentid1

end
--select  [dbo].[Get_departmentid_history](1,'2007-04-01')

----select * from employee_alteration where employeeid=1 order by alterdate

----- select * from resttypemsg
GO
/****** Object:  UserDefinedFunction [dbo].[get_classnamestring]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***该过程用于将班组里的班次链名称查找出来**/  --   Written   by:   xwj    

CREATE  function  [dbo].[get_classnamestring]  ( @class_idstr  nvarchar(50) )    
  
 returns   varchar(200)   
  AS                   
BEGIN
------ 
 ---declare @class_idstr      nvarchar(50)
 ---set @class_idstr='36'---'36,36,34,32'  
 declare @class_namestr    nvarchar(50) 
 declare @str_begin     int
 declare @str_lenth      int
 declare @point			int
 set @str_begin=1
 set @str_lenth=1
 set @point=1
 set @class_namestr=''
--select @point=charindex(',','36',@point)
--select @point
select @point=charindex(',',@class_idstr,@point)
while  @point<>0
	begin
		set @str_lenth=@point-@str_begin      
		select @class_namestr=@class_namestr+classname+',' from class where rkey=substring(@class_idstr,@str_begin,@str_lenth)         
		set @point=@point+1 ---
		set @str_begin=@point
		select @point=charindex(',',@class_idstr,@point)	
	end
set @str_lenth=len(@class_idstr)-@str_begin+1
select @class_namestr=@class_namestr+classname from class where rkey=substring(@class_idstr,@str_begin,@str_lenth)
---select @str_begin
---select @str_lenth
---select @point
---select  @class_namestr
return(@class_namestr)   
end  
-- exec dbo.get_departments
GO
/****** Object:  UserDefinedFunction [dbo].[NONext]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[NONext]()
RETURNS char(15)
AS
BEGIN
DECLARE @RetNum  varchar(25)

    
  select @RetNum=(SELECT 'S'+RIGHT(1000000001+ISNULL(RIGHT(MAX(replace(SEED_VALUE,' ','')),9),0),9) FROM data0004 WITH(XLOCK,PAGLOCK) where RKEY=56 )
  return(@RetNum)
END
GO
/****** Object:  UserDefinedFunction [dbo].[f_Next]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[f_Next]()
RETURNS char(10)
AS
BEGIN
DECLARE @RetNum  varchar(25)

    
  select @RetNum=(SELECT 'V_OUT'+RIGHT(100001+ISNULL(RIGHT(MAX(replace(SEED_VALUE,' ','')),5),0),5) FROM data0004 WITH(XLOCK,PAGLOCK) where table_name='data0724' )
  return(@RetNum)
END
GO
/****** Object:  UserDefinedFunction [dbo].[VMINext]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  FUNCTION [dbo].[VMINext]()
RETURNS char(10)
AS
BEGIN
DECLARE @RetNum  varchar(25)

    
  select @RetNum=(SELECT 'VMI'+RIGHT(100001+ISNULL(RIGHT(MAX(replace(SEED_VALUE,' ','')),5),0),5) FROM data0004 WITH(XLOCK,PAGLOCK) where   table_name='data0133' )
  return(@RetNum)
END
GO
/****** Object:  UserDefinedFunction [dbo].[INNext]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[INNext]()
RETURNS char(10)
AS
BEGIN
DECLARE @RetNum  varchar(25)

    
  select @RetNum=(SELECT 'R'+RIGHT(1000001+ISNULL(RIGHT(MAX(replace(SEED_VALUE,' ','')),6),0),6) FROM data0004 WITH(XLOCK,PAGLOCK) where RKEY =57 )
  return(@RetNum)
END
GO
/****** Object:  UserDefinedFunction [dbo].[RootName]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[RootName]
(
	@meterID int,
	@meterPID int,
	@factoryID int,
	@type int=1/*1、用水小计名称；2、用水总计名称；3、用电小计名称；4、用电总计名称*/
)
returns nvarchar(50)
as
begin	
	declare @name nvarchar(50)
--------------------
-----获取用水小计名称
	if @type=1
	begin
		if(select count(1) from tblWaterMeter where PID=@meterID and FactoryID=@factoryID)>0
		begin/*如果有子水表，取上一级水表的名称，如果没有上一级则取自己*/
			set @name=isnull((select MeterName from tblWaterMeter where ID=@meterPID and FactoryID=@factoryID)
						,(select MeterName from tblWaterMeter where ID=@meterID and FactoryID=@factoryID))
		end
		else
		begin/*如果没有子水表*/
			if (select count(1) from tblWaterMeter where PID in (select ID from tblWaterMeter where PID=@meterPID))>0
			begin/*如果平级水表下有子水表*/
				if @meterPID=-1
				begin
					set @name='所有总表'
				end
				else
				begin
					set @name='其它'
				end
			end
			else
			begin/*平级水表没有子水表，则取上一级水表的名称，否则取自己*/
				set @name=isnull((select MeterName from tblWaterMeter where ID=@meterPID and FactoryID=@factoryID)
							,(select MeterName from tblWaterMeter where ID=@meterID and FactoryID=@factoryID))
			end
		end
	end
--------------------
-----获取用水总计名称
	if @type=2
	begin
		if (select count(1) from tblWaterMeter where PID in (select ID from tblWaterMeter where PID=@meterPID))>0
			begin/*如果平级水表下有子水表*/
				if (select PID from tblWaterMeter where ID=@meterPID)<1
				begin/*如果上一级水表的PID小于1，取上一级水表的名称*/
					set @name=(select MeterName from tblWaterMeter where ID=@meterPID)+' 下叶子表'
				end
				else
				begin/*否则*/
					if (select count(1) from tblWaterMeter where ID=(select PID from tblWaterMeter where id=@meterPID))<2
					begin/*上一级的上一级水表，平级的只有一个水表*/
						if (select PID from tblWaterMeter where ID=(select PID from tblWaterMeter where id=@meterPID))<1
						begin/*如果上一级水表的上一级水表PID小于1*/
							set @name=(select MeterName from tblWaterMeter where ID=(
												select PID from tblWaterMeter where id=@meterPID
										))+' 下叶子表'
						end
						else
						begin/*否则*/
							if (select PID from tblWaterMeter where ID=(
											select PID from tblWaterMeter where ID=(
												select PID from tblWaterMeter where id=@meterPID
										)))<1
								begin/*上一级水表的上一级水表的上一级水表的PID小于1，取上一级水表的上一级水表*/
									set @name=(select MeterName from tblWaterMeter where ID=(
														select PID from tblWaterMeter where id=@meterPID
												))+' 下叶子表'
								end
							else
								begin/*取上一级水表的上一级水表的上一级水表*/
									set @name=(select MeterName from tblWaterMeter where ID=(
													select PID from tblWaterMeter where ID=(
														select PID from tblWaterMeter where id=@meterPID
												)))+' 下叶子表'
								end
						end
					end
					else
					begin/*平级的有多个水表，取上一级水表的上一级水表*/
						set @name=(select MeterName from tblWaterMeter where ID=(select PID from tblWaterMeter where id=@meterPID))+' 下叶子表'
					end
				end
			end
		else
			begin/*平级水表下没有子水表*/
				if (select PID from tblWaterMeter where ID=@meterPID)<0
				begin/*上一级水表PID小于0*/
					set @name=(select MeterName from tblWaterMeter where ID=@meterPID)+' 下叶子表'
				end
				else
				begin
					if (select count(1) from tblWaterMeter where ID=(select PID from tblWaterMeter where id=@meterPID))<2
					begin/*上一级的上一级水表，平级的只有一个水表*/
						if (select PID from tblWaterMeter where ID=(select PID from tblWaterMeter where id=@meterPID))<1
						begin/*如果上一级水表的上一级水表PID小于1*/
							set @name=(select MeterName from tblWaterMeter where ID=(
												select PID from tblWaterMeter where id=@meterPID
										))+' 下叶子表'
						end
						else
						begin/*否则,取上一级水表的上一级水表的上一级水表*/
							if (select PID from tblWaterMeter where ID=(
											select PID from tblWaterMeter where ID=(
												select PID from tblWaterMeter where id=@meterPID
										)))<1
								begin/*上一级水表的上一级水表的上一级水表的PID小于1，取上一级水表的上一级水表*/
									set @name=(select MeterName from tblWaterMeter where ID=(
														select PID from tblWaterMeter where id=@meterPID
												))+' 下叶子表'
								end
							else
								begin/*取上一级水表的上一级水表的上一级水表*/
									set @name=(select MeterName from tblWaterMeter where ID=(
													select PID from tblWaterMeter where ID=(
														select PID from tblWaterMeter where id=@meterPID
												)))+' 下叶子表'
								end
						end
					end
					else
					begin/*平级的有多个水表，取上一级水表的上一级水表*/
						set @name=(select MeterName from tblWaterMeter where ID=(select PID from tblWaterMeter where id=@meterPID))+' 下叶子表'
					end
				end

			end
	end
--------------------
-----获取用电小计名称
	if @type=3
	begin
		if(select count(1) from tblElectricMeter where PID=@meterID and FactoryID=@factoryID)>0
		begin/*如果有子电表，取上一级电表的名称，如果没有上一级则取自己*/
			set @name=isnull((select MeterName from tblElectricMeter where ID=@meterPID and FactoryID=@factoryID)
						,(select MeterName from tblElectricMeter where ID=@meterID and FactoryID=@factoryID))
		end
		else
		begin/*如果没有子电表*/
			if (select count(1) from tblElectricMeter where PID in (select ID from tblElectricMeter where PID=@meterPID))>0
			begin/*如果平级电表下有子电表*/
				if @meterPID=-1
				begin
					set @name='所有总表'
				end
				else
				begin
					set @name='其它'
				end
			end
			else
			begin/*平级电表没有子电表，则取上一级电表的名称，否则取自己*/
				set @name=isnull((select MeterName from tblElectricMeter where ID=@meterPID and FactoryID=@factoryID)
							,(select MeterName from tblElectricMeter where ID=@meterID and FactoryID=@factoryID))
			end
		end
	end
--------------------
-----获取用电总计名称
	if @type=4
	begin
		if (select count(1) from tblElectricMeter where PID in (select ID from tblElectricMeter where PID=@meterPID))>0
			begin/*如果平级电表下有子电表*/
				if (select PID from tblElectricMeter where ID=@meterPID)<1
				begin/*如果上一级电表的PID小于1，取上一级电表的名称*/
					set @name=(select MeterName from tblElectricMeter where ID=@meterPID)+' 下叶子表'
				end
				else
				begin/*否则*/
					if (select count(1) from tblElectricMeter where ID=(select PID from tblElectricMeter where id=@meterPID))<2
					begin/*上一级的上一级电表，平级的只有一个电表*/
						if (select PID from tblElectricMeter where ID=(select PID from tblElectricMeter where id=@meterPID))<1
						begin/*如果上一级电表的上一级电表PID小于1*/
							set @name=(select MeterName from tblElectricMeter where ID=(
												select PID from tblElectricMeter where id=@meterPID
										))+' 下叶子表'
						end
						else
						begin/*否则*/
							if (select PID from tblElectricMeter where ID=(
											select PID from tblElectricMeter where ID=(
												select PID from tblElectricMeter where id=@meterPID
										)))<1
								begin/*上一级电表的上一级电表的上一级电表的PID小于1，取上一级电表的上一级电表*/
									set @name=(select MeterName from tblElectricMeter where ID=(
														select PID from tblElectricMeter where id=@meterPID
												))+' 下叶子表'
								end
							else
								begin/*取上一级电表的上一级电表的上一级电表*/
									set @name=(select MeterName from tblElectricMeter where ID=(
													select PID from tblElectricMeter where ID=(
														select PID from tblElectricMeter where id=@meterPID
												)))+' 下叶子表'
								end
						end
					end
					else
					begin/*平级的有多个电表，取上一级电表的上一级电表*/
						set @name=(select MeterName from tblElectricMeter where ID=(select PID from tblElectricMeter where id=@meterPID))+' 下叶子表'
					end
				end
			end
		else
			begin/*平级电表下没有子电表*/
				if (select PID from tblElectricMeter where ID=@meterPID)<0
				begin/*上一级电表PID小于0*/
					set @name=(select MeterName from tblElectricMeter where ID=@meterPID)+' 下叶子表'
				end
				else
				begin
					if (select count(1) from tblElectricMeter where ID=(select PID from tblElectricMeter where id=@meterPID))<2
					begin/*上一级的上一级电表，平级的只有一个电表*/
						if (select PID from tblElectricMeter where ID=(select PID from tblElectricMeter where id=@meterPID))<1
						begin/*如果上一级电表的上一级电表PID小于1*/
							set @name=(select MeterName from tblElectricMeter where ID=(
												select PID from tblElectricMeter where id=@meterPID
										))+' 下叶子表'
						end
						else
						begin/*否则,取上一级电表的上一级电表的上一级电表*/
							if (select PID from tblElectricMeter where ID=(
											select PID from tblElectricMeter where ID=(
												select PID from tblElectricMeter where id=@meterPID
										)))<1
								begin/*上一级电表的上一级电表的上一级电表的PID小于1，取上一级电表的上一级电表*/
									set @name=(select MeterName from tblElectricMeter where ID=(
														select PID from tblElectricMeter where id=@meterPID
												))+' 下叶子表'
								end
							else
								begin/*取上一级电表的上一级电表的上一级电表*/
									set @name=(select MeterName from tblElectricMeter where ID=(
													select PID from tblElectricMeter where ID=(
														select PID from tblElectricMeter where id=@meterPID
												)))+' 下叶子表'
								end
						end
					end
					else
					begin/*平级的有多个电表，取上一级电表的上一级电表*/
						set @name=(select MeterName from tblElectricMeter where ID=(select PID from tblElectricMeter where id=@meterPID))+' 下叶子表'
					end
				end

			end
	end

	if datalength(@name)<1
		begin/*如果没有符合的条件，则取工厂名*/
			set @name=(select Name from tblFactory where ID=@factoryID)
		end
	return	@name
end
GO
/****** Object:  UserDefinedFunction [dbo].[fun_WaterGetPerentID]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function  [dbo].[fun_WaterGetPerentID]
(  
   @ID int --参数
)
returns int
as
begin
	declare @PID int
	declare @i int
	declare @TempID int 

	set @i=0
	set @TempID=@ID

	while(@i<=500)
		begin
			SELECT    @PID = PID  FROM    tblWaterMeter    where  ID = @ID
			if(@PID=-1)
				break
			select @ID=PID from  tblWaterMeter where  ID = @ID
			set @i=@i+1
		end
		if(@TempID=@ID)
			return -1
		return  @ID
end
GO
/****** Object:  UserDefinedFunction [dbo].[fun_WaterMeterMoveCheck]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fun_WaterMeterMoveCheck] 
(
@fromID int,--要移动的表ID
@toID int--目标表ID
)
returns nvarchar(100)
as
begin
	declare @reValue nvarchar(100)--返回值
		set @reValue=''
	declare @tblChildMeter table(id int PRIMARY KEY,pid int)--要移动的表的所有子表
	declare @tblOperation table(id int);--套接公式表  
WITH t AS(
SELECT ID,PID FROM tblWaterMeter WHERE PID=@fromID 
UNION ALL  
SELECT g.ID,g.PID FROM tblWaterMeter g INNER JOIN t ON g.PID=t.ID
) --递归获取要移动表的所有子表
insert @tblChildMeter(id,pid) 
select ID,PID from t group by ID,PID  

;with w as(
select LowerMeterID from tblMeterJoinOperation where UpperMeterID=@fromID and MeterType=0
union all
select a.LowerMeterID from tblMeterJoinOperation as a 
	inner join w on a.UpperMeterID=w.LowerMeterID and a.MeterType=0
)--递归获取移动表的所有套接子表
insert @tblOperation(id)
select distinct LowerMeterID from w

if @toID in (select id from @tblChildMeter) 
	begin --如果目标表存在移动表所有子表列表
		set @reValue=N'不能移到自身的子表或叶子表下面！'
	end  
else 
	begin 
		if @toID in(select id from @tblOperation)
			begin--如果目标表存在移动表所有套接子表列表
				set @reValue=N'目标表是套接子表，套接表不能移到自身的套接子表下面！'
			end
		else 
			begin 
				if @toID in (select LowerMeterID from tblMeterJoinOperation where MeterType=0) 
						and--如果存在套接子表并且不是套接主表
				   @toID not in(select UpperMeterID from tblMeterJoinOperation where MeterType=0)
					begin--
						set @reValue=N'目标表是套接子表，涉及公式表不能移到套接子表下面！'
					end
				else
					begin
						delete @tblOperation;--清空套接表列表
						with n as(
						select UpperMeterID from tblMeterJoinOperation where LowerMeterID=(
							select distinct UpperMeterID from tblMeterJoinOperation 
									where LowerMeterID=@fromID and MeterType=0
							)
						union all
						select b.UpperMeterID from tblMeterJoinOperation as b
							inner join n on b.LowerMeterID=n.UpperMeterID and b.MeterType=0
						)--递归获取移动表的所有套接主表
						insert @tblOperation(id)
						select distinct UpperMeterID from n
						if @toID in (select id from @tblOperation)
							begin--如果目标表存在移动表所有套接主表的套接主表列表
								set @reValue=N'目标表是套接主表，套接子表不能移到套接主表的套接主表下面！'
							end
						else
							begin--都不存在返回空
								set @reValue=''
							end
					end
			end 
	end
--返回空表示可以移动
return @reValue

end
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Water_GetChildMeterTotal]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fun_Water_GetChildMeterTotal]
(
@meterPID int,--子表的PID
@readDate smalldatetime,--用水日期
@factoryID int--工厂ID
)
returns decimal(18,3)
as
begin
	declare @tempReadDate smalldatetime --读数表读数日期
	set @tempReadDate=@readDate+1--读数表读数日期＝用水日期+1(读表日期比用水推后一天)
	declare @reValue decimal(18,3)--用水变量
	declare @childDg decimal(18,3)--子表用水

	declare @tblTemp table(--所有子表列表
		ID int IDENTITY(1,1) PRIMARY KEY,--自增列
		meterID int--表ID
	)
	insert @tblTemp(meterID)--获取子表ID
	select distinct ID from tblWaterMeter where PID=@meterPID and FactoryID=@factoryID

	declare @count int--循环变量
	declare @tempCount int--循环次数
	declare @tempID int--表ID

		set @count=0--循环变量初始化
		set @tempCount=(select count(1) from @tblTemp)--循环次数初始化
	if @tempCount>0
		begin
			  while @count<@tempCount--开始循环
				begin
					set @count=@count+1--循环变量递增
					select @tempID=meterID from @tblTemp where ID=@count--获取表ID
					select @childDg=RealDegree--获取表ID的用水
						from tblWaterMeterDegree
							where WaterMeterID=@tempID and ReadDate between @tempReadDate and @tempReadDate+1
					if @childDg is null--如果没有当天用水
						begin--递归获取子表用水
							set @reValue=isnull(@reValue,0)+isnull((select dbo.fun_Water_GetChildMeterTotal(@tempID,@readDate,@factoryID)),0)
						end
					else
						begin
							set @reValue=isnull(@reValue,0)+@childDg--累计子表用水
						end
					set @childDg=null--清空
				end
		end

	return isnull(@reValue,0)
end
GO
/****** Object:  UserDefinedFunction [dbo].[fun_GetWaterMeterRootID]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function  [dbo].[fun_GetWaterMeterRootID]
(  
   @ID int
)
returns int
as
begin
	declare @PID int
	declare @RootID int 
	
	set @RootID=@ID
	select @PID=PID from  tblWaterMeter where  ID = @ID
	while(@PID<>-1)
	begin
		SET @RootID=@PID
		SELECT    @PID = PID  FROM    tblWaterMeter    where  ID = @PID
	end

	if(@ID=@RootID)
		return -1
	return  @RootID
end
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetCurrInTime]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_GetCurrInTime](@rkey06 int)  
RETURNS  datetime
AS  
BEGIN   
 DECLARE @result datetime 
   
  
 SELECT TOP (100) PERCENT @result=d56.INTIME
 FROM dbo.Data0056 d56
 WHERE   d56.WO_PTR=@rkey06
 RETURN @result  
END
GO
/****** Object:  UserDefinedFunction [dbo].[fun_WaterGetOneAccountProjectMaxStandConfig]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 function: 得到每个核算项目某年某月下面的工序用水标准最大值
 Creater:dmfu
 date:2012-05-08
*/
Create Function [dbo].[fun_WaterGetOneAccountProjectMaxStandConfig]
(@Aid  int,
 @YearNum int,
 @MonthNum int
)
returns decimal(18,3)
As
Begin

declare @StandardNum decimal(18,3)
Select @StandardNum=Max(StandardNum_Day) 
  from tblWaterUse_Dept_Standard
where YearNum=@YearNum and MonthNum=@MonthNum
and D34_Ptr in
(
	Select D34_Ptr 
	  from tblWater_AccountProject_Detail 
	  where AccountProjectID=@Aid
)
return @StandardNum
End
GO
/****** Object:  UserDefinedFunction [dbo].[Get_workdays]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
此程序 计算标准正班天 需实际出勤天
(标准正班天+法定假天=计薪天)

详细计薪天算法在工资汇总的存储过程中

calendarid=0 是标准日薪日历
calendarid=1 是标准月薪6日历
calendarid=2 是标准月薪5.5日历
*/
CREATE Function [dbo].[Get_workdays]
(@employeecode nvarchar(20),
@begindate datetime,
@enddate datetime)

----select [dbo].[Get_workdays]('88376','2012-10-01','2012-10-31')
--- select * from employeemsg where employeecode='88376'

Returns float
As
begin
---declare @begindate datetime
----declare @enddate datetime
---set @begindate='2012-04-01'
---set @enddate='2012-04-30'
declare @cur_date datetime
declare @workdays float
declare @daystotal_a int
declare @daystotal_b int
declare @daystotal_c int

set @daystotal_a=0  ----日薪需要上的天数 20140911加月薪加班（14）
set @daystotal_b=0  ----月薪6需要上的天数
set @daystotal_c=0  -----月薪5.5需要上的天数

set @workdays=0

set @cur_date=@begindate

while @cur_date<=@enddate
begin
if datepart(dw,@cur_date) not in (1,7)
	begin
		set @daystotal_a=@daystotal_a+1  ----不在周六周日就算需1天正班 日薪
	end
if datepart(dw,@cur_date) not in (1)
	begin
		set @daystotal_b=@daystotal_b+1  -----不在周日就算需1天正班 月薪6
	end
if datepart(dw,@cur_date)   in (7)
	begin
		set @daystotal_c=@daystotal_c+1  ------周六的天数，以待a来减 月薪5.5
	end 

set @cur_date=dateadd(day,1,@cur_date)

end

----select @daystotal,@cur_date
/*
dbo.Get_wagetype
(@employeeid int,
@yearmonth nvarchar(10),
@wagetype int)
*/


declare @rank int
declare @wagetype int
declare @yearmonth nvarchar(20)
set @yearmonth=substring(convert(nvarchar(20),@enddate,120),1,7)
/*以结束日期为月份统计，判断员工的计算考勤月份，如果有帐套变动的情况下会自动切换*/
select @rank=isnull([rank],0) from employeemsg where employeecode=@employeecode
select @wagetype=dbo.Get_wagetype(rkey,@yearmonth,wagetype)
from employeemsg where employeecode=@employeecode

/*月薪14人员自动转 日薪算法*/
if @wagetype=14 
begin 
set @wagetype=9 
end
-----select @wagetype
---- select * from salaryaccount
---------------日薪帐----------
if @wagetype=9
begin
select @workdays=@daystotal_a-
(select count(*) from dbo.FactoryCalendar where [type]=3 and calendarid=0
and restdate between  @begindate and @enddate )
end

/*一周上六天*/
if @wagetype=11
begin
select @workdays=@daystotal_b-
(select count(*) from dbo.FactoryCalendar where
 [type] in(3,4)  and calendarid=1
and restdate between  @begindate and @enddate )
end

/*一周上5.5天  10 月薪5.5帐*/
if @wagetype=10
begin
select @workdays=@daystotal_a+@daystotal_c/2.0 --周一五＋周六除２
-
(select count(*) from dbo.FactoryCalendar where [type] in(3)  
and calendarid=2
and restdate between  @begindate and @enddate ) ----减法假
-
isnull((select sum(
case when datepart(dw,restdate)  in (7) then 0.5 else  1 end
) from dbo.FactoryCalendar 
where [type] in(4) 
 and calendarid=2
and restdate between  @begindate and @enddate 
),0)
-
isnull((select sum(
case when datepart(dw,restdate)  in (2,3,4,5,6) then 0.5 else  0 end
) from dbo.FactoryCalendar 
where [type] in(5) 
 and calendarid=2
and restdate between  @begindate and @enddate 
),0)


end



/*东莞特有的行政辅助，标准工作天是26天 */
if @rank=611 and @wagetype=9
begin
select @workdays=@daystotal_b-
(select count(*) from dbo.FactoryCalendar 
where [type] in(3,4)  and calendarid=1
and restdate between  @begindate and @enddate )
end
---------------------



declare @ondutytime datetime,@outdutytime datetime
declare @aaa float,@bbb float

set @aaa=0 -------法定假前置
set @bbb=0 -------法定假后置

select @ondutytime=ondutytime,
@outdutytime=isnull(outdutytime,@enddate)
from employeemsg where employeecode=@employeecode


if @ondutytime>=@begindate
begin
    if @wagetype=9
	begin
	  set @aaa=
	  (select count(*) from dbo.FactoryCalendar 
	  where [type] in(3,4)  
	  and calendarid=0
	  and restdate>=@begindate 
 	  and restdate<@ondutytime )
	end
    if @wagetype=10
	begin
	  set @aaa=
	  isnull((select count(*) from dbo.FactoryCalendar 
	  where [type] in(3)  
	  and calendarid=2
	  and restdate>=@begindate 
 	  and restdate<@ondutytime ),0)
      +
      isnull((select count(*)*0.5 from dbo.FactoryCalendar 
	  where [type] in(4)  
	  and calendarid=2
	  and restdate>=@begindate 
 	  and restdate<@ondutytime 
      and datepart(dw,restdate)in (7) ),0)  ---矫正周六放假，只扣半天的
     + isnull((select count(*)*0.5  -----增加半天班的
       from dbo.FactoryCalendar 
	  where [type] in (5)  
	  and calendarid=2
	  and restdate>=@begindate 
 	  and restdate<@ondutytime ),0)
	end
    if @wagetype=11
	begin
	  set @aaa=
	  (select count(*) from dbo.FactoryCalendar 
	  where [type] in(3,4)  
	  and calendarid=1
	  and restdate>=@begindate 
 	  and restdate<@ondutytime )
	end

end 





if @outdutytime<@enddate
begin
	if @wagetype=9
	begin
		set @bbb=
		(select count(*) from dbo.FactoryCalendar 
		where [type] in(3,4)  and calendarid=0
		and restdate>@outdutytime 
		and restdate<=@enddate )
	end
	if @wagetype=10
	begin
		set @bbb=
		isnull((select count(*) from dbo.FactoryCalendar 
		where [type] in(3)  and calendarid=2
		and restdate>@outdutytime 
		and restdate<=@enddate ),0)
       +
		isnull((select count(*)*0.5 from dbo.FactoryCalendar 
		where [type] in (4)  and calendarid=2
		and restdate>@outdutytime 
		and restdate<=@enddate
        and datepart(dw,restdate)in(7)),0)  ---矫正周六放假，只扣半天的
        +
		isnull((select count(*)*0.5 from dbo.FactoryCalendar 
		where [type] in (5)  and calendarid=2
		and restdate>@outdutytime 
		and restdate<=@enddate ),0) 
		--- -----增加半天班的

	end
	if @wagetype=11
	begin
		set @bbb=
		(select count(*) from dbo.FactoryCalendar 
		where [type] in(3,4)  and calendarid=1
		and restdate>@outdutytime 
		and restdate<=@enddate )
	end

end

set @workdays=@workdays+@aaa+@bbb

return @workdays

end
---select  dbo.Get_workdays('24103','2012-04-01','2012-04-30')

---- select * from FactoryCalendar
----- select * from resttypemsg
GO
/****** Object:  UserDefinedFunction [dbo].[fun_GetOperatorDegree]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fun_GetOperatorDegree]
(
@upperMeterID int,--套接表ID
@Degree decimal(18,3),--套接表实际用水
@readDate smallDatetime,--读表日期
@meterType int--表类型
)
returns decimal(18,3)
as
begin
/**/        /*套接子表的实际度数列表*/
	declare @tblMeterDegree table(
		degree decimal(18,3)
	)
	
	if @meterType=0/*0:用水*/
		begin
			insert	@tblMeterDegree(degree)
			select	case when a.Degree<0 /*实际度数小于0*/
						 then  case when LowerOperation='+'/*运算符为加号*/
									then (((a.Loops*a.MaxDegree)+a.Degree)*a.MulTiple)/*返回负的度数*/
									else abs((((a.Loops*a.MaxDegree)+a.Degree)*a.MulTiple))/*返回正的度数*/ 
	  								end
						 else convert(decimal(18,3),LowerOperation
								+convert(varchar,(((a.Loops*a.MaxDegree)+a.Degree)*a.MulTiple)))/*将运算符与度数转换成正负数*/
						 end
			  from	tblWaterMeterDegree as a inner join/*用水读数表*/ 
					tblMeterJoinOperation as b on a.WaterMeterID=b.LowerMeterID/*套接公式表*/ 
			 where	b.UpperMeterID=@upperMeterID and b.MeterType=@meterType
					and convert(smalldatetime,convert(varchar,a.ReadDate,102))=convert(smalldatetime,convert(varchar,@readDate,102))
		end

	if @meterType=1/*1:用电*/
		begin
			insert	@tblMeterDegree(degree)
			select	case when a.Degree<0 /*实际度数小于0*/
						 then  case when LowerOperation='+'/*运算符为加号*/
									then (((a.Loops*a.MaxDegree)+a.Degree)*a.MulTiple)/*返回负的度数*/
									else abs((((a.Loops*a.MaxDegree)+a.Degree)*a.MulTiple))/*返回正的度数*/ 
	  								end
						 else convert(decimal(18,3),LowerOperation
								+convert(varchar,(((a.Loops*a.MaxDegree)+a.Degree)*a.MulTiple)))/*将运算符与度数转换成正负数*/
						 end
			  from	tblElectricMeterDegree as a inner join/*用电读数表*/ 
					tblMeterJoinOperation as b on a.ElectricMeterID=b.LowerMeterID/*套接公式表*/
			 where	b.UpperMeterID=@upperMeterID and b.MeterType=@meterType
					and convert(smalldatetime,convert(varchar,a.ReadDate,102))=convert(smalldatetime,convert(varchar,@readDate,102))
		end

	declare @retValue decimal(18,3)
		set @retValue=isnull((select sum(degree) from @tblMeterDegree),0)/*将正负数的实际度数求和*/
		set @retValue=isnull((@Degree+@retValue),0)/*将套接主表实际度数与子表之和相加得到套接表用水*/
	return @retValue
end
GO
/****** Object:  UserDefinedFunction [dbo].[SumD207]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[SumD207](@D468_ptr int,@SD datetime,@ED datetime)
returns dec(11,4)
as--转入3个参数，根据额明细表data0468的主键，返回材料发放明细在某个时间段的领料金额。
begin
declare @SUMA dec(11,4)
select @SUMA=sum(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate)
from data0207 
join data0022 on data0022.rkey=data0207.D0022_PTR 
JOIN Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY where  Data0207.D0468_ptr = @D468_ptr
and Data0207.tdate>=@SD and Data0207.tdate<@ED
return @SUMA
end
GO
/****** Object:  UserDefinedFunction [dbo].[Get_FX]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[Get_FX]
(@employeeid int,
@yearmonth nvarchar(10),
@F float,
@index int)
Returns float
As
begin
----declare @employeeid int
----declare @yearmonth nvarchar(10)
----- declare @wagetype int

----set @employeeid=1661
----set @yearmonth='2012-04'
----set @wagetype=9
declare @fx float
declare @wagetype1 int
declare @now_date  datetime  ------更新日期<=‘2012-10-01’
------（比如2012年9月生效的升迁，他的工资应该在10月份生效）
-------哪个月生效，就填哪个月的1日
set @fx=@f
set @now_date = cast (@yearmonth+'-01' as datetime)
select @wagetype1=isnull(wagetype,9) from employeemsg where rkey=@employeeid
---select @wagetype1,@now_date
------ 查询是否存在工资帐套调动的情况
/**
if EXISTS 
(select  *
 from dbo.employee_alteration 
where orginal_accountid is not null 
and employeeid=@employeeid   
)
	begin
		if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
			select new_accountid from dbo.employee_alteration 
			where employeeid=@employeeid  and  orginal_accountid is not null 
			and alterdate<=@now_date)---- 变动日期小于等于激活月份-01 
		begin  ----如果存在就取最大日期记录中的新值
			set  @wagetype1=(select top 1 new_accountid
			from dbo.employee_alteration 
			where employeeid=@employeeid  and  orginal_accountid is not null 
			and alterdate<=@now_date
			order by alterdate desc)----取最大日期记录中的新值
		end
		else 
		begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
				-----表示最早的一条记录的原值是 激活月份时期的值
			set  @wagetype1=(select top 1 orginal_accountid
			from dbo.employee_alteration 
			where employeeid=@employeeid  and  orginal_accountid is not null 
			and alterdate>@now_date
			order by alterdate )				
		end		
	end
-----
/*@wagetype1 定位完毕*/
---select @wagetype1,@now_date	
**/
if @index=1
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F1' 
     /*and accountid=@wagetype1*/ 
      and employeeid=@employeeid)
----------如果存在该员工，该帐套，该项目，的调薪记录
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
					select newdata from dbo.basicsalary_Alteration
					where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F1'  
					and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
					set  @fx=(select top 1 newdata
					from dbo.basicsalary_Alteration 
					where employeeid=@employeeid   
                     ---/*and  accountid=@wagetype1 反复调动的人，这里是BUG，2014-04-09 by fish*/ 
                     and datafield='F1'  
					and effect_date<=@now_date
					order by effect_date desc)----如果存在就取最大日期记录中的新值

					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录，
                    -------就是算工资之后的日子才调的薪
					-----表示最早的一条记录的原值是 激活月份时期的值
					set  @fx=(select top 1 originaldata
					from dbo.basicsalary_Alteration 
					where employeeid=@employeeid   
                     ---/*and  accountid=@wagetype1反复调动的人，这里是BUG，2014-04-09 by fish*/ 
                     and datafield='F1'
					and effect_date>@now_date
					order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=2
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F2' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F2'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F2'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F2'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=3
begin
  -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F3' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F3'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F3'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F3'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end

if @index=4
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F4' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F4'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F4'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F4'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end

if @index=5
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F5' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F5'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F5'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F5'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=6
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F6' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F6'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F6'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F6'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=7
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F7' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F7'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F7'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F7'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=8
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F8' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F8'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F8'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F8'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=9
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F9' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F9'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F9'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F9'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end

if @index=10
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F10' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F10'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F10'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F10'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=11
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F11' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F11'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F11'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F11'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=12
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F12' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F12'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F12'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F12'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=13
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F13' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F13'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F13'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F13'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=14
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F14' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F14'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F14'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F14'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=15
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F15' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F15'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F15'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F15'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=16
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F16' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F16'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F16'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F16'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=17
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F17' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F17'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F17'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F17'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=18
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F18' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F18'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F18'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F18'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=19
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F19' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F19'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F19'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F19'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=20
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F20' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F20'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F20'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F20'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=21
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F21' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F21'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F21'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F21'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=22
begin
 -----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F22' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F22'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F22'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F22'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=23
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F23' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F23'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F23'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F23'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=24
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F24' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F24'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F24'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F24'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
/*
李少波:  我在写个2B程序，有80个IF，每个大IF 下有3个可能，一共240个可能.
郝龙: 你亮了，这就是一个苦b程序员干的活
*/
if @index=25
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F25' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F25'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F25'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F25'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=26
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F26' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F26'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F26'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F26'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=27
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F27' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F27'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F27'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F27'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=28
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F28' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F28'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F28'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F28'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=29
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F29' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F29'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F29'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F29'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=30
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F30' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F30'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F30'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F30'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=31
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F31' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F31'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F31'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F31'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=32
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F32' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F32'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F32'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F32'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=33
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F33' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F33'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F33'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F33'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=34
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F34' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F34'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F34'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F34'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=35
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F35' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F35'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F35'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F35'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=36
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F36' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F36'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F36'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F36'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=37
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F37' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F37'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F37'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F37'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=38
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F38' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F38'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F38'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F38'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=39
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F39' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F39'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F39'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F39'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=40
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F40' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F40'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F40'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F40'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=41
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F41' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F41'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F41'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F41'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=42
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F42' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F42'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F42'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F42'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=43
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F43' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F43'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F43'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F43'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=44
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F44' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F44'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F44'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F44'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=45
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F45' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F45'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F45'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F45'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=46
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F46' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F46'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F46'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F46'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=47
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F47' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F47'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F47'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F47'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=48
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F48' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F48'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F48'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F48'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=49
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F49' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F49'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F49'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F49'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=50
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F50' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F50'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F50'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F50'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=51
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F51' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F51'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F51'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F51'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=52
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F52' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F52'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F52'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F52'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=53
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F53' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F53'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F53'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F53'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=54
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F54' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F54'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F54'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F54'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=55
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F55' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F55'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F55'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F55'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=56
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F56' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F56'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F56'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F56'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=57
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F57' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F57'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F57'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F57'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=58
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F58' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F58'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F58'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F58'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=59
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F59' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F59'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F59'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F59'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=60
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F60' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F60'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F60'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F60'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=61
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F61' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F61'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F61'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F61'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=62
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F62' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F62'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F62'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F62'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=63
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F63' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F63'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F63'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F63'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=64
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F64' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F64'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F64'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F64'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=65
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F65' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F65'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F65'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F65'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=66
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F66' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F66'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F66'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F66'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=67
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F67' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F67'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F67'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F67'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=68
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F68' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F68'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F68'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F68'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=69
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F69' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F69'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F69'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F69'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=70
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F70' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F70'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F70'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F70'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=71
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F71' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F71'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F71'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F71'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=72
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F72' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F72'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F72'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F72'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=73
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F73' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F73'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F73'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F73'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=74
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F74' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F74'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F74'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F74'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=75
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F75' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F75'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F75'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F75'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=76
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F76' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F76'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F76'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F76'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=77
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F77' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F77'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F77'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F77'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=78
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F78' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F78'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F78'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F78'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=79
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F79' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F79'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F79'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F79'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end
if @index=80
begin
-----<<<<<
if EXISTS 
	(select * from dbo.basicsalary_Alteration 
		where datafield='F80' /*and accountid=@wagetype1*/ and employeeid=@employeeid)
		begin
			if EXISTS ( ----查询是否存在 变动日期小于等于激活月份-01日的记录
				select newdata from dbo.basicsalary_Alteration
				where employeeid=@employeeid  /*and  accountid=@wagetype1*/ and datafield='F80'  
				and effect_date<=@now_date) 
					begin  ----如果存在就取最大日期记录中的新值
						set  @fx=(select top 1 newdata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F80'  
						and effect_date<=@now_date
						order by effect_date desc)
					end
					else 
					begin----如果帐套调动记录中不存在调动日期小于或者等于 激活月份-01的记录
						-----表示最早的一条记录的原值是 激活月份时期的值
						set  @fx=(select top 1 originaldata
						from dbo.basicsalary_Alteration 
						where employeeid=@employeeid   /*and  accountid=@wagetype1*/ and datafield='F80'
						and effect_date>@now_date
						order by effect_date )				
					end	
		end
-----<<<<<<<
end


return @fx

end
GO
/****** Object:  UserDefinedFunction [dbo].[fun_ElectricMeterMoveCheck]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fun_ElectricMeterMoveCheck] 
(
@fromID int,--要移动的表ID
@toID int--目标表ID
)
returns nvarchar(100)
as
begin
	declare @reValue nvarchar(100)--返回值
		set @reValue=''
	declare @tblChildMeter table(id int PRIMARY KEY,pid int)--要移动的表的所有子表
	declare @tblOperation table(id int);--套接公式表  
WITH t AS(
SELECT ID,PID FROM tblElectricMeter WHERE PID=@fromID 
UNION ALL  
SELECT g.ID,g.PID FROM tblElectricMeter g INNER JOIN t ON g.PID=t.ID
) --递归获取要移动表的所有子表
insert @tblChildMeter(id,pid) 
select ID,PID from t group by ID,PID  

;with w as(
select LowerMeterID from tblMeterJoinOperation where UpperMeterID=@fromID and MeterType=1
union all
select a.LowerMeterID from tblMeterJoinOperation as a 
	inner join w on a.UpperMeterID=w.LowerMeterID and a.MeterType=1
)--递归获取移动表的所有套接子表
insert @tblOperation(id)
select distinct LowerMeterID from w

if @toID in (select id from @tblChildMeter) 
	begin --如果目标表存在移动表所有子表列表返回1
		set @reValue=N'不能移到自身的子表或叶子表下面！'
	end  
else 
	begin 
		if @toID in(select id from @tblOperation)
			begin--如果目标表存在移动表所有套接子表列表返回2
				set @reValue=N'目标表是套接子表，套接表不能移到自身的套接子表下面！'
			end
		else 
			begin 
				if @toID in (select LowerMeterID from tblMeterJoinOperation where MeterType=1) 
						and--如果存在套接子表并且不是套接主表
				   @toID not in(select UpperMeterID from tblMeterJoinOperation where MeterType=1)
					begin--
						set @reValue=N'目标表是套接子表，涉及公式表不能移到套接子表下面！'
					end
				else
					begin
						delete @tblOperation;--清空套接表列表
						with n as(
						select UpperMeterID from tblMeterJoinOperation where LowerMeterID=(
							select distinct UpperMeterID from tblMeterJoinOperation 
									where LowerMeterID=@fromID and MeterType=1
							)
						union all
						select b.UpperMeterID from tblMeterJoinOperation as b
							inner join n on b.LowerMeterID=n.UpperMeterID and b.MeterType=1
						)--递归获取移动表的所有套接主表
						insert @tblOperation(id)
						select distinct UpperMeterID from n
						if @toID in (select id from @tblOperation)
							begin--如果目标表存在移动表所有套接主表的套接主表列表
								set @reValue=N'目标表是套接主表，套接子表不能移到套接主表的套接主表下面！'
							end
						else
							begin--都不存在返回空
								set @reValue=''
							end
					end
			end 
	end
--返回空表示可以移动
return @reValue

end
GO
/****** Object:  UserDefinedFunction [dbo].[Get_perfectattendance]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
计算全勤奖 参数(员工ID,月份,需出勤天,实出勤天)
*/
CREATE Function [dbo].[Get_perfectattendance]
(@employeeid int,
@yearmonth nvarchar(20),
@shouldworkday float,
@realworkday float
)
Returns float
As
begin
declare @money money
declare @ondutytime datetime
declare @dataflag1 datetime
declare @dataflag2 datetime
declare @dataflag3 datetime
declare @flag int

/*
declare @yearmonth nvarchar(20)
set @yearmonth='2012-04'
declare @employeeid int
set @employeeid=1
*/
set @flag=0
select @ondutytime=ondutytime from employeemsg where rkey=@employeeid

set @dataflag1=dateadd(year,1,@ondutytime)
set @dataflag2=dateadd(year,2,@ondutytime)
set @dataflag3=dateadd(year,3,@ondutytime)

if @yearmonth+'-01'>=@dataflag1
begin
set @flag=1
end
if @yearmonth+'-01'>=@dataflag2
begin
set @flag=2
end
if @yearmonth+'-01'>=@dataflag3
begin
set @flag=3
end

---select @flag
--if @shouldworkday<=@realworkday
---set @flag=@flag
if (@realworkday>=@shouldworkday)
begin
set @money=@flag*50
end

if  (@realworkday >=15) and (@realworkday <@shouldworkday)
begin
set @money=@flag*0.5*50
end

if (@realworkday<15)
begin
set @money=0
end	



---------------------
return @money

end
---select  dbo.Get_workdays('24103','2012-04-01','2012-04-30')

---- select * from FactoryCalendar
----- select * from resttypemsg
GO
/****** Object:  UserDefinedFunction [dbo].[Get_weekdays]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Function [dbo].[Get_weekdays]  
(@employeecode nvarchar(20),  
@begindate datetime,  
@enddate datetime)  
  
----select [dbo].[Get_weekdays]('88376','2012-10-01','2012-10-31')  
--- select * from employeemsg where employeecode='88376'  
  
Returns int  
As  
begin  
declare 
@employeeid  int,
@weedays float

select @employeeid=rkey from employeemsg where employeecode=@employeecode

select  @weedays=count(rkey)  from onoffdutydata where checkdate between  @begindate and  @enddate and employeeid=@employeeid  and  resttype=3

return @weedays 

end
GO
/****** Object:  UserDefinedFunction [dbo].[GetVisitRecord]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetVisitRecord]
(@returnLen int)
returns varchar(16)
begin
declare @value varchar(16)
declare @temp varchar(16)
declare @record varchar(4)

	if @returnLen=16
		begin
			set @temp=(select left(replace(replace(replace(CONVERT(varchar, getdate(), 120 ),'-',''),' ',''),':',''),12))
			set @value=(select max(Visitor_Record) from tblVisiting where Visitor_Record like @temp+'%')
			if @value is null
				begin
					set @value=@temp+'0001'
				end
			else
				begin			
					set @record=convert(varchar(20),convert(int,right(@value,4))+1)
					if len(@record)=1
						set @record='000'+@record
					if len(@record)=2
						set @record='00'+@record
					if len(@record)=3
						set @record='0'+@record
					
					set @value=@temp+@record
				end
		end

	if @returnLen=10
		begin
			set @temp=(select left(replace(replace(replace(CONVERT(varchar, getdate(), 120 ),'-',''),' ',''),':',''),8))
			set @value=(select max(Appointment_Code) from tblAppointment_Main where Appointment_Code like @temp+'%')
			if @value is null
				begin
					set @value=@temp+'001'
				end
			else
				begin			
					set @record=convert(varchar(20),convert(int,right(@value,2))+1)
					if len(@record)=1
						set @record='00'+@record
					if len(@record)=2
						set @record='0'+@record
					
					set @value=@temp+@record
				end
		end

	if @returnLen=8
		begin
			set @temp=(select left(replace(replace(replace(CONVERT(varchar, getdate(), 120 ),'-',''),' ',''),':',''),8))
			set @value=(select max(Release_Record) from tblRelease where Release_Record like @temp+'%')
			if @value is null
				begin
					set @value=@temp+'001'
				end
			else
				begin			
					set @record=convert(varchar(20),convert(int,right(@value,2))+1)
					if len(@record)=1
						set @record='00'+@record
					if len(@record)=2
						set @record='0'+@record
					
					set @value=@temp+@record
				end
		end

	return isnull(@value,'')
end
GO
/****** Object:  UserDefinedFunction [dbo].[GetVisitModifiedNote]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetVisitModifiedNote]
(@vRkey int,@rkey73 int,@type varchar(10)='',@tblIndex int= 0)
returns varchar(500)
begin
/*修改记录生成函数*/
	declare @vNote varchar(600)  /*获取原有的修改记录*/
		if @tblIndex=0
			begin
				set @vNote=(select isnull(ModifiedNote,'') from tblVisiting where RKEY=@vRkey)  
			end

		if @tblIndex=1
			begin
				set @vNote=(select isnull(Changed_Record,'') from tblRelease where RKEY=@vRkey)  
			end

	if len(@vNote)>=418
	begin  /*如果过长*/
		set @vNote=@vNote+','+(select USER_FULL_NAME+':'+@type+convert(varchar,getdate(),120) from data0073 where RKEY=@rkey73)  
		set @vNote=right(@vNote,441) /*取后面的字符*/		
	end 
	else 
	begin 
		if len(@vNote)>10 
		begin /*如果不为空*/
			set @vNote=@vNote+','+(select USER_FULL_NAME+':'+@type+convert(varchar,getdate(),120) from data0073 where RKEY=@rkey73)  
		end 
		else
		begin/**/
			set @vNote=(select USER_FULL_NAME+':'+@type+convert(varchar,getdate(),120) from data0073 where RKEY=@rkey73) 
		end 
	end 
return @vNote
end
GO
/****** Object:  UserDefinedFunction [dbo].[GetAcctQryDesc]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jacky Zhong>
-- Create date: <2016-01-25>
-- Description:	<获取凭证描述>
-- =============================================
create FUNCTION [dbo].[GetAcctQryDesc](@rkey105 int,@rkey106 int)
RETURNS nvarchar(500)
AS
BEGIN
	DECLARE @Txt nvarchar(500)
    set @Txt=''

	
	select @Txt= @Txt+'['+rtrim(Data0103.GL_ACC_NUMBER)+'/'+rtrim(Data0103.GL_DESCRIPTION)+']' from data0106 INNER JOIN Data0103 ON Data0106.GL_ACCT_NO_PTR=Data0103.RKEY
    where data0106.GL_HEADER_PTR=@rkey105 and data0106.rkey<>@rkey106 
    and IsNULL(GL_DESCRIPTION,'')<>''
    ORDER BY data0106.rkey

	RETURN @Txt

END
GO
/****** Object:  UserDefinedFunction [dbo].[fun_ElectricGetOneAccountProjectMaxStandConfig]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 function: 得到每个核算项目某年某月下面的工序用电标准最大值
 Creater:Hll
 date:2012-05-09
*/
Create Function [dbo].[fun_ElectricGetOneAccountProjectMaxStandConfig]
(@Aid  int,
 @YearNum int,
 @MonthNum int
)
returns decimal(18,3)
As
Begin

declare @StandardNum decimal(18,3)
Select @StandardNum=Max(StandardNum_Day) 
  from tblElectricUse_Dept_Standard
where YearNum=@YearNum and MonthNum=@MonthNum
and D34_Ptr in
(
	Select D34_Ptr 
	  from tblElectric_AccountProject_Detail 
	  where AccountProjectID=@Aid
)
return @StandardNum
End
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Electric_GetChildMeterTotal]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fun_Electric_GetChildMeterTotal]
(
@meterPID int,--子表的PID
@readDate smalldatetime,--用水日期
@factoryID int--工厂ID
)
returns decimal(18,3)
as
begin
	declare @tempReadDate smalldatetime --读数表读数日期
	set @tempReadDate=@readDate+1--读数表读数日期＝用水日期+1(读表日期比用水推后一天)
	declare @reValue decimal(18,3)--用水变量
	declare @childDg decimal(18,3)--子表用水

	declare @tblTemp table(--所有子表列表
		ID int IDENTITY(1,1) PRIMARY KEY,--自增列
		meterID int--表ID
	)
	insert @tblTemp(meterID)--获取子表ID
	select distinct ID from tblElectricMeter where PID=@meterPID and FactoryID=@factoryID

	declare @count int--循环变量
	declare @tempCount int--循环次数
	declare @tempID int--表ID

		set @count=0--循环变量初始化
		set @tempCount=(select count(1) from @tblTemp)--循环次数初始化
	if @tempCount>0
		begin
			  while @count<@tempCount--开始循环
				begin
					set @count=@count+1--循环变量递增
					select @tempID=meterID from @tblTemp where ID=@count--获取表ID
					select @childDg=RealDegree--获取表ID的用水
						from tblElectricMeterDegree
							where ElectricMeterID=@tempID and ReadDate between @tempReadDate and @tempReadDate+1
					if @childDg is null--如果没有当天用水
						begin--递归获取子表用水
							set @reValue=isnull(@reValue,0)+isnull((select dbo.fun_Electric_GetChildMeterTotal(@tempID,@readDate,@factoryID)),0)
						end
					else
						begin
							set @reValue=isnull(@reValue,0)+@childDg--累计子表用水
						end
					set @childDg=null--清空
				end
		end

	return isnull(@reValue,0)
end
GO
/****** Object:  UserDefinedFunction [dbo].[fun_ElectricGetPerentID]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function  [dbo].[fun_ElectricGetPerentID]
(  
   @ID int --参数
)
returns int
as
begin
	declare @PID int
	declare @i int
	declare @TempID int 

	set @i=0
	set @TempID=@ID

	while(@i<=500)
		begin
			SELECT    @PID = PID  FROM     tblElectricMeter where  ID = @ID
			if(@PID=-1)
				break
			select @ID=PID from  tblElectricMeter where  ID = @ID
			set @i=@i+1
		end
		if(@TempID=@ID)
			return -1
		return  @ID
end
GO
/****** Object:  UserDefinedFunction [dbo].[Get_shui_20151204]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**  
从2008年3也份起,国家规定个人所得税的起征点为2000元,在2000元以上才需要代扣个税,未超过的不需要交纳.   
工资、薪金所得速算扣除数   
级数 全月应纳所得额 税率(%） 速算扣除数   
1 不超过500元的部分 5% 0   
2 超过500元~2000元的部分 10% 25   
3 超过2000元~5000元的部分 15% 125   
4 超过5000元~20000元的部分 20% 375   
5 超过20000元~40000元的部分 25% 1,375   
6 超过40000元~60000元的部分 30% 3,375   
7 超过60000元~80000元的部分 35% 6,375   
8 超过80000元~100000元的部分 40% 10,375   
9 超过100000元的部分 45% 15,375  
*/  
CREATE         Function [dbo].[Get_shui_20151204](@Money float)  
Returns float  
As  
begin  
declare @yearmonth nvarchar(20)  
set @yearmonth=(select top 1 checkyearmonth from salarycheck where actived=1)  
  
Declare @Law_Money float  
if @yearmonth<'2008-03'  
Begin   
  set    @Law_Money=Round((Case when @money between 1600.00 and 2100.00 then (@money-1600.00)*0.05  
                       when @money between 2100.00 and 3600.00 then (@money-2100.00)*0.1+25  
                       when @money>3600.00  then (@money-3600)*0.15+25.00+150.00  
                          else  0  
                   End),2)  
End   
else  
if @yearmonth>'2008-03' and @yearmonth<'2011-03'  
begin  
  set    @Law_Money=Round((Case when @money between 2000.00 and 2500.00 then (@money-2000.00)*0.05  
                                when @money between 2500.00 and 4000.00 then (@money-2500)*0.1+25.00  
                                when @money>4000  then (@money-4000.00)*0.15+25.00+150.00  
                          else  0  
                   End),2)  
end  
--select dbo.Get_shui(1650,'2008-02')  
else  
if @yearmonth>='2011-03' and @yearmonth<'2011-08'  
begin  
  set    @Law_Money=Round((Case   
when @money between 2000.00 and 2500.00 then (@money-2000.00)*0.05  
when @money between 2500.00 and 4000.00 then (@money-2000)*0.1-25.00   
when @money between 4000.00 and 7000.00 then (@money-2000)*0.15-125.00  
when @money between 7000.00 and 22000.00 then (@money-2000)*0.2-375.00  
when @money between 22000.00 and 42000.00 then (@money-2000)*0.25-1375.00                         
else  0 End),2)  
end  
/**  
从2011年9y份起,国家规定个人所得税的起征点为3500元,在3500元以上才需要代扣个税,未超过的不需要交纳.   
工资、薪金所得速算扣除数   
级数 全月应纳所得额 税率(%） 速算扣除数   
1 不超过1500元的部分 3% 0   
2 超过1500元~4500元的部分 10%  105  
3 超过4500元~9000元的部分 20%  555  
4 超过9000元~35000元的部分 25% 1005  
5 超过35000元~55000元的部分 30% 2755  
6 超过55000元~80000元的部分 35% 5505  
7 超过80000元              45% 13505     
*/  
  
else   
if @yearmonth>='2011-08'  
begin  
  set    @Law_Money=Round((Case   
when @money between 3500.00 and 5000.00 then (@money-3500.00)*0.03  
when @money between 5000.00 and 8000.00 then (@money-3500)*0.1-105.00   
when @money between 8000.00 and 12500.00 then (@money-3500)*0.2-555.00  
when @money between 12500.00 and 38500.00 then (@money-3500)*0.25-1005.00  
when @money between 38500.00 and 58500.00 then (@money-3500)*0.3-2755.00   
when @money between 58500.00 and 83500.00 then (@money-3500)*0.35-5505.00  
when @money >83500.00 then (@money-3500)*0.45-13505.00                          
else  0 End),2)  
end  
  
/*  
2000-2500 5 0  
2500-4000 10 25  
4000-7000 15 125  
7000-22000 20 375  
22000-42000 25 1,375  
*/  
  
  
  
  
  
  
return @Law_money  
  
end
GO
/****** Object:  UserDefinedFunction [dbo].[Get_shui]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**        
从2008年3也份起,国家规定个人所得税的起征点为2000元,在2000元以上才需要代扣个税,未超过的不需要交纳.         
工资、薪金所得速算扣除数         
级数 全月应纳所得额 税率(%） 速算扣除数         
1 不超过500元的部分 5% 0         
2 超过500元~2000元的部分 10% 25         
3 超过2000元~5000元的部分 15% 125         
4 超过5000元~20000元的部分 20% 375         
5 超过20000元~40000元的部分 25% 1,375         
6 超过40000元~60000元的部分 30% 3,375         
7 超过60000元~80000元的部分 35% 6,375         
8 超过80000元~100000元的部分 40% 10,375         
9 超过100000元的部分 45% 15,375        
*/        
      
CREATE           Function [dbo].[Get_shui](@Money float,@num int)        
Returns float        
As        
      
begin       
      
if @num=18       
begin       
       
declare @yearmonth nvarchar(20)        
set @yearmonth=(select top 1 checkyearmonth from salarycheck where actived=1)        
        
      
      
Declare @Law_Money float        
if @yearmonth<'2008-03'        
Begin         
  set    @Law_Money=Round((Case when @money between 1600.00 and 2100.00 then (@money-1600.00)*0.05        
                       when @money between 2100.00 and 3600.00 then (@money-2100.00)*0.1+25        
                       when @money>3600.00  then (@money-3600)*0.15+25.00+150.00        
                          else  0        
                   End),2)        
End         
else        
if @yearmonth>'2008-03' and @yearmonth<'2011-03'        
begin        
  set    @Law_Money=Round((Case when @money between 2000.00 and 2500.00 then (@money-2000.00)*0.05        
                                when @money between 2500.00 and 4000.00 then (@money-2500)*0.1+25.00        
                                when @money>4000  then (@money-4000.00)*0.15+25.00+150.00        
                          else  0        
                   End),2)        
end        
--select dbo.Get_shui(1650,'2008-02')        
else        
if @yearmonth>='2011-03' and @yearmonth<'2011-08'        
begin        
  set    @Law_Money=Round((Case         
when @money between 2000.00 and 2500.00 then (@money-2000.00)*0.05        
when @money between 2500.00 and 4000.00 then (@money-2000)*0.1-25.00         
when @money between 4000.00 and 7000.00 then (@money-2000)*0.15-125.00        
when @money between 7000.00 and 22000.00 then (@money-2000)*0.2-375.00        
when @money between 22000.00 and 42000.00 then (@money-2000)*0.25-1375.00                               
else  0 End),2)        
end        
/**        
从2011年9y份起,国家规定个人所得税的起征点为3500元,在3500元以上才需要代扣个税,未超过的不需要交纳.         
工资、薪金所得速算扣除数         
级数 全月应纳所得额 税率(%） 速算扣除数         
1 不超过1500元的部分 3% 0         
2 超过1500元~4500元的部分 10%  105        
3 超过4500元~9000元的部分 20%  555        
4 超过9000元~35000元的部分 25% 1005        
5 超过35000元~55000元的部分 30% 2755        
6 超过55000元~80000元的部分 35% 5505        
7 超过80000元              45% 13505           
*/        
        
else         
if @yearmonth>='2011-08' and @yearmonth<'2018-09'       
begin        
  set    @Law_Money=Round((Case         
when @money between 3500.00 and 5000.00 then (@money-3500.00)*0.03        
when @money between 5000.00 and 8000.00 then (@money-3500)*0.1-105.00         
when @money between 8000.00 and 12500.00 then (@money-3500)*0.2-555.00        
when @money between 12500.00 and 38500.00 then (@money-3500)*0.25-1005.00        
when @money between 38500.00 and 58500.00 then (@money-3500)*0.3-2755.00         
when @money between 58500.00 and 83500.00 then (@money-3500)*0.35-5505.00        
when @money >83500.00 then (@money-5000)*0.45-13505.00                                
else  0 End),2)        
end        
else         
if @yearmonth>='2018-09'        
begin        
  set    @Law_Money=Round((Case         
when @money between 5000.00 and  8000.00 then (@money-5000.00)*0.03        
when @money between 8000.00 and  17000.00 then (@money-5000)*0.1-210.00         
when @money between 17000.00 and 30000.00 then (@money-5000)*0.2-1410.00        
when @money between 30000.00 and 40000.00 then (@money-5000)*0.25-2660.00        
when @money between 40000.00 and 60000.00 then (@money-5000)*0.3-4410.00         
when @money between 60000.00 and 85000.00 then (@money-5000)*0.35-7160.00        
when @money >85000.00 then (@money-3500)*0.45-15160.00                                
else  0 End),2)        
end         
/*        
2000-2500 5 0        
2500-4000 10 25        
4000-7000 15 125        
7000-22000 20 375        
22000-42000 25 1,375        
*/        
      
end       
else   ----外籍人士      
begin       
       
set @yearmonth=(select top 1 checkyearmonth from salarycheck where actived=1)        
        
      
      
if @yearmonth<'2008-03'        
Begin         
  set    @Law_Money=Round((Case when @money between 1600.00 and 2100.00 then (@money-1600.00)*0.05        
                       when @money between 2100.00 and 3600.00 then (@money-2100.00)*0.1+25        
                       when @money>3600.00  then (@money-3600)*0.15+25.00+150.00        
                          else  0        
                   End),2)        
End         
else        
if @yearmonth>'2008-03' and @yearmonth<'2011-03'        
begin        
  set    @Law_Money=Round((Case when @money between 2000.00 and 2500.00 then (@money-2000.00)*0.05        
                                when @money between 2500.00 and 4000.00 then (@money-2500)*0.1+25.00        
              when @money>4000  then (@money-4000.00)*0.15+25.00+150.00        
                          else  0        
                   End),2)        
end        
--select dbo.Get_shui(1650,'2008-02')        
else        
if @yearmonth>='2011-03' and @yearmonth<'2011-08'        
begin        
  set    @Law_Money=Round((Case         
when @money between 2000.00 and 2500.00 then (@money-2000.00)*0.05        
when @money between 2500.00 and 4000.00 then (@money-2000)*0.1-25.00         
when @money between 4000.00 and 7000.00 then (@money-2000)*0.15-125.00        
when @money between 7000.00 and 22000.00 then (@money-2000)*0.2-375.00        
when @money between 22000.00 and 42000.00 then (@money-2000)*0.25-1375.00                               
else  0 End),2)        
end        
/**        
从2011年9y份起,国家规定个人所得税的起征点为3500元,在3500元以上才需要代扣个税,未超过的不需要交纳.         
工资、薪金所得速算扣除数         
级数 全月应纳所得额 税率(%） 速算扣除数         
1 不超过1500元的部分 3% 0         
2 超过1500元~4500元的部分 10%  105        
3 超过4500元~9000元的部分 20%  555        
4 超过9000元~35000元的部分 25% 1005        
5 超过35000元~55000元的部分 30% 2755        
6 超过55000元~80000元的部分 35% 5505        
7 超过80000元              45% 13505           
*/        
        
else         
if @yearmonth>='2011-08'  and  @yearmonth<'2018-09'       
begin        
  set    @Law_Money=Round((Case         
--when @money between 3500.00 and 5000.00 then (@money-3500.00)*0.03        
when @money between 5000.00 and 8000.00 then (@money-4800)*0.1-105.00         
when @money between 8000.00 and 12500.00 then (@money-4800)*0.2-555.00        
when @money between 12500.00 and 38500.00 then (@money-4800)*0.25-1005.00        
when @money between 38500.00 and 58500.00 then (@money-4800)*0.3-2755.00         
when @money between 58500.00 and 83500.00 then (@money-4800)*0.35-5505.00        
when @money >83500.00 then (@money-4800)*0.45-13505.00                                
else  0 End),2)        
end       
else         
if @yearmonth>='2018-09'        
begin        
  set    @Law_Money=Round((Case         
when @money between 5000.00 and  8000.00 then (@money-5000.00)*0.03        
when @money between 8000.00 and  17000.00 then (@money-5000)*0.1-210.00         
when @money between 17000.00 and 30000.00 then (@money-5000)*0.2-1410.00        
when @money between 30000.00 and 40000.00 then (@money-5000)*0.25-2660.00        
when @money between 40000.00 and 60000.00 then (@money-5000)*0.3-4410.00         
when @money between 60000.00 and 85000.00 then (@money-5000)*0.35-7160.00        
when @money >85000.00 then (@money-5000)*0.45-15160.00                                
else  0 End),2)        
end         
        
      
end        
        
        
return @Law_money        
        
end
GO
/****** Object:  UserDefinedFunction [dbo].[Get_shui_201809]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**    
从2008年3也份起,国家规定个人所得税的起征点为2000元,在2000元以上才需要代扣个税,未超过的不需要交纳.     
工资、薪金所得速算扣除数     
级数 全月应纳所得额 税率(%） 速算扣除数     
1 不超过500元的部分 5% 0     
2 超过500元~2000元的部分 10% 25     
3 超过2000元~5000元的部分 15% 125     
4 超过5000元~20000元的部分 20% 375     
5 超过20000元~40000元的部分 25% 1,375     
6 超过40000元~60000元的部分 30% 3,375     
7 超过60000元~80000元的部分 35% 6,375     
8 超过80000元~100000元的部分 40% 10,375     
9 超过100000元的部分 45% 15,375    
*/    
  
CREATE           Function [dbo].[Get_shui_201809](@Money float,@num int)    
Returns float    
As    
  
begin   
  
if @num=18   
begin   
   
declare @yearmonth nvarchar(20)    
set @yearmonth=(select top 1 checkyearmonth from salarycheck where actived=1)    
    
  
  
Declare @Law_Money float    
if @yearmonth<'2008-03'    
Begin     
  set    @Law_Money=Round((Case when @money between 1600.00 and 2100.00 then (@money-1600.00)*0.05    
                       when @money between 2100.00 and 3600.00 then (@money-2100.00)*0.1+25    
                       when @money>3600.00  then (@money-3600)*0.15+25.00+150.00    
                          else  0    
                   End),2)    
End     
else    
if @yearmonth>'2008-03' and @yearmonth<'2011-03'    
begin    
  set    @Law_Money=Round((Case when @money between 2000.00 and 2500.00 then (@money-2000.00)*0.05    
                                when @money between 2500.00 and 4000.00 then (@money-2500)*0.1+25.00    
                                when @money>4000  then (@money-4000.00)*0.15+25.00+150.00    
                          else  0    
                   End),2)    
end    
--select dbo.Get_shui(1650,'2008-02')    
else    
if @yearmonth>='2011-03' and @yearmonth<'2011-08'    
begin    
  set    @Law_Money=Round((Case     
when @money between 2000.00 and 2500.00 then (@money-2000.00)*0.05    
when @money between 2500.00 and 4000.00 then (@money-2000)*0.1-25.00     
when @money between 4000.00 and 7000.00 then (@money-2000)*0.15-125.00    
when @money between 7000.00 and 22000.00 then (@money-2000)*0.2-375.00    
when @money between 22000.00 and 42000.00 then (@money-2000)*0.25-1375.00                           
else  0 End),2)    
end    
/**    
从2011年9y份起,国家规定个人所得税的起征点为3500元,在3500元以上才需要代扣个税,未超过的不需要交纳.     
工资、薪金所得速算扣除数     
级数 全月应纳所得额 税率(%） 速算扣除数     
1 不超过1500元的部分 3% 0     
2 超过1500元~4500元的部分 10%  105    
3 超过4500元~9000元的部分 20%  555    
4 超过9000元~35000元的部分 25% 1005    
5 超过35000元~55000元的部分 30% 2755    
6 超过55000元~80000元的部分 35% 5505    
7 超过80000元              45% 13505       
*/    
    
else     
if @yearmonth>='2011-08'    
begin    
  set    @Law_Money=Round((Case     
when @money between 3500.00 and 5000.00 then (@money-3500.00)*0.03    
when @money between 5000.00 and 8000.00 then (@money-3500)*0.1-105.00     
when @money between 8000.00 and 12500.00 then (@money-3500)*0.2-555.00    
when @money between 12500.00 and 38500.00 then (@money-3500)*0.25-1005.00    
when @money between 38500.00 and 58500.00 then (@money-3500)*0.3-2755.00     
when @money between 58500.00 and 83500.00 then (@money-3500)*0.35-5505.00    
when @money >83500.00 then (@money-3500)*0.45-13505.00                            
else  0 End),2)    
end    
    
/*    
2000-2500 5 0    
2500-4000 10 25    
4000-7000 15 125    
7000-22000 20 375    
22000-42000 25 1,375    
*/    
  
end   
else   ----外籍人士  
begin   
   
set @yearmonth=(select top 1 checkyearmonth from salarycheck where actived=1)    
    
  
  
if @yearmonth<'2008-03'    
Begin     
  set    @Law_Money=Round((Case when @money between 1600.00 and 2100.00 then (@money-1600.00)*0.05    
                       when @money between 2100.00 and 3600.00 then (@money-2100.00)*0.1+25    
                       when @money>3600.00  then (@money-3600)*0.15+25.00+150.00    
                          else  0    
                   End),2)    
End     
else    
if @yearmonth>'2008-03' and @yearmonth<'2011-03'    
begin    
  set    @Law_Money=Round((Case when @money between 2000.00 and 2500.00 then (@money-2000.00)*0.05    
                                when @money between 2500.00 and 4000.00 then (@money-2500)*0.1+25.00    
              when @money>4000  then (@money-4000.00)*0.15+25.00+150.00    
                          else  0    
                   End),2)    
end    
--select dbo.Get_shui(1650,'2008-02')    
else    
if @yearmonth>='2011-03' and @yearmonth<'2011-08'    
begin    
  set    @Law_Money=Round((Case     
when @money between 2000.00 and 2500.00 then (@money-2000.00)*0.05    
when @money between 2500.00 and 4000.00 then (@money-2000)*0.1-25.00     
when @money between 4000.00 and 7000.00 then (@money-2000)*0.15-125.00    
when @money between 7000.00 and 22000.00 then (@money-2000)*0.2-375.00    
when @money between 22000.00 and 42000.00 then (@money-2000)*0.25-1375.00                           
else  0 End),2)    
end    
/**    
从2011年9y份起,国家规定个人所得税的起征点为3500元,在3500元以上才需要代扣个税,未超过的不需要交纳.     
工资、薪金所得速算扣除数     
级数 全月应纳所得额 税率(%） 速算扣除数     
1 不超过1500元的部分 3% 0     
2 超过1500元~4500元的部分 10%  105    
3 超过4500元~9000元的部分 20%  555    
4 超过9000元~35000元的部分 25% 1005    
5 超过35000元~55000元的部分 30% 2755    
6 超过55000元~80000元的部分 35% 5505    
7 超过80000元              45% 13505       
*/    
    
else     
if @yearmonth>='2011-08'    
begin    
  set    @Law_Money=Round((Case     
--when @money between 3500.00 and 5000.00 then (@money-3500.00)*0.03    
when @money between 5000.00 and 8000.00 then (@money-4800)*0.1-105.00     
when @money between 8000.00 and 12500.00 then (@money-4800)*0.2-555.00    
when @money between 12500.00 and 38500.00 then (@money-4800)*0.25-1005.00    
when @money between 38500.00 and 58500.00 then (@money-4800)*0.3-2755.00     
when @money between 58500.00 and 83500.00 then (@money-4800)*0.35-5505.00    
when @money >83500.00 then (@money-4800)*0.45-13505.00                            
else  0 End),2)    
end   
  
    
    
    
end    
    
    
return @Law_money    
    
end
GO
/****** Object:  UserDefinedFunction [dbo].[Get_7daysnotrest]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
此程序 计算找不满足7天休1天
*/
create Function [dbo].[Get_7daysnotrest]
(@employeeid int,
@begindate datetime,
@enddate datetime)

----select [dbo].[Get_workdays]('88376','2012-10-01','2012-10-31')
--- select * from employeemsg where employeecode='88376'

Returns int
As
begin

declare @cur_date datetime
declare @work int
declare @flag int
declare @daywork int
set @work=0
set @flag=0
set @daywork=0
set @cur_date=@begindate
---select * from employeemsg where status=1
while ( @cur_date<=@enddate and @flag=0)
begin
	set @daywork = (select isnull(rwt,0)+isnull(rot,0) from  onoffdutydata 
          where employeeid=@employeeid and checkdate=@cur_date )
    if @daywork>0 
       begin
        set @work=@work +1
			 if @work>6 
				begin
					set @flag=1
					break 
				end
       end
    else 
      begin
        set @work=0     
      end  
   set @cur_date=dateadd(day,1,@cur_date)
end

Return @flag

end
---select  dbo.Get_workdays('24103','2012-04-01','2012-04-30')

---- select * from FactoryCalendar
----- select * from resttypemsg
GO
/****** Object:  UserDefinedFunction [dbo].[getplace]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[getplace](@d17ptr int) 
RETURNS varchar(8000) 
AS 
BEGIN 
    DECLARE @str varchar(8000) 
    SET @str = '' 
    SELECT    @str = stuff  ((SELECT     ',' + spec_place
 FROM  data0022 AS t   WHERE     t .INVENTORY_PTR = tb.INVENTORY_PTR  and t.QUAN_ON_HAND>0  FOR xml path('')), 1, 1, '')
FROM      Data0022 as tb  where INVENTORY_PTR=@d17ptr
    RETURN @str
END
GO
/****** Object:  UserDefinedFunction [dbo].[get_departments]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***该过程用于将后台中该部门和该部门以下的部分都查找出来**/  --   Written   by:   xwj    

CREATE  function  [dbo].[get_departments]  ( @det_id  int )    
  
 returns   varchar(4000)   
  AS                   
BEGIN
------ begin   
 declare @det_id_str     varchar(4000)
 declare  @temptemp1     table (det_id int)
 declare @flag           int
  ---declare @det_id          int
  declare @det_id_str_add  varchar(20)
  ----set @det_id=38
  set @flag=1
  set @det_id_str=cast(@det_id as  nvarchar(10))
  insert into  @temptemp1
  select @det_id  

 -- select * from @temptemp1
 --- select * from datadepartment where rkey in(select * from #temptemp1) drop table #temptemp1
  select @flag=count(*) from datadepartment   where superior in (@det_id_str)
 ---select @flag

 while @flag<>0 
 begin    
  insert into @temptemp1 
  select rkey from  datadepartment 
  where superior in (select det_id from @temptemp1)
   and  rkey not in (select det_id from @temptemp1)

  select @flag=count(*) from datadepartment  
  where superior in (select det_id from @temptemp1)
  and  rkey not in (select det_id from @temptemp1)
 end

  ----清除第一个数据,重载参数表中的数据.
delete from @temptemp1
where det_id=@det_id


declare cur cursor 
 for select  cast (det_id as nvarchar(20))  from @temptemp1 
open cur 
fetch next from cur into @det_id_str_add 
while @@fetch_status=0
begin
set @det_id_str=@det_id_str+','+@det_id_str_add
fetch next from cur
into  @det_id_str_add 
end
CLOSE cur
DEALLOCATE cur

--drop table @temptemp1
select  @det_id_str='('+@det_id_str+')'
---select  @det_id_str

return(@det_id_str)   
end   



-- exec dbo.get_departments '1','0'
GO
/****** Object:  UserDefinedFunction [dbo].[func_GetPDeptStr]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[func_GetPDeptStr](@DeptID int )
RETURNS varchar(500)
AS  
BEGIN  
DECLARE @result varchar(500)
;
with cte as
( select 0 as level,rkey as id,  superior as ParentID, cast(''  as varchar) as iDPath from datadepartment where rkey=@DeptID
union all 
select  b.level+1, a.rkey as id, a.superior as ParentID, cast(b.iDPath+'/'+cast(a.rkey  as varchar) as varchar)  as  iDPath
from datadepartment  a 
inner join   cte b on b.ParentID=a.rkey
where a.invalid=0
)
select top 1  @result=iDPath from cte order by level desc
return @result

end
GO
/****** Object:  UserDefinedFunction [dbo].[ptrchangename]    Script Date: 11/27/2018 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ptrchangename](@AUDITED_ptr Integer)
Returns varchar(255) 
begin

declare @EMPLOYEE_NAME varchar(255) 


select @EMPLOYEE_NAME=EMPLOYEE_NAME from dbo.Data0005
where rkey=@AUDITED_ptr
 

return @EMPLOYEE_NAME 

End
GO




  
-- =============================================  
-- Author:  钟祥  
-- Create date: 2012-10-09  
-- Description: 获取生产数据短信内容  
-- =============================================  
CREATE function [dbo].[fun_GetSmsContent]   
()  
returns varchar(400)  
--with encryption   
As  
Begin  
declare @msgContent as varchar(400)  
Select @msgContent=b.短信内容  
From  
 (SELECT  TOP (1)    
          '东莞五株' + CONVERT(varchar(10), DATEADD(d, - 1, GETDATE()), 102)   
        + '信息：①入库' + CONVERT(varchar, 当日入库面积) + '/' + CONVERT(varchar, 月累计入库面积)   
        + '平米，入库产值' + CONVERT(varchar, 当日入库产值) + '/' + CONVERT(varchar, 月累计入库产值)   
        + '万元，②出库' + CONVERT(varchar, 当日出库面积) + '/' + CONVERT(varchar, 月累计出库面积)   
        + '平米，出库产值' + CONVERT(varchar, 当日出库产值) + '/' + CONVERT(varchar, 月累计出库产值)   
        + '万元，③库存' + CONVERT(VARCHAR, 当前库存面积)   
        + '平米，金额' + CONVERT(varchar, 当前库存金额)   
        + '万元(其中：周期超六个月库存' + CONVERT(varchar, 超周期库存面积)   
        + '平米，金额' + CONVERT(varchar, 超周期库存金额)   
        + '万元)，④订单' + CONVERT(varchar, 当日订单面积) + '/' + CONVERT(VARCHAR, 月累计订单面积)   
        + '平米，订单未投' + CONVERT(VARCHAR, 当日订单未投面积) + '/' + CONVERT(VARCHAR, 月累计订单未投面积)   
        + '平米，⑤报废' + CONVERT(varchar, 当日报废面积) + '/' + CONVERT(varchar, 月累计报废面积)   
        + '平米，报废率' + CONVERT(varchar, 当日报废率) + '%/' + CONVERT(VARCHAR, 月报废率)   
        + '%，⑥在线' + CONVERT(VARCHAR, 当前在线面积)   
        + '平米，在线暂缓' + CONVERT(varchar, 当前在线暂缓面积)   
        + '平米，退货' + CONVERT(varchar, 当日退货面积) + '/' + CONVERT(VARCHAR, 月累计退货面积)   
        + '平米' AS 短信内容  
   FROM View_SMS) as b  
return @msgContent  
End


go