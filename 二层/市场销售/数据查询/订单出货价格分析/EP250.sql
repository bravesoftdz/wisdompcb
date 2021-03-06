USE [sj_v20_live]
GO
/****** 对象:  StoredProcedure [dbo].[EP250]    脚本日期: 09/23/2008 09:05:57 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[EP250]

@vtp int,
@vprod varchar(10),
@vcust varchar(10),
@vproj varchar(20),
@vpart varchar(40),
@vsales varchar(5),
@vdate1 datetime,
@vdate2 datetime
as

SELECT dbo.Data0008.PROD_CODE, Data0009_2.REP_CODE, 
      dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_NUMBER, 
      dbo.Data0025.MANU_PART_DESC,dbo.Data0060.PART_PRICE, 
      dbo.Data0085.total_cost / dbo.Data0085.CURR_RATE AS TOTAL_COST, 
      dbo.Data0060.PARTS_ORDERED, dbo.Data0085.MARKUP AS MARKUP_RATE, 
      dbo.Data0064.DATE_SHIPPED, dbo.Data0001.CURR_CODE, dbo.Data0085.TTYPE, 
      SUM(dbo.Data0064.QUAN_SHIPPED) AS quan_shipped, 
      SUM(dbo.Data0064.QUAN_SHIPPED * dbo.Data0060.PART_PRICE / dbo.Data0060.EXCH_RATE)
       AS amount,Data0025.unit_sq
FROM  dbo.Data0001 INNER JOIN
      dbo.Data0025 INNER JOIN
      dbo.Data0010 INNER JOIN
      dbo.Data0060 ON dbo.Data0010.RKEY = dbo.Data0060.CUSTOMER_PTR ON 
      dbo.Data0025.RKEY = dbo.Data0060.CUST_PART_PTR 
       INNER JOIN
      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY ON 
      dbo.Data0001.RKEY = dbo.Data0060.CURRENCY_PTR INNER JOIN
      dbo.Data0064 ON dbo.Data0060.RKEY = dbo.Data0064.SO_PTR  inner join
      dbo.Data0085 ON dbo.Data0060.QTE_PTR = dbo.Data0085.RKEY LEFT OUTER JOIN
      dbo.Data0009 Data0009_2 ON dbo.Data0085.SREP_PTR = Data0009_2.RKEY
where 
dbo.Data0025.PARENT_PTR Is NULL and data0064.DATE_SHIPPED>=@VDATE1 AND
            data0064.DATE_SHIPPED<@VDATE2 and 
              data0060.so_tp=@vtp
	and data0010.cust_code like @vcust
	and data0025.MANU_PART_NUMBER like @vproj
	and Data0025.MANU_PART_DESC like @vpart
	and ((Data0009_2.rep_code like @vsales) or (@vsales='%'))
	and data0008.prod_code like @vprod  and Data0064.assign_type=0

GROUP BY dbo.Data0008.PROD_CODE, Data0009_2.REP_CODE, 
      dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_NUMBER, 
      dbo.Data0025.MANU_PART_DESC, 
      dbo.Data0060.PART_PRICE, dbo.Data0060.PARTS_ORDERED, 
      dbo.Data0085.MARKUP, dbo.Data0064.DATE_SHIPPED, dbo.Data0001.CURR_CODE, 
      dbo.Data0085.TTYPE, dbo.Data0025.unit_sq ,
      dbo.Data0060.EXCH_RATE, dbo.Data0085.total_cost, 
      dbo.Data0085.CURR_RATE
ORDER BY dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_DESC,date_shipped
GO
/****** 对象:  NumberedStoredProcedure [dbo].[EP250];2    脚本日期: 09/23/2008 09:05:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER  PROCEDURE [dbo].[EP250];2
@vcust varchar(10)
as
select rkey,cust_code,customer_name 
from data0010 
where cust_code like @vcust
order by cust_code
GO
/****** 对象:  NumberedStoredProcedure [dbo].[EP250];3    脚本日期: 09/23/2008 09:05:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[EP250];3
as
select rkey,rep_code,sales_rep_name,class from data0009
order by rep_code
GO
/****** 对象:  NumberedStoredProcedure [dbo].[EP250];4    脚本日期: 09/23/2008 09:05:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[EP250];4
as
select rkey,PARAMETER_NAME,PARAMETER_DESC FROM DATA0278
WHERE CATEGORY_PTR=1 AND RKEY>3
GO
/****** 对象:  NumberedStoredProcedure [dbo].[EP250];5    脚本日期: 09/23/2008 09:05:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[EP250];5

@vtp int,
@vprod varchar(10),
@vcust varchar(10),
@vproj varchar(20),
@vpart varchar(40),
@vsales varchar(5),

@vdate1 datetime,
@vdate2 datetime
as


SELECT dbo.Data0008.PROD_CODE, Data0009_2.REP_CODE, 
      dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_NUMBER, 
      dbo.Data0025.MANU_PART_DESC,dbo.Data0060.PART_PRICE, 
      dbo.Data0085.total_cost / dbo.Data0085.CURR_RATE AS TOTAL_COST, 
      dbo.Data0060.PARTS_ORDERED, dbo.Data0085.MARKUP AS MARKUP_RATE, 
      dbo.Data0098.RMA_DATE AS DATE_SHIPPED, dbo.Data0001.CURR_CODE, 
      dbo.Data0085.TTYPE, dbo.Data0098.QTY_AUTH AS quan_shipped, 
      dbo.Data0098.QTY_AUTH * dbo.Data0060.PART_PRICE / dbo.Data0060.EXCH_RATE AS
       amount,Data0025.unit_sq

FROM  dbo.Data0001 INNER JOIN
      dbo.Data0025 INNER JOIN
      dbo.Data0010 INNER JOIN
      dbo.Data0060 ON dbo.Data0010.RKEY = dbo.Data0060.CUSTOMER_PTR ON 
      dbo.Data0025.RKEY = dbo.Data0060.CUST_PART_PTR 
       INNER JOIN
      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY ON 
      dbo.Data0001.RKEY = dbo.Data0060.CURRENCY_PTR INNER JOIN
      dbo.Data0098 ON dbo.Data0060.RKEY = dbo.Data0098.SO_PTR  inner join
      dbo.Data0085 ON dbo.Data0060.QTE_PTR = dbo.Data0085.RKEY LEFT OUTER JOIN
      dbo.Data0009 Data0009_2 ON dbo.Data0085.SREP_PTR = Data0009_2.RKEY

where  dbo.Data0025.PARENT_PTR Is NULL and data0098.RMA_DATE>=@VDATE1 AND data0098.RMA_DATE<@VDATE2
   and data0060.so_tp=@vtp
	and data0010.cust_code like @vcust
	and data0025.MANU_PART_NUMBER like @vproj
	and Data0025.MANU_PART_DESC like @vpart
	and ((Data0009_2.rep_code like @vsales) or (@vsales='%'))
	and data0008.prod_code like @vprod 

ORDER BY dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_DESC
GO
/****** 对象:  NumberedStoredProcedure [dbo].[EP250];6    脚本日期: 09/23/2008 09:05:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[EP250];6

@vtp int,
@vprod varchar(10),
@vcust varchar(10),
@vproj varchar(20),
@vpart varchar(40),
@vsales varchar(5),
@vdate1 datetime,
@vdate2 datetime,
@rkey73 varchar(10)
as

SELECT dbo.Data0008.PROD_CODE, Data0009_2.REP_CODE, 
      dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_NUMBER, 
      dbo.Data0025.MANU_PART_DESC,dbo.Data0060.PART_PRICE, 
      round(dbo.Data0085.total_cost / dbo.Data0085.CURR_RATE,6) AS TOTAL_COST, 
      dbo.Data0060.PARTS_ORDERED, dbo.Data0085.MARKUP AS MARKUP_RATE, 
      dbo.Data0064.DATE_SHIPPED, dbo.Data0001.CURR_CODE, 
      CASE dbo.Data0085.TTYPE 
       WHEN 0 THEN '快速报价'
       WHEN 1 THEN '完全报价'
       WHEN 2 THEN '样板报价'
       WHEN 3 THEN '批量报价'
      END AS TTYPE, 
      SUM(ISNULL(dbo.Data0064.QUAN_SHIPPED,0)) AS quan_shipped, 
      SUM(dbo.Data0064.QUAN_SHIPPED * dbo.Data0060.PART_PRICE / dbo.Data0060.EXCH_RATE)
       AS amount,ISNULL(Data0025.unit_sq,0) AS unit_sq,
      SUM(ISNULL(dbo.Data0064.QUAN_SHIPPED,0))*ISNULL(Data0025.unit_sq,0) AS TotalArea
FROM  dbo.Data0001 INNER JOIN
      dbo.Data0025 INNER JOIN
      dbo.Data0010 INNER JOIN
      dbo.Data0060 ON dbo.Data0010.RKEY = dbo.Data0060.CUSTOMER_PTR ON 
      dbo.Data0025.RKEY = dbo.Data0060.CUST_PART_PTR 
       INNER JOIN
      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY ON 
      dbo.Data0001.RKEY = dbo.Data0060.CURRENCY_PTR INNER JOIN
      dbo.Data0064 ON dbo.Data0060.RKEY = dbo.Data0064.SO_PTR  inner join
      dbo.Data0085 ON dbo.Data0060.QTE_PTR = dbo.Data0085.RKEY LEFT OUTER JOIN
      dbo.Data0009 Data0009_2 ON dbo.Data0085.SREP_PTR = Data0009_2.RKEY
WHERE 
      dbo.Data0025.PARENT_PTR Is NULL AND
      data0064.DATE_SHIPPED>=@VDATE1 AND data0064.DATE_SHIPPED<@VDATE2 AND 
      data0060.so_tp=@vtp AND
      data0010.cust_code like @vcust AND
      data0010.rkey in (SELECT  CUSTOMER_PTR
                        FROM       dbo.DATA0100
                        WHERE     (CSI_PTR = @rkey73)) AND
      data0025.MANU_PART_NUMBER like @vproj AND
      Data0025.MANU_PART_DESC like @vpart AND
      ((Data0009_2.rep_code like @vsales) or (@vsales='%')) and
      data0008.prod_code like @vprod  and Data0064.assign_type=0 
GROUP BY dbo.Data0008.PROD_CODE, Data0009_2.REP_CODE, 
      dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_NUMBER, 
      dbo.Data0025.MANU_PART_DESC, 
      dbo.Data0060.PART_PRICE, dbo.Data0060.PARTS_ORDERED, 
      dbo.Data0085.MARKUP, dbo.Data0064.DATE_SHIPPED, dbo.Data0001.CURR_CODE, 
      dbo.Data0085.TTYPE, dbo.Data0025.unit_sq ,
      dbo.Data0060.EXCH_RATE, dbo.Data0085.total_cost, 
      dbo.Data0085.CURR_RATE
ORDER BY dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_DESC,date_shipped



GO
/****** 对象:  NumberedStoredProcedure [dbo].[EP250];7    脚本日期: 09/23/2008 09:05:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[EP250];7

@vtp int,
@vprod varchar(10),
@vcust varchar(10),
@vproj varchar(20),
@vpart varchar(40),
@vsales varchar(5),

@vdate1 datetime,
@vdate2 datetime,
@rkey73 varchar(10)
as


SELECT dbo.Data0008.PROD_CODE, Data0009_2.REP_CODE, 
      dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_NUMBER, 
      dbo.Data0025.MANU_PART_DESC,dbo.Data0060.PART_PRICE, 
      round(dbo.Data0085.total_cost / dbo.Data0085.CURR_RATE,6) AS TOTAL_COST, 
      dbo.Data0060.PARTS_ORDERED, dbo.Data0085.MARKUP AS MARKUP_RATE, 
      dbo.Data0098.RMA_DATE AS DATE_SHIPPED, dbo.Data0001.CURR_CODE, 
      CASE dbo.Data0085.TTYPE 
       WHEN 0 THEN '快速报价'
       WHEN 1 THEN '完全报价'
       WHEN 2 THEN '样板报价'
       WHEN 3 THEN '批量报价'
      END AS TTYPE, ISNULL(dbo.Data0098.QTY_AUTH,0) AS quan_shipped, 
      dbo.Data0098.QTY_AUTH * dbo.Data0060.PART_PRICE / dbo.Data0060.EXCH_RATE AS
       amount,ISNULL(Data0025.unit_sq,0) AS unit_sq,
      ISNULL(dbo.Data0098.QTY_AUTH,0)*ISNULL(Data0025.unit_sq,0) AS TotalArea
FROM  dbo.Data0001 INNER JOIN
      dbo.Data0025 INNER JOIN
      dbo.Data0010 INNER JOIN
      dbo.Data0060 ON dbo.Data0010.RKEY = dbo.Data0060.CUSTOMER_PTR ON 
      dbo.Data0025.RKEY = dbo.Data0060.CUST_PART_PTR 
       INNER JOIN
      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY ON 
      dbo.Data0001.RKEY = dbo.Data0060.CURRENCY_PTR INNER JOIN
      dbo.Data0098 ON dbo.Data0060.RKEY = dbo.Data0098.SO_PTR  inner join
      dbo.Data0085 ON dbo.Data0060.QTE_PTR = dbo.Data0085.RKEY LEFT OUTER JOIN
      dbo.Data0009 Data0009_2 ON dbo.Data0085.SREP_PTR = Data0009_2.RKEY

where  dbo.Data0025.PARENT_PTR Is NULL and data0098.RMA_DATE>=@VDATE1 AND data0098.RMA_DATE<@VDATE2
    and data0060.so_tp=@vtp
	and data0010.cust_code like @vcust
	and data0010.rkey in (SELECT   CUSTOMER_PTR
                          FROM       dbo.DATA0100
                          WHERE     (CSI_PTR = @rkey73))
    and data0025.MANU_PART_NUMBER like @vproj
	and Data0025.MANU_PART_DESC like @vpart
	and ((Data0009_2.rep_code like @vsales) or (@vsales='%'))
	and data0008.prod_code like @vprod 

ORDER BY dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_DESC


GO
/****** 对象:  NumberedStoredProcedure [dbo].[EP250];8    脚本日期: 09/23/2008 09:05:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[EP250];8

@vtp int,
@vprod varchar(10),
@vcust varchar(10),
@vproj varchar(20),
@vpart varchar(40),
@vsales varchar(5),
@vdate1 datetime,
@vdate2 datetime,
@rkey73 varchar(10)
as

SELECT dbo.Data0008.PROD_CODE, Data0009_2.REP_CODE, 
      dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_NUMBER, 
      dbo.Data0025.MANU_PART_DESC,dbo.Data0060.PART_PRICE, 
      round(dbo.Data0085.total_cost / dbo.Data0085.CURR_RATE,6) AS TOTAL_COST, 
      dbo.Data0060.PARTS_ORDERED, dbo.Data0085.MARKUP AS MARKUP_RATE, 
      dbo.Data0064.DATE_SHIPPED, dbo.Data0001.CURR_CODE, 
      CASE dbo.Data0085.TTYPE 
       WHEN 0 THEN '快速报价'
       WHEN 1 THEN '完全报价'
       WHEN 2 THEN '样板报价'
       WHEN 3 THEN '批量报价'
      END AS TTYPE, 
      SUM(ISNULL(dbo.Data0064.QUAN_SHIPPED,0)) AS quan_shipped, 
      SUM(dbo.Data0064.QUAN_SHIPPED * dbo.Data0060.PART_PRICE / dbo.Data0060.EXCH_RATE)
       AS amount,ISNULL(Data0025.unit_sq,0) AS unit_sq,
      SUM(ISNULL(dbo.Data0064.QUAN_SHIPPED,0))*ISNULL(Data0025.unit_sq,0) AS TotalArea
FROM  dbo.Data0001 INNER JOIN
      dbo.Data0025 INNER JOIN
      dbo.Data0010 INNER JOIN
      dbo.Data0060 ON dbo.Data0010.RKEY = dbo.Data0060.CUSTOMER_PTR ON 
      dbo.Data0025.RKEY = dbo.Data0060.CUST_PART_PTR 
       INNER JOIN
      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY ON 
      dbo.Data0001.RKEY = dbo.Data0060.CURRENCY_PTR INNER JOIN
      dbo.Data0064 ON dbo.Data0060.RKEY = dbo.Data0064.SO_PTR  inner join
      dbo.Data0085 ON dbo.Data0060.QTE_PTR = dbo.Data0085.RKEY LEFT OUTER JOIN
      dbo.Data0009 Data0009_2 ON dbo.Data0085.SREP_PTR = Data0009_2.RKEY
WHERE 
      dbo.Data0025.PARENT_PTR Is NULL AND
      data0064.DATE_SHIPPED>=@VDATE1 AND data0064.DATE_SHIPPED<@VDATE2 AND 
      data0060.so_tp=@vtp AND
      data0010.cust_code like @vcust AND
      data0025.MANU_PART_NUMBER like @vproj AND
      Data0025.MANU_PART_DESC like @vpart AND
      ((Data0009_2.rep_code like @vsales) or (@vsales='%')) and
      data0008.prod_code like @vprod  and Data0064.assign_type=0 
GROUP BY dbo.Data0008.PROD_CODE, Data0009_2.REP_CODE, 
      dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_NUMBER, 
      dbo.Data0025.MANU_PART_DESC, 
      dbo.Data0060.PART_PRICE, dbo.Data0060.PARTS_ORDERED, 
      dbo.Data0085.MARKUP, dbo.Data0064.DATE_SHIPPED, dbo.Data0001.CURR_CODE, 
      dbo.Data0085.TTYPE, dbo.Data0025.unit_sq ,
      dbo.Data0060.EXCH_RATE, dbo.Data0085.total_cost, 
      dbo.Data0085.CURR_RATE
ORDER BY dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_DESC,date_shipped


GO
/****** 对象:  NumberedStoredProcedure [dbo].[EP250];9    脚本日期: 09/23/2008 09:05:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[EP250];9

@vtp int,
@vprod varchar(10),
@vcust varchar(10),
@vproj varchar(20),
@vpart varchar(40),
@vsales varchar(5),

@vdate1 datetime,
@vdate2 datetime,
@rkey73 varchar(10)
as


SELECT dbo.Data0008.PROD_CODE, Data0009_2.REP_CODE, 
      dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_NUMBER, 
      dbo.Data0025.MANU_PART_DESC,dbo.Data0060.PART_PRICE, 
      round(dbo.Data0085.total_cost / dbo.Data0085.CURR_RATE,6) AS TOTAL_COST, 
      dbo.Data0060.PARTS_ORDERED, dbo.Data0085.MARKUP AS MARKUP_RATE, 
      dbo.Data0098.RMA_DATE AS DATE_SHIPPED, dbo.Data0001.CURR_CODE, 
      CASE dbo.Data0085.TTYPE 
       WHEN 0 THEN '快速报价'
       WHEN 1 THEN '完全报价'
       WHEN 2 THEN '样板报价'
       WHEN 3 THEN '批量报价'
      END AS TTYPE, ISNULL(dbo.Data0098.QTY_AUTH,0) AS quan_shipped, 
      dbo.Data0098.QTY_AUTH * dbo.Data0060.PART_PRICE / dbo.Data0060.EXCH_RATE AS
       amount,ISNULL(Data0025.unit_sq,0) AS unit_sq,
      ISNULL(dbo.Data0098.QTY_AUTH,0)*ISNULL(Data0025.unit_sq,0) AS TotalArea
FROM  dbo.Data0001 INNER JOIN
      dbo.Data0025 INNER JOIN
      dbo.Data0010 INNER JOIN
      dbo.Data0060 ON dbo.Data0010.RKEY = dbo.Data0060.CUSTOMER_PTR ON 
      dbo.Data0025.RKEY = dbo.Data0060.CUST_PART_PTR 
       INNER JOIN
      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY ON 
      dbo.Data0001.RKEY = dbo.Data0060.CURRENCY_PTR INNER JOIN
      dbo.Data0098 ON dbo.Data0060.RKEY = dbo.Data0098.SO_PTR  inner join
      dbo.Data0085 ON dbo.Data0060.QTE_PTR = dbo.Data0085.RKEY LEFT OUTER JOIN
      dbo.Data0009 Data0009_2 ON dbo.Data0085.SREP_PTR = Data0009_2.RKEY

where  dbo.Data0025.PARENT_PTR Is NULL and data0098.RMA_DATE>=@VDATE1 AND data0098.RMA_DATE<@VDATE2
    and data0060.so_tp=@vtp
	and data0010.cust_code like @vcust
    and data0025.MANU_PART_NUMBER like @vproj
	and Data0025.MANU_PART_DESC like @vpart
	and ((Data0009_2.rep_code like @vsales) or (@vsales='%'))
	and data0008.prod_code like @vprod 

ORDER BY dbo.Data0010.CUST_CODE, dbo.Data0025.MANU_PART_DESC

