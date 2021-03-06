USE [wisdompcb]
GO
/****** Object:  View [dbo].[v_empandextra]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_empandextra]
AS
SELECT     rkey, employeecode, departmentname, chinesename, ranks, 'local' AS factorytype, status
FROM         dbo.v_employeemsg
--union 
--SELECT rkey,employeecode,factoryarea,chinesename,'','extra' as factorytype,3 as [status] 
--FROM  employeemsg_extra 
--where  flag in (1,4)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0001"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_empandextra'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_empandextra'
GO
/****** Object:  View [dbo].[外层最后一步过数工序不为待入仓]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[外层最后一步过数工序不为待入仓]
AS
SELECT dbo.Data0006.PROD_STATUS, dbo.Data0056.DEPT_PTR, dbo.Data0056.STEP, 
      dbo.Data0006.BOM_PTR, d1.number, dbo.Data0006.WORK_ORDER_NUMBER
FROM dbo.Data0056 INNER JOIN
      dbo.Data0006 ON dbo.Data0056.WO_PTR = dbo.Data0006.RKEY INNER JOIN
          (SELECT dbo.Data0038.SOURCE_PTR, MAX(dbo.Data0038.STEP_NUMBER) 
               AS number
         FROM dbo.Data0038 INNER JOIN
               dbo.Data0034 ON 
               dbo.Data0038.DEPT_PTR = dbo.Data0034.RKEY INNER JOIN
               dbo.Data0025 ON 
               dbo.Data0038.SOURCE_PTR = dbo.Data0025.RKEY
         WHERE (dbo.Data0034.BARCODE_ENTRY_FLAG = 'Y') AND 
               (dbo.Data0025.PARENT_PTR IS NULL)
         GROUP BY dbo.Data0038.SOURCE_PTR) d1 ON 
      dbo.Data0006.BOM_PTR = d1.SOURCE_PTR AND 
      dbo.Data0056.STEP = d1.number
WHERE (dbo.Data0006.PROD_STATUS <> 5)
GO
/****** Object:  View [dbo].[内层最后一步过数工序不为待分配]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[内层最后一步过数工序不为待分配]
AS
SELECT dbo.Data0006.PROD_STATUS, dbo.Data0056.DEPT_PTR, dbo.Data0056.STEP, 
      dbo.Data0006.BOM_PTR, d1.number, dbo.Data0006.WORK_ORDER_NUMBER
FROM dbo.Data0056 INNER JOIN
      dbo.Data0006 ON dbo.Data0056.WO_PTR = dbo.Data0006.RKEY INNER JOIN
          (SELECT dbo.Data0038.SOURCE_PTR, MAX(dbo.Data0038.STEP_NUMBER) 
               AS number
         FROM dbo.Data0038 INNER JOIN
               dbo.Data0034 ON 
               dbo.Data0038.DEPT_PTR = dbo.Data0034.RKEY INNER JOIN
               dbo.Data0025 ON 
               dbo.Data0038.SOURCE_PTR = dbo.Data0025.RKEY
         WHERE (dbo.Data0034.BARCODE_ENTRY_FLAG = 'Y') AND 
               (dbo.Data0025.PARENT_PTR > 0)
         GROUP BY dbo.Data0038.SOURCE_PTR) d1 ON 
      dbo.Data0006.BOM_PTR = d1.SOURCE_PTR AND 
      dbo.Data0056.STEP = d1.number
WHERE (dbo.Data0006.PROD_STATUS <> 6)
GO
/****** Object:  View [dbo].[View_Auto_OnlinePause_ALL]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Auto_OnlinePause_ALL]
AS

SELECT     1 AS id, '东莞五株' AS ERP系统, *
FROM        [172.18.0.8].wisdompcb.dbo.View_Auto_OnlinePause

UNION ALL

SELECT     10 AS id, '东莞FPC' AS ERP系统, *
FROM        [172.18.9.9].wisdompcb_rb.dbo.View_Auto_OnlinePause

UNION ALL

SELECT     100 AS id, '深圳五株' AS ERP系统, *
FROM        [172.16.0.8].sj_v20_live.dbo.View_Auto_OnlinePause

UNION ALL

SELECT     1000 AS id, '志浩科技' AS ERP系统, *
FROM        [172.17.0.187].wisdompcb.dbo.View_Auto_OnlinePause
GO
/****** Object:  View [dbo].[View_SMS_Total]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SMS_Total]
AS
SELECT  TOP  1
--        '全部' AS 区域,
        DGHDI.当日入库面积 + DGGDC.当日入库面积 + DGFPC.当日入库面积 + SZWZ.当日入库面积 + SZXZ.当日入库面积 + MZWZ.当日入库面积 + ZHKJ.当日入库面积 + MZDM.当日入库面积 AS 当日入库面积,
        DGHDI.当日入库产值 + DGGDC.当日入库产值 + DGFPC.当日入库产值 + SZWZ.当日入库产值 + SZXZ.当日入库产值 + MZWZ.当日入库产值 + ZHKJ.当日入库产值 + MZDM.当日入库产值 AS 当日入库产值,
        DGHDI.当日白班入库面积 + DGGDC.当日白班入库面积 + DGFPC.当日白班入库面积 + SZWZ.当日白班入库面积 + SZXZ.当日白班入库面积 + MZWZ.当日白班入库面积 + ZHKJ.当日白班入库面积 + MZDM.当日白班入库面积 AS 当日白班入库面积,
        DGHDI.当日白班入库产值 + DGGDC.当日白班入库产值 + DGFPC.当日白班入库产值 + SZWZ.当日白班入库产值 + SZXZ.当日白班入库产值 + MZWZ.当日白班入库产值 + ZHKJ.当日白班入库产值 + MZDM.当日白班入库产值 AS 当日白班入库产值,        
        DGHDI.当日晚班入库面积 + DGGDC.当日晚班入库面积 + DGFPC.当日晚班入库面积 + SZWZ.当日晚班入库面积 + SZXZ.当日晚班入库面积 + MZWZ.当日晚班入库面积 + ZHKJ.当日晚班入库面积 + MZDM.当日晚班入库面积 AS 当日晚班入库面积,
        DGHDI.当日晚班入库产值 + DGGDC.当日晚班入库产值 + DGFPC.当日晚班入库产值 + SZWZ.当日晚班入库产值 + SZXZ.当日晚班入库产值 + MZWZ.当日晚班入库产值 + ZHKJ.当日晚班入库产值 + MZDM.当日晚班入库产值 AS 当日晚班入库产值,
        DGHDI.月累计入库面积 + DGGDC.月累计入库面积 + DGFPC.月累计入库面积 + SZWZ.月累计入库面积 + SZXZ.月累计入库面积 + MZWZ.月累计入库面积 + ZHKJ.月累计入库面积 + MZDM.月累计入库面积 AS 月累计入库面积,
        DGHDI.月累计入库产值 + DGGDC.月累计入库产值 + DGFPC.月累计入库产值 + SZWZ.月累计入库产值 + SZXZ.月累计入库产值 + MZWZ.月累计入库产值 + ZHKJ.月累计入库产值 + MZDM.月累计入库产值 AS 月累计入库产值,
        DGHDI.当日出库面积 + DGGDC.当日出库面积 + DGFPC.当日出库面积 + SZWZ.当日出库面积 + SZXZ.当日出库面积 + MZWZ.当日出库面积 + ZHKJ.当日出库面积 + MZDM.当日出库面积 AS 当日出库面积,
        DGHDI.当日出库产值 + DGGDC.当日出库产值 + DGFPC.当日出库产值 + SZWZ.当日出库产值 + SZXZ.当日出库产值 + MZWZ.当日出库产值 + ZHKJ.当日出库产值 + MZDM.当日出库产值 AS 当日出库产值,
        DGHDI.月累计出库面积 + DGGDC.月累计出库面积 + DGFPC.月累计出库面积 + SZWZ.月累计出库面积 + SZXZ.月累计出库面积 + MZWZ.月累计出库面积 + ZHKJ.月累计出库面积 + MZDM.月累计出库面积 AS 月累计出库面积,
        DGHDI.月累计出库产值 + DGGDC.月累计出库产值 + DGFPC.月累计出库产值 + SZWZ.月累计出库产值 + SZXZ.月累计出库产值 + MZWZ.月累计出库产值 + ZHKJ.月累计出库产值 + MZDM.月累计出库产值 AS 月累计出库产值,
        DGHDI.当日报废面积 + DGGDC.当日报废面积 + DGFPC.当日报废面积 + SZWZ.当日报废面积 + SZXZ.当日报废面积 + MZWZ.当日报废面积 + ZHKJ.当日报废面积 + MZDM.当日报废面积 AS 当日报废面积,
        DGHDI.月累计报废面积 + DGGDC.月累计报废面积 + DGFPC.月累计报废面积 + SZWZ.月累计报废面积 + SZXZ.月累计报废面积 + MZWZ.月累计报废面积 + ZHKJ.月累计报废面积 + MZDM.月累计报废面积 AS 月累计报废面积,
        CASE  WHEN ROUND((DGHDI.当日报废面积 + DGGDC.当日报废面积  + DGFPC.当日报废面积 + SZWZ.当日报废面积 + SZXZ.当日报废面积 + MZWZ.当日报废面积 + ZHKJ.当日报废面积 + MZDM.当日报废面积), 0) <> 0 
              THEN ROUND(ROUND((DGHDI.当日报废面积 + DGGDC.当日报废面积 + DGFPC.当日报废面积 + SZWZ.当日报废面积 + SZXZ.当日报废面积 + MZWZ.当日报废面积 + ZHKJ.当日报废面积 + MZDM.当日报废面积), 0) 
                        / ((DGHDI.当日入库面积 + DGGDC.当日入库面积 + DGFPC.当日入库面积 + SZWZ.当日入库面积 + SZXZ.当日入库面积 + MZWZ.当日入库面积 + ZHKJ.当日入库面积 + MZDM.当日入库面积) 
                          + ROUND((DGHDI.当日报废面积 + DGGDC.当日报废面积 + DGFPC.当日报废面积 + SZWZ.当日报废面积 + SZXZ.当日报废面积 + MZWZ.当日报废面积 + ZHKJ.当日报废面积 + MZDM.当日报废面积), 0)) * 100, 2) 
              ELSE 0 END AS 当日报废率, 
        CASE  WHEN ROUND((DGHDI.月累计报废面积 + DGGDC.月累计报废面积 + DGFPC.月累计报废面积 + SZWZ.月累计报废面积 + SZXZ.月累计报废面积 + MZWZ.月累计报废面积 + ZHKJ.月累计报废面积 + MZDM.月累计报废面积), 0) <> 0 
              THEN ROUND(ROUND((DGHDI.月累计报废面积 + DGGDC.月累计报废面积 + DGFPC.月累计报废面积 + SZWZ.月累计报废面积 + SZXZ.月累计报废面积 + MZWZ.月累计报废面积 + ZHKJ.月累计报废面积 + MZDM.月累计报废面积), 0) 
                        / ((DGHDI.月累计入库面积 + DGGDC.月累计入库面积 + DGFPC.月累计入库面积 + SZWZ.月累计入库面积 + SZXZ.月累计入库面积 + MZWZ.月累计入库面积 + ZHKJ.月累计入库面积 + MZDM.月累计入库面积) 
                          + ROUND((DGHDI.月累计报废面积 + DGGDC.月累计报废面积 + DGFPC.月累计报废面积 + SZWZ.月累计报废面积 + SZXZ.月累计报废面积 + MZWZ.月累计报废面积 + ZHKJ.月累计报废面积 + MZDM.月累计报废面积), 0)) * 100, 2) 
              ELSE 0 END AS 月报废率,
        DGHDI.当日订单面积 + DGGDC.当日订单面积 + DGFPC.当日订单面积 + SZWZ.当日订单面积 + SZXZ.当日订单面积 + MZWZ.当日订单面积 + ZHKJ.当日订单面积 + MZDM.当日订单面积 AS 当日订单面积,
        DGHDI.当日订单未投面积 + DGGDC.当日订单未投面积 + DGFPC.当日订单未投面积 + SZWZ.当日订单未投面积 + SZXZ.当日订单未投面积 + MZWZ.当日订单未投面积 + ZHKJ.当日订单未投面积 + MZDM.当日订单未投面积 AS 当日订单未投面积,
        DGHDI.月累计订单面积 + DGGDC.月累计订单面积 + DGFPC.月累计订单面积 + SZWZ.月累计订单面积 + SZXZ.月累计订单面积 + MZWZ.月累计订单面积 + ZHKJ.月累计订单面积 + MZDM.月累计订单面积 AS 月累计订单面积,
        DGHDI.月累计订单未投面积 + DGGDC.月累计订单未投面积 + DGFPC.月累计订单未投面积 + SZWZ.月累计订单未投面积 + SZXZ.月累计订单未投面积 + MZWZ.月累计订单未投面积 + ZHKJ.月累计订单未投面积 + MZDM.月累计订单未投面积 AS 月累计订单未投面积,
        DGHDI.当前库存面积 + DGGDC.当前库存面积 + DGFPC.当前库存面积 + SZWZ.当前库存面积 + SZXZ.当前库存面积 + MZWZ.当前库存面积 + ZHKJ.当前库存面积 + MZDM.当前库存面积 AS 当前库存面积,
        DGHDI.当前库存金额 + DGGDC.当前库存金额 + DGFPC.当前库存金额 + SZWZ.当前库存金额 + SZXZ.当前库存金额 + MZWZ.当前库存金额 + ZHKJ.当前库存金额 + MZDM.当前库存金额 AS 当前库存金额,
        DGHDI.超周期库存面积 + DGGDC.超周期库存面积 + DGFPC.超周期库存面积 + SZWZ.超周期库存面积 + SZXZ.超周期库存面积 + MZWZ.超周期库存面积 + ZHKJ.超周期库存面积 + MZDM.超周期库存面积 AS 超周期库存面积,
        DGHDI.超周期库存金额 + DGGDC.超周期库存金额 + DGFPC.超周期库存金额 + SZWZ.超周期库存金额 + SZXZ.超周期库存金额 + MZWZ.超周期库存金额 + ZHKJ.超周期库存金额 + MZDM.超周期库存金额 AS 超周期库存金额,
        DGHDI.当前在线面积 + DGGDC.当前在线面积 + DGFPC.当前在线面积 + SZWZ.当前在线面积 + SZXZ.当前在线面积 + MZWZ.当前在线面积 + ZHKJ.当前在线面积 + MZDM.当前在线面积 AS 当前在线面积,
        DGHDI.当前外层在线面积 + DGGDC.当前外层在线面积 + DGFPC.当前外层在线面积 + SZWZ.当前外层在线面积 + SZXZ.当前外层在线面积 + MZWZ.当前外层在线面积 + ZHKJ.当前外层在线面积 + MZDM.当前外层在线面积 AS 当前外层在线面积,
        DGHDI.当前内芯在线面积 + DGGDC.当前内芯在线面积 + DGFPC.当前内芯在线面积 + SZWZ.当前内芯在线面积 + SZXZ.当前内芯在线面积 + MZWZ.当前内芯在线面积 + ZHKJ.当前内芯在线面积 + MZDM.当前内芯在线面积 AS 当前内芯在线面积,
        DGHDI.当前在线暂缓面积 + DGGDC.当前在线暂缓面积 + DGFPC.当前在线暂缓面积 + SZWZ.当前在线暂缓面积 + SZXZ.当前在线暂缓面积 + MZWZ.当前在线暂缓面积 + ZHKJ.当前在线暂缓面积 + MZDM.当前在线暂缓面积 AS 当前在线暂缓面积,
        DGHDI.当日退货面积 + DGGDC.当日退货面积 + DGFPC.当日退货面积 + SZWZ.当日退货面积 + SZXZ.当日退货面积 + MZWZ.当日退货面积 + ZHKJ.当日退货面积 + MZDM.当日退货面积 AS 当日退货面积,
        DGHDI.月累计退货面积 + DGGDC.月累计退货面积 + DGFPC.月累计退货面积 + SZWZ.月累计退货面积 + SZXZ.月累计退货面积 + MZWZ.月累计退货面积 + ZHKJ.月累计退货面积 + MZDM.月累计退货面积 AS 月累计退货面积,
        DGHDI.当日尾数入仓面积 + DGGDC.当日尾数入仓面积 + DGFPC.当日尾数入仓面积 + SZWZ.当日尾数入仓面积 + SZXZ.当日尾数入仓面积 + MZWZ.当日尾数入仓面积 + ZHKJ.当日尾数入仓面积 + MZDM.当日尾数入仓面积 AS 当日尾数入仓面积,
        DGHDI.当日尾数出仓面积 + DGGDC.当日尾数出仓面积 + DGFPC.当日尾数出仓面积 + SZWZ.当日尾数出仓面积 + SZXZ.当日尾数出仓面积 + MZWZ.当日尾数出仓面积 + ZHKJ.当日尾数出仓面积 + MZDM.当日尾数出仓面积 AS 当日尾数出仓面积,
        DGHDI.月尾数入仓面积 + DGGDC.月尾数入仓面积 + DGFPC.月尾数入仓面积 + SZWZ.月尾数入仓面积 + SZXZ.月尾数入仓面积 + MZWZ.月尾数入仓面积 + ZHKJ.月尾数入仓面积 + MZDM.月尾数入仓面积 AS 月尾数入仓面积,
        DGHDI.月累计尾数出仓面积 + DGGDC.月累计尾数出仓面积 + DGFPC.月累计尾数出仓面积 + SZWZ.月累计尾数出仓面积 + SZXZ.月累计尾数出仓面积 + MZWZ.月累计尾数出仓面积 + ZHKJ.月累计尾数出仓面积 + MZDM.月累计尾数出仓面积 AS 月累计尾数出仓面积
FROM    [172.18.0.8].wisdompcb.dbo.view_sms_DGHDI AS DGHDI CROSS JOIN
        [172.18.0.8].wisdompcb.dbo.view_sms_DGGDC AS DGGDC CROSS JOIN
        [172.18.9.9].wisdompcb_rb.dbo.view_sms_DGFPC AS DGFPC CROSS JOIN
        [172.16.0.8].sj_v20_live.dbo.view_sms_SZWZ AS SZWZ CROSS JOIN
        [172.16.0.8].sj_v20_live.dbo.view_sms_SZXZ AS SZXZ CROSS JOIN
        [172.17.0.187].wisdompcb.dbo.view_sms_MZWZ AS MZWZ CROSS JOIN
        [172.17.0.187].wisdompcb.dbo.view_sms_ZHKJ AS ZHKJ CROSS JOIN
        [172.17.0.187].wisdompcb.dbo.view_sms_MZDM AS MZDM
GO
/****** Object:  View [dbo].[received_extend_stock_total]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[received_extend_stock_total]
AS
SELECT dbo.received_extend_total.RKEY, dbo.received_extend_total.INV_PART_NUMBER, 
      dbo.received_extend_total.INV_DESCRIPTION, dbo.received_extend_total.INV_NAME, 
      dbo.received_extend_total.UNIT_NAME, dbo.received_extend_total.GROUP_NAME, 
      dbo.received_extend_total.std_cost, dbo.received_extend_total.received, 
      dbo.received_extend_total.received_money, dbo.received_extend_total.extend, 
      dbo.received_extend_total.extend_money, dbo.stock.stock, dbo.stock.amount, 
      dbo.received_extend_total.inv_group_name, dbo.received_extend_total.ABBR_NAME, 
      dbo.received_extend_total.STOCK_SELL, dbo.received_extend_total.STOCK_BASE, 
      dbo.stock.stock * dbo.received_extend_total.STOCK_BASE AS totol_hight, 
      ROUND(dbo.stock.stock * dbo.received_extend_total.STOCK_SELL / 144, 3) 
      AS totol_mianji, dbo.invt_returen.quan_returen, dbo.invt_returen.amount_returen, 
      dbo.invt_scrap.quan_scrap, dbo.invt_scrap.amount_csrap
FROM dbo.received_extend_total LEFT OUTER JOIN
      dbo.invt_scrap ON 
      dbo.received_extend_total.rkey23 = dbo.invt_scrap.SUPP_PTR AND 
      dbo.received_extend_total.RKEY = dbo.invt_scrap.INVT_PTR LEFT OUTER JOIN
      dbo.invt_returen ON 
      dbo.received_extend_total.rkey23 = dbo.invt_returen.SUPP_PTR AND 
      dbo.received_extend_total.RKEY = dbo.invt_returen.INVT_PTR LEFT OUTER JOIN
      dbo.stock ON dbo.received_extend_total.rkey23 = dbo.stock.SUPP_PTR AND 
      dbo.received_extend_total.RKEY = dbo.stock.INVENTORY_PTR
GO
/****** Object:  View [dbo].[当前工序与流程号不对应的产品]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[当前工序与流程号不对应的产品]
AS
SELECT     dbo.Data0056.STEP, dbo.Data0038.STEP_NUMBER, dbo.Data0006.WORK_ORDER_NUMBER, dbo.Data0006.PROD_STATUS
FROM         dbo.Data0056 INNER JOIN
                      dbo.Data0006 ON dbo.Data0056.WO_PTR = dbo.Data0006.RKEY INNER JOIN
                      dbo.Data0038 ON dbo.Data0006.BOM_PTR = dbo.Data0038.SOURCE_PTR AND dbo.Data0056.DEPT_PTR = dbo.Data0038.DEPT_PTR AND 
                      dbo.Data0056.STEP <> dbo.Data0038.STEP_NUMBER
WHERE     (dbo.Data0006.wtype <> 3)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[16] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0056"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 189
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0006"
            Begin Extent = 
               Top = 0
               Left = 585
               Bottom = 201
               Right = 793
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Data0038"
            Begin Extent = 
               Top = 69
               Left = 311
               Bottom = 203
               Right = 503
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 2025
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'当前工序与流程号不对应的产品'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'当前工序与流程号不对应的产品'
GO
/****** Object:  View [dbo].[固定资产原值累计折旧修改]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[固定资产原值累计折旧修改]
AS
SELECT TOP 100 PERCENT FASSET_CODE, FASSET_NAME, FASSET_DESC, 
      orig_original_value AS 入帐原值, ORIGINAL_VALUE AS 当前原值, 
      SUMMED_DEPRE AS 累计折旧, SURPLUS AS 残值, NET_VALUE AS 净值, 
      MONTH_DEPRE_AMT AS 月折旧额, REMARK, 
      EXPECTED_LIFE_MONTHS AS 使用月份, DEPRED_MONTHS AS 已计提, 
      SURPLUS_RATE AS 残值率, MONTH_DEPRE_RATE AS 月折旧率, active_flag
FROM dbo.Data0517
WHERE (FASSET_CODE = 'FA00000635') OR
      (FASSET_CODE = 'FA00000639') OR
      (FASSET_CODE = 'FA00000492') OR
      (FASSET_CODE = 'FA00000475') OR
      (FASSET_CODE = 'FA00000624') OR
      (FASSET_CODE = 'FA00000679')
ORDER BY FASSET_CODE
GO
/****** Object:  View [dbo].[在线作业单数量修改]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[在线作业单数量修改]
AS
SELECT dbo.Data0056.QTY_BACKLOG, dbo.Data0056.PANELS AS panels56, 
      dbo.Data0006.WORK_ORDER_NUMBER, dbo.Data0006.QUAN_SCH, 
      dbo.Data0006.QUAN_REJ, dbo.Data0006.QUAN_PROD, dbo.Data0006.PANELS, 
      dbo.Data0006.PARTS_PER_PANEL, dbo.data0492.ISSUED_QTY, 
      dbo.data0492.WIP_QTY, dbo.data0492.QTY_REJECT, dbo.data0492.waitfor_release, 
      dbo.data0492.FG_QTY, dbo.data0492.UPANEL1, dbo.data0492.PANEL_1_QTY, 
      dbo.data0492.UPANEL2, dbo.data0492.PANEL_2_QTY, dbo.Data0006.PROD_STATUS, 
      dbo.Data0056.RKEY
FROM dbo.data0492 INNER JOIN
      dbo.Data0006 ON dbo.data0492.CUT_NO = dbo.Data0006.CUT_NO LEFT OUTER JOIN
      dbo.Data0056 ON dbo.Data0006.RKEY = dbo.Data0056.WO_PTR
WHERE (dbo.Data0006.WORK_ORDER_NUMBER = 'B0015780-2A-1-1')
GO
/****** Object:  View [dbo].[期初余额设置]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[期初余额设置]
AS
SELECT     TOP 100 PERCENT dbo.Data0103.GL_ACC_NUMBER, dbo.Data0103.GL_DESCRIPTION, dbo.Data0103.DB_CR, dbo.Data0103.TYR_OPEN, 
                      dbo.Data0103.TYR_DEBIT, dbo.Data0103.TYR_CREDIT, dbo.Data0103.TYR_OPEN_ORIG, dbo.Data0103.TYR_DEBIT_ORIG, 
                      dbo.Data0103.TYR_CREDIT_ORIG, dbo.Data0001.CURR_CODE, dbo.Data0001.CURR_NAME, dbo.Data0001.BASE_TO_OTHER, 
                      dbo.Data0103.PARENT_PTR
FROM         dbo.Data0001 RIGHT OUTER JOIN
                      dbo.Data0103 ON dbo.Data0001.RKEY = dbo.Data0103.CURR_PTR
WHERE     (dbo.Data0103.HAS_CHILD = 0)
ORDER BY dbo.Data0103.GL_ACC_NUMBER
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[12] 2[27] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0001"
            Begin Extent = 
               Top = 18
               Left = 446
               Bottom = 174
               Right = 639
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Data0103"
            Begin Extent = 
               Top = 16
               Left = 23
               Bottom = 218
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Width = 810
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'期初余额设置'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'期初余额设置'
GO
/****** Object:  View [dbo].[partrece_ext_stock_total]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--==================
CREATE VIEW [dbo].[partrece_ext_stock_total]
AS
SELECT     TOP (100) PERCENT dbo.partrece_jft_total.MANU_PART_NUMBER, dbo.partrece_jft_total.MANU_PART_DESC, dbo.partrece_jft_total.ABBR_NAME, 
                      dbo.partrece_jft_total.PROD_CODE, dbo.partrece_jft_total.unit_sq, dbo.partrece_jft_total.rece_total, dbo.partrece_jft_total.mianqi, dbo.partrece_jft_total.ext_total, 
                      dbo.partrece_jft_total.ext_mianqi, dbo.partrece_jft_total.t_quantity, dbo.partrece_jft_total.t_mianqi, dbo.stock_total.quantity_hand, 
                      ROUND(dbo.stock_total.quantity_hand * dbo.partrece_jft_total.unit_sq, 4) AS stock_mianqi
FROM         dbo.stock_total RIGHT OUTER JOIN
                      dbo.partrece_jft_total ON dbo.stock_total.CUST_PART_PTR = dbo.partrece_jft_total.RKEY
GO
/****** Object:  View [dbo].[View_FactoryPerMonthProduce]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_FactoryPerMonthProduce]
AS
SELECT		TOP (100) PERCENT 
			dbo.tblFactory_T15.FactoryID,
			YEAR(CASE WHEN DATEDIFF(hh, CONVERT(datetime, CONVERT(nvarchar(11),Data0053_1.MFG_DATE, 120) + '08:00:00', 120), Data0053_1.MFG_DATE) < 0 
					  THEN CONVERT(datetime, CONVERT(nvarchar(11), dateadd(dd, - 1, Data0053_1.MFG_DATE), 120), 120) 
					  ELSE CONVERT(datetime, CONVERT(nvarchar(11), Data0053_1.MFG_DATE, 120), 120) END) AS yearNumber, 
			MONTH(CASE WHEN DATEDIFF(hh, CONVERT(datetime, CONVERT(nvarchar(11), Data0053_1.MFG_DATE, 120) + '08:00:00', 120), Data0053_1.MFG_DATE) < 0 
					   THEN CONVERT(datetime, CONVERT(nvarchar(11), dateadd(dd, - 1, Data0053_1.MFG_DATE), 120), 120) 
					   ELSE CONVERT(datetime, CONVERT(nvarchar(11), Data0053_1.MFG_DATE, 120), 120) END) AS monthNumber, 
			ISNULL(ROUND(SUM(ROUND(Data0053_1.QUANTITY * Data0025_1.unit_sq, 4)), 3), 0) AS ProductArea
FROM        dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
			dbo.data0492 AS data0492_1 RIGHT OUTER JOIN
			dbo.data0416 AS data0416_1 INNER JOIN
			dbo.Data0025 AS Data0025_1 INNER JOIN
			dbo.Data0053 AS Data0053_1 INNER JOIN
			dbo.Data0015 AS Data0015_1 ON Data0053_1.WHSE_PTR = Data0015_1.RKEY INNER JOIN
			dbo.Data0016 AS Data0016_1 ON Data0053_1.LOC_PTR = Data0016_1.RKEY ON Data0025_1.RKEY = Data0053_1.CUST_PART_PTR ON 
			data0416_1.rkey = Data0053_1.NPAD_PTR INNER JOIN
			dbo.tblFactory_T15 ON Data0015_1.RKEY = dbo.tblFactory_T15.D15_Ptr LEFT OUTER JOIN
			dbo.Data0006 AS Data0006_1 ON Data0053_1.WORK_ORDER_PTR = Data0006_1.RKEY ON data0492_1.CUT_NO = Data0006_1.CUT_NO ON 
			Data0060_2.SALES_ORDER = data0492_1.SO_NO LEFT OUTER JOIN
			dbo.Data0060 AS data0060_1 ON data0416_1.so_ptr = data0060_1.RKEY
WHERE	   (Data0053_1.QUANTITY > 0) 
		    AND (Data0053_1.MFG_DATE >= CONVERT(datetime, '2011-01-01 08:00:00', 120)) 
			AND (Data0016_1.CODE = 'ST005' OR Data0016_1.CODE = 'ST020') 
			AND (Data0053_1.RMA_PTR = 0)
GROUP BY dbo.tblFactory_T15.FactoryID,
		 YEAR(CASE WHEN DATEDIFF(hh, CONVERT(datetime, CONVERT(nvarchar(11), Data0053_1.MFG_DATE, 120) + '08:00:00', 120), Data0053_1.MFG_DATE) < 0 
				   THEN CONVERT(datetime, CONVERT(nvarchar(11), dateadd(dd, - 1, Data0053_1.MFG_DATE), 120), 120) 
				   ELSE CONVERT(datetime, CONVERT(nvarchar(11), Data0053_1.MFG_DATE, 120), 120) END), 
		 MONTH(CASE WHEN DATEDIFF(hh, CONVERT(datetime, CONVERT(nvarchar(11), Data0053_1.MFG_DATE, 120) + '08:00:00', 120), Data0053_1.MFG_DATE) < 0 
					THEN CONVERT(datetime, CONVERT(nvarchar(11), dateadd(dd, - 1, Data0053_1.MFG_DATE), 120), 120) 
					ELSE CONVERT(datetime, CONVERT(nvarchar(11), Data0053_1.MFG_DATE, 120), 120) END)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0060_2"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 266
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "data0492_1"
            Begin Extent = 
               Top = 6
               Left = 304
               Bottom = 114
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "data0416_1"
            Begin Extent = 
               Top = 6
               Left = 530
               Bottom = 114
               Right = 676
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0025_1"
            Begin Extent = 
               Top = 6
               Left = 714
               Bottom = 114
               Right = 939
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0053_1"
            Begin Extent = 
               Top = 6
               Left = 977
               Bottom = 114
               Right = 1178
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0015_1"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0016_1"
            Begin Extent = 
               Top = 6
               Left = 1216
               Bottom = 114
               Right = 1394
            End
            Di' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_FactoryPerMonthProduce'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'splayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblFactory_T15"
            Begin Extent = 
               Top = 114
               Left = 270
               Bottom = 207
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0006_1"
            Begin Extent = 
               Top = 114
               Left = 454
               Bottom = 222
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "data0060_1"
            Begin Extent = 
               Top = 114
               Left = 707
               Bottom = 222
               Right = 935
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_FactoryPerMonthProduce'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_FactoryPerMonthProduce'
GO
/****** Object:  View [dbo].[V_POList]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_POList]
AS 
SELECT  dbo.Data0017.INV_PART_NUMBER AS 材料编码, dbo.Data0017.INV_NAME AS 材料名称, dbo.Data0017.INV_DESCRIPTION AS 材料规格

, dbo.Data0070.PO_NUMBER AS 采购订单号, data0070.PO_DATE AS 下单日期, dbo.Data0005.EMPLOYEE_NAME as 采购人员

, dbo.Data0023.ABBR_NAME AS 供应商简称

, dbo.Data0071.QUAN_ORD AS 订单数量, dbo.Data0071.QUAN_RECD AS 已接收数量, dbo.Data0071.QUAN_ORD - dbo.Data0071.QUAN_RECD AS 欠货数量
, dbo.Data0002.UNIT_NAME AS  采购单位

, dbo.Data0071.PRICE as 不含税价, dbo.Data0071.tax_price AS 含税价, dbo.Data0071.TAX_2 AS 税率

, dbo.Data0001.CURR_NAME AS 货币, dbo.Data0070.EXCHANGE_RATE AS 汇率

, dbo.Data0071.REQ_DATE as 要求到货日期, isnull(dbo.Data0071.recd_DATE,'') as 最后收货日期 

, dbo.Data0071.extra_req as 特别要求, dbo.Data0071.rohs as 环保等级, dbo.Data0071.IF_urgency as 是否紧急 

, dbo.Data0015.ABBR_NAME AS 工厂 

, ISNULL(dbo.Data0068.PO_REQ_NUMBER, dbo.Data0070.FOB)  as 请购编号
, ISNULL(dbo.Data0034.DEPT_NAME, data0034_1.DEPT_NAME)  as 请购部门
, ISNULL(data0005_1.EMPLOYEE_NAME, dbo.Data0070.ANALYSIS_CODE_1) as 请购人员
, dbo.Data0071.reason as 请购原因

, case  data0070.STATUS when 1 then '待审核' when 2 then '被退回' when 3 then '已保留' when 4 then '已暂缓'
 when 5 then '已审核' when 6 then '已收货' when 7 then '已完成' when 8 then '未提交' end as 状态
 
, '编码物料' as 类型          
FROM         dbo.Data0071 INNER JOIN
          dbo.Data0070 ON dbo.Data0071.PO_PTR = dbo.Data0070.RKEY INNER JOIN
          dbo.Data0017 ON dbo.Data0071.INVT_PTR = dbo.Data0017.RKEY INNER JOIN
          dbo.Data0023 ON dbo.Data0070.SUPPLIER_POINTER = dbo.Data0023.RKEY INNER JOIN
          dbo.Data0002 ON dbo.Data0071.PURCHASE_UNIT_PTR = dbo.Data0002.RKEY INNER JOIN
          dbo.Data0005 ON dbo.Data0070.EMPLOYEE_POINTER = dbo.Data0005.RKEY INNER JOIN
          dbo.Data0015 ON dbo.Data0070.WAREHOUSE_POINTER = dbo.Data0015.RKEY INNER JOIN
          dbo.Data0001 ON dbo.Data0070.CURRENCY_PTR = dbo.Data0001.RKEY LEFT OUTER JOIN
          dbo.Data0069 ON dbo.Data0071.rkey69 = dbo.Data0069.RKEY LEFT OUTER JOIN
          dbo.Data0068 ON dbo.Data0069.PURCH_REQ_PTR = dbo.Data0068.RKEY LEFT OUTER JOIN
          dbo.Data0005 AS data0005_1 ON dbo.Data0068.REQ_BY = data0005_1.RKEY LEFT OUTER JOIN
          dbo.Data0034 ON dbo.Data0068.DEPARTMENT_NAME = dbo.Data0034.DEPT_CODE LEFT OUTER JOIN
          dbo.Data0034 AS data0034_1 ON dbo.Data0070.PO_REV_NO = data0034_1.DEPT_CODE 
union 
SELECT dbo.Data0072.DESCRIPTION AS 材料名称, dbo.Data0072.GUI_GE AS 材料规格, dbo.Data0072.DESCRIPTION2 AS 材料类型

, dbo.Data0070.PO_NUMBER AS 采购订单号, data0070.PO_DATE AS 下单日期, dbo.Data0005.EMPLOYEE_NAME as 采购人员
 
, dbo.Data0023.ABBR_NAME AS 供应商简称

, dbo.Data0072.QUAN_ORD AS 订单数量
, dbo.Data0072.QUANTITY_RECEIVED AS 已接收数量
, dbo.Data0072.QUAN_ORD - dbo.Data0072.QUANTITY_RECEIVED AS 欠货数量
, dbo.Data0002.UNIT_NAME AS 采购单位

, dbo.Data0072.UNIT_PRICE as 不含税价, dbo.Data0072.tax_price AS 含税价格, dbo.Data0072.state_TAX AS 税率

, dbo.Data0001.CURR_NAME AS 货币, dbo.Data0070.EXCHANGE_RATE AS 汇率

, dbo.Data0072.del_DATE as 要求到货日期, dbo.Data0072.recd_DATE as 最后收货日期

, '' as 特别要求 , dbo.Data0072.rohs as 环保等级, dbo.Data0072.IF_urgency as 是否紧急 

, dbo.Data0015.ABBR_NAME AS 工厂

, ISNULL(dbo.Data0068.PO_REQ_NUMBER, dbo.Data0070.FOB)  as 请购编号
, ISNULL(dbo.Data0034.DEPT_NAME, data0034_1.DEPT_NAME)  as 请购部门 
, ISNULL(data0005_1.EMPLOYEE_NAME, dbo.Data0070.ANALYSIS_CODE_1) as 请购人员 
, dbo.Data0072.reason as 请购原因

, case  data0070.STATUS when 1 then '待审核' when 2 then '被退回' when 3 then '已保留' when 4 then '已暂缓'
	when 5 then '已审核' when 6 then '已收货' when 7 then '已完成' when 8 then '未提交' end as 状态 
	
, '非编码物料' as 类型           
FROM         dbo.Data0072 INNER JOIN
          dbo.Data0070 ON dbo.Data0072.POPTR = dbo.Data0070.RKEY  INNER JOIN
          dbo.Data0023 ON dbo.Data0070.SUPPLIER_POINTER = dbo.Data0023.RKEY INNER JOIN
          dbo.Data0002 ON dbo.Data0072.UNIT_PTR = dbo.Data0002.RKEY INNER JOIN
          dbo.Data0005 ON dbo.Data0070.EMPLOYEE_POINTER = dbo.Data0005.RKEY INNER JOIN
          dbo.Data0015 ON dbo.Data0070.WAREHOUSE_POINTER = dbo.Data0015.RKEY INNER JOIN
          dbo.Data0001 ON dbo.Data0070.CURRENCY_PTR = dbo.Data0001.RKEY LEFT OUTER JOIN
          dbo.Data0204 ON dbo.Data0072.rkey204 = dbo.Data0204.RKEY LEFT OUTER JOIN
          dbo.Data0068 ON dbo.Data0204.PURCHase_REQ_PTR = dbo.Data0068.RKEY LEFT OUTER JOIN
          dbo.Data0005 AS data0005_1 ON dbo.Data0068.REQ_BY = data0005_1.RKEY LEFT OUTER JOIN
          dbo.Data0034 ON dbo.Data0068.DEPARTMENT_NAME = dbo.Data0034.DEPT_CODE LEFT OUTER JOIN
          dbo.Data0034 AS data0034_1 ON dbo.Data0070.PO_REV_NO = data0034_1.DEPT_CODE
GO
/****** Object:  View [dbo].[V_inStock22]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_inStock22]
as
select Stuff_Mesh.GRN_NUMBER as 入库单号,  Stuff_Mesh.DELIVER_NUMBER as 送货单号,  Stuff_Mesh.PO_NUMBER as 采购单号,
      Stuff_Mesh.code as 供应商代码,Stuff_Mesh.ABBR_NAME AS 供应商,
 
      Stuff_Mesh.INV_PART_NUMBER as 材料编码, Stuff_Mesh.INV_NAME as 材料名称, 
      Stuff_Mesh.INV_DESCRIPTION as 材料规格, Stuff_Mesh.GROUP_DESC as 材料类别,Stuff_Mesh.inv_group_desc as 材料组别,
      
      Stuff_Mesh.QUANTITY as 接收数量,Stuff_Mesh.QUAN_ON_HAND as 当前库存, Stuff_Mesh.UNIT_NAME as 单位,
      Stuff_Mesh.CURR_NAME as 货币,Stuff_Mesh.exch_rate as 汇率,Stuff_Mesh.TAX_2 as 税率,Stuff_Mesh.PRICE as 含税价, 
       ROUND(Stuff_Mesh.QUANTITY * Stuff_Mesh.PRICE, 2) AS 金额,
       
      Stuff_Mesh.ABBR_NAME AS 工厂, Stuff_Mesh.LOCATION as 仓库,Stuff_Mesh.spec_place as 具体位置,Stuff_Mesh.BARCODE_ID as 特别要求,
      
      Stuff_Mesh.ship_DATE as 送货时间,Stuff_Mesh.EXPIRE_DATE as 有效期, Stuff_Mesh.rohs as 环保标识,
      case Stuff_Mesh.ttype
      when 1 then '编码入库' when  2 then '杂项入库'
      when 3 then '直接入库'  when 4 then '调拨入仓' 
      when 5 then 'VMI入库'   when 6 then '杂项直入'  end as 入库类型,
            
      Stuff_Mesh.EMPLOYEE_NAME as 创建人,Stuff_Mesh.dept_name as 请购部门,Stuff_Mesh.ANALYSIS_CODE_1 as 请购人员
from (  
SELECT dbo.Data0456.GRN_NUMBER, dbo.Data0456.DELIVER_NUMBER, 
      dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.INV_NAME, 
      dbo.Data0017.INV_DESCRIPTION, Data0496.GROUP_DESC,data0019.inv_group_desc, 
      dbo.Data0022.QUANTITY,data0022.QUAN_ON_HAND,Data0002.UNIT_NAME,dbo.Data0001.CURR_NAME, dbo.Data0022.PRICE, 
      dbo.Data0022.TAX_2,data0022.spec_place,Data0023.CODE, dbo.Data0023.ABBR_NAME,Data0016.LOCATION, 
      dbo.Data0015.ABBR_NAME AS abbr_warehouse, dbo.Data0005.EMPLOYEE_NAME, 
      dbo.Data0456.ship_DATE, dbo.Data0022.BARCODE_ID, 
      dbo.Data0022.EXPIRE_DATE, dbo.Data0070.PO_NUMBER, 
      dbo.Data0456.exch_rate, dbo.Data0022.rohs,data0034.dept_name ,data0070.ANALYSIS_CODE_1,data0456.ttype
FROM dbo.Data0022 INNER JOIN
      dbo.Data0017 ON dbo.Data0022.INVENTORY_PTR = dbo.Data0017.RKEY INNER JOIN
      dbo.Data0496 ON dbo.Data0017.GROUP_PTR = dbo.Data0496.RKEY  INNER JOIN 
      dbo.Data0019 on  dbo.Data0019.rkey = dbo.Data0496.group_ptr INNER JOIN 
      dbo.Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY INNER JOIN
      dbo.Data0002 on dbo.Data0022.LOCATION_PTR_FROM = dbo.Data0002.Rkey INNER JOIN
      dbo.Data0023 ON dbo.Data0456.SUPP_PTR = dbo.Data0023.RKEY INNER JOIN
      dbo.Data0015 ON dbo.Data0456.warehouse_ptr = dbo.Data0015.RKEY INNER JOIN
      dbo.Data0005 ON dbo.Data0456.CREATE_BY = dbo.Data0005.RKEY INNER JOIN
      dbo.Data0016 ON dbo.Data0022.LOCATION_PTR = dbo.Data0016.RKEY INNER JOIN
      dbo.Data0001 ON 
      dbo.Data0456.currency_ptr = dbo.Data0001.RKEY LEFT OUTER JOIN
      dbo.Data0070 ON dbo.Data0456.PO_PTR = dbo.Data0070.RKEY left join 
      data0034 on data0034.dept_code=Data0070.PO_REV_NO   
    union 
    select dbo.Data0456.GRN_NUMBER,dbo.Data0456.DELIVER_NUMBER,
       null,dbo.Data0235.goods_name,
       dbo.Data0235.goods_guige,null,null,dbo.Data0235.QUAN_RECD,data0235.QUAN_ON_HAND,
       Data0002.UNIT_NAME,dbo.Data0001.CURR_NAME, dbo.Data0235.unit_price*(1-dbo.Data0235.state_tax/100),
       dbo.Data0235.state_tax,null,Data0023.CODE,dbo.Data0023.ABBR_NAME,Data0016.LOCATION, 
       dbo.Data0015.ABBR_NAME AS abbr_warehouse,dbo.Data0005.EMPLOYEE_NAME, 
       dbo.Data0456.ship_DATE,dbo.Data0235.REF_NUMBER, 
       dbo.Data0235.DATE_RECD,dbo.Data0070.PO_NUMBER, 
       dbo.Data0456.exch_rate,dbo.Data0235.rohs,data0034.dept_name ,data0070.ANALYSIS_CODE_1,data0456.ttype
from dbo.Data0235 INNER JOIN
	  dbo.Data0456 ON dbo.Data0235.GRN_PTR = dbo.Data0456.RKEY INNER JOIN
	  dbo.Data0023 ON dbo.Data0456.SUPP_PTR = dbo.Data0023.RKEY INNER JOIN
	  dbo.Data0015 ON dbo.Data0456.warehouse_ptr = dbo.Data0015.RKEY INNER JOIN
	  dbo.Data0005 ON dbo.Data0456.CREATE_BY = dbo.Data0005.RKEY INNER JOIN
      dbo.Data0002 on dbo.Data0235.unit_ptr = dbo.Data0002.Rkey INNER JOIN
      dbo.Data0016 ON dbo.Data0235.location_ptr = dbo.Data0016.RKEY INNER JOIN
	  dbo.Data0001 ON dbo.Data0456.currency_ptr = dbo.Data0001.RKEY LEFT OUTER JOIN
	  dbo.Data0070 ON dbo.Data0456.PO_PTR = dbo.Data0070.RKEY left join 
      data0034 on data0034.dept_code=Data0070.PO_REV_NO  
)  as Stuff_Mesh 
WHERE (Stuff_Mesh.QUANTITY > 0)
GO
/****** Object:  View [dbo].[V_inputStoreList]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_inputStoreList]
AS
SELECT     dbo.Data0006.WORK_ORDER_NUMBER AS '作业单号', dbo.Data0006.CUT_NO AS '配料单号', Data0060_2.SALES_ORDER AS '销售订单', 
                      dbo.Data0097.PO_NUMBER AS '客户订单号', dbo.Data0025.MANU_PART_NUMBER AS '本厂编号', dbo.Data0025.MANU_PART_DESC AS '客户型号', 
                      dbo.Data0025.ANALYSIS_CODE_2 AS '客户物料号', dbo.Data0025.LAYERS AS '层数', dbo.Data0025.SAMPLE_NR AS '测式成型备注', 
                      dbo.Data0025.CPJS AS '产品阶数', dbo.Data0053.QUANTITY AS '入仓数量', dbo.Data0053.QTY_ON_HAND AS '库存数量', 
                      CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC, 6) ELSE Data0025.LATEST_PRICE END AS '不含税价格(原币)', 
                      CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * (1 + Data0060_2.RUSH_CHARGE * 0.01), 6) 
                      ELSE Data0025.LATEST_PRICE END AS '含税价格(原币)', dbo.Data0001.CURR_CODE AS '货币', 
                      CASE WHEN Data0060_2.PART_PRICE >= 0 THEN Data0060_2.EXCH_RATE ELSE 1 END AS '原币汇率', 
                      ROUND(dbo.Data0053.QUANTITY * (dbo.Data0053.cost_pcs + dbo.Data0053.matl_ovhd_pcs + dbo.Data0053.OVHD_COST + dbo.Data0053.PLANNED_QTY + dbo.Data0053.ovhd1_pcs
                       + dbo.Data0053.outsource_pcs), 4) AS '成本', ROUND(dbo.Data0053.QUANTITY * dbo.Data0025.unit_sq, 4) AS '不含板边入库面积', 
                      CASE WHEN data0053.work_order_ptr > 0 THEN round(Data0053.QUANTITY * Data0006.panel_ln * Data0006.panel_wd * 0.000001 / Data0006.PARTS_PER_PANEL, 4) 
                      ELSE ROUND(dbo.Data0053.QUANTITY * dbo.Data0025.unit_sq, 4) END AS '含板边入库面积', 
                      dbo.Data0053.QUANTITY * dbo.Data0025.REPORT_UNIT_VALUE1 / 1000 AS '入仓重量(KG)', 
                      CASE WHEN Data0060_2.PART_PRICE >= 0 THEN Data0010_1.cust_code ELSE data0010_2.cust_code END AS '客户代码', 
                      CASE WHEN Data0060_2.PART_PRICE >= 0 THEN Data0010_1.ABBR_NAME ELSE data0010_2.ABBR_NAME END AS '客户简称', 
                      CASE WHEN data0053.barcode_ptr IS NOT NULL THEN data0060_2.ORIG_CUSTOMER ELSE data0025.ORIG_CUSTOMER END AS '关联原客户', 
                      dbo.data0416.number AS '入仓单号', dbo.Data0005.EMPLOYEE_NAME AS '入库人员', dbo.data0416.type AS '入库类型', 
                      dbo.Data0008.PROD_CODE AS '产品类别', dbo.Data0008.PRODUCT_NAME AS '产品类别名称', dbo.Data0007.PR_GRP_CODE AS '组别代码', 
                      dbo.Data0007.PRODUCT_GROUP_NAME AS '组别名称', dbo.Data0015.WAREHOUSE_CODE AS '工厂', dbo.Data0016.LOCATION AS '仓库', 
                      dbo.Data0053.spec_place AS '具体位置', 
                      CASE WHEN Data0060_2.PART_PRICE >= 0 THEN CASE data0060_2.COMMISION_ON_TOOLING WHEN 'N' THEN '内销' WHEN 'Y' THEN '转厂' END ELSE CASE data0010_2.EDI_FLAG_FOR_SOACK
                       WHEN 0 THEN '内销' WHEN 1 THEN '转厂' END END AS '是否转厂', dbo.Data0053.MFG_DATE AS '入仓日期', dbo.Data0053.ischaban AS '好板叉板', 
                      dbo.Data0053.zhouqi AS '周期', 
                      CASE dbo.Data0053.RMA_PTR WHEN 0 THEN '正常过数入仓' WHEN 1 THEN '退货重检入仓' WHEN 2 THEN '返修重检入仓' WHEN 3 THEN '直接入仓' WHEN 4 THEN
                       '委外加工入仓' WHEN 5 THEN '委外加工退货入仓' WHEN 6 THEN '销售退货入仓' WHEN 7 THEN '转换入仓' WHEN 8 THEN '特殊入仓' END AS '入仓类型', 
                      dbo.Data0053.REFERENCE_NUMBER AS '入仓备注', Data0060_2.REFERENCE_NUMBER AS '订单参考', dbo.Data0023.ABBR_NAME AS '外协厂家'
FROM         dbo.Data0097 RIGHT OUTER JOIN
                      dbo.Data0023 RIGHT OUTER JOIN
                      dbo.Data0060 AS Data0060_2 ON dbo.Data0023.RKEY = Data0060_2.supplier_ptr LEFT OUTER JOIN
                      dbo.Data0001 ON Data0060_2.CURRENCY_PTR = dbo.Data0001.RKEY LEFT OUTER JOIN
                      dbo.Data0010 AS Data0010_1 ON Data0060_2.CUSTOMER_PTR = Data0010_1.RKEY ON 
                      dbo.Data0097.RKEY = Data0060_2.PURCHASE_ORDER_PTR RIGHT OUTER JOIN
                      dbo.data0416 INNER JOIN
                      dbo.Data0005 ON dbo.data0416.empl_ptr = dbo.Data0005.RKEY INNER JOIN
                      dbo.Data0008 INNER JOIN
                      dbo.Data0025 ON dbo.Data0008.RKEY = dbo.Data0025.PROD_CODE_PTR INNER JOIN
                      dbo.Data0010 AS Data0010_2 ON dbo.Data0025.CUSTOMER_PTR = Data0010_2.RKEY INNER JOIN
                      dbo.Data0053 INNER JOIN
                      dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                      dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY ON dbo.Data0025.RKEY = dbo.Data0053.CUST_PART_PTR ON 
                      dbo.data0416.rkey = dbo.Data0053.NPAD_PTR LEFT OUTER JOIN
                      dbo.Data0006 ON dbo.Data0053.WORK_ORDER_PTR = dbo.Data0006.RKEY ON Data0060_2.RKEY = dbo.Data0053.barcode_ptr INNER JOIN
                      dbo.Data0007 ON dbo.Data0008.PR_GRP_POINTER = dbo.Data0007.RKEY
WHERE     (dbo.Data0053.QUANTITY > 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[17] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0097"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0023"
            Begin Extent = 
               Top = 6
               Left = 245
               Bottom = 125
               Right = 461
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0060_2"
            Begin Extent = 
               Top = 6
               Left = 499
               Bottom = 125
               Right = 720
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0001"
            Begin Extent = 
               Top = 6
               Left = 758
               Bottom = 125
               Right = 958
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0010_1"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "data0416"
            Begin Extent = 
               Top = 126
               Left = 294
               Bottom = 245
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0005"
            Begin Extent = 
               Top = 126
               Left = 474
               Bottom = 245
               Right = 649
            End
            DisplayFlag' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_inputStoreList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N's = 280
            TopColumn = 0
         End
         Begin Table = "Data0008"
            Begin Extent = 
               Top = 126
               Left = 687
               Bottom = 245
               Right = 901
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0025"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0010_2"
            Begin Extent = 
               Top = 246
               Left = 294
               Bottom = 365
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0053"
            Begin Extent = 
               Top = 126
               Left = 939
               Bottom = 245
               Right = 1133
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0015"
            Begin Extent = 
               Top = 246
               Left = 550
               Bottom = 365
               Right = 737
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0016"
            Begin Extent = 
               Top = 246
               Left = 775
               Bottom = 365
               Right = 946
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0006"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 485
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0007"
            Begin Extent = 
               Top = 366
               Left = 284
               Bottom = 485
               Right = 496
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_inputStoreList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_inputStoreList'
GO
/****** Object:  View [dbo].[V_OtherMtrlStockList]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_OtherMtrlStockList]
as
SELECT  dbo.Data0235.goods_name AS 材料名称, dbo.Data0235.goods_guige AS 材料规格
, dbo.Data0235.goods_type AS 材料类型

, isnull(dbo.Data0070.PO_NUMBER,'') as 采购订单号, dbo.Data0023.CODE AS 供应商代码, dbo.Data0023.ABBR_NAME AS 供应商简称

, dbo.Data0015.WAREHOUSE_CODE 工厂代码, dbo.Data0015.ABBR_NAME 工厂名称

, dbo.Data0235.unit_price AS 含税价, ROUND(dbo.Data0235.unit_price / (1 + dbo.Data0235.state_tax * 0.01), 3) AS 不含税价
, ROUND(dbo.Data0235.QUAN_ON_HAND * dbo.Data0235.unit_price, 3) AS 总金额

, dbo.Data0001.CURR_CODE AS 货币, dbo.Data0235.state_tax AS 税率, dbo.Data0456.exch_rate AS 汇率

, dbo.Data0235.QUAN_RECD AS 接收数量, dbo.Data0235.QUAN_ON_HAND AS 当前库存数量

, dbo.Data0002.UNIT_NAME as 单位, dbo.Data0016.LOCATION AS 仓库位置
, case dbo.Data0456.TTYPE when 1 then '编码入仓' when 2 then '杂项入仓'
		when 3 then '直接入仓生产物料' when 4 then '调拨入仓' when 5 then 'VMI入库' 
		when 6 then '直接入库非生产物料' end as 入库类型

, dbo.Data0456.ship_DATE as 到货日期

, isnull(dbo.Data0235.cust_decl,'') AS   报关单号, isnull(dbo.Data0235.REF_NUMBER,'') as 备注

FROM         dbo.Data0002 INNER JOIN
                      dbo.Data0235 ON dbo.Data0002.RKEY = dbo.Data0235.unit_ptr INNER JOIN  
                      dbo.Data0456 ON dbo.Data0235.GRN_PTR = dbo.Data0456.RKEY INNER JOIN
                      dbo.Data0015 ON dbo.Data0456.warehouse_ptr = dbo.Data0015.RKEY INNER JOIN
                      dbo.Data0023 ON dbo.Data0456.SUPP_PTR = dbo.Data0023.RKEY INNER JOIN
                      dbo.Data0001 ON dbo.Data0001.RKEY = dbo.Data0456.currency_ptr INNER JOIN
                      dbo.Data0016 ON dbo.Data0235.location_ptr = dbo.Data0016.RKEY left JOIN
                      dbo.Data0070 ON dbo.Data0456.PO_PTR = dbo.Data0070.RKEY
WHERE     (dbo.Data0235.QUAN_ON_HAND > 0)
GO
/****** Object:  View [dbo].[V_StoreList]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_StoreList]
AS
SELECT     TOP (100) PERCENT dbo.Data0006.WORK_ORDER_NUMBER AS '作业单号', CASE WHEN Data0060.SALES_ORDER IS NOT NULL 
                      THEN Data0060.SALES_ORDER ELSE '' END AS '销售订单号', dbo.Data0097.PO_NUMBER AS '客户订单号', dbo.Data0025.MANU_PART_NUMBER AS '本厂编号', 
                      dbo.Data0025.MANU_PART_DESC AS '客户型号', dbo.Data0025.ANALYSIS_CODE_2 AS '客户物料号', dbo.Data0025.SAMPLE_NR AS '测式成型备注', 
                      CASE Data0025.TTYPE WHEN 0 THEN '量产' WHEN 1 THEN '样板' ELSE '未定义' END AS '产品属性', dbo.Data0025.CPJS AS '产品阶数', 
                      CASE WHEN Data0060.customer_ptr IS NOT NULL THEN Data0010_1.ABBR_NAME ELSE data0010.ABBR_NAME END AS '客户简称', 
                      CASE WHEN Data0060.customer_ptr IS NOT NULL THEN Data0010_1.cust_code ELSE data0010.cust_code END AS '客户代码', 
                      CASE WHEN data0053.barcode_ptr IS NOT NULL THEN data0060.ORIG_CUSTOMER ELSE data0025.ORIG_CUSTOMER END AS '关联原客户', 
                      dbo.Data0008.PRODUCT_NAME AS '产品类别名称', dbo.Data0008.PROD_CODE AS '产品类别', dbo.Data0060.PARTS_ORDERED AS '订单数量', 
                      dbo.Data0053.QTY_ON_HAND AS '库存数量', dbo.Data0025.LATEST_PRICE AS '最新价格', dbo.Data0001.CURR_NAME AS '货币名称', 
                      ROUND(dbo.Data0053.QUANTITY * (dbo.Data0053.cost_pcs + dbo.Data0053.matl_ovhd_pcs + dbo.Data0053.OVHD_COST + dbo.Data0053.PLANNED_QTY + dbo.Data0053.ovhd1_pcs
                       + dbo.Data0053.outsource_pcs), 4) AS '成本', dbo.Data0010.FED_TAX_ID_NO AS '付款方法', dbo.Data0053.MFG_DATE AS '入仓日期', 
                      dbo.Data0060.SCH_DATE AS '回复交期', dbo.Data0053.MFG_DATE + dbo.Data0025.REVIEW_DAYS AS '过期日期', CASE WHEN DATEDIFF(day, GETDATE(), 
                      dbo.Data0060.SCH_DATE) < 0 THEN '已超期' ELSE '有效' END AS '状态', dbo.Data0015.WAREHOUSE_CODE AS '工厂', dbo.Data0016.LOCATION AS '仓库', 
                      dbo.Data0053.spec_place AS '具体位置', dbo.Data0060.REFERENCE_NUMBER AS '订单参考', dbo.Data0053.REFERENCE_NUMBER AS '备注', 
                      dbo.Data0005.EMPLOYEE_NAME AS '入库人员', d05.EMPLOYEE_NAME AS '业务员姓名', 
                      CASE Data0060.COMMISION_ON_TOOLING WHEN 'Y' THEN '转厂' WHEN 'N' THEN '内销' END AS '销售方式', dbo.Data0025.REPORT_UNIT_VALUE1 AS '单重(G)', 
                      ROUND(dbo.Data0053.QTY_ON_HAND * dbo.Data0025.REPORT_UNIT_VALUE1 * 0.001, 4) AS '总重(KG)', 
                      ROUND(dbo.Data0053.QTY_ON_HAND * dbo.Data0025.unit_sq, 4) AS '库存面积', 
                      CASE data0053.rma_ptr WHEN 0 THEN '正常过数入仓' WHEN 1 THEN '退货重检入仓' WHEN 2 THEN '返修重检入仓' WHEN 3 THEN '直接入仓' WHEN 4 THEN '委外加工入仓'
                       WHEN 5 THEN '委外加工退货入仓' WHEN 6 THEN '销售退货入仓' WHEN 7 THEN '转换入仓' WHEN 8 THEN '特殊入仓' END AS '入仓类型', 
                      dbo.Data0053.ischaban AS '好板叉板', dbo.Data0053.zhouqi AS '周期', dbo.Data0023.ABBR_NAME AS '外协厂家'
FROM         dbo.Data0006 RIGHT OUTER JOIN
                      dbo.Data0097 RIGHT OUTER JOIN
                      dbo.Data0005 AS d05 RIGHT OUTER JOIN
                      dbo.Data0060 ON d05.RKEY = dbo.Data0060.COMM_ASSIGNED_BY_E_P RIGHT OUTER JOIN
                      dbo.Data0008 INNER JOIN
                      dbo.Data0025 ON dbo.Data0008.RKEY = dbo.Data0025.PROD_CODE_PTR INNER JOIN
                      dbo.Data0010 ON dbo.Data0025.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN
                      dbo.Data0053 INNER JOIN
                      dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                      dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY ON dbo.Data0025.RKEY = dbo.Data0053.CUST_PART_PTR INNER JOIN
                      dbo.data0416 ON dbo.Data0053.NPAD_PTR = dbo.data0416.rkey INNER JOIN
                      dbo.Data0005 ON dbo.data0416.empl_ptr = dbo.Data0005.RKEY ON dbo.Data0060.RKEY = dbo.Data0053.barcode_ptr LEFT OUTER JOIN
                      dbo.Data0010 AS Data0010_1 ON dbo.Data0060.CUSTOMER_PTR = Data0010_1.RKEY LEFT OUTER JOIN
                      dbo.Data0023 ON dbo.Data0060.supplier_ptr = dbo.Data0023.RKEY LEFT OUTER JOIN
                      dbo.Data0001 ON dbo.Data0060.CURRENCY_PTR = dbo.Data0001.RKEY ON dbo.Data0097.RKEY = dbo.Data0060.PURCHASE_ORDER_PTR ON 
                      dbo.Data0006.RKEY = dbo.Data0053.WORK_ORDER_PTR
WHERE     (dbo.Data0053.QTY_ON_HAND > 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0006"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0097"
            Begin Extent = 
               Top = 6
               Left = 284
               Bottom = 125
               Right = 453
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d05"
            Begin Extent = 
               Top = 6
               Left = 491
               Bottom = 125
               Right = 666
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0060"
            Begin Extent = 
               Top = 6
               Left = 704
               Bottom = 125
               Right = 925
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0008"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0025"
            Begin Extent = 
               Top = 126
               Left = 290
               Bottom = 245
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0010"
            Begin Extent = 
               Top = 126
               Left = 546
               Bottom = 245
               Right = 764
            End
            DisplayFlags = 280
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_StoreList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'            TopColumn = 0
         End
         Begin Table = "Data0053"
            Begin Extent = 
               Top = 126
               Left = 802
               Bottom = 245
               Right = 996
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0015"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0016"
            Begin Extent = 
               Top = 6
               Left = 963
               Bottom = 125
               Right = 1134
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "data0416"
            Begin Extent = 
               Top = 246
               Left = 263
               Bottom = 365
               Right = 405
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0005"
            Begin Extent = 
               Top = 246
               Left = 443
               Bottom = 365
               Right = 618
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0010_1"
            Begin Extent = 
               Top = 246
               Left = 656
               Bottom = 365
               Right = 874
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0023"
            Begin Extent = 
               Top = 246
               Left = 912
               Bottom = 365
               Right = 1128
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0001"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 485
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_StoreList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_StoreList'
GO
/****** Object:  View [dbo].[V_MtrlStockList]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_MtrlStockList]
as
--材料库存明细查询
SELECT dbo.Data0017.INV_PART_NUMBER as 材料编码,dbo.Data0017.INV_NAME as 材料名称, 
       dbo.Data0017.INV_DESCRIPTION as 材料规格,dbo.Data0496.GROUP_DESC as 材料类型,
       dbo.Data0019.inv_group_desc as 材料组别,dbo.Data0002.UNIT_NAME as 单位, 
       dbo.Data0023.CODE AS 供应商代码,dbo.Data0023.ABBR_NAME AS 供应商简称,dbo.Data0022.QUAN_ON_HAND as 库存数量,                       
       (case when dbo.Data0022.EXPIRE_DATE IS not NULL then  DATEDIFF(day, GETDATE(), 
       dbo.Data0022.EXPIRE_DATE) else 0 end ) AS 有效天数,
       DATEDIFF(day,dbo.Data0456.ship_date, GETDATE()) as 入库天数 ,
       dbo.Data0022.QUAN_ON_HAND - dbo.Data0022.QUAN_TO_BE_STOCKED AS 有效库存, 
       dbo.Data0016.LOCATION as 仓库,dbo.Data0022.spec_place as 具体位置, 
       dbo.Data0022.EXPIRE_DATE 有效期,dbo.Data0022.BARCODE_ID as 备注, 
       dbo.Data0022.cust_decl as 报关单号,dbo.Data0022.TDATE as 制造日期, 
       dbo.Data0456.GRN_NUMBER as 入库单号,dbo.Data0022.rohs as 环保标识, 
       dbo.Data0022.SUPPLIER2 as 原供应商或生产批号,dbo.Data0022.PACKING_SLIP_FLAG as 耐CAF,
       CASE WHEN dbo.Data0456.ttype = 1 THEN '编码入库' WHEN dbo.Data0456.ttype = 2 
       THEN '杂项入库' WHEN dbo.Data0456.ttype = 3 THEN '直接入库' 
       WHEN dbo.Data0456.ttype= 4 THEN '调拔入库' 
       WHEN dbo.Data0456.ttype = 5 THEN 'VMI入库' END AS 入库类型, 
       dbo.Data0015.ABBR_NAME as 工厂, dbo.Data0456.ship_DATE as 送货日期, 
       ROUND(dbo.Data0022.QUAN_ON_HAND * dbo.Data0017.STOCK_SELL, 4) AS 库存面积,
       dbo.Data0001.CURR_CODE as 币种,dbo.Data0456.exch_rate as 汇率,dbo.Data0022.TAX_2 as 税率,   
       dbo.Data0022.tax_price as 含税价格, dbo.Data0022.PRICE as 不含税价, 
       ROUND(dbo.Data0022.PRICE * dbo.Data0456.exch_rate, 4) AS 本币不含税价, 
       dbo.Data0022.tax_price * dbo.Data0456.exch_rate AS 本币含税价, 
       ROUND((dbo.Data0022.tax_price * dbo.Data0456.exch_rate * dbo.Data0022.QUAN_ON_HAND) 
       / (1 + dbo.Data0022.TAX_2 * 0.01), 4) AS 本币不含税金额, 
       dbo.Data0022.tax_price * dbo.Data0456.exch_rate * dbo.Data0022.QUAN_ON_HAND AS 本币含税金额, 
       (CASE  WHEN  (DATEDIFF(day, GETDATE(), dbo.Data0022.EXPIRE_DATE) <= 0) 
       and (dbo.Data0022.EXPIRE_DATE is not  null)  THEN '已过期'
       WHEN  (DATEDIFF(day, GETDATE(), dbo.Data0022.EXPIRE_DATE) >0) 
       and (dbo.Data0022.EXPIRE_DATE is not  null )  THEN '有效'
       ELSE '无有效期' END) AS 状态,
       dbo.Data0022.STOCK_BASE as 库存单重KG, 
       dbo.Data0022.STOCK_BASE * dbo.Data0022.QUAN_ON_HAND AS 库存总重, 
       dbo.Data0068.PO_REQ_NUMBER as 请购编号,dbo.Data0070.PO_REV_NO as 请购部门,dbo.Data0071.reason as 请购原因, 
       dbo.Data0070.PO_NUMBER as 采购单号,dbo.Data0070.ANALYSIS_CODE_1 as 请购人员,
       Data0005_1.EMPLOYEE_NAME as 采购人员,dbo.Data0070.CONFIRMATION_NUMBER as 最后审核人,
       dbo.Data0005.EMPLOYEE_NAME AS IQC审核人员,dbo.Data0391.auth_date AS IQC审核时间,
       CASE data0391.status WHEN 1 THEN '待检验' WHEN 3 THEN '审核不合格'
       WHEN 2 THEN  '已审核'  END AS IQC检测状态
FROM   dbo.Data0005 AS Data0005_1 RIGHT OUTER JOIN
       dbo.Data0070 RIGHT OUTER JOIN
	   dbo.Data0015 INNER JOIN
	   dbo.Data0023 INNER JOIN
	   dbo.Data0456 INNER JOIN
	   dbo.Data0022 INNER JOIN
	   dbo.Data0017 ON dbo.Data0022.INVENTORY_PTR = dbo.Data0017.RKEY INNER JOIN
	   dbo.Data0496 ON dbo.Data0017.GROUP_PTR = dbo.Data0496.RKEY ON dbo.Data0456.RKEY = dbo.Data0022.GRN_PTR INNER JOIN
	   dbo.Data0002 ON dbo.Data0022.LOCATION_PTR_FROM = dbo.Data0002.RKEY ON dbo.Data0023.RKEY = dbo.Data0456.SUPP_PTR INNER JOIN
	   dbo.Data0016 ON dbo.Data0022.LOCATION_PTR = dbo.Data0016.RKEY ON dbo.Data0015.RKEY = dbo.Data0456.warehouse_ptr INNER JOIN
	   dbo.Data0001 ON dbo.Data0456.currency_ptr = dbo.Data0001.RKEY LEFT OUTER JOIN
	   dbo.Data0071 ON dbo.Data0022.SOURCE_PTR = dbo.Data0071.RKEY LEFT OUTER JOIN
	   dbo.Data0019 ON dbo.Data0496.group_ptr = dbo.Data0019.rkey LEFT OUTER JOIN
	   dbo.DATA0391 ON dbo.Data0022.rkey391 = dbo.DATA0391.rkey LEFT OUTER JOIN
	   dbo.Data0005 ON dbo.DATA0391.auth_user_ptr = dbo.Data0005.RKEY ON dbo.Data0070.RKEY = dbo.Data0456.PO_PTR LEFT OUTER JOIN
	   dbo.Data0069 ON dbo.Data0071.rkey69 = dbo.Data0069.RKEY LEFT OUTER JOIN
	   dbo.Data0068 ON dbo.Data0069.PURCH_REQ_PTR = dbo.Data0068.RKEY ON Data0005_1.RKEY = dbo.Data0070.EMPLOYEE_POINTER
WHERE  dbo.Data0022.QUAN_ON_HAND > 0
GO
/****** Object:  View [dbo].[V_Return_Goods]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Return_Goods]
AS
SELECT     dbo.Data0098.RMA_NUMBER AS 退货单号码, dbo.Data0010.CUST_CODE AS 客户代码, dbo.Data0010.ABBR_NAME AS 客户简称, 
                      dbo.Data0025.MANU_PART_DESC AS 客户型号, dbo.Data0025.MANU_PART_NUMBER AS 本厂编号, dbo.Data0060.SALES_ORDER AS 订单编号, 
                      dbo.Data0098.RMA_DATE AS 退货日期, dbo.Data0097.PO_NUMBER AS 客户订单号, dbo.Data0098.QTY_AUTH AS 退货数量, dbo.Data0098.QTY_RECD AS 数量, 
                      dbo.Data0060.PARTS_RETURNED - dbo.Data0060.RETURNED_SHIP AS 欠货数PCS, dbo.Data0005.EMPLOYEE_NAME AS 录入人员, 
                      dbo.Data0023.ABBR_NAME AS 外发供应商, dbo.Data0060.PARTS_ALLOC AS 原币不含税单价, ROUND(dbo.Data0060.PARTS_ALLOC / dbo.Data0060.EXCH_RATE, 6) 
                      AS 本币不含税单价, dbo.Data0001.CURR_NAME AS 货币, dbo.Data0008.PRODUCT_NAME AS 产品类型, dbo.Data0116.MEMO_NUMBER AS 备忘号, 
                      dbo.Data0025.unit_sq AS 单只面积, dbo.Data0098.QTY_RECD * dbo.Data0025.unit_sq AS 面积, dbo.Data0015.WAREHOUSE_CODE AS 工厂代码, 
                      CASE Data0098.RMA_STATUS WHEN 1 THEN '未提交' WHEN 2 THEN '待入仓' WHEN 3 THEN '已入仓' WHEN 4 THEN '已充帐' END AS 退货状态, 
                      CASE Data0098.rma_type WHEN 0 THEN '客户退货' WHEN 1 THEN '主动召回' END AS 退货类型, 
                      CASE Data0060.so_tp WHEN 0 THEN '自制' WHEN 1 THEN '外发' WHEN 2 THEN '半制程' END AS 订单类别, 
                      ROUND(dbo.Data0098.QTY_RECD * dbo.Data0025.REPORT_UNIT_VALUE1 * 0.001, 4) AS 总重量, 
                      CASE WHEN ROUND((dbo.Data0098.QTY_AUTH * dbo.Data0060.PARTS_ALLOC) * (1 + dbo.Data0060.RUSH_CHARGE * 0.01), 4) IS NULL 
                      THEN 0 ELSE ROUND((dbo.Data0098.QTY_AUTH * dbo.Data0060.PARTS_ALLOC) * (1 + dbo.Data0060.RUSH_CHARGE * 0.01), 4) END AS 含税金额, 
                      ROUND((dbo.Data0098.QTY_AUTH * dbo.Data0060.PARTS_ALLOC) * (1 + dbo.Data0060.RUSH_CHARGE * 0.01), 4) AS 原币含税退货金额, 
                      dbo.Data0098.remark AS 常用备注, dbo.Data0098.qty_ship AS 需补货数, CONVERT(varchar, dbo.Data0098.RMA_DATE, 23) AS 日期, CONVERT(varchar(7), 
                      dbo.Data0098.RMA_DATE, 23) AS 月份
FROM         dbo.Data0008 INNER JOIN
                      dbo.Data0098 INNER JOIN
                      dbo.Data0005 ON dbo.Data0098.AUTH_BY_EMPL_PTR = dbo.Data0005.RKEY INNER JOIN
                      dbo.Data0025 ON dbo.Data0098.CUSTOMER_PART_PTR = dbo.Data0025.RKEY ON dbo.Data0008.RKEY = dbo.Data0025.PROD_CODE_PTR INNER JOIN
                      dbo.Data0010 ON dbo.Data0098.CUSTOMER_PTR = dbo.Data0010.RKEY LEFT OUTER JOIN
                      dbo.Data0060 LEFT OUTER JOIN
                      dbo.Data0015 ON dbo.Data0060.SHIP_REG_TAX_ID = dbo.Data0015.RKEY LEFT OUTER JOIN
                      dbo.Data0001 ON dbo.Data0060.CURRENCY_PTR = dbo.Data0001.RKEY LEFT OUTER JOIN
                      dbo.Data0097 ON dbo.Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.RKEY ON dbo.Data0098.SO_PTR = dbo.Data0060.RKEY LEFT OUTER JOIN
                      dbo.Data0023 ON dbo.Data0060.supplier_ptr = dbo.Data0023.RKEY LEFT OUTER JOIN
                      dbo.Data0116 ON dbo.Data0098.srce_ptr = dbo.Data0116.RKEY
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0008"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0098"
            Begin Extent = 
               Top = 6
               Left = 290
               Bottom = 125
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0005"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0025"
            Begin Extent = 
               Top = 126
               Left = 251
               Bottom = 245
               Right = 469
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0010"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0060"
            Begin Extent = 
               Top = 246
               Left = 294
               Bottom = 365
               Right = 515
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0015"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 485
               Right = 225
            End
            DisplayFlags ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Return_Goods'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 280
            TopColumn = 0
         End
         Begin Table = "Data0001"
            Begin Extent = 
               Top = 366
               Left = 263
               Bottom = 485
               Right = 463
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0097"
            Begin Extent = 
               Top = 486
               Left = 38
               Bottom = 605
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0023"
            Begin Extent = 
               Top = 486
               Left = 245
               Bottom = 605
               Right = 461
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0116"
            Begin Extent = 
               Top = 606
               Left = 38
               Bottom = 725
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 32
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Return_Goods'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Return_Goods'
GO
/****** Object:  View [dbo].[V_OutPrd64]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_OutPrd64]
as

SELECT dbo.Data0060.SALES_ORDER as 销售订单, dbo.data0439.delivery_no as 装箱单,  dbo.Data0025.MANU_PART_NUMBER as 本厂编号,
data0008.PROD_CODE as 类型代码,Data0008.PRODUCT_NAME as 类型名称,
  
Data0112.invoice_number as 发票号码,data0112.POSTED_DATE as 发票日期, 

dbo.Data0097.PO_NUMBER as 客户订单号,  dbo.Data0025.MANU_PART_DESC as 客户型号, dbo.Data0025.ANALYSIS_CODE_2 as 客户物料号,
dbo.Data0010.CUST_CODE as 客户代码,dbo.Data0010.ABBR_NAME as 客户简称,dbo.Data0060.ORIG_CUSTOMER as 关联原客户,
 
dbo.Data0060.SCH_DATE as 回复交期,dbo.data0439.date_sailing as 出货日期, dbo.Data0064.DATE_ASSIGN as 指派日期, 
  
dbo.Data0064.QUAN_SHIPPED as 出货数量,ROUND(dbo.Data0064.QUAN_SHIPPED * dbo.Data0025.unit_sq, 4) AS 出货面积,
ROUND(dbo.Data0064.QUAN_SHIPPED * dbo.Data0064.REPORT_UNIT_VALUE1 * 0.001, 4) AS 出货重量KG,dbo.Data0064.cartons_no as 出货箱数, 
dbo.data0439.fob as 交货箱尺寸, dbo.data0439.reference_number as 包装箱尺寸,
  
dbo.Data0001.CURR_CODE as 货币代码,dbo.Data0060.EXCH_RATE as 汇率,dbo.Data0064.TAX_2 as 税率,
 
CASE data0060.tax_in_price WHEN 'N' THEN '否' WHEN 'Y' THEN '是' END AS 是否含税, dbo.Data0064.part_price as 价格, 
ROUND(dbo.Data0064.part_price * dbo.Data0064.QUAN_SHIPPED, 4) AS 金额,

(case when data0439.invoice_ptr is null then 'N' else 'Y' end) as 是否开票,data0064.ovsh_qty as 已开票数量,
  
dbo.Data0064.cust_decl as 报关单号,dbo.Data0005.EMPLOYEE_NAME as 指派员工,dbo.Data0064.REMARK AS 指派备注,

Data0023.CODE as 供应商代码, dbo.Data0023.ABBR_NAME AS 供应商简称
   
from data0064 inner join 
data0060 on data0064.SO_PTR=data0060.rkey inner join
data0025 on data0060.Cust_Part_Ptr=data0025.rkey inner join
data0008 on data0025.prod_code_ptr=data0008.rkey inner join 
data0001 on Data0060.CURRENCY_PTR = dbo.Data0001.RKEY inner join
data0097 on Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.RKEY left join
data0023 on Data0060.supplier_ptr=data0023.rkey left join
data0439 on Data0064.packing_list_ptr = dbo.data0439.rkey left join
data0010 on data0439.customer_ptr = dbo.Data0010.RKEY left join
Data0005 on data0439.employee_ptr = dbo.Data0005.RKEY left join
Data0112 ON dbo.data0439.invoice_ptr = dbo.Data0112.RKEY
WHERE (dbo.Data0064.QUAN_SHIPPED > 0)
GO
/****** Object:  View [dbo].[V_ReqList]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_ReqList]
as
SELECT  Data0068.PO_REQ_NUMBER as 请购单号,Data0068.REQ_DATE as 请购日期,
		Data0034.DEPT_NAME as 请购部门,Data0005.EMPLOYEE_NAME as 请购人员,

        CASE Data0068.FLAG when 'S' then '生产物料' else '非生产物料' end as 类别,
        CASE Data0068.STATUS WHEN 7 THEN '未提交' WHEN 1 THEN '待审批' WHEN 2 THEN '待采购' WHEN 3 THEN '已批准' 
        WHEN 4 THEN '被退回' WHEN 5 THEN '请购单已撤消' WHEN 6 THEN '请购单已处理' END AS 状态,

        Data0017.INV_PART_NUMBER as 材料编码,Data0017.INV_NAME as 材料名称, Data0017.INV_DESCRIPTION as 材料规格,

        Data0069.QUANTITY as 请购数量,Data0069.req_quantity as 请购需求数量,

		Data0001.CURR_NAME as 货币,Data0002.UNIT_NAME as 单位,

		Data0023.ABBR_NAME as 供应商,Data0015.ABBR_NAME as 工厂,

        Data0069.reason as 请购原因,Data0069.extra_req as 特别要求
FROM    Data0069 INNER JOIN
        Data0017 ON Data0069.INVT_PTR = Data0017.RKEY INNER JOIN
        Data0068 ON Data0069.PURCH_REQ_PTR = Data0068.RKEY INNER JOIN
        Data0015 ON Data0068.WHSE_PTR = Data0015.RKEY INNER JOIN
        Data0005 ON Data0068.REQ_BY = Data0005.RKEY INNER JOIN
        Data0002 ON Data0069.UNIT_PTR = Data0002.RKEY INNER JOIN
        Data0034 ON Data0068.DEPARTMENT_NAME = Data0034.DEPT_CODE LEFT OUTER JOIN
        Data0001 ON Data0069.PO_LINK_PTR = Data0001.RKEY LEFT OUTER JOIN
        Data0023 ON Data0069.SUPP_PTR = Data0023.RKEY
--WHERE 1=1
UNION
SELECT  Data0068_1.PO_REQ_NUMBER as 请购单号,Data0068_1.REQ_DATE as 请购日期,

        Data0034_1.DEPT_NAME as 请购部门, Data0005_1.EMPLOYEE_NAME as 请购人员,

        CASE Data0068_1.FLAG when 'S' then '生产物料' else '非生产物料' end as 类别,
        CASE Data0068_1.STATUS WHEN 7 THEN '未提交' WHEN 1 THEN '待审批' WHEN 2 THEN '待采购' WHEN 3 THEN '已批准' 
        WHEN 4 THEN '被退回' WHEN 5 THEN '请购单已撤消' WHEN 6 THEN '请购单已处理' END AS 状态,

        Data0204.DESCRIPTION_2 as 材料编码,Data0204.DESCRIPTION_1 as 材料名称, Data0204.GUI_GE as 材料规格,

		Data0204.QUANTITY_REQUIRED as 请购数量,Data0204.req_quantity 请购需求数量,

        Data0001_1.CURR_NAME as 货币, Data0002_1.UNIT_NAME as 单位, 

        Data0023_1.ABBR_NAME as 供应商,Data0015_1.ABBR_NAME as 工厂,

        Data0204.reason 请购原因, '' AS 特别要求
FROM    Data0204 INNER JOIN
        Data0068 AS Data0068_1 ON Data0204.PURCHASE_REQ_PTR = Data0068_1.RKEY INNER JOIN
        Data0015 AS Data0015_1 ON Data0068_1.WHSE_PTR = Data0015_1.RKEY INNER JOIN
        Data0005 AS Data0005_1 ON Data0068_1.REQ_BY = Data0005_1.RKEY INNER JOIN
        Data0002 AS Data0002_1 ON Data0204.G_L_PTR = Data0002_1.RKEY INNER JOIN
        Data0034 AS Data0034_1 ON Data0068_1.DEPARTMENT_NAME = Data0034_1.DEPT_CODE LEFT OUTER JOIN
        Data0001 AS Data0001_1 ON Data0204.PO_LINK_PTR = Data0001_1.RKEY LEFT OUTER JOIN
        Data0023 AS Data0023_1 ON Data0204.SUPPLIER_PTR = Data0023_1.RKEY
GO
/****** Object:  View [dbo].[V_ReturnGoods]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ReturnGoods]
AS
SELECT     dbo.Data0098.RMA_NUMBER AS 退货单号码, dbo.Data0010.CUST_CODE AS 客户代码, dbo.Data0010.ABBR_NAME AS 客户简称, 
                      dbo.Data0025.MANU_PART_DESC AS 客户型号, dbo.Data0025.MANU_PART_NUMBER AS 本厂编号, dbo.Data0060.SALES_ORDER AS 订单编号, 
                      dbo.Data0098.RMA_DATE AS 退货日期, dbo.Data0098.QTY_AUTH AS 退货数量, dbo.Data0098.QTY_RECD AS 已接收数量, 
                      dbo.Data0060.PARTS_RETURNED - dbo.Data0060.RETURNED_SHIP AS 欠货数PCS, dbo.Data0005.EMPLOYEE_NAME AS 录入人员, 
                      dbo.Data0023.ABBR_NAME AS 外发供应商, dbo.Data0060.PARTS_ALLOC AS 原币不含税单价, ROUND(dbo.Data0060.PARTS_ALLOC / dbo.Data0060.EXCH_RATE, 6) 
                      AS 本币不含税单价, dbo.Data0001.CURR_NAME AS 货币, dbo.Data0008.PRODUCT_NAME AS 产品类别, dbo.Data0116.MEMO_NUMBER AS 备忘号, 
                      dbo.Data0025.unit_sq AS 单只面积, dbo.Data0098.QTY_RECD * dbo.Data0025.unit_sq AS 总面积, dbo.Data0015.WAREHOUSE_CODE AS 工厂代码, 
                      CASE Data0098.RMA_STATUS WHEN 1 THEN '未提交' WHEN 2 THEN '待入仓' WHEN 3 THEN '已入仓' WHEN 4 THEN '已充帐' END AS 退货状态, 
                      CASE Data0098.rma_type WHEN 0 THEN '客户退货' WHEN 1 THEN '主动召回' END AS 退货类型, 
                      ROUND(dbo.Data0098.QTY_RECD * dbo.Data0025.REPORT_UNIT_VALUE1 * 0.001, 4) AS 总重量, ROUND((dbo.Data0098.QTY_AUTH * dbo.Data0060.PARTS_ALLOC) 
                      * (1 + dbo.Data0060.RUSH_CHARGE * 0.01), 4) AS 原币含税退货金额, dbo.Data0098.remark AS 常用备注, dbo.Data0098.qty_ship AS 需补货数
FROM         dbo.Data0008 INNER JOIN
                      dbo.Data0098 INNER JOIN
                      dbo.Data0005 ON dbo.Data0098.AUTH_BY_EMPL_PTR = dbo.Data0005.RKEY INNER JOIN
                      dbo.Data0025 ON dbo.Data0098.CUSTOMER_PART_PTR = dbo.Data0025.RKEY ON dbo.Data0008.RKEY = dbo.Data0025.PROD_CODE_PTR INNER JOIN
                      dbo.Data0010 ON dbo.Data0098.CUSTOMER_PTR = dbo.Data0010.RKEY LEFT OUTER JOIN
                      dbo.Data0060 LEFT OUTER JOIN
                      dbo.Data0015 ON dbo.Data0060.SHIP_REG_TAX_ID = dbo.Data0015.RKEY LEFT OUTER JOIN
                      dbo.Data0001 ON dbo.Data0060.CURRENCY_PTR = dbo.Data0001.RKEY LEFT OUTER JOIN
                      dbo.Data0097 ON dbo.Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.RKEY ON dbo.Data0098.SO_PTR = dbo.Data0060.RKEY LEFT OUTER JOIN
                      dbo.Data0023 ON dbo.Data0060.supplier_ptr = dbo.Data0023.RKEY LEFT OUTER JOIN
                      dbo.Data0116 ON dbo.Data0098.srce_ptr = dbo.Data0116.RKEY
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0008"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0098"
            Begin Extent = 
               Top = 6
               Left = 290
               Bottom = 125
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0005"
            Begin Extent = 
               Top = 6
               Left = 550
               Bottom = 125
               Right = 725
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0025"
            Begin Extent = 
               Top = 6
               Left = 763
               Bottom = 125
               Right = 981
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0010"
            Begin Extent = 
               Top = 6
               Left = 1019
               Bottom = 125
               Right = 1237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0060"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0015"
            Begin Extent = 
               Top = 126
               Left = 297
               Bottom = 245
               Right = 484
            End
            DisplayFlags = ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_ReturnGoods'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'280
            TopColumn = 0
         End
         Begin Table = "Data0001"
            Begin Extent = 
               Top = 126
               Left = 522
               Bottom = 245
               Right = 722
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0097"
            Begin Extent = 
               Top = 126
               Left = 760
               Bottom = 245
               Right = 929
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Data0023"
            Begin Extent = 
               Top = 126
               Left = 967
               Bottom = 245
               Right = 1183
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0116"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_ReturnGoods'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_ReturnGoods'
GO
/****** Object:  View [dbo].[v_VMIMtrlStockIn_List]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_VMIMtrlStockIn_List]
AS

SELECT 
--材料信息
	Data0017.INV_PART_NUMBER as 材料编码, Data0017.INV_NAME as 材料名称,Data0017.INV_DESCRIPTION as 材料规格,
--材料类别
    Data0019.inv_group_desc 材料组别,Data0496.GROUP_DESC as 材料类别,
--相关单号
    Data0133.GRN_NUMBER as 入库单号,Data0134.cust_decl as 报关单号,Data0070.po_number as 采购单号,
--供应商信息
    Data0023.CODE as 供应商代码,Data0023.ABBR_NAME as 供应商简称,
--位置信息
    Data0015.ABBR_NAME as 工厂,Data0016.LOCATION as 仓库,Data0134.SUPPLIER2 as 具体位置,
--日期信息
    Data0133.ship_DATE as 送货日期, Data0134.manu_date as 制造日期,Data0134.EXPIRE_DATE as 有效期,
--数量信息
    Data0134.QUAN_ON_HAND as 当前库存数,Data0017.CONSIGN_ONHAND_QTY as 安全库存数, Data0002.UNIT_NAME as 单位,
--来源信息
    Data0034.DEPT_NAME as 请购部门,Data0071.reason 请购原因,D05_1.EMPLOYEE_NAME as 请购人员,
--其它信息
    Data0005.employee_name as 入库员工,Data0134.BARCODE_ID as 特殊要求,Data0134.rohs as 环保ROHS

FROM   Data0134 inner join
       Data0017 on Data0134.INVENTORY_PTR = Data0017.RKEY INNER JOIN
       Data0496 ON Data0017.GROUP_PTR = Data0496.RKEY INNER JOIN
       Data0133 ON Data0133.RKEY = Data0134.GRN_PTR INNER JOIN
       Data0002 ON Data0134.UNIT_PTR = Data0002.RKEY INNER JOIN
       Data0023 ON Data0023.RKEY = Data0133.SUPP_PTR INNER JOIN
       Data0016 ON Data0134.LOCATION_PTR = Data0016.RKEY INNER JOIN
       Data0015 ON Data0015.RKEY = Data0133.warehouse_ptr INNER JOIN
       Data0001 ON Data0133.currency_ptr = Data0001.RKEY INNER JOIN
       Data0005 ON Data0133.CREATE_BY = Data0005.RKEY INNER JOIN
       Data0019 on data0496.group_ptr=data0019.rkey left outer join 
       Data0070 on data0133.po_ptr=data0070.rkey left outer join 
       Data0071 on data0134.SOURCE_PTR=data0071.rkey left outer join
       Data0069 on data0071.rkey69=data0069.rkey left outer join
       Data0068 ON Data0068.RKEY = data0069.PURCH_REQ_PTR left outer join
       Data0005 D05_1 ON Data0068.REQ_BY = D05_1.RKEY left outer join
       Data0034 ON Data0068.DEPARTMENT_NAME = dbo.Data0034.DEPT_CODE  
WHERE  Data0134.QUAN_ON_HAND > 0 
--ORDER BY Data0017.INV_PART_NUMBER
GO
/****** Object:  View [dbo].[v_MtrlStockOut_list]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[v_MtrlStockOut_list]
AS  
SELECT     dbo.Data0207.TDATE,dbo.Data0457.GON_NUMBER AS 出库单号, dbo.Data0457.REF_NUMBER AS 领料单号, dbo.Data0456.GRN_NUMBER AS 入仓单号 ,  dbo.Data0070.PO_NUMBER 采购单号, 
	dbo.Data0017.INV_PART_NUMBER 材料编码, dbo.Data0017.INV_NAME 材料名称,  dbo.Data0017.INV_DESCRIPTION  材料规格,
	dbo.Data0496.GROUP_DESC 材料类别, dbo.Data0019.inv_group_name AS 材料组别,
	CASE WHEN dbo.Data0496.ttype = 'p' THEN '直接材料' WHEN dbo.Data0496.ttype = 'M' THEN '间接材料' END AS 直接或间接,
	CONVERT(VARCHAR(10),dbo.Data0207.TDATE,120) AS 发放日期, CONVERT(VARCHAR(7),dbo.Data0207.TDATE,120) AS 月份,
	dbo.Data0207.QUANTITY 发料数量,   dbo.Data0207.RTN_QUANTITY 退料数量, ROUND(dbo.Data0207.QUANTITY * dbo.Data0017.STOCK_SELL, 4) AS 发放面积, dbo.Data0002.UNIT_NAME AS 单位,
	dbo.Data0001.CURR_CODE AS 币别,data0001.EXCH_RATE AS 汇率,dbo.Data0022.TAX_2 AS 税率, 
	 dbo.Data0022.tax_price AS 含税价,    ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4)   AS 含税金额,
	dbo.Data0023.CODE  供应商代码, dbo.Data0023.ABBR_NAME AS 供应商简称,  
	Data0015_1.ABBR_NAME AS 库存工厂,Data0005_1.EMPLOYEE_NAME AS 发料人员,   dbo.Data0016.LOCATION AS 发放仓库名称, 
	Data0015.ABBR_NAME AS  领料工厂,dbo.Data0005.EMPLOYEE_NAME AS  领料人员,dbo.Data0034.DEPT_CODE 领料部门编号, dbo.Data0034.DEPT_NAME 领料部门名称, 
	CASE WHEN dbo.Data0034.ttype = 1 THEN '工序' WHEN dbo.Data0034.ttype <> 1 THEN '非工序' END AS 部门类型,                       	
	dbo.Data0456.ship_DATE AS 送货日期,  dbo.Data0022.EXPIRE_DATE  AS 有效期, 
     CASE data0456.ttype WHEN 1 THEN '编码入库' WHEN 3 THEN '直接入库' WHEN 4 THEN '调拔入库' WHEN 5 THEN 'VMI入库' END AS 入仓类型, 
	dbo.Data0468.CUT_NO AS 配料单号
FROM   dbo.Data0457
	INNER JOIN  dbo.Data0207 ON dbo.Data0207.GON_PTR = dbo.Data0457.RKEY 
	INNER JOIN  dbo.Data0017 ON dbo.Data0207.INVENTORY_PTR = dbo.Data0017.RKEY 
	INNER JOIN  dbo.Data0496 ON dbo.Data0017.GROUP_PTR = dbo.Data0496.RKEY
	INNER JOIN  dbo.Data0019 ON dbo.Data0496.group_ptr = dbo.Data0019.rkey 
	INNER JOIN  dbo.Data0034 ON dbo.Data0457.dept_ptr = dbo.Data0034.RKEY 
	INNER JOIN  dbo.Data0005 ON dbo.Data0457.RECD_BY = dbo.Data0005.RKEY
	INNER JOIN  dbo.Data0005 AS Data0005_1 ON dbo.Data0457.CREATE_BY = Data0005_1.RKEY                 
	INNER JOIN  dbo.Data0015 ON dbo.Data0457.warehouse_ptr = dbo.Data0015.RKEY
	INNER JOIN  dbo.Data0022 ON dbo.Data0207.D0022_PTR = dbo.Data0022.RKEY
	INNER JOIN  dbo.Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY 
	INNER JOIN  dbo.Data0468  ON dbo.Data0468.RKEY = dbo.Data0207.D0468_PTR 
	INNER JOIN  dbo.Data0002 ON dbo.Data0022.LOCATION_PTR_FROM = dbo.Data0002.RKEY  
	INNER JOIN  dbo.Data0023 ON dbo.Data0456.SUPP_PTR = dbo.Data0023.RKEY 
	INNER JOIN  dbo.Data0001 ON dbo.Data0456.currency_ptr = dbo.Data0001.RKEY
	INNER JOIN  dbo.Data0015 AS Data0015_1 ON dbo.Data0456.warehouse_ptr = Data0015_1.RKEY
	INNER JOIN  dbo.Data0016 ON dbo.Data0022.LOCATION_PTR = dbo.Data0016.RKEY 
	LEFT JOIN   dbo.Data0070 ON dbo.Data0456.PO_PTR = dbo.Data0070.RKEY        
WHERE     (dbo.Data0207.QUANTITY <>0) 
--and  Data0207.TDATE>='2017-10-08 00:00:00'and Data0207.TDATE<='2018-04-09 23:59:00'
GO
/****** Object:  View [dbo].[v_StockOut_list]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[v_StockOut_list]
as  
SELECT     dbo.Data0457.REF_NUMBER AS 领料单号, dbo.Data0457.GON_NUMBER as 出库单号, 
	dbo.Data0017.INV_PART_NUMBER 材料编码, dbo.Data0017.INV_NAME 材料名称,  dbo.Data0017.INV_DESCRIPTION  村料规格,
	dbo.Data0496.GROUP_DESC 材料类别,CASE WHEN dbo.Data0496.ttype = 'p' THEN '直接材料' WHEN dbo.Data0496.ttype = 'M' THEN '间接材料' END AS 材料类型,
	dbo.Data0207.TDATE as 发放日期, 
	dbo.Data0207.QUANTITY 发料数量,   dbo.Data0207.RTN_QUANTITY 退料数量,  dbo.Data0002.UNIT_NAME as 单位,
	dbo.Data0001.CURR_CODE as 币别,data0001.EXCH_RATE as 汇率,dbo.Data0022.TAX_2 as 税率, 
	 dbo.Data0022.tax_price as 含税价,    ROUND(dbo.Data0207.QUANTITY * dbo.Data0022.tax_price * dbo.Data0456.exch_rate, 4)   AS 含税金额,
	ROUND(dbo.Data0207.QUANTITY * dbo.Data0017.STOCK_SELL, 4) AS 发放面积,
	dbo.Data0023.CODE  供应商代码, dbo.Data0023.ABBR_NAME as 供应商简称,  
	Data0005_1.EMPLOYEE_NAME AS 发料人员,   dbo.Data0016.LOCATION as 仓库, 
	Data0015.ABBR_NAME as  领料工厂,dbo.Data0005.EMPLOYEE_NAME as  领料人员,
	dbo.Data0034.DEPT_CODE 申领部门编号, dbo.Data0034.DEPT_NAME 申领部门名称, CASE WHEN dbo.Data0034.ttype = 1 THEN '工序' WHEN dbo.Data0034.ttype <> 1 THEN '非工序' END AS 部门类型,                       
	dbo.Data0456.GRN_NUMBER as 入仓单号 ,  dbo.Data0070.PO_NUMBER 采购单号, 
	dbo.Data0456.ship_DATE AS 送货日期,  dbo.Data0022.EXPIRE_DATE  as 有效期,  
	Data0015_1.ABBR_NAME AS 库存工厂
FROM   dbo.Data0457
	INNER JOIN  dbo.Data0207 ON dbo.Data0207.GON_PTR = dbo.Data0457.RKEY 
	INNER JOIN  dbo.Data0017 ON dbo.Data0207.INVENTORY_PTR = dbo.Data0017.RKEY 
	INNER JOIN  dbo.Data0496 ON dbo.Data0017.GROUP_PTR = dbo.Data0496.RKEY
	INNER JOIN  dbo.Data0019 ON dbo.Data0496.group_ptr = dbo.Data0019.rkey 
	INNER JOIN  dbo.Data0034 ON dbo.Data0457.dept_ptr = dbo.Data0034.RKEY 
	INNER JOIN  dbo.Data0005 ON dbo.Data0457.RECD_BY = dbo.Data0005.RKEY
	INNER JOIN  dbo.Data0005 AS Data0005_1 ON dbo.Data0457.CREATE_BY = Data0005_1.RKEY                 
	INNER JOIN  dbo.Data0015 ON dbo.Data0457.warehouse_ptr = dbo.Data0015.RKEY
	INNER JOIN  dbo.Data0022 ON dbo.Data0207.D0022_PTR = dbo.Data0022.RKEY
	INNER JOIN  dbo.Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY 
	inner join  dbo.Data0468  ON dbo.Data0468.RKEY = dbo.Data0207.D0468_PTR 
	INNER JOIN  dbo.Data0002 ON dbo.Data0022.LOCATION_PTR_FROM = dbo.Data0002.RKEY  
	INNER JOIN  dbo.Data0023 ON dbo.Data0456.SUPP_PTR = dbo.Data0023.RKEY 
	INNER JOIN  dbo.Data0001 ON dbo.Data0456.currency_ptr = dbo.Data0001.RKEY
	INNER JOIN  dbo.Data0015 AS Data0015_1 ON dbo.Data0456.warehouse_ptr = Data0015_1.RKEY
	INNER JOIN  dbo.Data0016 ON dbo.Data0022.LOCATION_PTR = dbo.Data0016.RKEY 
	left join   dbo.Data0070 ON dbo.Data0456.PO_PTR = dbo.Data0070.RKEY        
WHERE     (dbo.Data0207.QUANTITY <>0) 
--and  Data0207.TDATE>='2017-10-08 00:00:00'and Data0207.TDATE<='2018-04-09 23:59:00'
GO
/****** Object:  View [dbo].[v_VMIStockInList]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_VMIStockInList]
 as 
SELECT Data0133.GRN_NUMBER as 入库单号,data0133.deliver_number as 送货单号, Data0070.PO_NUMBER as 采购订单号, 

       Data0017.INV_PART_NUMBER as 材料编码, Data0017.INV_NAME as 材料名称,Data0017.INV_DESCRIPTION as 材料规格 ,
       
       Data0496.GROUP_DESC as 材料类别,data0019.inv_group_desc as 材料组别,
       
       Data0023.CODE as 供应商代码, Data0023.ABBR_NAME AS 供应商名称, 
       
       Data0134.QUANTITY as 接收数量,Data0134.QUAN_ON_HAND as 现持有数量,Data0002.UNIT_NAME as 单位, 
       
       Data0001.CURR_CODE as 货币代码,data0001.EXCH_RATE as 汇率,Data0134.TAX_2 as 税率, Data0134.tax_PRICE as 含税价, 
       ROUND(dbo.Data0134.QUANTITY * dbo.Data0134.tax_price, 2) AS 原币含税金额,
       
       Data0015.ABBR_NAME as 工厂,Data0016.LOCATION as 仓库, Data0134.SUPPLIER2 as 详细位置,
       
       Data0133.ship_DATE as 送货日期,Data0134.EXPIRE_DATE as 有效期,
       
       case when data0133.ttype=1 then '按PO入库'
               when data0133.ttype=3  then '直接入库' end 入库类型,
      Data0005_1.EMPLOYEE_NAME as 创建人,data0034.dept_name as 请购部门 ,ANALYSIS_CODE_1 as  请购人员,Data0134.BARCODE_ID as 特别要求 
FROM dbo.Data0134 INNER JOIN
      dbo.Data0133 ON dbo.Data0134.GRN_PTR = dbo.Data0133.RKEY INNER JOIN
      dbo.Data0017 ON dbo.Data0134.INVENTORY_PTR = dbo.Data0017.RKEY INNER JOIN
      dbo.Data0496 ON dbo.Data0017.GROUP_PTR = dbo.Data0496.RKEY  INNER JOIN 
      dbo.Data0019 on  dbo.Data0019.rkey = dbo.Data0496.group_ptr INNER JOIN 
      dbo.Data0002 on dbo.Data0002.RKEY = dbo.Data0134.UNIT_PTR INNER JOIN
      dbo.Data0023 on dbo.Data0023.RKEY = dbo.Data0133.SUPP_PTR  INNER JOIN  
      dbo.Data0015 ON dbo.Data0133.warehouse_ptr = dbo.Data0015.RKEY INNER JOIN
      dbo.Data0016 ON dbo.Data0134.LOCATION_PTR = dbo.Data0016.RKEY INNER JOIN
      dbo.Data0001 ON dbo.Data0133.currency_ptr = dbo.Data0001.RKEY LEFT  JOIN
      dbo.Data0070 ON dbo.Data0133.PO_PTR = dbo.Data0070.RKEY left join 
      dbo.Data0071 ON dbo.Data0134.SOURCE_PTR = dbo.Data0071.RKEY left JOIN
      dbo.Data0005 ON dbo.Data0005.RKEY = dbo.Data0071.IQCEMPL_PTR    INNER JOIn  
      dbo.Data0005 as data0005_1  ON dbo.Data0133.CREATE_BY = Data0005_1.RKEY  left join 
      dbo.data0034 on data0034.dept_code=Data0070.PO_REV_NO 
WHERE (dbo.Data0134.QUANTITY > 0)
--and  Data0133.create_DATE>='2017-01-28 00:00:00'and Data0133.create_DATE<='2018-03-29 23:59:00'
--order by Data0496.GROUP_NAME,data0017.inv_part_number
GO
/****** Object:  View [dbo].[v_VMIStockIn_List]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_VMIStockIn_List]  
 as   
SELECT Data0133.GRN_NUMBER as 入库单号,data0133.deliver_number as 送货单号, Data0070.PO_NUMBER as 采购订单号,   
  
       Data0017.INV_PART_NUMBER as 材料编码, Data0017.INV_NAME as 材料名称,Data0017.INV_DESCRIPTION as 材料规格 ,  
         
       Data0496.GROUP_DESC as 材料类别,data0019.inv_group_desc as 材料组别,  
         
       Data0023.CODE as 供应商代码, Data0023.ABBR_NAME AS 供应商简称,   
         
       Data0134.QUANTITY as 接收数量,Data0134.QUAN_ON_HAND as 现持有数量,Data0002.UNIT_NAME as 单位,   
         
       Data0001.CURR_CODE as 货币代码,data0001.EXCH_RATE as 汇率,Data0134.TAX_2 as 税率, Data0134.tax_PRICE as 含税价,   
       ROUND(dbo.Data0134.QUANTITY * dbo.Data0134.tax_price, 2) AS 原币含税金额,  
         
       Data0015.ABBR_NAME as 工厂简称,Data0016.LOCATION as 仓库名称, Data0134.SUPPLIER2 as 详细位置,  
         
       Data0133.ship_DATE as 送货日期,convert(char(10),Data0134.EXPIRE_DATE,120) as 有效期,  
         
       case when data0133.ttype=1 then '按PO入库'  
               when data0133.ttype=3  then '直接入库' end 入库类型,  
      Data0005_1.EMPLOYEE_NAME as 创建人,data0034.dept_name as 请购部门 ,ANALYSIS_CODE_1 as  请购人员,Data0134.BARCODE_ID as 特别要求   
FROM dbo.Data0134 INNER JOIN  
      dbo.Data0133 ON dbo.Data0134.GRN_PTR = dbo.Data0133.RKEY INNER JOIN  
      dbo.Data0017 ON dbo.Data0134.INVENTORY_PTR = dbo.Data0017.RKEY INNER JOIN  
      dbo.Data0496 ON dbo.Data0017.GROUP_PTR = dbo.Data0496.RKEY  INNER JOIN   
      dbo.Data0019 on  dbo.Data0019.rkey = dbo.Data0496.group_ptr INNER JOIN   
      dbo.Data0002 on dbo.Data0002.RKEY = dbo.Data0134.UNIT_PTR INNER JOIN  
      dbo.Data0023 on dbo.Data0023.RKEY = dbo.Data0133.SUPP_PTR  INNER JOIN    
      dbo.Data0015 ON dbo.Data0133.warehouse_ptr = dbo.Data0015.RKEY INNER JOIN  
      dbo.Data0016 ON dbo.Data0134.LOCATION_PTR = dbo.Data0016.RKEY INNER JOIN  
      dbo.Data0001 ON dbo.Data0133.currency_ptr = dbo.Data0001.RKEY LEFT  JOIN  
      dbo.Data0070 ON dbo.Data0133.PO_PTR = dbo.Data0070.RKEY left join   
      dbo.Data0071 ON dbo.Data0134.SOURCE_PTR = dbo.Data0071.RKEY left JOIN  
      dbo.Data0005 ON dbo.Data0005.RKEY = dbo.Data0071.IQCEMPL_PTR    INNER JOIn    
      dbo.Data0005 as data0005_1  ON dbo.Data0133.CREATE_BY = Data0005_1.RKEY  left join   
      dbo.data0034 on data0034.dept_code=Data0070.PO_REV_NO   
WHERE (dbo.Data0134.QUANTITY > 0)  
--and  Data0133.create_DATE>='2017-01-28 00:00:00'and Data0133.create_DATE<='2018-03-29 23:59:00'  
--order by Data0496.GROUP_NAME,data0017.inv_part_number
GO
/****** Object:  View [dbo].[v_Order_List]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--订单列表查询视图
CREATE VIEW [dbo].[v_Order_List]
AS
SELECT     dbo.Data0060.SALES_ORDER AS 销售订单号,dbo.Data0015.ABBR_NAME 工厂,

dbo.Data0025.MANU_PART_NUMBER AS 本厂编号, dbo.Data0025.MANU_PART_DESC AS 客户型号, dbo.Data0025.ANALYSIS_CODE_2 AS 客户物料号,
dbo.Data0025.ANALYSIS_CODE_1 AS 交货尺寸, dbo.Data0025.set_qty AS 交货单元数, dbo.Data0025.SAMPLE_NR AS 测试成型备注,
                          
CASE data0025.ttype WHEN 0 THEN '量产' WHEN 1 THEN '样板' END AS 产品属性, dbo.Data0025.LAYERS AS 层数,dbo.Data0008.PRODUCT_NAME AS 产品类型,
                      
dbo.Data0010.CUST_CODE AS 客户代码, dbo.Data0010.ABBR_NAME AS 客户简称, 
dbo.Data0097.PO_NUMBER AS 客户订单号, dbo.Data0060.ORIG_CUSTOMER AS 关联原客户, 
                       
       dbo.Data0060.ENT_DATE AS 下单日期, 
      dbo.Data0060.ORIG_SCHED_SHIP_DATE AS 计划交期,
      dbo.Data0060.SCH_DATE AS 回复交期, 
      dbo.Data0060.CONF_DATE AS 确认日期,
                      
     case DATA0060.STATUS when 1 then '有效' when 2 then '暂缓' when 3 then '关闭' 
     when 4 then '已完成' when 6 then '未提交' end as 订单状态, 
     data0060.so_oldnew  as 订单新旧,                  
     case data0060.QUOTE_PRICE when 0 then '未评审' when 1 then '已评审'
     when 2 then '被退回' when 3 then '不评审' end as 评审标记,
     case data0060.so_tp when 0 then '自制' when 1 then '外发' when 2 then '半制程' end as 加工形式,
    case  data0060.PROD_REL when 1 then '未确认' when 2 then '已确认' when 3 then '已投产' end as 生产标记,
    
     dbo.Data0005.EMPLOYEE_NAME as 输入人员, data0005_1.EMPLOYEE_NAME AS 业务员, data0005_2.EMPLOYEE_NAME AS 确认人员,
                      
                      
   data0060.PARTS_ORDERED as 数量,data0060.PARTS_ORDERED*data0025.unit_sq as 面积,
  round(data0060.PARTS_ALLOC*(1+data0060.RUSH_CHARGE*0.01),4) as 含税价格,data0060.RUSH_CHARGE as 税率,
  round(data0060.PARTS_ORDERED*data0060.PARTS_ALLOC*(1+data0060.RUSH_CHARGE*0.01),2) as 含税金额,
    case when data0060.tax_in_price='Y' then Data0060.TOTAL_ADD_L_PRICE
   else Data0060.TOTAL_ADD_L_PRICE*(1+data0060.RUSH_CHARGE*0.01) end  as 工具费用,
  data0001.curr_name as 货币,
  
   dbo.Data0060.REFERENCE_NUMBER AS 订单参考,
   
   data0060.ISSUED_QTY as 投产数量,data0060.PARTS_SHIPPED as 送货数量,data0060.PARTS_RETURNED as 退货数量,data0060.RETURNED_SHIP as 退货再出货数量,
   data0060.PARTS_ORDERED-data0060.PARTS_SHIPPED+data0060.PARTS_RETURNED-data0060.RETURNED_SHIP as 欠货数量,isnull(d53.QTY_ON_HAND,0) AS 库存数量,
   --日期分组使用
   日期=convert(varchar,dbo.Data0060.ENT_DATE,23),月份=convert(varchar(7),dbo.Data0060.ENT_DATE,23)
FROM	dbo.Data0060 INNER JOIN
        dbo.Data0097 ON dbo.Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.RKEY INNER JOIN
        dbo.Data0025 ON dbo.Data0060.CUST_PART_PTR = dbo.Data0025.RKEY INNER JOIN
        dbo.Data0010 ON dbo.Data0060.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN
        dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN
        dbo.Data0015 ON dbo.Data0060.SHIP_REG_TAX_ID = dbo.Data0015.RKEY INNER JOIN
        dbo.Data0005 ON dbo.Data0060.ENTERED_BY_EMPL_PTR = dbo.Data0005.RKEY INNER JOIN
        dbo.Data0005 AS data0005_1 ON dbo.Data0060.COMM_ASSIGNED_BY_E_P = data0005_1.RKEY LEFT OUTER JOIN
        dbo.Data0005 AS data0005_2 ON dbo.Data0060.CONF_BY_EMPL_PTR = data0005_2.RKEY inner join data0001
        on data0060.CURRENCY_PTR=data0001.rkey LEFT OUTER JOIN 
		(select barcode_ptr,QTY_ON_HAND=sum(QTY_ON_HAND) from dbo.Data0053 where QTY_ON_HAND>0 group by barcode_ptr) d53 
		on dbo.Data0060.RKEY =d53.barcode_ptr
GO
/****** Object:  View [dbo].[v_employeemsg]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_employeemsg]     
as    
select top 10000    
a.rkey, 
a.station,   
a.chinesename,    
a.employeecode,    
a.departmentid,    
a.ondutytime,    
isnull(cast (convert (nvarchar(10), a.outdutytime,120) as datetime) ,NULL) as outdutytime,    
a.employ_type,    
isnull(a.Position,0) as position,    
a.[Rank],    
a.Politics_face,    
a.education,    
a.marriage,    
a.sex,    
a.addr,    
a.province,    
a.IDCard,    
a.Cardno,    
a.phone,    
a.attendance,    
a.wagetype,    
isnull(f.accountname,'暂无') as accountname,    
a.roomcode,    
a.nation,    
a.resume,    
a.others_contacts,    
a.birthday,    
a.status,    
a.classgroupid,    
b.departmentname,    
isnull((select top 1 code from dbo.employee_insurance  
where employeeid=a.rkey order by startdate desc),' ') as insurance_code,     
isnull(c.item,'') as position_item,    
isnull(d.classgroupcode,'') as  classgroupcode,    
isnull(e.item,'') as marriage_item,a.adate,a.formal,   
isnull(g.item,'') as Ranks,  
isnull(h.item,'') as StayGrade ,
'DGWZ' AS FACTORY  
from employeemsg a    
left join datadepartment b    
on a.departmentid=b.rkey    
left join datadetail c    
on a.position=c.rkey    
left join classgroup d    
on a.classgroupid=d.rkey    
left join datadetail e    
on a.marriage=e.rkey    
left join salaryaccount f    
on a.wagetype=f.rkey   
left join datadetail g  
on a.rank=g.rkey   
left join datadetail h  
on a.DGrade_Ptr=h.rkey  
order by  status,outdutytime desc    
---where employeecode ='23966'
GO
/****** Object:  View [dbo].[凭证借贷不平衡数据查询]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[凭证借贷不平衡数据查询]
AS
SELECT     TOP (100) PERCENT SUM(dbo.Data0106.AMOUNT) AS amount_d, dbo.Data0105.VOUCHER, d1.amount_c
FROM         dbo.Data0105 INNER JOIN
                      dbo.Data0106 ON dbo.Data0105.RKEY = dbo.Data0106.GL_HEADER_PTR INNER JOIN
                          (SELECT     TOP (100) PERCENT SUM(Data0106_1.AMOUNT) AS amount_c, Data0105_1.VOUCHER
                            FROM          dbo.Data0105 AS Data0105_1 INNER JOIN
                                                   dbo.Data0106 AS Data0106_1 ON Data0105_1.RKEY = Data0106_1.GL_HEADER_PTR
                            WHERE      (Data0105_1.FYEAR = 2011) AND (Data0105_1.PERIOD = 10) AND (Data0106_1.D_C = 'C')
                            GROUP BY Data0106_1.D_C, Data0105_1.VOUCHER
                            ORDER BY Data0105_1.VOUCHER) AS d1 ON d1.VOUCHER = dbo.Data0105.VOUCHER
WHERE     (dbo.Data0105.FYEAR = 2012) AND (dbo.Data0105.PERIOD = 2) AND (dbo.Data0106.D_C = 'D')
GROUP BY dbo.Data0106.D_C, dbo.Data0105.VOUCHER, d1.amount_c
HAVING      (SUM(dbo.Data0106.AMOUNT) <> d1.amount_c)
ORDER BY dbo.Data0105.VOUCHER
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0105"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 221
               Right = 273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0106"
            Begin Extent = 
               Top = 6
               Left = 311
               Bottom = 125
               Right = 507
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "d1"
            Begin Extent = 
               Top = 6
               Left = 545
               Bottom = 206
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'凭证借贷不平衡数据查询'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'凭证借贷不平衡数据查询'
GO
/****** Object:  View [dbo].[View_1]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT     t106.GL_ACCT_NO_PTR, t105.RKEY, t105.VOUCHER, t105.BATCH_NUMBER, t105.VOU_TYPE, t105.STATUS
FROM         dbo.Data0105 AS t105 INNER JOIN
                      dbo.Data0106 AS t106 ON t105.RKEY = t106.GL_HEADER_PTR
WHERE     (t105.FYEAR = '2016') AND (t105.PERIOD = '1') AND (NOT EXISTS
                          (SELECT     GL_ACCT_PTR
                            FROM          dbo.Data0110 AS t110
                            WHERE      (FYEAR = '2016') AND (GL_ACCT_PTR = t106.GL_ACCT_NO_PTR)))
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "t105"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 218
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t106"
            Begin Extent = 
               Top = 23
               Left = 486
               Bottom = 131
               Right = 657
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 27
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
/****** Object:  View [dbo].[V_fixAssetAlt]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_fixAssetAlt]
AS
SELECT     dbo.data0327.rkey, dbo.data0327.alter_date, dbo.Data0005.EMPLOYEE_NAME, dbo.data0327.fasset_ptr, dbo.Data0517.FASSET_CODE, 
                      dbo.Data0517.FASSET_NAME, dbo.Data0105.VOUCHER, dbo.data0327.Reason, dbo.data0327.ORIGINAL_VALUE, dbo.data0327.SUMMED_DEPRE, 
                      dbo.data0327.NET_VALUE, dbo.data0327.SURPLUS_RATE, dbo.data0327.SURPLUS, dbo.data0327.EXPECTED_LIFE_MONTHS, 
                      dbo.data0327.DEPRED_MONTHS, dbo.data0327.MONTH_DEPRE_RATE, dbo.data0327.MONTH_DEPRE_AMT, dbo.data0327.LOCATION, 
                      dbo.Data0514.FASSET_TYPE, Data0514_1.FASSET_TYPE AS altFASSET_TYPE, dbo.data0327.ORIGINAL_VALUE_1, dbo.data0327.DEPT_PTR, 
                      dbo.data0327.SUMMED_DEPRE_1, dbo.data0327.NET_VALUE_1, dbo.data0327.LOCATION_1, dbo.data0327.status_ptr, 
                      dbo.data0327.SURPLUS_RATE_1, dbo.data0327.SURPLUS_1, dbo.data0327.EXPECTED_LIFE_MONTHS_1, dbo.data0327.DEPRED_MONTHS_1, 
                      dbo.data0327.MONTH_DEPRE_RATE_1, dbo.data0327.MONTH_DEPRE_AMT_1, 
                      CASE WHEN Data0105.STATUS = 0 THEN '未审' WHEN Data0105.STATUS = 1 THEN '会计已审' WHEN Data0105.STATUS = 2 THEN '主管已审' WHEN Data0105.STATUS
                       = 3 THEN '已登帐' WHEN Data0105.STATUS = 4 THEN '出纳审核' END AS STATUS, dbo.data0327.DEPRE_MTHD_PTR, dbo.data0327.fasset_type_ptr, 
                      dbo.data0327.DEPRE_MTHD_PTR_1, dbo.data0327.increased_orig_value, 
                      CASE WHEN data0327.alter_type = 1 THEN '原值/残值/折旧变动' WHEN data0327.alter_type = 2 THEN '固定资产类别变动' WHEN data0327.alter_type =
                       3 THEN '固定资产部门(折旧费用)变动' WHEN data0327.alter_type = 4 THEN '使用状态变动' END AS alter_type, 
                      dbo.data0327.alter_type AS alter_type2, dbo.data0327.voucher_ptr,dbo.data0327.dept_ptr_1,dbo.data0327.rkey d327rkey
FROM         dbo.data0327 INNER JOIN
                      dbo.Data0517 ON dbo.data0327.fasset_ptr = dbo.Data0517.RKEY INNER JOIN
                      dbo.Data0005 ON dbo.data0327.alter_by_ptr = dbo.Data0005.RKEY INNER JOIN
                      dbo.Data0514 ON dbo.Data0517.FASSET_TYPE_PTR = dbo.Data0514.RKEY INNER JOIN
                      dbo.Data0514 AS Data0514_1 ON dbo.data0327.fasset_type_ptr_1 = Data0514_1.RKEY LEFT OUTER JOIN
                      dbo.Data0105 ON dbo.data0327.voucher_ptr = dbo.Data0105.RKEY
GO
/****** Object:  View [dbo].[v_WeiXinUser]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_WeiXinUser]
as
select a.rkey,a.userid,a.name,a.department,convert(int,a.enable) as enable,
	a.olduserid,a.english_name,a.mobile,a.status,iscon=case when b.guid<>'' then '是' else '否' end
from WeiXinUser a 
	left join Data0073(nolock) b on a.english_name=b.user_login_name and a.userid=b.guid
GO
/****** Object:  View [dbo].[View_SMS_DGGDC]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SMS_DGGDC]
AS
SELECT  TOP 1
        当日白班入库.当日白班入库面积 + 当日晚班入库.当日晚班入库面积 AS 当日入库面积,
        当日白班入库.当日白班入库产值 + 当日晚班入库.当日晚班入库产值 AS 当日入库产值,
        当日白班入库.当日白班入库面积,
        当日白班入库.当日白班入库产值,
        当日晚班入库.当日晚班入库面积,
        当日晚班入库.当日晚班入库产值,
        月累计入库.月累计入库面积,
        月累计入库.月累计入库产值, 
        当日出库.当日出库面积, 
        当日出库.当日出库产值, 
        月累计出库.月累计出库面积, 
        月累计出库.月累计出库产值,
        ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) AS 当日报废面积, 
        ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0) AS 月累计报废面积, 
        CASE  WHEN ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) <> 0 
              THEN ROUND(ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) 
                            / (当日白班入库.当日白班入库面积 + 当日晚班入库.当日晚班入库面积 + ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0)) * 100, 2) 
              ELSE 0 END AS 当日报废率, 
        CASE  WHEN ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0) <> 0 
              THEN ROUND(ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0) 
                            / (月累计入库.月累计入库面积 + ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0)) * 100, 2) 
              ELSE 0 END AS 月报废率, 
        当日订单.当日订单面积, 
        当日订单.当日订单未投面积, 
        月累计订单.月累计订单面积, 
        月累计订单.月累计订单未投面积, 
        当前库存.当前库存面积, 
        当前库存.当前库存金额, 
        超周期库存.超周期库存面积, 
        超周期库存.超周期库存金额,
        当前外层在线.当前外层在线面积 + 当前内芯在线.当前内芯在线面积 AS 当前在线面积, 
        当前外层在线.当前外层在线面积, 
        当前内芯在线.当前内芯在线面积,
		当前半制程在线.当前半制程在线面积, 
        当前在线暂缓.当前在线暂缓面积, 
        当日退货.当日退货面积, 
        月累计退货面积.月累计退货面积, 
        当日尾数入仓.当日尾数入仓面积, 
        当日尾数出仓.当日尾数出仓面积, 
        月累计尾数入仓.月尾数入仓面积,
        月累计尾数出仓.月累计尾数出仓面积,
        CASE WHEN 当天每块面积.当天每块面积 = 0 THEN 0
             ELSE ROUND((当日白班入库.当日白班入库面积 + 当日晚班入库.当日晚班入库面积) * 1.0 / 22 / 60 / 当天每块面积.当天每块面积, 2) 
        END AS 当天每分钟块过板数,
        CASE WHEN 月累计每块面积.月累计每块面积 = 0 THEN 0
             ELSE ROUND(月累计入库.月累计入库面积 * 1.0 / DAY(GETDATE()) / 22 / 60 / 月累计每块面积.月累计每块面积, 2)
        END AS 月累计每分钟块过板数
FROM   (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0053.QUANTITY * dbo.Data0025.unit_sq, 4)), 0), 0) AS 当日白班入库面积, 
                ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE, 4),6) 
                                      ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4), 6) 
                                                ELSE Data0025.LATEST_PRICE END END * dbo.Data0053.QUANTITY) / 10000, 0), 0) AS 当日白班入库产值
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                dbo.data0416 INNER JOIN
                dbo.Data0025 INNER JOIN
                dbo.Data0053 INNER JOIN
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY ON dbo.Data0025.RKEY = dbo.Data0053.CUST_PART_PTR ON 
                dbo.data0416.rkey = dbo.Data0053.NPAD_PTR LEFT OUTER JOIN
                dbo.Data0006 ON dbo.Data0053.WORK_ORDER_PTR = dbo.Data0006.RKEY LEFT OUTER JOIN
                dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO ON Data0060_2.SALES_ORDER = dbo.data0492.SO_NO ON 
                data0060_1.RKEY = dbo.data0416.so_ptr
        WHERE  (dbo.Data0053.QUANTITY > 0) AND 
               (
                ((dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND (dbo.Data0016.CODE IN ('ST040')))
               ) AND
               (dbo.Data0053.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (dbo.Data0053.MFG_DATE <  CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 20:00:00', 120)) AND 
               (dbo.Data0053.RMA_PTR = 0)) 
    AS 当日白班入库	CROSS JOIN
      (SELECT   TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0053.QUANTITY * dbo.Data0025.unit_sq, 4)), 0), 0) AS 当日晚班入库面积, 
                ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE, 4),6) 
                                      ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4), 6) 
                                                ELSE Data0025.LATEST_PRICE END END * dbo.Data0053.QUANTITY) / 10000, 0), 0) AS 当日晚班入库产值
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                dbo.data0416 INNER JOIN
                dbo.Data0025 INNER JOIN
                dbo.Data0053 INNER JOIN
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY ON dbo.Data0025.RKEY = dbo.Data0053.CUST_PART_PTR ON 
                dbo.data0416.rkey = dbo.Data0053.NPAD_PTR LEFT OUTER JOIN
                dbo.Data0006 ON dbo.Data0053.WORK_ORDER_PTR = dbo.Data0006.RKEY LEFT OUTER JOIN
                dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO ON Data0060_2.SALES_ORDER = dbo.data0492.SO_NO ON 
                data0060_1.RKEY = dbo.data0416.so_ptr
        WHERE  (dbo.Data0053.QUANTITY > 0) AND 
               (
                ((dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND (dbo.Data0016.CODE IN ('ST040')))
               ) AND 
               (dbo.Data0053.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 20:00:00', 120)) AND 
               (dbo.Data0053.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (dbo.Data0053.RMA_PTR = 0)) 
    AS 当日晚班入库	CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_1.QUANTITY * Data0025_1.unit_sq, 4)), 0), 0) AS 月累计入库面积, 
                ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE,4), 6) 
                                      ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4),6) 
                                                ELSE Data0025_1.LATEST_PRICE END END * Data0053_1.QUANTITY) / 10000, 0), 0) AS 月累计入库产值
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                dbo.data0416 AS data0416_1 INNER JOIN
                dbo.Data0025 AS Data0025_1 INNER JOIN
                dbo.Data0053 AS Data0053_1 INNER JOIN
                dbo.Data0015 AS Data0015_1 ON Data0053_1.WHSE_PTR = Data0015_1.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_1 ON Data0053_1.LOC_PTR = Data0016_1.RKEY ON Data0025_1.RKEY = Data0053_1.CUST_PART_PTR ON 
                data0416_1.rkey = Data0053_1.NPAD_PTR LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_1 ON Data0053_1.WORK_ORDER_PTR = Data0006_1.RKEY LEFT OUTER JOIN
                dbo.data0492 AS data0492_1 ON Data0006_1.CUT_NO = data0492_1.CUT_NO ON Data0060_2.SALES_ORDER = data0492_1.SO_NO ON 
                data0060_1.RKEY = data0416_1.so_ptr
        WHERE  (Data0053_1.QUANTITY > 0) AND 
               (
                ((Data0015_1.WAREHOUSE_CODE = 'D0001') AND (Data0016_1.CODE IN ('ST040')))
               ) AND 
               (Data0053_1.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
               (Data0053_1.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0053_1.RMA_PTR = 0)) 
    AS 月累计入库 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0052.QUAN_SHP * Data0025_13.unit_sq, 4)), 0), 0) AS 当日出库面积, 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0052.QUAN_SHP * dbo.Data0060.PARTS_ALLOC / dbo.Data0060.EXCH_RATE, 4))/ 10000, 0), 0) AS 当日出库产值
        FROM    dbo.Data0052 INNER JOIN
                dbo.Data0064 ON dbo.Data0052.SO_SHP_PTR = dbo.Data0064.RKEY INNER JOIN
                dbo.Data0060 ON dbo.Data0064.SO_PTR = dbo.Data0060.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_6 ON dbo.Data0052.DATA0053_PTR = Data0053_6.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_13 ON Data0053_6.WHSE_PTR = Data0015_13.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_6 ON Data0053_6.LOC_PTR = Data0016_6.RKEY INNER JOIN
                dbo.Data0025 AS Data0025_13 ON Data0053_6.CUST_PART_PTR = Data0025_13.RKEY INNER JOIN
                dbo.Data0001 ON dbo.Data0060.CURRENCY_PTR = dbo.Data0001.RKEY LEFT OUTER JOIN
                dbo.data0416 AS data0416_3 ON Data0053_6.NPAD_PTR = data0416_3.rkey LEFT OUTER JOIN
                dbo.data0439 ON dbo.Data0064.packing_list_ptr = dbo.data0439.rkey LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_6 ON Data0053_6.WORK_ORDER_PTR = Data0006_6.RKEY
        WHERE  (
                ((Data0016_6.CODE IN ('ST040')) AND (Data0015_13.WAREHOUSE_CODE = 'D0001'))
               )AND 
               (dbo.Data0064.DATE_ASSIGN >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (dbo.Data0064.DATE_ASSIGN <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (dbo.Data0064.PACKING_SLIP_FLAG = '1') AND (Data0025_13.ttype = 0) AND (dbo.Data0052.QUAN_SHP > 0)) 
    AS 当日出库 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0052_1.QUAN_SHP * Data0025_14.unit_sq, 4)), 0), 0) AS 月累计出库面积, 
                ISNULL(ROUND(SUM(ROUND(Data0052_1.QUAN_SHP * Data0060_7.PARTS_ALLOC / Data0060_7.EXCH_RATE, 4))/ 10000, 0), 0) AS 月累计出库产值
        FROM    dbo.Data0052 AS Data0052_1 INNER JOIN
                dbo.Data0064 AS Data0064_1 ON Data0052_1.SO_SHP_PTR = Data0064_1.RKEY INNER JOIN
                dbo.Data0060 AS Data0060_7 ON Data0064_1.SO_PTR = Data0060_7.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_7 ON Data0052_1.DATA0053_PTR = Data0053_7.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_14 ON Data0053_7.WHSE_PTR = Data0015_14.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_7 ON Data0053_7.LOC_PTR = Data0016_7.RKEY INNER JOIN
                dbo.Data0025 AS Data0025_14 ON Data0053_7.CUST_PART_PTR = Data0025_14.RKEY INNER JOIN
                dbo.Data0001 AS Data0001_1 ON Data0060_7.CURRENCY_PTR = Data0001_1.RKEY LEFT OUTER JOIN
                dbo.data0416 AS data0416_4 ON Data0053_7.NPAD_PTR = data0416_4.rkey LEFT OUTER JOIN
                dbo.data0439 AS data0439_1 ON Data0064_1.packing_list_ptr = data0439_1.rkey LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_7 ON Data0053_7.WORK_ORDER_PTR = Data0006_7.RKEY
        WHERE  (
                ((Data0016_7.CODE IN ('ST040')) AND (Data0015_14.WAREHOUSE_CODE = 'D0001'))
               )AND 
               (Data0064_1.DATE_ASSIGN >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
               (Data0064_1.DATE_ASSIGN <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0064_1.PACKING_SLIP_FLAG = '1') AND (Data0025_14.ttype = 0) AND (Data0052_1.QUAN_SHP > 0)) 
    AS 月累计出库 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(dbo.Data0058.QTY_REJECT * Data0025_2.unit_sq), 0), 0) AS 当日报废面积
        FROM    dbo.Data0058 INNER JOIN
                dbo.Data0006 AS Data0006_2 ON dbo.Data0058.WO_PTR = Data0006_2.RKEY INNER JOIN
                dbo.Data0025 AS Data0025_2 ON Data0006_2.BOM_PTR = Data0025_2.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_2 ON dbo.Data0058.warehouse_ptr = Data0015_2.RKEY INNER JOIN
                dbo.Data0039 AS Data0039_DRBF ON dbo.Data0058.REJECT_PTR = Data0039_DRBF.RKEY
        WHERE  (Data0015_2.WAREHOUSE_CODE = 'D0001') AND (dbo.Data0058.TTYPE <> 2) AND 
               (Data0039_DRBF.rej_type <> 4) AND
               (dbo.Data0058.TDATETIME >= CONVERT(DATETIME, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (dbo.Data0058.TDATETIME <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND
               (Data0039_DRBF.REJECT_DESCRIPTION NOT LIKE '%研发%'))
    AS 当日报废 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(Data0058_1.QTY_REJECT * Data0025_3.unit_sq), 0), 0) AS 月累计报废面积
        FROM    dbo.Data0058 AS Data0058_1 INNER JOIN
                dbo.Data0006 AS Data0006_3 ON Data0058_1.WO_PTR = Data0006_3.RKEY INNER JOIN
                dbo.Data0025 AS Data0025_3 ON Data0006_3.BOM_PTR = Data0025_3.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_3 ON Data0058_1.warehouse_ptr = Data0015_3.RKEY INNER JOIN
                dbo.Data0039 AS Data0039_YLJBF ON Data0058_1.REJECT_PTR = Data0039_YLJBF.RKEY
        WHERE  (Data0015_3.WAREHOUSE_CODE = 'D0001') AND (Data0058_1.TTYPE <> 2) AND 
               (Data0039_YLJBF.rej_type <> 4) AND
               (Data0058_1.TDATETIME >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
               (Data0058_1.TDATETIME <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND
               (Data0039_YLJBF.REJECT_DESCRIPTION NOT LIKE '%研发%'))
    AS 月累计报废 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(dbo.Data0060.PARTS_ORDERED * Data0025_8.unit_sq), 0), 0) AS 当日订单面积, 
                ISNULL(ROUND(SUM(dbo.Data0060.TO_BE_PLANNED * Data0025_8.unit_sq), 0), 0) AS 当日订单未投面积
        FROM    dbo.Data0060 INNER JOIN
                dbo.Data0025 AS Data0025_8 ON dbo.Data0060.CUST_PART_PTR = Data0025_8.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_8 ON dbo.Data0060.SHIP_REG_TAX_ID = Data0015_8.RKEY
        WHERE  (Data0015_8.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.Data0060.ENT_DATE >= CONVERT(DATETIME, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 00:00:00', 120)) AND 
               (dbo.Data0060.so_style = 0) AND (Data0025_8.ttype = 0) AND (dbo.Data0060.so_tp = 0) AND 
               (dbo.Data0060.ENT_DATE <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 00:00:00', 120)) AND
               (dbo.Data0060.status IN (-1,1,2,3,4)))
    AS 当日订单 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(Data0060_4.PARTS_ORDERED * Data0025_7.unit_sq), 0), 0) AS 月累计订单面积, 
                ISNULL(ROUND(SUM(Data0060_4.TO_BE_PLANNED * Data0025_7.unit_sq), 0), 0) AS 月累计订单未投面积
        FROM    dbo.Data0060 AS Data0060_4 INNER JOIN
                dbo.Data0025 AS Data0025_7 ON Data0060_4.CUST_PART_PTR = Data0025_7.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_7 ON Data0060_4.SHIP_REG_TAX_ID = Data0015_7.RKEY
        WHERE  (Data0015_7.WAREHOUSE_CODE = 'D0001') AND 
               (Data0060_4.ENT_DATE >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 00:00:00', 120)) AND 
               (Data0060_4.so_style = 0) AND (Data0025_7.ttype = 0) AND (Data0060_4.so_tp = 0) AND 
               (Data0060_4.ENT_DATE <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 00:00:00', 120)) AND
               (Data0060_4.status IN (-1,1,2,3,4)))
    AS 月累计订单 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_2.QTY_ON_HAND * Data0025_6.unit_sq, 4)), 0), 0) AS 当前库存面积, 
                ISNULL(ROUND(SUM(Data0025_6.LATEST_PRICE * Data0053_2.QTY_ON_HAND)/ 10000, 0), 0) AS 当前库存金额
        FROM    dbo.Data0023 RIGHT OUTER JOIN
                dbo.Data0008 INNER JOIN
                dbo.Data0025 AS Data0025_6 ON dbo.Data0008.RKEY = Data0025_6.PROD_CODE_PTR INNER JOIN
                dbo.Data0010 ON Data0025_6.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_2 INNER JOIN
                dbo.Data0015 AS Data0015_6 ON Data0053_2.WHSE_PTR = Data0015_6.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_2 ON Data0053_2.LOC_PTR = Data0016_2.RKEY ON 
                Data0025_6.RKEY = Data0053_2.CUST_PART_PTR INNER JOIN
                dbo.data0416 AS data0416_6 ON Data0053_2.NPAD_PTR = data0416_6.rkey LEFT OUTER JOIN
                dbo.Data0060 AS Data0060_1 LEFT OUTER JOIN
                dbo.Data0010 AS Data0010_2 ON Data0060_1.CUSTOMER_PTR = Data0010_2.RKEY ON data0416_6.so_ptr = Data0060_1.RKEY ON 
                dbo.Data0023.RKEY = Data0060_1.supplier_ptr LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_9 LEFT OUTER JOIN
                dbo.data0492 AS data0492_6 LEFT OUTER JOIN
                dbo.Data0001 AS Data0001_3 RIGHT OUTER JOIN
                dbo.Data0010 AS Data0010_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_9 ON Data0010_1.RKEY = Data0060_9.CUSTOMER_PTR ON 
                Data0001_3.RKEY = Data0060_9.CURRENCY_PTR ON data0492_6.SO_NO = Data0060_9.SALES_ORDER ON 
                Data0006_9.CUT_NO = data0492_6.CUT_NO ON Data0053_2.WORK_ORDER_PTR = Data0006_9.RKEY
        WHERE  (
                ((Data0015_6.WAREHOUSE_CODE = 'D0001') AND (Data0016_2.CODE = 'ST040'))             
               ) 
           AND (Data0025_6.ttype = 0) AND (Data0053_2.QTY_ON_HAND > 0)) 
    AS 当前库存 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_8.QTY_ON_HAND * Data0025_15.unit_sq, 4)), 0), 0) AS 超周期库存面积,
                ISNULL(ROUND(SUM(Data0025_15.LATEST_PRICE * Data0053_8.QTY_ON_HAND)/ 10000, 0), 0) AS 超周期库存金额
        FROM    dbo.Data0023 AS Data0023_1 RIGHT OUTER JOIN
                dbo.Data0008 AS Data0008_1 INNER JOIN
                dbo.Data0025 AS Data0025_15 ON Data0008_1.RKEY = Data0025_15.PROD_CODE_PTR INNER JOIN
                dbo.Data0010 AS Data0010_3 ON Data0025_15.CUSTOMER_PTR = Data0010_3.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_8 INNER JOIN
                dbo.Data0015 AS Data0015_15 ON Data0053_8.WHSE_PTR = Data0015_15.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_8 ON Data0053_8.LOC_PTR = Data0016_8.RKEY ON 
                Data0025_15.RKEY = Data0053_8.CUST_PART_PTR INNER JOIN
                dbo.data0416 AS data0416_5 ON Data0053_8.NPAD_PTR = data0416_5.rkey LEFT OUTER JOIN
                dbo.Data0060 AS Data0060_1 LEFT OUTER JOIN
                dbo.Data0010 AS Data0010_2 ON Data0060_1.CUSTOMER_PTR = Data0010_2.RKEY ON data0416_5.so_ptr = Data0060_1.RKEY ON 
                Data0023_1.RKEY = Data0060_1.supplier_ptr LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_8 LEFT OUTER JOIN
                dbo.data0492 AS data0492_5 LEFT OUTER JOIN
                dbo.Data0001 AS Data0001_2 RIGHT OUTER JOIN
                dbo.Data0010 AS Data0010_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_8 ON Data0010_1.RKEY = Data0060_8.CUSTOMER_PTR ON 
                Data0001_2.RKEY = Data0060_8.CURRENCY_PTR ON data0492_5.SO_NO = Data0060_8.SALES_ORDER ON 
                Data0006_8.CUT_NO = data0492_5.CUT_NO ON Data0053_8.WORK_ORDER_PTR = Data0006_8.RKEY
        WHERE  (
                ((Data0015_15.WAREHOUSE_CODE = 'D0001') AND (Data0016_8.CODE = 'ST040'))
               ) 
           AND (Data0025_15.ttype = 0)
           AND (Data0053_8.MFG_DATE + /*Data0025_15.REVIEW_DAYS*/ 180 < GETDATE()) AND (Data0053_8.QTY_ON_HAND > 0)) 
    AS 超周期库存 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0025_5.unit_sq * dbo.Data0056.QTY_BACKLOG, 4)), 0), 0) AS 当前外层在线面积
        FROM    dbo.Data0025 AS Data0025_5 INNER JOIN
                dbo.Data0006 AS Data0006_4 ON Data0006_4.BOM_PTR = Data0025_5.RKEY INNER JOIN
                dbo.Data0056 ON dbo.Data0056.WO_PTR = Data0006_4.RKEY INNER JOIN
                dbo.data0492 AS data0492_3 ON data0492_3.CUT_NO = Data0006_4.CUT_NO INNER JOIN
                dbo.Data0015 AS Data0015_5 ON data0492_3.WHOUSE_PTR = Data0015_5.RKEY
        WHERE  (Data0025_5.ttype = 0) AND (ISNULL(Data0025_5.PARENT_PTR, 0) = 0) AND (ISNULL(dbo.Data0056.WTYPE, 0) = 0) AND 
               (Data0015_5.WAREHOUSE_CODE = 'D0001')) 
    AS 当前外层在线 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0025_5.unit_sq * dbo.Data0056.QTY_BACKLOG, 4)), 0), 0) AS 当前内芯在线面积
        FROM    dbo.Data0025 AS Data0025_5 INNER JOIN
                dbo.Data0006 AS Data0006_4 ON Data0006_4.BOM_PTR = Data0025_5.RKEY INNER JOIN
                dbo.Data0056 ON dbo.Data0056.WO_PTR = Data0006_4.RKEY INNER JOIN
                dbo.data0492 AS data0492_3 ON data0492_3.CUT_NO = Data0006_4.CUT_NO INNER JOIN
                dbo.Data0015 AS Data0015_5 ON data0492_3.WHOUSE_PTR = Data0015_5.RKEY
        WHERE  (Data0025_5.ttype = 0) AND (ISNULL(Data0025_5.PARENT_PTR, 0) > 0) AND (ISNULL(dbo.Data0056.WTYPE, 0) = 0) AND 
               (Data0015_5.WAREHOUSE_CODE = 'D0001')) 
    AS 当前内芯在线 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0025_BZCZX.unit_sq * Data0056_BZCZX.QTY_BACKLOG, 4)), 0), 0) AS 当前半制程在线面积
        FROM    dbo.Data0025 AS Data0025_BZCZX INNER JOIN
                dbo.Data0006 AS Data0006_BZCZX ON Data0006_BZCZX.BOM_PTR = Data0025_BZCZX.RKEY INNER JOIN
                dbo.Data0056 AS Data0056_BZCZX ON Data0056_BZCZX.WO_PTR = Data0006_BZCZX.RKEY INNER JOIN
                dbo.data0492 AS data0492_BZCZX ON data0492_BZCZX.CUT_NO = Data0006_BZCZX.CUT_NO INNER JOIN
                dbo.Data0015 AS Data0015_BZCZX ON data0492_BZCZX.WHOUSE_PTR = Data0015_BZCZX.RKEY
        WHERE  (Data0025_BZCZX.ttype = 0) AND (ISNULL(Data0056_BZCZX.WTYPE, 0) = 0) AND 
               (Data0025_BZCZX.MANU_PART_NUMBER LIKE 'BL%') AND 
			   ((Data0015_BZCZX.WAREHOUSE_CODE = 'D0001')/* OR (Data0015_BZCZX.WAREHOUSE_CODE = 'D0001')*/)) 
    AS 当前半制程在线 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0025_5.unit_sq * Data0056_1.QTY_BACKLOG, 4)), 0), 0) AS 当前在线暂缓面积
        FROM    dbo.Data0025 AS Data0025_5 INNER JOIN
                dbo.Data0006 AS Data0006_4 ON Data0006_4.BOM_PTR = Data0025_5.RKEY INNER JOIN
                dbo.Data0056 AS Data0056_1 ON Data0056_1.WO_PTR = Data0006_4.RKEY INNER JOIN
                dbo.data0492 AS data0492_4 ON data0492_4.CUT_NO = Data0006_4.CUT_NO INNER JOIN
                dbo.Data0015 AS Data0015_5 ON data0492_4.WHOUSE_PTR = Data0015_5.RKEY
        WHERE  (Data0025_5.ttype = 0) AND (ISNULL(Data0025_5.PARENT_PTR, 0) = 0) AND (Data0015_5.WAREHOUSE_CODE = 'D0001') AND 
               (Data0006_4.PROD_STATUS = 103)) 
    AS 当前在线暂缓 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0098.QTY_RECD * Data0025_9.unit_sq, 4)), 0), 0) AS 当日退货面积
        FROM    dbo.Data0098 INNER JOIN
                dbo.Data0025 AS Data0025_9 ON dbo.Data0098.CUSTOMER_PART_PTR = Data0025_9.RKEY LEFT OUTER JOIN
                dbo.Data0060 AS Data0060_5 LEFT OUTER JOIN
                dbo.Data0015 AS Data0015_9 ON Data0060_5.SHIP_REG_TAX_ID = Data0015_9.RKEY ON 
                dbo.Data0098.SO_PTR = Data0060_5.RKEY
        WHERE  (Data0015_9.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.Data0098.RMA_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120), 120)) AND 
               (dbo.Data0098.RMA_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120), 120))) 
    AS 当日退货 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0098_1.QTY_RECD * Data0025_4.unit_sq, 4)), 0), 0) AS 月累计退货面积
        FROM    dbo.Data0098 AS Data0098_1 INNER JOIN
                dbo.Data0025 AS Data0025_4 ON Data0098_1.CUSTOMER_PART_PTR = Data0025_4.RKEY LEFT OUTER JOIN
                dbo.Data0060 AS Data0060_3 LEFT OUTER JOIN
                dbo.Data0015 AS Data0015_4 ON Data0060_3.SHIP_REG_TAX_ID = Data0015_4.RKEY ON 
                Data0098_1.SO_PTR = Data0060_3.RKEY
        WHERE  (Data0015_4.WAREHOUSE_CODE = 'D0001') AND 
               (Data0098_1.RMA_DATE >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01', 120)) AND 
               (Data0098_1.RMA_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120), 120))) 
    AS 月累计退货面积 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_3.QUANTITY * Data0025_10.unit_sq, 4)), 2), 0) AS 当日尾数入仓面积
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                dbo.data0416 AS data0416_2 INNER JOIN
                dbo.Data0025 AS Data0025_10 INNER JOIN
                dbo.Data0053 AS Data0053_3 INNER JOIN
                dbo.Data0015 AS Data0015_10 ON Data0053_3.WHSE_PTR = Data0015_10.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_3 ON Data0053_3.LOC_PTR = Data0016_3.RKEY ON Data0025_10.RKEY = Data0053_3.CUST_PART_PTR ON 
                data0416_2.rkey = Data0053_3.NPAD_PTR LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_5 ON Data0053_3.WORK_ORDER_PTR = Data0006_5.RKEY LEFT OUTER JOIN
                dbo.data0492 AS data0492_2 ON Data0006_5.CUT_NO = data0492_2.CUT_NO ON Data0060_2.SALES_ORDER = data0492_2.SO_NO ON 
                data0060_1.RKEY = data0416_2.so_ptr
        WHERE  (Data0053_3.QUANTITY > 0) AND (Data0015_10.WAREHOUSE_CODE = 'D0001') AND 
               (Data0053_3.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (Data0053_3.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0016_3.CODE = 'ST041') AND (Data0053_3.RMA_PTR = 0)) 
    AS 当日尾数入仓 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0465.QUANTITY * dbo.Data0025.unit_sq, 4)), 2), 0) AS 当日尾数出仓面积
        FROM    dbo.Data0465 INNER JOIN
                dbo.data0415 ON dbo.Data0465.heard_ptr = dbo.data0415.rkey INNER JOIN
                dbo.Data0025 ON dbo.data0415.custpart_ptr = dbo.Data0025.RKEY INNER JOIN
                dbo.Data0053 ON dbo.Data0465.D0053_PTR = dbo.Data0053.RKEY INNER JOIN
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY
        WHERE  (dbo.Data0016.CODE = 'ST041') AND (dbo.data0415.type = 4) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.data0415.sys_date >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (dbo.data0415.sys_date <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120))) 
    AS 当日尾数出仓 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_3.QUANTITY * Data0025_10.unit_sq, 4)), 2), 0) AS 月尾数入仓面积
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                dbo.data0416 AS data0416_2 INNER JOIN
                dbo.Data0025 AS Data0025_10 INNER JOIN
                dbo.Data0053 AS Data0053_3 INNER JOIN
                dbo.Data0015 AS Data0015_10 ON Data0053_3.WHSE_PTR = Data0015_10.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_3 ON Data0053_3.LOC_PTR = Data0016_3.RKEY ON Data0025_10.RKEY = Data0053_3.CUST_PART_PTR ON 
                data0416_2.rkey = Data0053_3.NPAD_PTR LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_5 ON Data0053_3.WORK_ORDER_PTR = Data0006_5.RKEY LEFT OUTER JOIN
                dbo.data0492 AS data0492_2 ON Data0006_5.CUT_NO = data0492_2.CUT_NO ON Data0060_2.SALES_ORDER = data0492_2.SO_NO ON 
                data0060_1.RKEY = data0416_2.so_ptr
        WHERE  (Data0053_3.QUANTITY > 0) AND (Data0015_10.WAREHOUSE_CODE = 'D0001') AND 
               (Data0053_3.MFG_DATE >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
               (Data0053_3.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0016_3.CODE = 'ST041') AND (Data0053_3.RMA_PTR = 0)) 
    AS 月累计尾数入仓 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0465.QUANTITY * dbo.Data0025.unit_sq, 4)), 2), 0) AS 月累计尾数出仓面积
        FROM    dbo.Data0465 INNER JOIN
                dbo.data0415 ON dbo.Data0465.heard_ptr = dbo.data0415.rkey INNER JOIN
                dbo.Data0025 ON dbo.data0415.custpart_ptr = dbo.Data0025.RKEY INNER JOIN
                dbo.Data0053 ON dbo.Data0465.D0053_PTR = dbo.Data0053.RKEY INNER JOIN
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY
        WHERE  (dbo.Data0016.CODE = 'ST041') AND (dbo.data0415.type = 4) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.data0415.sys_date >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
               (dbo.data0415.sys_date <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120))) 
    AS 月累计尾数出仓 CROSS JOIN
       (SELECT  ISNULL(AVG(Data0006_dtmfzkgbl.PARTS_PER_PANEL * Data0025_dtmfzkgbl.unit_sq), 0) AS 当天每块面积
        FROM    dbo.Data0006 AS Data0006_dtmfzkgbl INNER JOIN
                dbo.Data0025 AS Data0025_dtmfzkgbl ON Data0006_dtmfzkgbl.BOM_PTR = Data0025_dtmfzkgbl.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_dtmfzkgbl ON Data0006_dtmfzkgbl.RKEY = Data0053_dtmfzkgbl.WORK_ORDER_PTR INNER JOIN
                dbo.Data0015 AS Data0015_dtmfzkgbl ON Data0053_dtmfzkgbl.WHSE_PTR = Data0015_dtmfzkgbl.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_dtmfzkgbl ON Data0053_dtmfzkgbl.LOC_PTR = Data0016_dtmfzkgbl.RKEY
        WHERE  (Data0053_dtmfzkgbl.QUANTITY > 0) AND (Data0015_dtmfzkgbl.WAREHOUSE_CODE = 'D0001') AND 
               (Data0053_dtmfzkgbl.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (Data0053_dtmfzkgbl.MFG_DATE <  CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0016_dtmfzkgbl.CODE = 'ST040') AND (Data0053_dtmfzkgbl.RMA_PTR = 0))
    AS 当天每块面积 CROSS JOIN
       (SELECT  ISNULL(AVG(Data0006_yljmfzkgbl.PARTS_PER_PANEL * Data0025_yljmfzkgbl.unit_sq), 0) AS 月累计每块面积
        FROM    dbo.Data0006 AS Data0006_yljmfzkgbl INNER JOIN
                dbo.Data0025 AS Data0025_yljmfzkgbl ON Data0006_yljmfzkgbl.BOM_PTR = Data0025_yljmfzkgbl.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_yljmfzkgbl ON Data0006_yljmfzkgbl.RKEY = Data0053_yljmfzkgbl.WORK_ORDER_PTR INNER JOIN
                dbo.Data0015 AS Data0015_yljmfzkgbl ON Data0053_yljmfzkgbl.WHSE_PTR = Data0015_yljmfzkgbl.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_yljmfzkgbl ON Data0053_yljmfzkgbl.LOC_PTR = Data0016_yljmfzkgbl.RKEY
        WHERE  (Data0053_yljmfzkgbl.QUANTITY > 0) AND (Data0015_yljmfzkgbl.WAREHOUSE_CODE = 'D0001') AND 
               (Data0053_yljmfzkgbl.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
               (Data0053_yljmfzkgbl.MFG_DATE <  CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0016_yljmfzkgbl.CODE = 'ST040') AND (Data0053_yljmfzkgbl.RMA_PTR = 0))
    AS 月累计每块面积
GO
/****** Object:  View [dbo].[View_SMS_DGHDI]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SMS_DGHDI]
AS
SELECT     TOP (1) 当日白班入库.当日白班入库面积 + 当日晚班入库.当日晚班入库面积 AS 当日入库面积, 
                      当日白班入库.当日白班入库产值 + 当日晚班入库.当日晚班入库产值 AS 当日入库产值, 当日白班入库.当日白班入库面积, 当日白班入库.当日白班入库产值, 
                      当日晚班入库.当日晚班入库面积, 当日晚班入库.当日晚班入库产值, 月累计入库.月累计入库面积, 月累计入库.月累计入库产值, 当日出库.当日出库面积, 
                      当日出库.当日出库产值, 月累计出库.月累计出库面积, 月累计出库.月累计出库产值, 
                      ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) AS 当日报废面积, 
                      ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0) AS 月累计报废面积, 
                      CASE WHEN ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) 
                      <> 0 THEN ROUND(ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) 
                      / (当日白班入库.当日白班入库面积 + 当日晚班入库.当日晚班入库面积 + ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积,
                       0)) * 100, 2) ELSE 0 END AS 当日报废率, CASE WHEN ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积,
                       0) <> 0 THEN ROUND(ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0) 
                      / (月累计入库.月累计入库面积 + ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0)) * 100, 2) 
                      ELSE 0 END AS 月报废率, 当日订单.当日订单面积, 当日订单.当日订单未投面积, 月累计订单.月累计订单面积, 月累计订单.月累计订单未投面积, 
                      当前库存.当前库存面积, 当前库存.当前库存金额, 超周期库存.超周期库存面积, 超周期库存.超周期库存金额, 
                      当前外层在线.当前外层在线面积 + 当前内芯在线.当前内芯在线面积 AS 当前在线面积, 当前外层在线.当前外层在线面积, 当前内芯在线.当前内芯在线面积, 
                      当前半制程在线.当前半制程在线面积, 当前在线暂缓.当前在线暂缓面积, 当日退货.当日退货面积, 月累计退货面积.月累计退货面积, 当日尾数入仓.当日尾数入仓面积, 
                      当日尾数出仓.当日尾数出仓面积, 月累计尾数入仓.月尾数入仓面积, 月累计尾数出仓.月累计尾数出仓面积, 
                      CASE WHEN 当天每块面积.当天每块面积 = 0 THEN 0 ELSE ROUND((当日白班入库.当日白班入库面积 + 当日晚班入库.当日晚班入库面积) 
                      * 1.0 / 22 / 60 / 当天每块面积.当天每块面积, 2) END AS 当天每分钟块过板数, 
                      CASE WHEN 月累计每块面积.月累计每块面积 = 0 THEN 0 ELSE ROUND(月累计入库.月累计入库面积 * 1.0 / DAY(GETDATE()) 
                      / 22 / 60 / 月累计每块面积.月累计每块面积, 2) END AS 月累计每分钟块过板数
FROM         (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(dbo.Data0053.QUANTITY * dbo.Data0025.unit_sq, 4)), 0), 0) AS 当日白班入库面积, 
                                              ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE, 4), 6) 
                                              ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4), 6) 
                                              ELSE Data0025.LATEST_PRICE END END * dbo.Data0053.QUANTITY) / 10000, 0), 0) AS 当日白班入库产值
                       FROM          dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                                              dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                                              dbo.data0416 INNER JOIN
                                              dbo.Data0025 INNER JOIN
                                              dbo.Data0053 INNER JOIN
                                              dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                                              dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY ON dbo.Data0025.RKEY = dbo.Data0053.CUST_PART_PTR ON 
                                              dbo.data0416.rkey = dbo.Data0053.NPAD_PTR LEFT OUTER JOIN
                                              dbo.Data0006 ON dbo.Data0053.WORK_ORDER_PTR = dbo.Data0006.RKEY LEFT OUTER JOIN
                                              dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO ON Data0060_2.SALES_ORDER = dbo.data0492.SO_NO ON 
                                              data0060_1.RKEY = dbo.data0416.so_ptr
                       WHERE      (dbo.Data0053.QUANTITY > 0) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0002') AND (dbo.Data0016.CODE IN ('ST005', 'ST020')) AND 
                                              (dbo.Data0053.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
                                              (dbo.Data0053.MFG_DATE < CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 20:00:00', 120)) AND 
                                              (dbo.Data0053.RMA_PTR = 0)) AS 当日白班入库 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(dbo.Data0053.QUANTITY * dbo.Data0025.unit_sq, 4)), 0), 0) AS 当日晚班入库面积, 
                                                   ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE, 4), 6) 
                                                   ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4), 6) 
                                                   ELSE Data0025.LATEST_PRICE END END * dbo.Data0053.QUANTITY) / 10000, 0), 0) AS 当日晚班入库产值
                            FROM          dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                                                   dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                                                   dbo.data0416 INNER JOIN
                                                   dbo.Data0025 INNER JOIN
                                                   dbo.Data0053 INNER JOIN
                                                   dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                                                   dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY ON dbo.Data0025.RKEY = dbo.Data0053.CUST_PART_PTR ON 
                                                   dbo.data0416.rkey = dbo.Data0053.NPAD_PTR LEFT OUTER JOIN
                                                   dbo.Data0006 ON dbo.Data0053.WORK_ORDER_PTR = dbo.Data0006.RKEY LEFT OUTER JOIN
                                                   dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO ON Data0060_2.SALES_ORDER = dbo.data0492.SO_NO ON 
                                                   data0060_1.RKEY = dbo.data0416.so_ptr
                            WHERE      (dbo.Data0053.QUANTITY > 0) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0002') AND (dbo.Data0016.CODE IN ('ST005', 'ST020')) AND 
                                                   (dbo.Data0053.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 20:00:00', 120)) AND 
                                                   (dbo.Data0053.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND (dbo.Data0053.RMA_PTR = 0)) 
                      AS 当日晚班入库 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0053_1.QUANTITY * Data0025_1.unit_sq, 4)), 0), 0) AS 月累计入库面积, 
                                                   ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE, 4), 6) 
                                                   ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4), 6) 
                                                   ELSE Data0025_1.LATEST_PRICE END END * Data0053_1.QUANTITY) / 10000, 0), 0) AS 月累计入库产值
                            FROM          dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                                                   dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                                                   dbo.data0416 AS data0416_1 INNER JOIN
                                                   dbo.Data0025 AS Data0025_1 INNER JOIN
                                                   dbo.Data0053 AS Data0053_1 INNER JOIN
                                                   dbo.Data0015 AS Data0015_1 ON Data0053_1.WHSE_PTR = Data0015_1.RKEY INNER JOIN
                                                   dbo.Data0016 AS Data0016_1 ON Data0053_1.LOC_PTR = Data0016_1.RKEY ON Data0025_1.RKEY = Data0053_1.CUST_PART_PTR ON 
                                                   data0416_1.rkey = Data0053_1.NPAD_PTR LEFT OUTER JOIN
                                                   dbo.Data0006 AS Data0006_1 ON Data0053_1.WORK_ORDER_PTR = Data0006_1.RKEY LEFT OUTER JOIN
                                                   dbo.data0492 AS data0492_1 ON Data0006_1.CUT_NO = data0492_1.CUT_NO ON Data0060_2.SALES_ORDER = data0492_1.SO_NO ON 
                                                   data0060_1.RKEY = data0416_1.so_ptr
                            WHERE      (Data0053_1.QUANTITY > 0) AND (Data0015_1.WAREHOUSE_CODE = 'D0002') AND (Data0016_1.CODE IN ('ST005', 'ST020')) AND 
                                                   (Data0053_1.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
                                                   (Data0053_1.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND (Data0053_1.RMA_PTR = 0)) 
                      AS 月累计入库 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(dbo.Data0052.QUAN_SHP * Data0025_13.unit_sq, 4)), 0), 0) AS 当日出库面积, 
                                                   ISNULL(ROUND(SUM(ROUND(dbo.Data0052.QUAN_SHP * dbo.Data0060.PARTS_ALLOC / dbo.Data0060.EXCH_RATE, 4)) / 10000, 0), 0) 
                                                   AS 当日出库产值
                            FROM          dbo.Data0052 INNER JOIN
                                                   dbo.Data0064 ON dbo.Data0052.SO_SHP_PTR = dbo.Data0064.RKEY INNER JOIN
                                                   dbo.Data0060 ON dbo.Data0064.SO_PTR = dbo.Data0060.RKEY INNER JOIN
                                                   dbo.Data0053 AS Data0053_6 ON dbo.Data0052.DATA0053_PTR = Data0053_6.RKEY INNER JOIN
                                                   dbo.Data0015 AS Data0015_13 ON Data0053_6.WHSE_PTR = Data0015_13.RKEY INNER JOIN
                                                   dbo.Data0016 AS Data0016_6 ON Data0053_6.LOC_PTR = Data0016_6.RKEY INNER JOIN
                                                   dbo.Data0025 AS Data0025_13 ON Data0053_6.CUST_PART_PTR = Data0025_13.RKEY INNER JOIN
                                                   dbo.Data0001 ON dbo.Data0060.CURRENCY_PTR = dbo.Data0001.RKEY LEFT OUTER JOIN
                                                   dbo.data0416 AS data0416_3 ON Data0053_6.NPAD_PTR = data0416_3.rkey LEFT OUTER JOIN
                                                   dbo.data0439 ON dbo.Data0064.packing_list_ptr = dbo.data0439.rkey LEFT OUTER JOIN
                                                   dbo.Data0006 AS Data0006_6 ON Data0053_6.WORK_ORDER_PTR = Data0006_6.RKEY
                            WHERE      (Data0016_6.CODE IN ('ST005')) AND (Data0015_13.WAREHOUSE_CODE = 'D0002') AND (dbo.Data0064.DATE_ASSIGN >= CONVERT(datetime, 
                                                   CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND (dbo.Data0064.DATE_ASSIGN <= CONVERT(datetime, 
                                                   CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND (dbo.Data0064.PACKING_SLIP_FLAG = '1') AND (Data0025_13.ttype = 0) AND 
                                                   (dbo.Data0052.QUAN_SHP > 0)) AS 当日出库 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0052_1.QUAN_SHP * Data0025_14.unit_sq, 4)), 0), 0) AS 月累计出库面积, 
                                                   ISNULL(ROUND(SUM(ROUND(Data0052_1.QUAN_SHP * Data0060_7.PARTS_ALLOC / Data0060_7.EXCH_RATE, 4)) / 10000, 0), 0) 
                                                   AS 月累计出库产值
                            FROM          dbo.Data0052 AS Data0052_1 INNER JOIN
                                                   dbo.Data0064 AS Data0064_1 ON Data0052_1.SO_SHP_PTR = Data0064_1.RKEY INNER JOIN
                                                   dbo.Data0060 AS Data0060_7 ON Data0064_1.SO_PTR = Data0060_7.RKEY INNER JOIN
                                                   dbo.Data0053 AS Data0053_7 ON Data0052_1.DATA0053_PTR = Data0053_7.RKEY INNER JOIN
                                                   dbo.Data0015 AS Data0015_14 ON Data0053_7.WHSE_PTR = Data0015_14.RKEY INNER JOIN
                                                   dbo.Data0016 AS Data0016_7 ON Data0053_7.LOC_PTR = Data0016_7.RKEY INNER JOIN
                                                   dbo.Data0025 AS Data0025_14 ON Data0053_7.CUST_PART_PTR = Data0025_14.RKEY INNER JOIN
                                                   dbo.Data0001 AS Data0001_1 ON Data0060_7.CURRENCY_PTR = Data0001_1.RKEY LEFT OUTER JOIN
                                                   dbo.data0416 AS data0416_4 ON Data0053_7.NPAD_PTR = data0416_4.rkey LEFT OUTER JOIN
                                                   dbo.data0439 AS data0439_1 ON Data0064_1.packing_list_ptr = data0439_1.rkey LEFT OUTER JOIN
                                                   dbo.Data0006 AS Data0006_7 ON Data0053_7.WORK_ORDER_PTR = Data0006_7.RKEY
                            WHERE      (Data0016_7.CODE IN ('ST005')) AND (Data0015_14.WAREHOUSE_CODE = 'D0002') AND (Data0064_1.DATE_ASSIGN >= CONVERT(datetime, 
                                                   CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND (Data0064_1.DATE_ASSIGN <= CONVERT(datetime, 
                                                   CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND (Data0064_1.PACKING_SLIP_FLAG = '1') AND (Data0025_14.ttype = 0) AND 
                                                   (Data0052_1.QUAN_SHP > 0)) AS 月累计出库 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(dbo.Data0058.QTY_REJECT * Data0025_2.unit_sq), 0), 0) AS 当日报废面积
                            FROM          dbo.Data0058 INNER JOIN
                                                   dbo.Data0006 AS Data0006_2 ON dbo.Data0058.WO_PTR = Data0006_2.RKEY INNER JOIN
                                                   dbo.Data0025 AS Data0025_2 ON Data0006_2.BOM_PTR = Data0025_2.RKEY INNER JOIN
                                                   dbo.Data0015 AS Data0015_2 ON dbo.Data0058.warehouse_ptr = Data0015_2.RKEY INNER JOIN
                                                   dbo.Data0039 AS Data0039_DRBF ON dbo.Data0058.REJECT_PTR = Data0039_DRBF.RKEY
                            WHERE      (Data0015_2.WAREHOUSE_CODE = 'D0002') AND (dbo.Data0058.TTYPE <> 2) AND (Data0039_DRBF.rej_type <> 4) AND 
                                                   (dbo.Data0058.TDATETIME >= CONVERT(DATETIME, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
                                                   (dbo.Data0058.TDATETIME <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
                                                   (Data0039_DRBF.REJECT_DESCRIPTION NOT LIKE '%研发%')) AS 当日报废 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(Data0058_1.QTY_REJECT * Data0025_3.unit_sq), 0), 0) AS 月累计报废面积
                            FROM          dbo.Data0058 AS Data0058_1 INNER JOIN
                                                   dbo.Data0006 AS Data0006_3 ON Data0058_1.WO_PTR = Data0006_3.RKEY INNER JOIN
                                                   dbo.Data0025 AS Data0025_3 ON Data0006_3.BOM_PTR = Data0025_3.RKEY INNER JOIN
                                                   dbo.Data0015 AS Data0015_3 ON Data0058_1.warehouse_ptr = Data0015_3.RKEY INNER JOIN
                                                   dbo.Data0039 AS Data0039_YLJBF ON Data0058_1.REJECT_PTR = Data0039_YLJBF.RKEY
                            WHERE      (Data0015_3.WAREHOUSE_CODE = 'D0002') AND (Data0058_1.TTYPE <> 2) AND (Data0039_YLJBF.rej_type <> 4) AND 
                                                   (Data0058_1.TDATETIME >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
                                                   (Data0058_1.TDATETIME <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
                                                   (Data0039_YLJBF.REJECT_DESCRIPTION NOT LIKE '%研发%')) AS 月累计报废 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(dbo.Data0060.PARTS_ORDERED * Data0025_8.unit_sq), 0), 0) AS 当日订单面积, 
                                                   ISNULL(ROUND(SUM(dbo.Data0060.TO_BE_PLANNED * Data0025_8.unit_sq), 0), 0) AS 当日订单未投面积
                            FROM          dbo.Data0060 INNER JOIN
                                                   dbo.Data0025 AS Data0025_8 ON dbo.Data0060.CUST_PART_PTR = Data0025_8.RKEY INNER JOIN
                                                   dbo.Data0015 AS Data0015_8 ON dbo.Data0060.SHIP_REG_TAX_ID = Data0015_8.RKEY
                            WHERE      (Data0015_8.WAREHOUSE_CODE = 'D0002') AND (dbo.Data0060.ENT_DATE >= CONVERT(DATETIME, CONVERT(varchar(10), DATEADD(day, - 1, 
                                                   GETDATE()), 120) + ' 00:00:00', 120)) AND (dbo.Data0060.so_style = 0) AND (Data0025_8.ttype = 0) AND (dbo.Data0060.so_tp = 0) AND 
                                                   (dbo.Data0060.ENT_DATE <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 00:00:00', 120)) AND (dbo.Data0060.STATUS IN (- 1, 1, 2, 
                                                   3, 4))) AS 当日订单 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(Data0060_4.PARTS_ORDERED * Data0025_7.unit_sq), 0), 0) AS 月累计订单面积, 
                                                   ISNULL(ROUND(SUM(Data0060_4.TO_BE_PLANNED * Data0025_7.unit_sq), 0), 0) AS 月累计订单未投面积
                            FROM          dbo.Data0060 AS Data0060_4 INNER JOIN
                                                   dbo.Data0025 AS Data0025_7 ON Data0060_4.CUST_PART_PTR = Data0025_7.RKEY INNER JOIN
                                                   dbo.Data0015 AS Data0015_7 ON Data0060_4.SHIP_REG_TAX_ID = Data0015_7.RKEY
                            WHERE      (Data0015_7.WAREHOUSE_CODE = 'D0002') AND (Data0060_4.ENT_DATE >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()),
                                                    120) + '01 00:00:00', 120)) AND (Data0060_4.so_style = 0) AND (Data0025_7.ttype = 0) AND (Data0060_4.so_tp = 0) AND 
                                                   (Data0060_4.ENT_DATE <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 00:00:00', 120)) AND (Data0060_4.STATUS IN (- 1, 1, 2, 3, 
                                                   4))) AS 月累计订单 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0053_2.QTY_ON_HAND * Data0025_6.unit_sq, 4)), 0), 0) AS 当前库存面积, 
                                                   ISNULL(ROUND(SUM(Data0025_6.LATEST_PRICE * Data0053_2.QTY_ON_HAND) / 10000, 0), 0) AS 当前库存金额
                            FROM          dbo.Data0023 RIGHT OUTER JOIN
                                                   dbo.Data0008 INNER JOIN
                                                   dbo.Data0025 AS Data0025_6 ON dbo.Data0008.RKEY = Data0025_6.PROD_CODE_PTR INNER JOIN
                                                   dbo.Data0010 ON Data0025_6.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN
                                                   dbo.Data0053 AS Data0053_2 INNER JOIN
                                                   dbo.Data0015 AS Data0015_6 ON Data0053_2.WHSE_PTR = Data0015_6.RKEY INNER JOIN
                                                   dbo.Data0016 AS Data0016_2 ON Data0053_2.LOC_PTR = Data0016_2.RKEY ON Data0025_6.RKEY = Data0053_2.CUST_PART_PTR INNER JOIN
                                                   dbo.data0416 AS data0416_6 ON Data0053_2.NPAD_PTR = data0416_6.rkey LEFT OUTER JOIN
                                                   dbo.Data0060 AS Data0060_1 LEFT OUTER JOIN
                                                   dbo.Data0010 AS Data0010_2 ON Data0060_1.CUSTOMER_PTR = Data0010_2.RKEY ON data0416_6.so_ptr = Data0060_1.RKEY ON 
                                                   dbo.Data0023.RKEY = Data0060_1.supplier_ptr LEFT OUTER JOIN
                                                   dbo.Data0006 AS Data0006_9 LEFT OUTER JOIN
                                                   dbo.data0492 AS data0492_6 LEFT OUTER JOIN
                                                   dbo.Data0001 AS Data0001_3 RIGHT OUTER JOIN
                                                   dbo.Data0010 AS Data0010_1 RIGHT OUTER JOIN
                                                   dbo.Data0060 AS Data0060_9 ON Data0010_1.RKEY = Data0060_9.CUSTOMER_PTR ON Data0001_3.RKEY = Data0060_9.CURRENCY_PTR ON 
                                                   data0492_6.SO_NO = Data0060_9.SALES_ORDER ON Data0006_9.CUT_NO = data0492_6.CUT_NO ON 
                                                   Data0053_2.WORK_ORDER_PTR = Data0006_9.RKEY
                            WHERE      (Data0015_6.WAREHOUSE_CODE = 'D0002') AND (Data0016_2.CODE = 'ST005') AND (Data0025_6.ttype = 0) AND (Data0053_2.QTY_ON_HAND > 0)) 
                      AS 当前库存 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0053_8.QTY_ON_HAND * Data0025_15.unit_sq, 4)), 0), 0) AS 超周期库存面积, 
                                                   ISNULL(ROUND(SUM(Data0025_15.LATEST_PRICE * Data0053_8.QTY_ON_HAND) / 10000, 0), 0) AS 超周期库存金额
                            FROM          dbo.Data0023 AS Data0023_1 RIGHT OUTER JOIN
                                                   dbo.Data0008 AS Data0008_1 INNER JOIN
                                                   dbo.Data0025 AS Data0025_15 ON Data0008_1.RKEY = Data0025_15.PROD_CODE_PTR INNER JOIN
                                                   dbo.Data0010 AS Data0010_3 ON Data0025_15.CUSTOMER_PTR = Data0010_3.RKEY INNER JOIN
                                                   dbo.Data0053 AS Data0053_8 INNER JOIN
                                                   dbo.Data0015 AS Data0015_15 ON Data0053_8.WHSE_PTR = Data0015_15.RKEY INNER JOIN
                                                   dbo.Data0016 AS Data0016_8 ON Data0053_8.LOC_PTR = Data0016_8.RKEY ON Data0025_15.RKEY = Data0053_8.CUST_PART_PTR INNER JOIN
                                                   dbo.data0416 AS data0416_5 ON Data0053_8.NPAD_PTR = data0416_5.rkey LEFT OUTER JOIN
                                                   dbo.Data0060 AS Data0060_1 LEFT OUTER JOIN
                                                   dbo.Data0010 AS Data0010_2 ON Data0060_1.CUSTOMER_PTR = Data0010_2.RKEY ON data0416_5.so_ptr = Data0060_1.RKEY ON 
                                                   Data0023_1.RKEY = Data0060_1.supplier_ptr LEFT OUTER JOIN
                                                   dbo.Data0006 AS Data0006_8 LEFT OUTER JOIN
                                                   dbo.data0492 AS data0492_5 LEFT OUTER JOIN
                                                   dbo.Data0001 AS Data0001_2 RIGHT OUTER JOIN
                                                   dbo.Data0010 AS Data0010_1 RIGHT OUTER JOIN
                                                   dbo.Data0060 AS Data0060_8 ON Data0010_1.RKEY = Data0060_8.CUSTOMER_PTR ON Data0001_2.RKEY = Data0060_8.CURRENCY_PTR ON 
                                                   data0492_5.SO_NO = Data0060_8.SALES_ORDER ON Data0006_8.CUT_NO = data0492_5.CUT_NO ON 
                                                   Data0053_8.WORK_ORDER_PTR = Data0006_8.RKEY
                            WHERE      (Data0015_15.WAREHOUSE_CODE = 'D0002') AND (Data0016_8.CODE = 'ST005') AND (Data0025_15.ttype = 0) AND 
                                                   (Data0053_8.MFG_DATE + 180 < GETDATE()) AND (Data0053_8.QTY_ON_HAND > 0)) AS 超周期库存 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0025_5.unit_sq * dbo.Data0056.QTY_BACKLOG, 4)), 0), 0) AS 当前外层在线面积
                            FROM          dbo.Data0025 AS Data0025_5 INNER JOIN
                                                   dbo.Data0006 AS Data0006_4 ON Data0006_4.BOM_PTR = Data0025_5.RKEY INNER JOIN
                                                   dbo.Data0056 ON dbo.Data0056.WO_PTR = Data0006_4.RKEY INNER JOIN
                                                   dbo.data0492 AS data0492_3 ON data0492_3.CUT_NO = Data0006_4.CUT_NO INNER JOIN
                                                   dbo.Data0015 AS Data0015_5 ON data0492_3.WHOUSE_PTR = Data0015_5.RKEY
                            WHERE      (Data0025_5.ttype = 0) AND (ISNULL(Data0025_5.PARENT_PTR, 0) = 0) AND (ISNULL(dbo.Data0056.WTYPE, 0) = 0) AND 
                                                   (Data0025_5.MANU_PART_NUMBER NOT LIKE 'BL%') AND (Data0015_5.WAREHOUSE_CODE = 'D0002')) AS 当前外层在线 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0025_5.unit_sq * dbo.Data0056.QTY_BACKLOG, 4)), 0), 0) AS 当前内芯在线面积
                            FROM          dbo.Data0025 AS Data0025_5 INNER JOIN
                                                   dbo.Data0006 AS Data0006_4 ON Data0006_4.BOM_PTR = Data0025_5.RKEY INNER JOIN
                                                   dbo.Data0056 ON dbo.Data0056.WO_PTR = Data0006_4.RKEY INNER JOIN
                                                   dbo.data0492 AS data0492_3 ON data0492_3.CUT_NO = Data0006_4.CUT_NO INNER JOIN
                                                   dbo.Data0015 AS Data0015_5 ON data0492_3.WHOUSE_PTR = Data0015_5.RKEY
                            WHERE      (Data0025_5.ttype = 0) AND (ISNULL(Data0025_5.PARENT_PTR, 0) > 0) AND (ISNULL(dbo.Data0056.WTYPE, 0) = 0) AND 
                                                   (Data0025_5.MANU_PART_NUMBER NOT LIKE 'BL%') AND (Data0015_5.WAREHOUSE_CODE = 'D0002')) AS 当前内芯在线 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0025_BZCZX.unit_sq * Data0056_BZCZX.QTY_BACKLOG, 4)), 0), 0) 
                                                   AS 当前半制程在线面积
                            FROM          dbo.Data0025 AS Data0025_BZCZX INNER JOIN
                                                   dbo.Data0006 AS Data0006_BZCZX ON Data0006_BZCZX.BOM_PTR = Data0025_BZCZX.RKEY INNER JOIN
                                                   dbo.Data0056 AS Data0056_BZCZX ON Data0056_BZCZX.WO_PTR = Data0006_BZCZX.RKEY INNER JOIN
                                                   dbo.data0492 AS data0492_BZCZX ON data0492_BZCZX.CUT_NO = Data0006_BZCZX.CUT_NO INNER JOIN
                                                   dbo.Data0015 AS Data0015_BZCZX ON data0492_BZCZX.WHOUSE_PTR = Data0015_BZCZX.RKEY
                            WHERE      (Data0025_BZCZX.ttype = 0) AND (ISNULL(Data0056_BZCZX.WTYPE, 0) = 0) AND (Data0025_BZCZX.MANU_PART_NUMBER LIKE 'BL%') AND 
                                                   (Data0015_BZCZX.WAREHOUSE_CODE = 'D0002')) AS 当前半制程在线 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0025_5.unit_sq * Data0056_1.QTY_BACKLOG, 4)), 0), 0) AS 当前在线暂缓面积
                            FROM          dbo.Data0025 AS Data0025_5 INNER JOIN
                                                   dbo.Data0006 AS Data0006_4 ON Data0006_4.BOM_PTR = Data0025_5.RKEY INNER JOIN
                                                   dbo.Data0056 AS Data0056_1 ON Data0056_1.WO_PTR = Data0006_4.RKEY INNER JOIN
                                                   dbo.data0492 AS data0492_4 ON data0492_4.CUT_NO = Data0006_4.CUT_NO INNER JOIN
                                                   dbo.Data0015 AS Data0015_5 ON data0492_4.WHOUSE_PTR = Data0015_5.RKEY
                            WHERE      (Data0025_5.ttype = 0) AND (ISNULL(Data0025_5.PARENT_PTR, 0) = 0) AND (Data0015_5.WAREHOUSE_CODE = 'D0002') AND 
                                                   (Data0006_4.PROD_STATUS = 103)) AS 当前在线暂缓 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(dbo.Data0098.QTY_RECD * Data0025_9.unit_sq, 4)), 0), 0) AS 当日退货面积
                            FROM          dbo.Data0098 INNER JOIN
                                                   dbo.Data0025 AS Data0025_9 ON dbo.Data0098.CUSTOMER_PART_PTR = Data0025_9.RKEY LEFT OUTER JOIN
                                                   dbo.Data0060 AS Data0060_5 LEFT OUTER JOIN
                                                   dbo.Data0015 AS Data0015_9 ON Data0060_5.SHIP_REG_TAX_ID = Data0015_9.RKEY ON dbo.Data0098.SO_PTR = Data0060_5.RKEY
                            WHERE      (Data0015_9.WAREHOUSE_CODE = 'D0002') AND (dbo.Data0098.RMA_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, 
                                                   GETDATE()), 120), 120)) AND (dbo.Data0098.RMA_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120), 120))) AS 当日退货 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0098_1.QTY_RECD * Data0025_4.unit_sq, 4)), 0), 0) AS 月累计退货面积
                            FROM          dbo.Data0098 AS Data0098_1 INNER JOIN
                                                   dbo.Data0025 AS Data0025_4 ON Data0098_1.CUSTOMER_PART_PTR = Data0025_4.RKEY LEFT OUTER JOIN
                                                   dbo.Data0060 AS Data0060_3 LEFT OUTER JOIN
                                                   dbo.Data0015 AS Data0015_4 ON Data0060_3.SHIP_REG_TAX_ID = Data0015_4.RKEY ON Data0098_1.SO_PTR = Data0060_3.RKEY
                            WHERE      (Data0015_4.WAREHOUSE_CODE = 'D0002') AND (Data0098_1.RMA_DATE >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 
                                                   120) + '01', 120)) AND (Data0098_1.RMA_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120), 120))) AS 月累计退货面积 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0053_3.QUANTITY * Data0025_10.unit_sq, 4)), 2), 0) AS 当日尾数入仓面积
                            FROM          dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                                                   dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                                                   dbo.data0416 AS data0416_2 INNER JOIN
                                                   dbo.Data0025 AS Data0025_10 INNER JOIN
                                                   dbo.Data0053 AS Data0053_3 INNER JOIN
                                                   dbo.Data0015 AS Data0015_10 ON Data0053_3.WHSE_PTR = Data0015_10.RKEY INNER JOIN
                                                   dbo.Data0016 AS Data0016_3 ON Data0053_3.LOC_PTR = Data0016_3.RKEY ON Data0025_10.RKEY = Data0053_3.CUST_PART_PTR ON 
                                                   data0416_2.rkey = Data0053_3.NPAD_PTR LEFT OUTER JOIN
                                                   dbo.Data0006 AS Data0006_5 ON Data0053_3.WORK_ORDER_PTR = Data0006_5.RKEY LEFT OUTER JOIN
                                                   dbo.data0492 AS data0492_2 ON Data0006_5.CUT_NO = data0492_2.CUT_NO ON Data0060_2.SALES_ORDER = data0492_2.SO_NO ON 
                                                   data0060_1.RKEY = data0416_2.so_ptr
                            WHERE      (Data0053_3.QUANTITY > 0) AND (Data0015_10.WAREHOUSE_CODE = 'D0002') AND (Data0016_3.CODE = 'ST007') AND 
                                                   (Data0053_3.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
                                                   (Data0053_3.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND (Data0053_3.RMA_PTR = 0)) 
                      AS 当日尾数入仓 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(dbo.Data0465.QUANTITY * dbo.Data0025.unit_sq, 4)), 2), 0) AS 当日尾数出仓面积
                            FROM          dbo.Data0465 INNER JOIN
                                                   dbo.data0415 ON dbo.Data0465.heard_ptr = dbo.data0415.rkey INNER JOIN
                                                   dbo.Data0025 ON dbo.data0415.custpart_ptr = dbo.Data0025.RKEY INNER JOIN
                                                   dbo.Data0053 ON dbo.Data0465.D0053_PTR = dbo.Data0053.RKEY INNER JOIN
                                                   dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                                                   dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY
                            WHERE      (dbo.Data0016.CODE = 'ST007') AND (dbo.Data0015.WAREHOUSE_CODE = 'D0002') AND (dbo.data0415.type = 4) AND 
                                                   (dbo.data0415.sys_date >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
                                                   (dbo.data0415.sys_date <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120))) AS 当日尾数出仓 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(Data0053_3.QUANTITY * Data0025_10.unit_sq, 4)), 2), 0) AS 月尾数入仓面积
                            FROM          dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                                                   dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                                                   dbo.data0416 AS data0416_2 INNER JOIN
                                                   dbo.Data0025 AS Data0025_10 INNER JOIN
                                                   dbo.Data0053 AS Data0053_3 INNER JOIN
                                                   dbo.Data0015 AS Data0015_10 ON Data0053_3.WHSE_PTR = Data0015_10.RKEY INNER JOIN
                                                   dbo.Data0016 AS Data0016_3 ON Data0053_3.LOC_PTR = Data0016_3.RKEY ON Data0025_10.RKEY = Data0053_3.CUST_PART_PTR ON 
                                                   data0416_2.rkey = Data0053_3.NPAD_PTR LEFT OUTER JOIN
                                                   dbo.Data0006 AS Data0006_5 ON Data0053_3.WORK_ORDER_PTR = Data0006_5.RKEY LEFT OUTER JOIN
                                                   dbo.data0492 AS data0492_2 ON Data0006_5.CUT_NO = data0492_2.CUT_NO ON Data0060_2.SALES_ORDER = data0492_2.SO_NO ON 
                                                   data0060_1.RKEY = data0416_2.so_ptr
                            WHERE      (Data0053_3.QUANTITY > 0) AND (Data0015_10.WAREHOUSE_CODE = 'D0002') AND (Data0016_3.CODE = 'ST007') AND 
                                                   (Data0053_3.MFG_DATE >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
                                                   (Data0053_3.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND (Data0053_3.RMA_PTR = 0)) 
                      AS 月累计尾数入仓 CROSS JOIN
                          (SELECT     TOP (100) PERCENT ISNULL(ROUND(SUM(ROUND(dbo.Data0465.QUANTITY * dbo.Data0025.unit_sq, 4)), 2), 0) AS 月累计尾数出仓面积
                            FROM          dbo.Data0465 INNER JOIN
                                                   dbo.data0415 ON dbo.Data0465.heard_ptr = dbo.data0415.rkey INNER JOIN
                                                   dbo.Data0025 ON dbo.data0415.custpart_ptr = dbo.Data0025.RKEY INNER JOIN
                                                   dbo.Data0053 ON dbo.Data0465.D0053_PTR = dbo.Data0053.RKEY INNER JOIN
                                                   dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                                                   dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY
                            WHERE      (dbo.Data0016.CODE = 'ST007') AND (dbo.Data0015.WAREHOUSE_CODE = 'D0002') AND (dbo.data0415.type = 4) AND 
                                                   (dbo.data0415.sys_date >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
                                                   (dbo.data0415.sys_date <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120))) AS 月累计尾数出仓 CROSS JOIN
                          (SELECT     ISNULL(AVG(Data0006_dtmfzkgbl.PARTS_PER_PANEL * Data0025_dtmfzkgbl.unit_sq), 0) AS 当天每块面积
                            FROM          dbo.Data0006 AS Data0006_dtmfzkgbl INNER JOIN
                                                   dbo.Data0025 AS Data0025_dtmfzkgbl ON Data0006_dtmfzkgbl.BOM_PTR = Data0025_dtmfzkgbl.RKEY INNER JOIN
                                                   dbo.Data0053 AS Data0053_dtmfzkgbl ON Data0006_dtmfzkgbl.RKEY = Data0053_dtmfzkgbl.WORK_ORDER_PTR INNER JOIN
                                                   dbo.Data0015 AS Data0015_dtmfzkgbl ON Data0053_dtmfzkgbl.WHSE_PTR = Data0015_dtmfzkgbl.RKEY INNER JOIN
                                                   dbo.Data0016 AS Data0016_dtmfzkgbl ON Data0053_dtmfzkgbl.LOC_PTR = Data0016_dtmfzkgbl.RKEY
                            WHERE      (Data0053_dtmfzkgbl.QUANTITY > 0) AND (Data0053_dtmfzkgbl.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()),
                                                    120) + ' 08:00:00', 120)) AND (Data0053_dtmfzkgbl.MFG_DATE < CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
                                                   (Data0015_dtmfzkgbl.WAREHOUSE_CODE = 'D0002') AND (Data0016_dtmfzkgbl.CODE = 'ST005' OR
                                                   Data0016_dtmfzkgbl.CODE = 'ST020') AND (Data0053_dtmfzkgbl.RMA_PTR = 0)) AS 当天每块面积 CROSS JOIN
                          (SELECT     ISNULL(AVG(Data0006_yljmfzkgbl.PARTS_PER_PANEL * Data0025_yljmfzkgbl.unit_sq), 0) AS 月累计每块面积
                            FROM          dbo.Data0006 AS Data0006_yljmfzkgbl INNER JOIN
                                                   dbo.Data0025 AS Data0025_yljmfzkgbl ON Data0006_yljmfzkgbl.BOM_PTR = Data0025_yljmfzkgbl.RKEY INNER JOIN
                                                   dbo.Data0053 AS Data0053_yljmfzkgbl ON Data0006_yljmfzkgbl.RKEY = Data0053_yljmfzkgbl.WORK_ORDER_PTR INNER JOIN
                                                   dbo.Data0015 AS Data0015_yljmfzkgbl ON Data0053_yljmfzkgbl.WHSE_PTR = Data0015_yljmfzkgbl.RKEY INNER JOIN
                                                   dbo.Data0016 AS Data0016_yljmfzkgbl ON Data0053_yljmfzkgbl.LOC_PTR = Data0016_yljmfzkgbl.RKEY
                            WHERE      (Data0053_yljmfzkgbl.QUANTITY > 0) AND (Data0053_yljmfzkgbl.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()),
                                                    120) + '01 08:00:00', 120)) AND (Data0053_yljmfzkgbl.MFG_DATE < CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
                                                   (Data0015_yljmfzkgbl.WAREHOUSE_CODE = 'D0002') AND (Data0016_yljmfzkgbl.CODE = 'ST005' OR
                                                   Data0016_yljmfzkgbl.CODE = 'ST020') AND (Data0053_yljmfzkgbl.RMA_PTR = 0)) AS 月累计每块面积
GO
/****** Object:  View [dbo].[View_SMS_DGHDI_20]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SMS_DGHDI_20]
AS
SELECT  TOP 1
        当日白班入库.当日白班入库面积 + 当日晚班入库.当日晚班入库面积 AS 当日入库面积,
        当日白班入库.当日白班入库产值 + 当日晚班入库.当日晚班入库产值 AS 当日入库产值,
        当日白班入库.当日白班入库面积,
        当日白班入库.当日白班入库产值,
        当日晚班入库.当日晚班入库面积,
        当日晚班入库.当日晚班入库产值,
        月累计入库.月累计入库面积,
        月累计入库.月累计入库产值, 
        当日出库.当日出库面积, 
        当日出库.当日出库产值, 
        月累计出库.月累计出库面积, 
        月累计出库.月累计出库产值,
        ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) AS 当日报废面积, 
        ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0) AS 月累计报废面积, 
        CASE  WHEN ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) <> 0 
              THEN ROUND(ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) 
                            / (当日白班入库.当日白班入库面积 + 当日晚班入库.当日晚班入库面积 + ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0)) * 100, 2) 
              ELSE 0 END AS 当日报废率, 
        CASE  WHEN ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0) <> 0 
              THEN ROUND(ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0) 
                            / (月累计入库.月累计入库面积 + ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0)) * 100, 2) 
              ELSE 0 END AS 月报废率, 
        当日订单.当日订单面积, 
        当日订单.当日订单未投面积, 
        月累计订单.月累计订单面积, 
        月累计订单.月累计订单未投面积, 
        当前库存.当前库存面积, 
        当前库存.当前库存金额, 
        超周期库存.超周期库存面积, 
        超周期库存.超周期库存金额,
        当前在线.当前在线面积, 
        当前在线暂缓.当前在线暂缓面积, 
        当日退货.当日退货面积, 
        月累计退货面积.月累计退货面积, 
        当日尾数入仓.当日尾数入仓面积, 
        当日尾数出仓.当日尾数出仓面积, 
        月累计尾数入仓.月尾数入仓面积,
        月累计尾数出仓.月累计尾数出仓面积
FROM   (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0053.QUANTITY * dbo.Data0025.unit_sq, 4)), 0), 0) AS 当日白班入库面积, 
                ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE, 4),6) 
                                      ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4), 6) 
                                                ELSE Data0025.LATEST_PRICE END END * dbo.Data0053.QUANTITY) / 10000, 0), 0) AS 当日白班入库产值
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                dbo.data0416 INNER JOIN
                dbo.Data0025 INNER JOIN
                dbo.Data0053 INNER JOIN
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY ON dbo.Data0025.RKEY = dbo.Data0053.CUST_PART_PTR ON 
                dbo.data0416.rkey = dbo.Data0053.NPAD_PTR LEFT OUTER JOIN
                dbo.Data0006 ON dbo.Data0053.WORK_ORDER_PTR = dbo.Data0006.RKEY LEFT OUTER JOIN
                dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO ON Data0060_2.SALES_ORDER = dbo.data0492.SO_NO ON 
                data0060_1.RKEY = dbo.data0416.so_ptr
        WHERE  (dbo.Data0053.QUANTITY > 0) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.Data0053.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (dbo.Data0053.MFG_DATE <  CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 20:00:00', 120)) AND 
               (dbo.Data0016.CODE = 'ST005' OR dbo.Data0016.CODE = 'ST020') AND (dbo.Data0053.RMA_PTR = 0)) 
    AS 当日白班入库	CROSS JOIN
      (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0053.QUANTITY * dbo.Data0025.unit_sq, 4)), 0), 0) AS 当日晚班入库面积, 
                ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE, 4),6) 
                                      ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4), 6) 
                                                ELSE Data0025.LATEST_PRICE END END * dbo.Data0053.QUANTITY) / 10000, 0), 0) AS 当日晚班入库产值
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                dbo.data0416 INNER JOIN
                dbo.Data0025 INNER JOIN
                dbo.Data0053 INNER JOIN
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY ON dbo.Data0025.RKEY = dbo.Data0053.CUST_PART_PTR ON 
                dbo.data0416.rkey = dbo.Data0053.NPAD_PTR LEFT OUTER JOIN
                dbo.Data0006 ON dbo.Data0053.WORK_ORDER_PTR = dbo.Data0006.RKEY LEFT OUTER JOIN
                dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO ON Data0060_2.SALES_ORDER = dbo.data0492.SO_NO ON 
                data0060_1.RKEY = dbo.data0416.so_ptr
        WHERE  (dbo.Data0053.QUANTITY > 0) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.Data0053.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 20:00:00', 120)) AND 
               (dbo.Data0053.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (dbo.Data0016.CODE = 'ST005' OR dbo.Data0016.CODE = 'ST020') AND (dbo.Data0053.RMA_PTR = 0)) 
    AS 当日晚班入库	CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_1.QUANTITY * Data0025_1.unit_sq, 4)), 0), 0) AS 月累计入库面积, 
                ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE,4), 6) 
                                      ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4),6) 
                                                ELSE Data0025_1.LATEST_PRICE END END * Data0053_1.QUANTITY) / 10000, 0), 0) AS 月累计入库产值
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                dbo.data0416 AS data0416_1 INNER JOIN
                dbo.Data0025 AS Data0025_1 INNER JOIN
                dbo.Data0053 AS Data0053_1 INNER JOIN
                dbo.Data0015 AS Data0015_1 ON Data0053_1.WHSE_PTR = Data0015_1.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_1 ON Data0053_1.LOC_PTR = Data0016_1.RKEY ON Data0025_1.RKEY = Data0053_1.CUST_PART_PTR ON 
                data0416_1.rkey = Data0053_1.NPAD_PTR LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_1 ON Data0053_1.WORK_ORDER_PTR = Data0006_1.RKEY LEFT OUTER JOIN
                dbo.data0492 AS data0492_1 ON Data0006_1.CUT_NO = data0492_1.CUT_NO ON Data0060_2.SALES_ORDER = data0492_1.SO_NO ON 
                data0060_1.RKEY = data0416_1.so_ptr
        WHERE  (Data0053_1.QUANTITY > 0) AND (Data0015_1.WAREHOUSE_CODE = 'D0001') AND 
               (Data0053_1.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(8), GETDATE(), 120) + '01 08:00:00', 120)) AND 
               (Data0053_1.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (Data0016_1.CODE = 'ST005' OR Data0016_1.CODE = 'ST020') AND (Data0053_1.RMA_PTR = 0)) 
    AS 月累计入库 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0052.QUAN_SHP * Data0025_13.unit_sq, 4)), 0), 0) AS 当日出库面积, 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0052.QUAN_SHP * dbo.Data0060.PARTS_ALLOC / dbo.Data0060.EXCH_RATE, 4))/ 10000, 0), 0) AS 当日出库产值
        FROM    dbo.Data0052 INNER JOIN
                dbo.Data0064 ON dbo.Data0052.SO_SHP_PTR = dbo.Data0064.RKEY INNER JOIN
                dbo.Data0060 ON dbo.Data0064.SO_PTR = dbo.Data0060.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_6 ON dbo.Data0052.DATA0053_PTR = Data0053_6.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_13 ON Data0053_6.WHSE_PTR = Data0015_13.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_6 ON Data0053_6.LOC_PTR = Data0016_6.RKEY INNER JOIN
                dbo.Data0025 AS Data0025_13 ON Data0053_6.CUST_PART_PTR = Data0025_13.RKEY INNER JOIN
                dbo.Data0001 ON dbo.Data0060.CURRENCY_PTR = dbo.Data0001.RKEY LEFT OUTER JOIN
                dbo.data0416 AS data0416_3 ON Data0053_6.NPAD_PTR = data0416_3.rkey LEFT OUTER JOIN
                dbo.data0439 ON dbo.Data0064.packing_list_ptr = dbo.data0439.rkey LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_6 ON Data0053_6.WORK_ORDER_PTR = Data0006_6.RKEY
        WHERE  (Data0016_6.CODE = 'ST005') AND (Data0015_13.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.Data0064.DATE_ASSIGN >= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (dbo.Data0064.DATE_ASSIGN <  CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (dbo.Data0064.PACKING_SLIP_FLAG = '1') AND (Data0025_13.ttype = 0) AND (dbo.Data0052.QUAN_SHP > 0)) 
    AS 当日出库 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0052_1.QUAN_SHP * Data0025_14.unit_sq, 4)), 0), 0) AS 月累计出库面积, 
                ISNULL(ROUND(SUM(ROUND(Data0052_1.QUAN_SHP * Data0060_7.PARTS_ALLOC / Data0060_7.EXCH_RATE, 4))/ 10000, 0), 0) AS 月累计出库产值
        FROM    dbo.Data0052 AS Data0052_1 INNER JOIN
                dbo.Data0064 AS Data0064_1 ON Data0052_1.SO_SHP_PTR = Data0064_1.RKEY INNER JOIN
                dbo.Data0060 AS Data0060_7 ON Data0064_1.SO_PTR = Data0060_7.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_7 ON Data0052_1.DATA0053_PTR = Data0053_7.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_14 ON Data0053_7.WHSE_PTR = Data0015_14.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_7 ON Data0053_7.LOC_PTR = Data0016_7.RKEY INNER JOIN
                dbo.Data0025 AS Data0025_14 ON Data0053_7.CUST_PART_PTR = Data0025_14.RKEY INNER JOIN
                dbo.Data0001 AS Data0001_1 ON Data0060_7.CURRENCY_PTR = Data0001_1.RKEY LEFT OUTER JOIN
                dbo.data0416 AS data0416_4 ON Data0053_7.NPAD_PTR = data0416_4.rkey LEFT OUTER JOIN
                dbo.data0439 AS data0439_1 ON Data0064_1.packing_list_ptr = data0439_1.rkey LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_7 ON Data0053_7.WORK_ORDER_PTR = Data0006_7.RKEY
        WHERE  (Data0016_7.CODE = 'ST005') AND (Data0015_14.WAREHOUSE_CODE = 'D0001') AND 
               (Data0064_1.DATE_ASSIGN >= CONVERT(datetime, CONVERT(varchar(8), GETDATE(), 120) + '01 08:00:00', 120)) AND 
               (Data0064_1.DATE_ASSIGN <= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (Data0064_1.PACKING_SLIP_FLAG = '1') AND (Data0025_14.ttype = 0) AND (Data0052_1.QUAN_SHP > 0)) 
    AS 月累计出库 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(dbo.Data0058.QTY_REJECT * Data0025_2.unit_sq), 0), 0) AS 当日报废面积
        FROM    dbo.Data0058 INNER JOIN
                dbo.Data0006 AS Data0006_2 ON dbo.Data0058.WO_PTR = Data0006_2.RKEY INNER JOIN
                dbo.Data0025 AS Data0025_2 ON Data0006_2.BOM_PTR = Data0025_2.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_2 ON dbo.Data0058.warehouse_ptr = Data0015_2.RKEY
        WHERE  (Data0015_2.WAREHOUSE_CODE = 'D0001') AND (dbo.Data0058.TTYPE <> 2) AND 
               (dbo.Data0058.TDATETIME >= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (dbo.Data0058.TDATETIME <  CONVERT(DATETIME, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120) + ' 08:00:00', 120))) 
    AS 当日报废 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(Data0058_1.QTY_REJECT * Data0025_3.unit_sq), 0), 0) AS 月累计报废面积
        FROM    dbo.Data0058 AS Data0058_1 INNER JOIN
                dbo.Data0006 AS Data0006_3 ON Data0058_1.WO_PTR = Data0006_3.RKEY INNER JOIN
                dbo.Data0025 AS Data0025_3 ON Data0006_3.BOM_PTR = Data0025_3.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_3 ON Data0058_1.warehouse_ptr = Data0015_3.RKEY
        WHERE  (Data0015_3.WAREHOUSE_CODE = 'D0001') AND (Data0058_1.TTYPE <> 2) AND 
               (Data0058_1.TDATETIME >= CONVERT(DATETIME, CONVERT(varchar(8), GETDATE(), 120) + '01 08:00:00', 120)) AND 
               (Data0058_1.TDATETIME <= CONVERT(DATETIME, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120) + ' 08:00:00', 120))) 
    AS 月累计报废 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(dbo.Data0060.PARTS_ORDERED * Data0025_8.unit_sq), 0), 0) AS 当日订单面积, 
                ISNULL(ROUND(SUM(dbo.Data0060.TO_BE_PLANNED * Data0025_8.unit_sq), 0), 0) AS 当日订单未投面积
        FROM    dbo.Data0060 INNER JOIN
                dbo.Data0025 AS Data0025_8 ON dbo.Data0060.CUST_PART_PTR = Data0025_8.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_8 ON dbo.Data0060.SHIP_REG_TAX_ID = Data0015_8.RKEY
        WHERE  (Data0015_8.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.Data0060.ENT_DATE >= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120), 120)) AND 
               (dbo.Data0060.so_style = 0) AND (Data0025_8.ttype = 0) AND (dbo.Data0060.so_tp = 0) AND 
               (dbo.Data0060.ENT_DATE <= CONVERT(DATETIME, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120), 120))) 
    AS 当日订单 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(Data0060_4.PARTS_ORDERED * Data0025_7.unit_sq), 0), 0) AS 月累计订单面积, 
                ISNULL(ROUND(SUM(Data0060_4.TO_BE_PLANNED * Data0025_7.unit_sq), 0), 0) AS 月累计订单未投面积
        FROM    dbo.Data0060 AS Data0060_4 INNER JOIN
                dbo.Data0025 AS Data0025_7 ON Data0060_4.CUST_PART_PTR = Data0025_7.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_7 ON Data0060_4.SHIP_REG_TAX_ID = Data0015_7.RKEY
        WHERE  (Data0015_7.WAREHOUSE_CODE = 'D0001') AND 
               (Data0060_4.ENT_DATE >= CONVERT(DATETIME, CONVERT(varchar(8), GETDATE(), 120) + '01', 120)) AND 
               (Data0060_4.so_style = 0) AND (Data0025_7.ttype = 0) AND (Data0060_4.so_tp = 0) AND 
               (Data0060_4.ENT_DATE <= CONVERT(DATETIME, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120), 120))) 
    AS 月累计订单 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_2.QTY_ON_HAND * Data0025_6.unit_sq, 4)), 0), 0) AS 当前库存面积, 
                ISNULL(ROUND(SUM(Data0025_6.LATEST_PRICE * Data0053_2.QTY_ON_HAND)/ 10000, 0), 0) AS 当前库存金额
        FROM    dbo.Data0023 RIGHT OUTER JOIN
                dbo.Data0008 INNER JOIN
                dbo.Data0025 AS Data0025_6 ON dbo.Data0008.RKEY = Data0025_6.PROD_CODE_PTR INNER JOIN
                dbo.Data0010 ON Data0025_6.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_2 INNER JOIN
                dbo.Data0015 AS Data0015_6 ON Data0053_2.WHSE_PTR = Data0015_6.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_2 ON Data0053_2.LOC_PTR = Data0016_2.RKEY ON 
                Data0025_6.RKEY = Data0053_2.CUST_PART_PTR INNER JOIN
                dbo.data0416 AS data0416_6 ON Data0053_2.NPAD_PTR = data0416_6.rkey LEFT OUTER JOIN
                dbo.Data0060 AS Data0060_1 LEFT OUTER JOIN
                dbo.Data0010 AS Data0010_2 ON Data0060_1.CUSTOMER_PTR = Data0010_2.RKEY ON data0416_6.so_ptr = Data0060_1.RKEY ON 
                dbo.Data0023.RKEY = Data0060_1.supplier_ptr LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_9 LEFT OUTER JOIN
                dbo.data0492 AS data0492_6 LEFT OUTER JOIN
                dbo.Data0001 AS Data0001_3 RIGHT OUTER JOIN
                dbo.Data0010 AS Data0010_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_9 ON Data0010_1.RKEY = Data0060_9.CUSTOMER_PTR ON 
                Data0001_3.RKEY = Data0060_9.CURRENCY_PTR ON data0492_6.SO_NO = Data0060_9.SALES_ORDER ON 
                Data0006_9.CUT_NO = data0492_6.CUT_NO ON Data0053_2.WORK_ORDER_PTR = Data0006_9.RKEY
        WHERE  (Data0015_6.WAREHOUSE_CODE = 'D0001') AND (Data0025_6.ttype = 0) AND (Data0016_2.CODE = 'ST005') AND (Data0053_2.QTY_ON_HAND > 0)) 
    AS 当前库存 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_8.QTY_ON_HAND * Data0025_15.unit_sq, 4)), 0), 0) AS 超周期库存面积,
                ISNULL(ROUND(SUM(Data0025_15.LATEST_PRICE * Data0053_8.QTY_ON_HAND)/ 10000, 0), 0) AS 超周期库存金额
        FROM    dbo.Data0023 AS Data0023_1 RIGHT OUTER JOIN
                dbo.Data0008 AS Data0008_1 INNER JOIN
                dbo.Data0025 AS Data0025_15 ON Data0008_1.RKEY = Data0025_15.PROD_CODE_PTR INNER JOIN
                dbo.Data0010 AS Data0010_3 ON Data0025_15.CUSTOMER_PTR = Data0010_3.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_8 INNER JOIN
                dbo.Data0015 AS Data0015_15 ON Data0053_8.WHSE_PTR = Data0015_15.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_8 ON Data0053_8.LOC_PTR = Data0016_8.RKEY ON 
                Data0025_15.RKEY = Data0053_8.CUST_PART_PTR INNER JOIN
                dbo.data0416 AS data0416_5 ON Data0053_8.NPAD_PTR = data0416_5.rkey LEFT OUTER JOIN
                dbo.Data0060 AS Data0060_1 LEFT OUTER JOIN
                dbo.Data0010 AS Data0010_2 ON Data0060_1.CUSTOMER_PTR = Data0010_2.RKEY ON data0416_5.so_ptr = Data0060_1.RKEY ON 
                Data0023_1.RKEY = Data0060_1.supplier_ptr LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_8 LEFT OUTER JOIN
                dbo.data0492 AS data0492_5 LEFT OUTER JOIN
                dbo.Data0001 AS Data0001_2 RIGHT OUTER JOIN
                dbo.Data0010 AS Data0010_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_8 ON Data0010_1.RKEY = Data0060_8.CUSTOMER_PTR ON 
                Data0001_2.RKEY = Data0060_8.CURRENCY_PTR ON data0492_5.SO_NO = Data0060_8.SALES_ORDER ON 
                Data0006_8.CUT_NO = data0492_5.CUT_NO ON Data0053_8.WORK_ORDER_PTR = Data0006_8.RKEY
        WHERE  (Data0015_15.WAREHOUSE_CODE = 'D0001') AND (Data0025_15.ttype = 0) AND (Data0016_8.CODE = 'ST005') AND 
               (Data0053_8.MFG_DATE + /*Data0025_15.REVIEW_DAYS*/ 180 < GETDATE()) AND (Data0053_8.QTY_ON_HAND > 0)) 
    AS 超周期库存 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0025_5.unit_sq * dbo.Data0056.QTY_BACKLOG, 4)), 0), 0) AS 当前在线面积
        FROM    dbo.Data0025 AS Data0025_5 INNER JOIN
                dbo.Data0006 AS Data0006_4 ON Data0006_4.BOM_PTR = Data0025_5.RKEY INNER JOIN
                dbo.Data0056 ON dbo.Data0056.WO_PTR = Data0006_4.RKEY INNER JOIN
                dbo.data0492 AS data0492_3 ON data0492_3.CUT_NO = Data0006_4.CUT_NO INNER JOIN
                dbo.Data0015 AS Data0015_5 ON data0492_3.WHOUSE_PTR = Data0015_5.RKEY
        WHERE  (Data0025_5.ttype = 0) AND (ISNULL(Data0025_5.PARENT_PTR, 0) = 0) AND (ISNULL(dbo.Data0056.WTYPE, 0) = 0) AND 
               (Data0015_5.WAREHOUSE_CODE = 'D0001')) 
    AS 当前在线 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0025_5.unit_sq * Data0056_1.QTY_BACKLOG, 4)), 0), 0) AS 当前在线暂缓面积
        FROM    dbo.Data0025 AS Data0025_5 INNER JOIN
                dbo.Data0006 AS Data0006_4 ON Data0006_4.BOM_PTR = Data0025_5.RKEY INNER JOIN
                dbo.Data0056 AS Data0056_1 ON Data0056_1.WO_PTR = Data0006_4.RKEY INNER JOIN
                dbo.data0492 AS data0492_4 ON data0492_4.CUT_NO = Data0006_4.CUT_NO INNER JOIN
                dbo.Data0015 AS Data0015_5 ON data0492_4.WHOUSE_PTR = Data0015_5.RKEY
        WHERE  (Data0025_5.ttype = 0) AND (ISNULL(Data0025_5.PARENT_PTR, 0) = 0) AND (Data0015_5.WAREHOUSE_CODE = 'D0001') AND 
               (Data0006_4.PROD_STATUS = 103)) 
    AS 当前在线暂缓 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0098.QTY_RECD * Data0025_9.unit_sq, 4)), 0), 0) AS 当日退货面积
        FROM    dbo.Data0098 INNER JOIN
                dbo.Data0025 AS Data0025_9 ON dbo.Data0098.CUSTOMER_PART_PTR = Data0025_9.RKEY LEFT OUTER JOIN
                dbo.Data0060 AS Data0060_5 LEFT OUTER JOIN
                dbo.Data0015 AS Data0015_9 ON Data0060_5.SHIP_REG_TAX_ID = Data0015_9.RKEY ON 
                dbo.Data0098.SO_PTR = Data0060_5.RKEY
        WHERE  (Data0015_9.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.Data0098.RMA_DATE >= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120), 120)) AND 
               (dbo.Data0098.RMA_DATE <= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120), 120))) 
    AS 当日退货 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0098_1.QTY_RECD * Data0025_4.unit_sq, 4)), 0), 0) AS 月累计退货面积
        FROM    dbo.Data0098 AS Data0098_1 INNER JOIN
                dbo.Data0025 AS Data0025_4 ON Data0098_1.CUSTOMER_PART_PTR = Data0025_4.RKEY LEFT OUTER JOIN
                dbo.Data0060 AS Data0060_3 LEFT OUTER JOIN
                dbo.Data0015 AS Data0015_4 ON Data0060_3.SHIP_REG_TAX_ID = Data0015_4.RKEY ON 
                Data0098_1.SO_PTR = Data0060_3.RKEY
        WHERE  (Data0015_4.WAREHOUSE_CODE = 'D0001') AND 
               (Data0098_1.RMA_DATE >= CONVERT(datetime, CONVERT(varchar(8), GETDATE(), 120) + '01', 120)) AND 
               (Data0098_1.RMA_DATE <= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120), 120))) 
    AS 月累计退货面积 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_3.QUANTITY * Data0025_10.unit_sq, 4)), 2), 0) AS 当日尾数入仓面积
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                dbo.data0416 AS data0416_2 INNER JOIN
                dbo.Data0025 AS Data0025_10 INNER JOIN
                dbo.Data0053 AS Data0053_3 INNER JOIN
                dbo.Data0015 AS Data0015_10 ON Data0053_3.WHSE_PTR = Data0015_10.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_3 ON Data0053_3.LOC_PTR = Data0016_3.RKEY ON Data0025_10.RKEY = Data0053_3.CUST_PART_PTR ON 
                data0416_2.rkey = Data0053_3.NPAD_PTR LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_5 ON Data0053_3.WORK_ORDER_PTR = Data0006_5.RKEY LEFT OUTER JOIN
                dbo.data0492 AS data0492_2 ON Data0006_5.CUT_NO = data0492_2.CUT_NO ON Data0060_2.SALES_ORDER = data0492_2.SO_NO ON 
                data0060_1.RKEY = data0416_2.so_ptr
        WHERE  (Data0053_3.QUANTITY > 0) AND (Data0015_10.WAREHOUSE_CODE = 'D0001') AND 
               (Data0053_3.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0053_3.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (Data0016_3.CODE = 'ST007') AND (Data0053_3.RMA_PTR = 0)) 
    AS 当日尾数入仓 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0465.QUANTITY * dbo.Data0025.unit_sq, 4)), 2), 0) AS 当日尾数出仓面积
        FROM    dbo.Data0465 INNER JOIN
                dbo.data0415 ON dbo.Data0465.heard_ptr = dbo.data0415.rkey INNER JOIN
                dbo.Data0025 ON dbo.data0415.custpart_ptr = dbo.Data0025.RKEY INNER JOIN
                dbo.Data0053 ON dbo.Data0465.D0053_PTR = dbo.Data0053.RKEY INNER JOIN
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY
        WHERE  (dbo.Data0016.CODE = 'ST007') AND (dbo.data0415.type = 4) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.data0415.sys_date >= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (dbo.data0415.sys_date <= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120) + ' 08:00:00', 120))) 
    AS 当日尾数出仓 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_3.QUANTITY * Data0025_10.unit_sq, 4)), 2), 0) AS 月尾数入仓面积
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN
                dbo.data0416 AS data0416_2 INNER JOIN
                dbo.Data0025 AS Data0025_10 INNER JOIN
                dbo.Data0053 AS Data0053_3 INNER JOIN
                dbo.Data0015 AS Data0015_10 ON Data0053_3.WHSE_PTR = Data0015_10.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_3 ON Data0053_3.LOC_PTR = Data0016_3.RKEY ON Data0025_10.RKEY = Data0053_3.CUST_PART_PTR ON 
                data0416_2.rkey = Data0053_3.NPAD_PTR LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_5 ON Data0053_3.WORK_ORDER_PTR = Data0006_5.RKEY LEFT OUTER JOIN
                dbo.data0492 AS data0492_2 ON Data0006_5.CUT_NO = data0492_2.CUT_NO ON Data0060_2.SALES_ORDER = data0492_2.SO_NO ON 
                data0060_1.RKEY = data0416_2.so_ptr
        WHERE  (Data0053_3.QUANTITY > 0) AND (Data0015_10.WAREHOUSE_CODE = 'D0001') AND 
               (Data0053_3.MFG_DATE >= CONVERT(DATETIME, CONVERT(varchar(8), GETDATE(), 120) + '01 08:00:00', 120)) AND 
               (Data0053_3.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120) + ' 08:00:00', 120)) AND 
               (Data0016_3.CODE = 'ST007') AND (Data0053_3.RMA_PTR = 0)) 
    AS 月累计尾数入仓 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(dbo.Data0465.QUANTITY * dbo.Data0025.unit_sq, 4)), 2), 0) AS 月累计尾数出仓面积
        FROM    dbo.Data0465 INNER JOIN
                dbo.data0415 ON dbo.Data0465.heard_ptr = dbo.data0415.rkey INNER JOIN
                dbo.Data0025 ON dbo.data0415.custpart_ptr = dbo.Data0025.RKEY INNER JOIN
                dbo.Data0053 ON dbo.Data0465.D0053_PTR = dbo.Data0053.RKEY INNER JOIN
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY
        WHERE  (dbo.Data0016.CODE = 'ST007') AND (dbo.data0415.type = 4) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND 
               (dbo.data0415.sys_date >= CONVERT(DATETIME, CONVERT(varchar(8), GETDATE(), 120) + '01 08:00:00', 120)) AND 
               (dbo.data0415.sys_date <= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, 1, GETDATE()), 120) + ' 08:00:00', 120))) 
    AS 月累计尾数出仓
GO
/****** Object:  View [dbo].[v_data0069_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--请购单表身veiw,用途: 1.微信审批列表,2.
CREATE view [dbo].[v_data0069_check]
as
select data0069.RKEY,data0069.QUANTITY,data0069.REQ_DATE,data0069.extra_req,
	data0069.reason,data0069.reply_date,data0069.IF_urgency,data0069.req_quantity,
	data0069.purch_req_ptr,
	data0017.inv_part_number,data0017.inv_description,
	data0017.inv_name,data0017.quan_on_hand CurrStQty,
	data0002.unit_code,data0002.unit_name ,qty_zaitu=
	(select SUM(Data0071.QUAN_ORD - Data0071.QUAN_RECD + Data0071.QUAN_RETN) 
	   FROM Data0071 INNER JOIN
	   Data0070 ON Data0071.PO_PTR = Data0070.RKEY
	   WHERE Data0070.STATUS = 5
	   and data0071.invt_ptr=data0069.INVT_PTR),
	VMI_QTY=(select isnull(SUM(dbo.Data0134.QUAN_ON_HAND),0) from data0134 where dbo.DATA0134.INVENTORY_PTR = dbo.Data0017.RKEY),
	case data0017.CRITICAL_MATL_FLAG when 0 then '否'
	when 1 then '是' end as CRITICAL_MATL
 from data0069 inner join data0017 on data0069.INVT_PTR=data0017.rkey
	inner join data0002 on data0069.UNIT_PTR=data0002.rkey
GO
/****** Object:  View [dbo].[v_data0071_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--采购单表身view,用途: 1.微信审批列表,2.
CREATE view [dbo].[v_data0071_check]
as

SELECT     dbo.Data0071.RKEY, dbo.Data0071.PO_PTR, dbo.Data0071.INVT_PTR, dbo.Data0071.QUAN_ORD, dbo.Data0071.QUAN_RECD, dbo.Data0071.QUAN_IN_INSP, 
                      dbo.Data0071.QUAN_RETN, dbo.Data0071.QUAN_INVD, dbo.Data0071.PRICE, dbo.Data0071.TAX_2, dbo.Data0071.DISCOUNT, 
                      dbo.Data0071.REQ_DATE, dbo.Data0071.QUAN_REJD, dbo.Data0071.WO_PTR, dbo.Data0071.PURCHASE_UNIT_PTR, dbo.Data0071.CONVERSION_FACTOR, 
                      dbo.Data0071.PRINTED_DATE, dbo.Data0071.reason, dbo.Data0071.extra_req, dbo.Data0071.avl_flag, dbo.Data0071.tax_price, dbo.Data0071.rohs, 
                 dbo.Data0071.IF_CAF,dbo.Data0071.IF_urgency, dbo.Data0017.INV_PART_NUMBER AS partnumber,
                     ROUND(data0071.QUAN_ORD * data0071.tax_price, 4) 
                      AS so_total,
                      vmi_qty=(select sum(data0134.quan_on_hand)  from data0134 where data0134.inventory_ptr=data0071.INVT_PTR),
                      dbo.Data0017.INV_NAME AS inv_part_number, dbo.Data0017.INV_DESCRIPTION AS inv_part_description, dbo.Data0002.UNIT_CODE, dbo.Data0002.UNIT_NAME, 
                      dbo.Data0017.QUAN_ON_HAND AS quantity_stock, CASE data0017.CRITICAL_MATL_FLAG WHEN 0 THEN '否' WHEN 1 THEN '是' END AS CRITICAL_MATL, 
                      dbo.Data0068.PO_REQ_NUMBER, dbo.Data0034.DEPT_NAME, dbo.Data0005.EMPLOYEE_NAME,
                      quantity_zaitu=(SELECT SUM(a.QUAN_ORD - a.QUAN_RECD + a.QUAN_RETN) FROM dbo.Data0071 a INNER JOIN dbo.Data0070 b ON a.PO_PTR = b.RKEY INNER JOIN
							  dbo.Data0071 c ON a.INVT_PTR = c.INVT_PTR WHERE (b.STATUS = 5) AND (c.PO_PTR = dbo.Data0071.PO_PTR))
FROM         dbo.Data0068 LEFT OUTER JOIN
                      dbo.Data0005 ON dbo.Data0068.REQ_BY = dbo.Data0005.RKEY LEFT OUTER JOIN
                      dbo.Data0034 ON dbo.Data0068.DEPARTMENT_NAME = dbo.Data0034.DEPT_CODE RIGHT OUTER JOIN
                      dbo.Data0069 ON dbo.Data0068.RKEY = dbo.Data0069.PURCH_REQ_PTR RIGHT OUTER JOIN
                      dbo.Data0071 INNER JOIN
                      dbo.Data0017 ON dbo.Data0071.INVT_PTR = dbo.Data0017.RKEY INNER JOIN
                      dbo.Data0002 ON dbo.Data0071.PURCHASE_UNIT_PTR = dbo.Data0002.RKEY ON dbo.Data0069.RKEY = dbo.Data0071.rkey69
GO
/****** Object:  View [dbo].[V_StdHistoryPrice]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--微信查看历史价格
CREATE view [dbo].[V_StdHistoryPrice]
AS
SELECT Data0069.QUANTITY, dbo.Data0069.UNIT_PRICE,
       Data0069.REQ_DATE, dbo.Data0002.UNIT_NAME,
       Data0001.CURR_NAME, dbo.Data0023.ABBR_NAME,
       Data0069.o_i_flag,Data0069.INVT_PTR
FROM   Data0069 INNER JOIN
       Data0023 ON dbo.Data0069.SUPP_PTR = dbo.Data0023.RKEY INNER JOIN
       Data0001 ON
       Data0069.PO_LINK_PTR = dbo.Data0001.RKEY INNER JOIN
       Data0002 ON dbo.Data0069.UNIT_PTR = dbo.Data0002.RKEY
GO
/****** Object:  View [dbo].[V_EmpMsg]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_EmpMsg]
AS
SELECT   dbo.employeemsg.employeecode AS 工号, dbo.employeemsg.chinesename AS 姓名, 
                dbo.datadepartment.departmentname AS 部门名称, datadetail_5.item AS 职务, 
                CASE employeemsg.sex WHEN 0 THEN '女' WHEN 1 THEN '男' END AS 性别, CONVERT(char(10), 
                dbo.employeemsg.birthday, 20) AS 出生年月, dbo.employeemsg.province AS 籍贯, dbo.employeemsg.nation AS 民族, 
                ISNULL(datadetail_4.item, '') AS 婚姻状况, ISNULL(dbo.employeemsg.phone, '') AS 电话, 
                ISNULL(dbo.employeemsg.addr, '') AS 地址, CONVERT(char(10), dbo.employeemsg.ondutytime, 20) AS 入职日期, 
                ISNULL(dbo.employeemsg.roomcode, '') AS 房间号, dbo.employeemsg.IDCard AS 身份证号, CONVERT(varchar(10), 
                dbo.employeemsg.iDCardtime, 23) AS 证有效期, ISNULL(datadetail_3.item, '') AS 学历, 
                ISNULL(dbo.employeemsg.graduatedschool, '') AS 毕业院校, ISNULL(dbo.employeemsg.majorsubject, '') AS 专业, 
                ISNULL(dbo.employeemsg.GraduateTime, '') AS 毕业时间, ISNULL(dbo.employeemsg.contactpersonname, '') 
                AS 紧急联系人, ISNULL(dbo.employeemsg.contactpersontel, '') AS 紧急联系人电话, 
                ISNULL(dbo.employeemsg.contactpersonaddr, '') AS 紧急联系人地址, dbo.datadetail.item AS 合同类型, 
                ISNULL(datadetail_1.item, '') AS 职级, ISNULL(datadetail_7.item, '') AS 岗位, 
                CASE WHEN wagetype = 9 THEN '日薪帐' WHEN wagetype = 10 THEN '月薪5.5' WHEN wagetype = 11 THEN '月薪6' END
                 AS 工资账套, ISNULL(dbo.employeemsg.remark, '') AS 备注
FROM      dbo.employeemsg LEFT OUTER JOIN
                dbo.datadetail AS datadetail_4 ON dbo.employeemsg.marriage = datadetail_4.rkey LEFT OUTER JOIN
                dbo.datadetail AS datadetail_3 ON dbo.employeemsg.education = datadetail_3.rkey LEFT OUTER JOIN
                dbo.datadetail AS datadetail_5 ON dbo.employeemsg.Position = datadetail_5.rkey LEFT OUTER JOIN
                dbo.datadetail AS datadetail_7 ON dbo.employeemsg.station = datadetail_7.rkey LEFT OUTER JOIN
                dbo.datadetail AS datadetail_1 ON dbo.employeemsg.Rank = datadetail_1.rkey LEFT OUTER JOIN
                dbo.datadetail ON dbo.employeemsg.employ_type = dbo.datadetail.rkey LEFT OUTER JOIN
                dbo.datadepartment ON dbo.employeemsg.departmentid = dbo.datadepartment.rkey
WHERE   (dbo.employeemsg.status = 1)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "employeemsg"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 145
               Right = 280
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "datadetail_4"
            Begin Extent = 
               Top = 6
               Left = 318
               Bottom = 145
               Right = 488
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "datadetail_3"
            Begin Extent = 
               Top = 6
               Left = 526
               Bottom = 145
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "datadetail_5"
            Begin Extent = 
               Top = 6
               Left = 734
               Bottom = 145
               Right = 904
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "datadetail_7"
            Begin Extent = 
               Top = 6
               Left = 942
               Bottom = 145
               Right = 1112
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "datadetail_1"
            Begin Extent = 
               Top = 150
               Left = 38
               Bottom = 289
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "datadetail"
            Begin Extent = 
               Top = 150
               Left = 246
               Bottom = 289
               Right = 416
            End
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_EmpMsg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'         DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "datadepartment"
            Begin Extent = 
               Top = 150
               Left = 454
               Bottom = 289
               Right = 680
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_EmpMsg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_EmpMsg'
GO
/****** Object:  View [dbo].[View_SMS_Special_DGHDI]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SMS_Special_DGHDI]
AS
SELECT  TOP 1
        薄板月累计入库.薄板月累计入库面积,
        薄板月累计入库.薄板月累计入库产值, 
        厚铜板月累计入库.厚铜板月累计入库面积,
        厚铜板月累计入库.厚铜板月累计入库产值,
        薄板月累计出库.薄板月累计出库面积, 
        薄板月累计出库.薄板月累计出库产值,
        厚铜板月累计出库.厚铜板月累计出库面积, 
        厚铜板月累计出库.厚铜板月累计出库产值,
        薄板月累计订单.薄板月累计订单面积, 
        薄板月累计订单.薄板月累计订单未投面积,
        厚铜板月累计订单.厚铜板月累计订单面积, 
        厚铜板月累计订单.厚铜板月累计订单未投面积
FROM   (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_RKBB.QUANTITY * Data0025_RKBB.unit_sq, 4)), 0), 0) AS 薄板月累计入库面积, 
                ISNULL(ROUND(SUM(CASE WHEN Data0060_RKBB2.part_price >= 0 THEN ROUND(Data0060_RKBB2.PARTS_ALLOC * ROUND(1 / Data0060_RKBB2.EXCH_RATE,4), 6) 
                                      ELSE CASE WHEN Data0060_RKBB1.part_price >= 0 THEN ROUND(Data0060_RKBB1.PARTS_ALLOC * ROUND(1 / Data0060_RKBB1.EXCH_RATE, 4),6) 
                                                ELSE Data0025_RKBB.LATEST_PRICE END END * Data0053_RKBB.QUANTITY) / 10000, 0), 0) AS 薄板月累计入库产值
        FROM    dbo.Data0060 AS Data0060_RKBB2 RIGHT OUTER JOIN
                dbo.data0492 AS data0492_RKBB RIGHT OUTER JOIN
                dbo.Data0060 AS data0060_RKBB1 RIGHT OUTER JOIN
                dbo.Data0008 AS Data0008_RKBB INNER JOIN
                dbo.Data0007 AS Data0007_RKBB ON Data0008_RKBB.PR_GRP_POINTER = Data0007_RKBB.RKEY RIGHT OUTER JOIN
                dbo.data0416 AS data0416_RKBB INNER JOIN
                dbo.Data0025 AS Data0025_RKBB INNER JOIN
                dbo.Data0053 AS Data0053_RKBB INNER JOIN
                dbo.Data0015 AS Data0015_RKBB ON Data0053_RKBB.WHSE_PTR = Data0015_RKBB.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_RKBB ON Data0053_RKBB.LOC_PTR = Data0016_RKBB.RKEY ON Data0025_RKBB.RKEY = Data0053_RKBB.CUST_PART_PTR ON 
                data0416_RKBB.rkey = Data0053_RKBB.NPAD_PTR ON Data0008_RKBB.RKEY = Data0025_RKBB.PROD_CODE_PTR ON 
                data0060_RKBB1.RKEY = data0416_RKBB.so_ptr LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_RKBB ON Data0053_RKBB.WORK_ORDER_PTR = Data0006_RKBB.RKEY ON data0492_RKBB.CUT_NO = Data0006_RKBB.CUT_NO ON 
                Data0060_RKBB2.SALES_ORDER = data0492_RKBB.SO_NO
        WHERE  (Data0053_RKBB.QUANTITY > 0) AND 
               (
                ((Data0015_RKBB.WAREHOUSE_CODE = 'D0001') AND (Data0016_RKBB.CODE IN ('ST005', 'ST020'))) OR
                ((Data0015_RKBB.WAREHOUSE_CODE = 'D0002') AND (Data0016_RKBB.CODE IN ('ST030')))
               ) AND 
               (Data0053_RKBB.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
               (Data0053_RKBB.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0053_RKBB.RMA_PTR = 0) AND
               ((Data0007_RKBB.PR_GRP_CODE = 'S') OR (Data0008_RKBB.difficulty_grade = 0))
        )
    AS 薄板月累计入库 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0053_RKHTB.QUANTITY * Data0025_RKHTB.unit_sq, 4)), 0), 0) AS 厚铜板月累计入库面积, 
                ISNULL(ROUND(SUM(CASE WHEN Data0060_RKHTB2.part_price >= 0 THEN ROUND(Data0060_RKHTB2.PARTS_ALLOC * ROUND(1 / Data0060_RKHTB2.EXCH_RATE,4), 6) 
                                      ELSE CASE WHEN Data0060_RKHTB1.part_price >= 0 THEN ROUND(Data0060_RKHTB1.PARTS_ALLOC * ROUND(1 / Data0060_RKHTB1.EXCH_RATE, 4),6) 
                                                ELSE Data0025_RKHTB.LATEST_PRICE END END * Data0053_RKHTB.QUANTITY) / 10000, 0), 0) AS 厚铜板月累计入库产值
        FROM    dbo.Data0060 AS Data0060_RKHTB2 RIGHT OUTER JOIN
                dbo.data0492 AS data0492_RKHTB RIGHT OUTER JOIN
                dbo.Data0060 AS data0060_RKHTB1 RIGHT OUTER JOIN
                dbo.Data0008 AS Data0008_RKHTB INNER JOIN
                dbo.Data0007 AS Data0007_RKHTB ON Data0008_RKHTB.PR_GRP_POINTER = Data0007_RKHTB.RKEY RIGHT OUTER JOIN
                dbo.data0416 AS data0416_RKHTB INNER JOIN
                dbo.Data0025 AS Data0025_RKHTB INNER JOIN
                dbo.Data0053 AS Data0053_RKHTB INNER JOIN
                dbo.Data0015 AS Data0015_RKHTB ON Data0053_RKHTB.WHSE_PTR = Data0015_RKHTB.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_RKHTB ON Data0053_RKHTB.LOC_PTR = Data0016_RKHTB.RKEY ON Data0025_RKHTB.RKEY = Data0053_RKHTB.CUST_PART_PTR ON 
                data0416_RKHTB.rkey = Data0053_RKHTB.NPAD_PTR ON Data0008_RKHTB.RKEY = Data0025_RKHTB.PROD_CODE_PTR ON 
                data0060_RKHTB1.RKEY = data0416_RKHTB.so_ptr LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_RKHTB ON Data0053_RKHTB.WORK_ORDER_PTR = Data0006_RKHTB.RKEY ON 
                data0492_RKHTB.CUT_NO = Data0006_RKHTB.CUT_NO ON Data0060_RKHTB2.SALES_ORDER = data0492_RKHTB.SO_NO
        WHERE  (Data0053_RKHTB.QUANTITY > 0) AND 
               (
                ((Data0015_RKHTB.WAREHOUSE_CODE = 'D0001') AND (Data0016_RKHTB.CODE IN ('ST005', 'ST020'))) OR
                ((Data0015_RKHTB.WAREHOUSE_CODE = 'D0002') AND (Data0016_RKHTB.CODE IN ('ST030')))
               ) AND 
               (Data0053_RKHTB.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
               (Data0053_RKHTB.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0053_RKHTB.RMA_PTR = 0) AND
              ((Data0007_RKHTB.PR_GRP_CODE <> 'S') OR (Data0008_RKHTB.difficulty_grade = 1))
        )
    AS 厚铜板月累计入库 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0052_CKBB.QUAN_SHP * Data0025_CKBB.unit_sq, 4)), 0), 0) AS 薄板月累计出库面积, 
                ISNULL(ROUND(SUM(ROUND(Data0052_CKBB.QUAN_SHP * Data0060_CKBB.PARTS_ALLOC / Data0060_CKBB.EXCH_RATE, 4))/ 10000, 0), 0) AS 薄板月累计出库产值
        FROM    dbo.Data0052 AS Data0052_CKBB INNER JOIN
                dbo.Data0064 AS Data0064_CKBB ON Data0052_CKBB.SO_SHP_PTR = Data0064_CKBB.RKEY INNER JOIN
                dbo.Data0060 AS Data0060_CKBB ON Data0064_CKBB.SO_PTR = Data0060_CKBB.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_CKBB ON Data0052_CKBB.DATA0053_PTR = Data0053_CKBB.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_CKBB ON Data0053_CKBB.WHSE_PTR = Data0015_CKBB.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_CKBB ON Data0053_CKBB.LOC_PTR = Data0016_CKBB.RKEY INNER JOIN
                dbo.Data0025 AS Data0025_CKBB ON Data0053_CKBB.CUST_PART_PTR = Data0025_CKBB.RKEY INNER JOIN
                dbo.Data0001 AS Data0001_CKBB ON Data0060_CKBB.CURRENCY_PTR = Data0001_CKBB.RKEY INNER JOIN
                dbo.Data0008 AS Data0008_CKBB ON Data0025_CKBB.PROD_CODE_PTR = Data0008_CKBB.RKEY INNER JOIN
                dbo.Data0007 AS Data0007_CKBB ON Data0008_CKBB.PR_GRP_POINTER = Data0007_CKBB.RKEY LEFT OUTER JOIN
                dbo.data0416 AS data0416_CKBB ON Data0053_CKBB.NPAD_PTR = data0416_CKBB.rkey LEFT OUTER JOIN
                dbo.data0439 AS data0439_CKBB ON Data0064_CKBB.packing_list_ptr = data0439_CKBB.rkey LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_CKBB ON Data0053_CKBB.WORK_ORDER_PTR = Data0006_CKBB.RKEY
        WHERE  (
                ((Data0016_CKBB.CODE IN ('ST005')) AND (Data0015_CKBB.WAREHOUSE_CODE = 'D0001')) OR
                ((Data0016_CKBB.CODE IN ('ST030')) AND (Data0015_CKBB.WAREHOUSE_CODE = 'D0002'))
               )AND 
               (Data0064_CKBB.DATE_ASSIGN >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
               (Data0064_CKBB.DATE_ASSIGN <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0064_CKBB.PACKING_SLIP_FLAG = '1') AND 
               (Data0025_CKBB.ttype = 0) AND 
               (Data0052_CKBB.QUAN_SHP > 0) AND
               ((Data0007_CKBB.PR_GRP_CODE = 'S') OR (Data0008_CKBB.difficulty_grade = 0))
        )                 
    AS 薄板月累计出库 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(ROUND(Data0052_CKHTB.QUAN_SHP * Data0025_CKHTB.unit_sq, 4)), 0), 0) AS 厚铜板月累计出库面积, 
                ISNULL(ROUND(SUM(ROUND(Data0052_CKHTB.QUAN_SHP * Data0060_CKHTB.PARTS_ALLOC / Data0060_CKHTB.EXCH_RATE, 4))/ 10000, 0), 0) AS 厚铜板月累计出库产值
        FROM    dbo.Data0052 AS Data0052_CKHTB INNER JOIN
                dbo.Data0064 AS Data0064_CKHTB ON Data0052_CKHTB.SO_SHP_PTR = Data0064_CKHTB.RKEY INNER JOIN
                dbo.Data0060 AS Data0060_CKHTB ON Data0064_CKHTB.SO_PTR = Data0060_CKHTB.RKEY INNER JOIN
                dbo.Data0053 AS Data0053_CKHTB ON Data0052_CKHTB.DATA0053_PTR = Data0053_CKHTB.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_CKHTB ON Data0053_CKHTB.WHSE_PTR = Data0015_CKHTB.RKEY INNER JOIN
                dbo.Data0016 AS Data0016_CKHTB ON Data0053_CKHTB.LOC_PTR = Data0016_CKHTB.RKEY INNER JOIN
                dbo.Data0025 AS Data0025_CKHTB ON Data0053_CKHTB.CUST_PART_PTR = Data0025_CKHTB.RKEY INNER JOIN
                dbo.Data0001 AS Data0001_CKHTB ON Data0060_CKHTB.CURRENCY_PTR = Data0001_CKHTB.RKEY INNER JOIN
                dbo.Data0008 AS Data0008_CKHTB ON Data0025_CKHTB.PROD_CODE_PTR = Data0008_CKHTB.RKEY INNER JOIN
                dbo.Data0007 AS Data0007_CKHTB ON Data0008_CKHTB.PR_GRP_POINTER = Data0007_CKHTB.RKEY LEFT OUTER JOIN
                dbo.data0416 AS data0416_CKHTB ON Data0053_CKHTB.NPAD_PTR = data0416_CKHTB.rkey LEFT OUTER JOIN
                dbo.data0439 AS data0439_CKHTB ON Data0064_CKHTB.packing_list_ptr = data0439_CKHTB.rkey LEFT OUTER JOIN
                dbo.Data0006 AS Data0006_CKHTB ON Data0053_CKHTB.WORK_ORDER_PTR = Data0006_CKHTB.RKEY
        WHERE  (
                ((Data0016_CKHTB.CODE IN ('ST005')) AND (Data0015_CKHTB.WAREHOUSE_CODE = 'D0001')) OR
                ((Data0016_CKHTB.CODE IN ('ST030')) AND (Data0015_CKHTB.WAREHOUSE_CODE = 'D0002'))
               )AND 
               (Data0064_CKHTB.DATE_ASSIGN >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND 
               (Data0064_CKHTB.DATE_ASSIGN <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND 
               (Data0064_CKHTB.PACKING_SLIP_FLAG = '1') AND 
               (Data0025_CKHTB.ttype = 0) AND 
               (Data0052_CKHTB.QUAN_SHP > 0) AND
              ((Data0007_CKHTB.PR_GRP_CODE <> 'S') OR (Data0008_CKHTB.difficulty_grade = 1))
        )                 
    AS 厚铜板月累计出库 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(Data0060_DDBB.PARTS_ORDERED * Data0025_DDBB.unit_sq), 0), 0) AS 薄板月累计订单面积, 
                ISNULL(ROUND(SUM(Data0060_DDBB.TO_BE_PLANNED * Data0025_DDBB.unit_sq), 0), 0) AS 薄板月累计订单未投面积
        FROM    dbo.Data0060 AS Data0060_DDBB INNER JOIN
                dbo.Data0025 AS Data0025_DDBB ON Data0060_DDBB.CUST_PART_PTR = Data0025_DDBB.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_DDBB ON Data0060_DDBB.SHIP_REG_TAX_ID = Data0015_DDBB.RKEY INNER JOIN
                dbo.Data0008 AS Data0008_DDBB ON Data0025_DDBB.PROD_CODE_PTR = Data0008_DDBB.RKEY INNER JOIN
                dbo.Data0007 AS Data0007_DDBB ON Data0008_DDBB.PR_GRP_POINTER = Data0007_DDBB.RKEY
        WHERE  (
                (Data0015_DDBB.WAREHOUSE_CODE = 'D0001') OR
                (Data0015_DDBB.WAREHOUSE_CODE = 'D0002')
               ) AND 
               (Data0060_DDBB.ENT_DATE >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 00:00:00', 120)) AND 
               (Data0060_DDBB.so_style = 0) AND (Data0025_DDBB.ttype = 0) AND (Data0060_DDBB.so_tp = 0) AND 
               (Data0060_DDBB.ENT_DATE <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 00:00:00', 120)) AND
               (Data0060_DDBB.status IN (-1,1,2,3,4)) AND
              ((Data0007_DDBB.PR_GRP_CODE = 'S') OR (Data0008_DDBB.difficulty_grade = 0))
    )               
    AS 薄板月累计订单 CROSS JOIN
       (SELECT  TOP (100) PERCENT 
                ISNULL(ROUND(SUM(Data0060_DDHTB.PARTS_ORDERED * Data0025_DDHTB.unit_sq), 0), 0) AS 厚铜板月累计订单面积, 
                ISNULL(ROUND(SUM(Data0060_DDHTB.TO_BE_PLANNED * Data0025_DDHTB.unit_sq), 0), 0) AS 厚铜板月累计订单未投面积
        FROM    dbo.Data0060 AS Data0060_DDHTB INNER JOIN
                dbo.Data0025 AS Data0025_DDHTB ON Data0060_DDHTB.CUST_PART_PTR = Data0025_DDHTB.RKEY INNER JOIN
                dbo.Data0015 AS Data0015_DDHTB ON Data0060_DDHTB.SHIP_REG_TAX_ID = Data0015_DDHTB.RKEY INNER JOIN
                dbo.Data0008 AS Data0008_DDHTB ON Data0025_DDHTB.PROD_CODE_PTR = Data0008_DDHTB.RKEY INNER JOIN
                dbo.Data0007 AS Data0007_DDHTB ON Data0008_DDHTB.PR_GRP_POINTER = Data0007_DDHTB.RKEY
        WHERE  (
                (Data0015_DDHTB.WAREHOUSE_CODE = 'D0001') OR
                (Data0015_DDHTB.WAREHOUSE_CODE = 'D0002')
               ) AND 
               (Data0060_DDHTB.ENT_DATE >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 00:00:00', 120)) AND 
               (Data0060_DDHTB.so_style = 0) AND (Data0025_DDHTB.ttype = 0) AND (Data0060_DDHTB.so_tp = 0) AND 
               (Data0060_DDHTB.ENT_DATE <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 00:00:00', 120)) AND
               (Data0060_DDHTB.status IN (-1,1,2,3,4)) AND
              ((Data0007_DDHTB.PR_GRP_CODE <> 'S') OR (Data0008_DDHTB.difficulty_grade = 1))
    )               
    AS 厚铜板月累计订单
GO
/****** Object:  View [dbo].[partrece_total]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[partrece_total]
AS
SELECT  TOP (100) PERCENT dbo.Data0025.RKEY, dbo.Data0025.MANU_PART_NUMBER,
 dbo.Data0025.MANU_PART_DESC, dbo.Data0010.ABBR_NAME,
  dbo.Data0008.PROD_CODE, dbo.Data0025.unit_sq,
SUM(dbo.Data0053.QUANTITY) AS rece_total,
ROUND(SUM(dbo.Data0053.QUANTITY * dbo.Data0025.unit_sq), 4) AS mianqi
FROM         dbo.Data0025 INNER JOIN
dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN
dbo.Data0010 ON dbo.Data0025.CUSTOMER_PTR = dbo.Data0010.RKEY LEFT OUTER JOIN
dbo.Data0053 ON dbo.Data0025.RKEY = dbo.Data0053.CUST_PART_PTR
WHERE     (dbo.Data0025.PARENT_PTR IS NULL)
and Data0053.mfg_date >= '2018-10-28' and Data0053.mfg_date <= '2018-11-28'
and data0053.WHSE_PTR=1
GROUP BY dbo.Data0025.RKEY, dbo.Data0025.MANU_PART_NUMBER,
dbo.Data0025.MANU_PART_DESC, dbo.Data0008.PROD_CODE, dbo.Data0010.ABBR_NAME,
 dbo.Data0025.unit_sq
GO
/****** Object:  View [dbo].[v_Data0491_list]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_Data0491_list]
as 
SELECT    dbo.data0492.CUT_NO AS 配料单号, dbo.Data0015.WAREHOUSE_CODE AS 工厂代码
, dbo.data0492.SO_NO AS 销售订单号

, dbo.Data0025.MANU_PART_NUMBER AS 本厂编号, dbo.Data0025.MANU_PART_DESC AS 客户型号
, dbo.Data0008.PRODUCT_NAME AS 产品类型

, dbo.Data0010.CUST_CODE AS 客户代码, dbo.Data0010.ABBR_NAME AS 客户简称, dbo.Data0060.ORIG_CUSTOMER AS 关联原客户

, dbo.data0492.ISSUE_DATE AS 投产日期, dbo.Data0005.EMPLOYEE_NAME AS 投产人员, dbo.Data0060.SCH_DATE 回复交期
, CASE data0492.TTYPE WHEN 0 THEN '正常投产' WHEN 1 THEN '补料投产' 
			WHEN 2 THEN '按MRB重投' WHEN 3 THEN '按MRB返修' WHEN 4 THEN '按板号投产' END AS 投产类型
, CASE data0492.tstatus WHEN 0 THEN '已审核' WHEN 1 THEN '未审核' 
					WHEN 2 THEN '不审核' WHEN 3 THEN '已取消' END AS 状态
, dbo.data0492.remark AS 备注
					

, dbo.data0060.PARTS_ORDERED AS 订单数量, dbo.data0492.ORD_REQ_QTY AS 待计划数
, dbo.data0492.PLANNED_QTY AS 计划数量, dbo.data0492.ISSUED_QTY AS 投产数量
, dbo.data0492.cite_qryonhand AS 引用库存PCS数

, Data0025.unit_sq * Data0060.PARTS_ORDERED AS [订单面积(不含板边)], Data0025.unit_sq * data0492.ORD_REQ_QTY AS [待计划面积(不含板边)]
, Data0025.unit_sq * data0492.ISSUED_QTY AS [投产面积(不含板边)], Data0025.unit_sq * (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY) AS [超投面积(不含板边)]
, Data0025.unit_sq AS [单只面积(不含板边)]

, case when data0492.upanel1 >0 then data0492.ORD_REQ_QTY*
cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*
cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-
(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1
when data0492.upanel2 >0 then data0492.ORD_REQ_QTY*
cast(substring(pnl2_size,1,CHARINDEX('*',pnl2_size)-4) as money)*
cast(substring(pnl2_size,CHARINDEX('*',pnl2_size)+2,len(pnl2_size)-
(CHARINDEX('*',pnl2_size)+3)) as money)*0.000001/data0492.upanel2
else Data0025.unit_sq * data0492.ORD_REQ_QTY end as [待计划面积(含板边)]

, case when data0492.upanel1 >0 then data0492.ISSUED_QTY*
cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*
cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-
(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1
when data0492.upanel2 >0 then data0492.ISSUED_QTY*
cast(substring(pnl2_size,1,CHARINDEX('*',pnl2_size)-4) as money)*
cast(substring(pnl2_size,CHARINDEX('*',pnl2_size)+2,len(pnl2_size)-
(CHARINDEX('*',pnl2_size)+3)) as money)*0.000001/data0492.upanel2
else Data0025.unit_sq * data0492.ISSUED_QTY end as [投产面积(含板边)]

, case when data0492.upanel1 >0 then (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY)*
cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*
cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-
(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1
when data0492.upanel2 >0 then (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY)*
cast(substring(pnl2_size,1,CHARINDEX('*',pnl2_size)-4) as money)*
cast(substring(pnl2_size,CHARINDEX('*',pnl2_size)+2,len(pnl2_size)-
(CHARINDEX('*',pnl2_size)+3)) as money)*0.000001/data0492.upanel2
else Data0025.unit_sq * (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY) end as [超投面积(含板边)]

, case when data0492.upanel1 >0 then
cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*
cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-
(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1
when data0492.upanel2 >0 then
cast(substring(pnl2_size,1,CHARINDEX('*',pnl2_size)-4) as money)*
cast(substring(pnl2_size,CHARINDEX('*',pnl2_size)+2,len(pnl2_size)-
(CHARINDEX('*',pnl2_size)+3)) as money)*0.000001/data0492.upanel2
else Data0025.unit_sq end AS [单只面积(含板边)]

, dbo.Data0491.APP_QUAN AS 超投数量, data0492.operation_rate AS  超投率
, round(data0492.PLANNED_QTY/(1+data0025.EST_SCRAP*0.01),0,1)-data0492.ORD_REQ_QTY as 人为超投数量
, round((round(data0492.PLANNED_QTY/(1+data0025.EST_SCRAP*0.01),0,1)-
			data0492.ORD_REQ_QTY)*dbo.Data0025.unit_sq,3) as 人为超投面积 
, dbo.Data0491.remark AS 超投原因

, dbo.data0492.waitfor_release AS 待发放数量
, dbo.data0492.WIP_QTY AS WIP数量
, dbo.data0492.QTY_REJECT AS 报废数量
, dbo.data0492.FG_QTY AS 入库数量

, case isnull(dbo.Data0025.PARENT_PTR,0) when 0 then data0025.EST_SCRAP else 0 end 默认报废率
, case when dbo.data0492.ISSUED_QTY>0 then (case isnull(dbo.Data0025.PARENT_PTR,0) 
				when 0 then (round(CAST(dbo.data0492.QTY_REJECT AS float)/
				CAST(dbo.data0492.ISSUED_QTY AS float), 4)*100) else 0 end) else 0 end AS [实际报废率%]

, dbo.data0414.number  AS MRB处理编号, dbo.data0415.number  AS 出仓单号
							
FROM  dbo.Data0491 RIGHT OUTER JOIN
      dbo.Data0025 INNER JOIN
      dbo.data0492 ON dbo.Data0025.RKEY = dbo.data0492.BOM_PTR INNER JOIN
      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN
      dbo.Data0005 ON dbo.data0492.CREATED_BY_PTR = dbo.Data0005.RKEY INNER JOIN
      dbo.Data0015 ON dbo.data0492.WHOUSE_PTR = dbo.Data0015.RKEY INNER JOIN
      dbo.Data0010 ON dbo.data0492.COMPLETED = dbo.Data0010.RKEY LEFT OUTER JOIN
      dbo.Data0060 ON dbo.data0492.SO_NO = dbo.Data0060.SALES_ORDER 
				   ON dbo.Data0491.MO_PTR = dbo.data0492.rkey LEFT OUTER JOIN
      dbo.data0414 ON dbo.data0492.mrb_ptr = dbo.data0414.rkey LEFT OUTER JOIN
      dbo.data0415 ON dbo.data0414.d415_ptr = dbo.data0415.rkey  LEFT OUTER JOIN
      dbo.data0097 on dbo.data0060.PURCHASE_ORDER_PTR=dbo.data0097.Rkey
WHERE    issue_date >='2018-01-01' and
 issue_date < '2018-03-05'
GO
/****** Object:  View [dbo].[v_GointoProductionList]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_GointoProductionList]  
as  
--相关单号  
SELECT    dbo.data0492.CUT_NO AS 配料单号, dbo.Data0015.WAREHOUSE_CODE AS 工厂代码  
, dbo.data0492.SO_NO AS 销售订单号  
--产品信息  
, dbo.Data0025.MANU_PART_NUMBER AS 本厂编号, dbo.Data0025.MANU_PART_DESC AS 客户型号  
, dbo.Data0008.PRODUCT_NAME AS 产品类型  
--客户信息  
, dbo.Data0010.CUST_CODE AS 客户代码, dbo.Data0010.ABBR_NAME AS 客户简称, dbo.Data0060.ORIG_CUSTOMER AS 关联原客户  
--投产状态  
, convert(varchar,dbo.data0492.ISSUE_DATE,23) AS 投产日期, convert(varchar(7),dbo.data0492.ISSUE_DATE,120) as 月份,
dbo.Data0005.EMPLOYEE_NAME AS 投产人员, dbo.Data0060.SCH_DATE 回复交期  
, CASE data0492.TTYPE WHEN 0 THEN '正常投产' WHEN 1 THEN '补料投产'   
   WHEN 2 THEN '按MRB重投' WHEN 3 THEN '按MRB返修' WHEN 4 THEN '按板号投产' END AS 投产类型  
, CASE data0492.tstatus WHEN 0 THEN '已审核' WHEN 1 THEN '未审核'   
     WHEN 2 THEN '不审核' WHEN 3 THEN '已取消' END AS 状态  
, dbo.data0492.remark AS 备注   
--参考数量  
, dbo.data0060.PARTS_ORDERED AS 订单数量, dbo.data0492.ORD_REQ_QTY AS 待计划数  
, dbo.data0492.PLANNED_QTY AS 计划数量, dbo.data0492.ISSUED_QTY AS 投产数量  
, dbo.data0492.cite_qryonhand AS 引用库存PCS数  
--面积(不含板边)  
, Data0025.unit_sq * Data0060.PARTS_ORDERED AS [订单面积(不含板边)], Data0025.unit_sq * data0492.ORD_REQ_QTY AS [待计划面积(不含板边)]  
, Data0025.unit_sq * data0492.ISSUED_QTY AS [投产面积(不含板边)], Data0025.unit_sq * (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY) AS [超投面积(不含板边)]  
, Data0025.unit_sq AS [单只面积(不含板边)]  
--面积(含板边)  
, case when data0492.upanel1 >0 then data0492.ORD_REQ_QTY*  
cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*  
cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-  
(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1  
when data0492.upanel2 >0 then data0492.ORD_REQ_QTY*  
cast(substring(pnl2_size,1,CHARINDEX('*',pnl2_size)-4) as money)*  
cast(substring(pnl2_size,CHARINDEX('*',pnl2_size)+2,len(pnl2_size)-  
(CHARINDEX('*',pnl2_size)+3)) as money)*0.000001/data0492.upanel2  
else Data0025.unit_sq * data0492.ORD_REQ_QTY end as [待计划面积(含板边)]  
  
, case when data0492.upanel1 >0 then data0492.ISSUED_QTY*  
cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*  
cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-  
(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1  
when data0492.upanel2 >0 then data0492.ISSUED_QTY*  
cast(substring(pnl2_size,1,CHARINDEX('*',pnl2_size)-4) as money)*  
cast(substring(pnl2_size,CHARINDEX('*',pnl2_size)+2,len(pnl2_size)-  
(CHARINDEX('*',pnl2_size)+3)) as money)*0.000001/data0492.upanel2  
else Data0025.unit_sq * data0492.ISSUED_QTY end as [投产面积(含板边)]  
  
, case when data0492.upanel1 >0 then (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY)*  
cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*  
cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-  
(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1  
when data0492.upanel2 >0 then (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY)*  
cast(substring(pnl2_size,1,CHARINDEX('*',pnl2_size)-4) as money)*  
cast(substring(pnl2_size,CHARINDEX('*',pnl2_size)+2,len(pnl2_size)-  
(CHARINDEX('*',pnl2_size)+3)) as money)*0.000001/data0492.upanel2  
else Data0025.unit_sq * (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY) end as [超投面积(含板边)]  
  
, case when data0492.upanel1 >0 then  
cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*  
cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-  
(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1  
when data0492.upanel2 >0 then  
cast(substring(pnl2_size,1,CHARINDEX('*',pnl2_size)-4) as money)*  
cast(substring(pnl2_size,CHARINDEX('*',pnl2_size)+2,len(pnl2_size)-  
(CHARINDEX('*',pnl2_size)+3)) as money)*0.000001/data0492.upanel2  
else Data0025.unit_sq end AS [单只面积(含板边)]  
--超投信息  
,dbo.data0492.ISSUED_QTY - dbo.data0492.ORD_REQ_QTY AS 超投数量  
, data0492.operation_rate AS  超投率  
, round(data0492.PLANNED_QTY/(1+data0025.EST_SCRAP*0.01),0,1)-data0492.ORD_REQ_QTY as 人为超投数量  
, round((round(data0492.PLANNED_QTY/(1+data0025.EST_SCRAP*0.01),0,1)-  
   data0492.ORD_REQ_QTY)*dbo.Data0025.unit_sq,3) as 人为超投面积   
--投产数量  
, dbo.data0492.waitfor_release AS 待发放数量  
, dbo.data0492.WIP_QTY AS WIP数量  
, dbo.data0492.QTY_REJECT AS 报废数量  
, dbo.data0492.FG_QTY AS 入库数量  
--报废率  
, case isnull(dbo.Data0025.PARENT_PTR,0) when 0 then data0025.EST_SCRAP else 0 end 默认报废率  
, case when dbo.data0492.ISSUED_QTY>0 then (case isnull(dbo.Data0025.PARENT_PTR,0)   
    when 0 then (round(CAST(dbo.data0492.QTY_REJECT AS float)/  
    CAST(dbo.data0492.ISSUED_QTY AS float), 4)*100) else 0 end) else 0 end AS [实际报废率]  
--关联单号  
, dbo.data0414.number  AS MRB处理编号, dbo.data0415.number  AS 出仓单号          
FROM  dbo.data0492 INNER JOIN  
      dbo.Data0025 ON dbo.Data0025.RKEY = dbo.data0492.BOM_PTR INNER JOIN  
      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN  
      dbo.Data0005 ON dbo.data0492.CREATED_BY_PTR = dbo.Data0005.RKEY INNER JOIN  
      dbo.Data0015 ON dbo.data0492.WHOUSE_PTR = dbo.Data0015.RKEY INNER JOIN  
      dbo.Data0010 ON dbo.data0492.COMPLETED = dbo.Data0010.RKEY LEFT OUTER JOIN  
      dbo.Data0060 ON dbo.data0492.SO_NO = dbo.Data0060.SALES_ORDER LEFT OUTER JOIN  
      dbo.data0414 ON dbo.data0492.mrb_ptr = dbo.data0414.rkey LEFT OUTER JOIN  
      dbo.data0415 ON dbo.data0414.d415_ptr = dbo.data0415.rkey  LEFT OUTER JOIN  
      dbo.data0097 on dbo.data0060.PURCHASE_ORDER_PTR=dbo.data0097.Rkey
GO
/****** Object:  View [dbo].[v_ProdOut_list]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[v_ProdOut_list]
AS  

 SELECT     TOP (100) PERCENT dbo.Data0025.MANU_PART_NUMBER AS 本厂编号, dbo.Data0025.MANU_PART_DESC AS 客户型号,
dbo.Data0034.DEPT_CODE AS 工序代码,  dbo.Data0034.DEPT_NAME AS 工序,
dbo.Data0048.QTY_PROD AS [PCS数量], dbo.Data0048.PANELS AS [PNL数量],
dbo.Data0025.unit_sq,
dbo.Data0006.panel_ln,dbo.Data0006.panel_wd,
dbo.Data0006.PARTS_PER_PANEL,
dbo.Data0010.CUST_CODE AS 客户简称
, dbo.Data0008.PROD_CODE AS 类别代码
, dbo.Data0008.PRODUCT_NAME 产品类型
,d15_1.abbr_name AS 工厂,
d15_2.abbr_name AS 投料工厂
,Data0006.panel_ln AS spell_lngth
,Data0006.panel_wd AS spell_width
,CONVERT(VARCHAR(10),data0048.OUTTIME,120) AS 日期
, CONVERT(VARCHAR(7),data0048.OUTTIME,120) AS 月份,
 CASE WHEN data0025.PARENT_PTR IS NULL THEN '内层' ELSE '外层' end AS [内外层],
 CASE  data0060.so_tp WHEN 0 THEN '自制' WHEN 1 THEN '外发' WHEN 2 THEN '半制程' END AS 加工形式
,CASE WHEN data0034.BARCODE_ENTRY_FLAG = 'Y' THEN '过数工序' WHEN data0034.BARCODE_ENTRY_FLAG = 'N' THEN '非过数工序' END AS 是否过数
,data0008.difficulty_grade_value AS 阶数

FROM         dbo.Data0048 INNER JOIN
  dbo.Data0006 ON dbo.Data0048.WO_PTR = dbo.Data0006.RKEY INNER JOIN
  dbo.Data0034 ON dbo.Data0048.FM_DEPT_PTR = dbo.Data0034.RKEY INNER JOIN
  dbo.Data0025 ON dbo.Data0006.BOM_PTR = dbo.Data0025.RKEY INNER JOIN
  dbo.Data0034 AS Data0034_1 ON dbo.Data0034.BIG_DEPT_PTR = Data0034_1.RKEY INNER JOIN
  dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN
  dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO INNER JOIN
  dbo.Data0010 ON dbo.data0492.COMPLETED = dbo.Data0010.RKEY INNER JOIN
  dbo.data0007 ON data0007.RKEY=data0008.PR_GRP_POINTER INNER JOIN
  dbo.data0015 D15_1 ON data0048.warehouse_ptr=D15_1.rkey INNER JOIN
  dbo.data0015 D15_2 ON data0492.WHOUSE_PTR=D15_2.rkey LEFT OUTER JOIN
  dbo.Data0060 ON dbo.data0492.SO_NO = dbo.Data0060.SALES_ORDER
GO
/****** Object:  View [dbo].[V_WorkList]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_WorkList]
AS
SELECT  D06.WORK_ORDER_NUMBER AS 作业单号, D492.CUT_NO AS 配料单号

, D492.SO_NO AS 销售订单号, D10.ABBR_NAME AS 客户简称
, ISNULL(CASE WHEN D60.ORIG_CUSTOMER IS NULL THEN d25.ORIG_CUSTOMER ELSE D60.ORIG_CUSTOMER END,'') AS 关联原客户
, CASE D60.so_tp WHEN 0 THEN '自制' WHEN 1 THEN '外发' WHEN 2 THEN '半制程' END AS 加工形式

, d25.MANU_PART_NUMBER AS 本厂编号, d25.MANU_PART_DESC AS 客户型号
, d25.LAYERS AS 层数, d25.CPJS AS 产品阶数
, D08.PRODUCT_NAME AS 产品类型名称, D07.PRODUCT_GROUP_NAME AS 产品组别

, d15.ABBR_NAME AS 生产工厂

, D06.ENT_DATETIME AS 投产日期, D06.SCH_COMPL_DATE AS 计划完工日期

, d34.DEPT_NAME AS 工序名称, D56.STEP AS 当前步骤

, D56.INTIME AS 接收时间
, D06.QUAN_SCH AS 投产数量
, D06.QUAN_REJ AS 报废数量
, D06.QUAN_ALLREJ AS 报废待审核数量
, D06.QUAN_PROD AS 完工入库数量
, ISNULL(D56.QTY_BACKLOG,0) AS 当前在线数量pcs
, ISNULL(D56.PANELS,0) AS 在线pnl数量
, ISNULL(D56.TO_BE_STOCKED,0) AS 待入库数量

, d25.unit_sq AS 单只面积, ROUND(d25.unit_sq * D56.QTY_BACKLOG, 4) AS 在线pcs面积

,CASE WHEN D06.PARTS_PER_PANEL <> 0 THEN D06.panel_ln 
		* D06.panel_wd * 0.000001 / D06.PARTS_PER_PANEL ELSE 0 END AS [单只面积(含板边)]
, CASE WHEN D06.PARTS_PER_PANEL <> 0 THEN D56.QTY_BACKLOG * (D06.panel_ln * D06.panel_wd * 0.000001)
		/ D06.PARTS_PER_PANEL ELSE 0 END AS [在线pcs面积(含板边)]		
		
, CASE D06.Prod_Status WHEN 3 THEN '生产中' WHEN 4 THEN '外发生产' 
		WHEN 5 THEN '待入仓' WHEN 6 THEN '待分配' WHEN 103 THEN '生产中暂缓' ELSE '' END AS 作业单状态
, CASE D06.wtype WHEN 0 THEN '正常' WHEN 1 THEN '被拆分' 
				WHEN 2 THEN '待返工' WHEN 3 THEN '返工' 
				WHEN 4 THEN '待报废' WHEN 5 THEN '已报废' ELSE '' END AS 在线状态

FROM  dbo.Data0060 AS D60 RIGHT OUTER JOIN
      dbo.Data0025 AS d25 INNER JOIN
      dbo.Data0006 AS D06 ON D06.BOM_PTR = d25.RKEY INNER JOIN
      dbo.Data0056 AS D56 ON D56.WO_PTR = D06.RKEY INNER JOIN
      dbo.Data0034 AS d34 ON D56.DEPT_PTR = d34.RKEY INNER JOIN
      dbo.data0492 AS D492 ON D492.CUT_NO = D06.CUT_NO INNER JOIN
      dbo.Data0008 AS D08 ON D08.RKEY = d25.PROD_CODE_PTR INNER JOIN
      dbo.Data0007 AS D07 ON D07.RKEY = D08.PR_GRP_POINTER INNER JOIN
      dbo.Data0015 AS d15 ON D56.LOC_PTR = d15.RKEY INNER JOIN
      dbo.Data0010 AS D10 ON D492.COMPLETED = D10.RKEY ON D60.SALES_ORDER = D492.SO_NO
GO
/****** Object:  View [dbo].[ft1]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ft1]
AS
WITH d25cte AS (SELECT     RKEY, PARENT_PTR
                                     FROM         dbo.Data0025
                                     WHERE     (RKEY IN
                                                                (SELECT     Data0025_1.RKEY
                                                                  FROM          dbo.Data0056 INNER JOIN
                                                                                         dbo.Data0006 ON dbo.Data0056.WO_PTR = dbo.Data0006.RKEY INNER JOIN
                                                                                         dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO INNER JOIN
                                                                                         dbo.Data0060 ON dbo.data0492.SO_NO = dbo.Data0060.SALES_ORDER INNER JOIN
                                                                                         dbo.Data0025 AS Data0025_1 ON dbo.Data0060.CUST_PART_PTR = Data0025_1.RKEY))
                                     UNION ALL
                                     SELECT     d25.RKEY, d25.PARENT_PTR
                                     FROM         dbo.Data0025 AS d25 INNER JOIN
                                                           d25cte AS d25cte_2 ON d25cte_2.rkey = d25.PARENT_PTR)
    SELECT     d25cte_1.RKEY, d25cte_1.PARENT_PTR, d1.STEP_NUMBER, d2.TType, SUM(d2.DataValues) AS stime1, SUM(d2.DataValues2) AS stime2, SUM(d2.DataValues3) AS stime3
     FROM         d25cte AS d25cte_1 INNER JOIN
                                (SELECT     d381.SOURCE_PTR, d381.STEP_NUMBER, d5861.DataValues
                                  FROM          d25cte AS d251 INNER JOIN
                                                         dbo.Data0038 AS d381 ON d381.SOURCE_PTR = d251.RKEY INNER JOIN
                                                         dbo.Data0586 AS d5861 ON d5861.RKey34 = d381.DEPT_PTR) AS d1 ON d1.SOURCE_PTR = d25cte_1.RKEY INNER JOIN
                                (SELECT     d382.SOURCE_PTR, d382.STEP_NUMBER, d5862.DataValues, d5862.DataValues2, d5862.DataValues3, d5862.TType
                                  FROM          d25cte AS d252 INNER JOIN
                                                         dbo.Data0038 AS d382 ON d382.SOURCE_PTR = d252.RKEY INNER JOIN
                                                         dbo.Data0586 AS d5862 ON d5862.RKey34 = d382.DEPT_PTR) AS d2 ON d2.SOURCE_PTR = d1.SOURCE_PTR AND d2.STEP_NUMBER >= d1.STEP_NUMBER
     GROUP BY d25cte_1.RKEY, d25cte_1.PARENT_PTR, d1.STEP_NUMBER, d2.TType
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[31] 4[31] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "d25cte_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 93
               Right = 196
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d1"
            Begin Extent = 
               Top = 6
               Left = 234
               Bottom = 108
               Right = 410
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d2"
            Begin Extent = 
               Top = 6
               Left = 448
               Bottom = 123
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ft1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ft1'
GO
/****** Object:  View [dbo].[v_ProductOut_List]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*成品出仓查询列表视图*/
CREATE VIEW [dbo].[v_ProductOut_List]
AS
SELECT     CONVERT(VARCHAR, dbo.Data0064.DATE_ASSIGN, 23) AS 日期, CONVERT(VARCHAR(7), dbo.Data0064.DATE_ASSIGN, 23) AS 月份, 
                      dbo.Data0025.MANU_PART_NUMBER AS 本厂编号, dbo.Data0025.MANU_PART_DESC AS 客户型号, dbo.Data0025.LAYERS AS 层数, 
                      dbo.Data0007.PR_GRP_CODE AS 产品组别代码, dbo.Data0007.PRODUCT_GROUP_NAME AS 产品组别名称, dbo.Data0008.PRODUCT_NAME AS 产品类型名称, 
                      dbo.Data0008.PROD_CODE AS 产品类型代码, dbo.Data0010.ABBR_NAME AS 客户简称, dbo.Data0010.CUST_CODE AS 客户代码, 
                      dbo.Data0005.EMPLOYEE_NAME AS 业务员, dbo.Data0064.QUAN_SHIPPED AS 数量, dbo.Data0015.ABBR_NAME AS 工厂, 
                      CASE dbo.Data0060.so_tp WHEN 0 THEN '自制' WHEN 1 THEN '外发' WHEN 2 THEN '半制程' END AS 订单类别, dbo.Data0025.ttype AS 产品性质, 
                      dbo.Data0064.assign_type AS 指派类型, dbo.Data0064.QUAN_SHIPPED * dbo.Data0025.unit_sq AS 面积, 
                      ROUND(dbo.Data0064.QUAN_SHIPPED * dbo.Data0060.PARTS_ALLOC / CASE WHEN data0060.exch_rate = 0 THEN 1 ELSE data0060.exch_rate END, 4) 
                      AS 不含税本币金额, ROUND((dbo.Data0064.QUAN_SHIPPED * dbo.Data0060.PARTS_ALLOC) * (1 + dbo.Data0064.TAX_2 * 0.01) 
                      / CASE WHEN data0060.exch_rate = 0 THEN 1 ELSE data0060.exch_rate END, 4) AS 含税本币金额, CASE WHEN data0025.PARENT_PTR IS NULL 
                      THEN '内层' ELSE '外层' END AS 内外层, dbo.Data0008.PROD_INCREMENTBY AS 产品层数, dbo.Data0008.difficulty_grade_value AS 产品阶数
FROM         dbo.Data0064 INNER JOIN
                      dbo.Data0060 ON dbo.Data0064.SO_PTR = dbo.Data0060.RKEY INNER JOIN
                      dbo.Data0025 ON dbo.Data0060.CUST_PART_PTR = dbo.Data0025.RKEY INNER JOIN
                      dbo.Data0010 ON dbo.Data0060.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN
                      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN
                      dbo.Data0007 ON dbo.Data0008.PR_GRP_POINTER = dbo.Data0007.RKEY INNER JOIN
                      dbo.Data0005 ON dbo.Data0060.COMM_ASSIGNED_BY_E_P = dbo.Data0005.RKEY INNER JOIN
                      dbo.Data0015 ON dbo.Data0060.SHIP_REG_TAX_ID = dbo.Data0015.RKEY
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[17] 2[46] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0064"
            Begin Extent = 
               Top = 0
               Left = 38
               Bottom = 119
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0060"
            Begin Extent = 
               Top = 6
               Left = 278
               Bottom = 125
               Right = 499
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0025"
            Begin Extent = 
               Top = 6
               Left = 537
               Bottom = 125
               Right = 755
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0010"
            Begin Extent = 
               Top = 6
               Left = 793
               Bottom = 125
               Right = 1011
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0008"
            Begin Extent = 
               Top = 51
               Left = 29
               Bottom = 206
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 16
         End
         Begin Table = "Data0007"
            Begin Extent = 
               Top = 126
               Left = 290
               Bottom = 245
               Right = 502
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0005"
            Begin Extent = 
               Top = 126
               Left = 540
               Bottom = 245
               Right = 715
            End
            DisplayFlags =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ProductOut_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 280
            TopColumn = 0
         End
         Begin Table = "Data0015"
            Begin Extent = 
               Top = 126
               Left = 753
               Bottom = 245
               Right = 940
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4260
         Alias = 2700
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ProductOut_List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ProductOut_List'
GO
/****** Object:  View [dbo].[v_bomprice06_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--BOM报价审批信息view,用途: 1.微信审批列表,2.
CREATE view [dbo].[v_bomprice06_check]
as
SELECT
	BP06.D264_ptr
	 , BP06.IDKEY
	 , BP06.BPNO
	 , BP06.Customer_Name
	 , BP06.Manu_Part_Desc
	 , BP06.D10_Ptr
	 , BP06.BP00_Ptr
	 , BP06.hanshuijiage_Pcs
	 , BP06.buhanshuijiage_Pcs
	 , BP06.D01_Ptr
	 , BP06.maolilv_add
	 , BP06.CreateMan
	 , BP06.SaleMan
	 , BP06.BPTime
	 , BP06.AuthStatus
	 , BP06.CurRate
	 , BP06.payment
	 , BP06.Auth_NoteList
	 , BP06.EnableDays
	 , BP06.ANALYSIS_CODE_2
	 , bp06.jinglilv_add
	 , bp06.OrignPrice
	 , bp06.OrignPrice_M
	 , d10.CUST_CODE
	 , d25.MANU_PART_NUMBER
	 , bp00.bpname
	 , d01.CURR_NAME
	 , d05_1.EMPLOYEE_NAME AS SMan
	 , d05_2.EMPLOYEE_NAME AS CMan
	 , bp06.Layers
	 , bp06.[完成板厚mm]
	 , bp06.[bPCSPerSet]
	 , bp06.[bSet_L]
     , bp06.[bSet_W]
	 , bp06.[bSurface]
	 , bp06.[bBPType]
	 , bp06.[bUseAge]
	 , bp14.D05_ptr
	 , bp14.nowauth
	 , bp14.Auth_Flag
	 , bp14.SeqNo
	 , bp14.idkey as idkeybp14
	 , d73.RKEY as d73ptr
from  bomprice06 bp06
	LEFT JOIN Data0010 d10
		ON bp06.D10_Ptr = d10.RKEY
	LEFT JOIN data0025 d25
		ON d25.RKEY = BP06.D25_Ptr
	LEFT JOIN bomprice00 bp00
		ON bp00.idkey = BP06.bp00_ptr
	LEFT JOIN data0001 d01
		ON d01.RKEY = BP06.D01_Ptr
	LEFT JOIN data0005 d05_1
		ON d05_1.RKEY = BP06.SaleMan
	LEFT JOIN data0005 d05_2
		ON d05_2.Rkey = BP06.CreateMan
	LEFT JOIN BOMPrice14 bp14
		ON bp06.idkey = bp14.BP06_Ptr
	LEFT JOIN Data0073 d73
		ON bp14.D05_ptr = d73.EMPLOYEE_PTR
WHERE bp06.AuthStatus in(1,2,3) AND
	DATEDIFF(DAY,bp06.CreateTime,GETDATE())<=7
GO
/****** Object:  View [dbo].[v_data0492_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--超投审批信息view,用途: 1.微信审批列表,2.
CREATE view [dbo].[v_data0492_check]
as
SELECT  data0492.RKEY as rkey492,data0491.RKEY as rkey491,dbo.data0492.CUT_NO, dbo.data0492.SO_NO, dbo.data0492.ORD_REQ_QTY, dbo.data0492.ISSUED_QTY, 
	dbo.data0492.ISSUE_DATE, dbo.data0492.TSTATUS,dbo.Data0025.MANU_PART_NUMBER, dbo.Data0025.MANU_PART_DESC, dbo.data0492.analysis_code_3,
	dbo.Data0491.remark, dbo.data0492.remark AS remark492, CASE Data0492.ttype WHEN 0 THEN '订单投产' WHEN 1 THEN '补料投产' 
	WHEN 2 THEN 'MRB重投' WHEN 3 THEN 'MRB返修' WHEN 4 THEN '板号投产' END AS ct_type,data0025.EST_SCRAP,
    dbo.data0492.SCH_COMPL_DATE, dbo.Data0005.EMPLOYEE_NAME,Data0025.unit_sq * data0492.ORD_REQ_QTY AS area3, 
	Data0025.unit_sq * data0492.ISSUED_QTY AS area1,Data0025.unit_sq * (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY) AS area2, 
	Data0025.unit_sq*Data0060.PARTS_ORDERED AS area_4,case when data0492.upanel1 >0 then data0492.ORD_REQ_QTY*
		cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*
		cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-
		(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1
	else Data0025.unit_sq * data0492.ORD_REQ_QTY end as area3_1,

	case when data0492.upanel1 >0 then data0492.ISSUED_QTY*
	cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*
	cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-
	(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1
	else Data0025.unit_sq * data0492.ISSUED_QTY end as area1_1,

	case when data0492.upanel1 >0 then (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY)*
	cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*
	cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-
	(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1
	else Data0025.unit_sq * (data0492.ISSUED_QTY - data0492.ORD_REQ_QTY) end as area2_1,

	case when data0492.upanel1 >0 then
	cast(substring(pnl1_size,1,CHARINDEX('*',pnl1_size)-4) as money)*
	cast(substring(pnl1_size,CHARINDEX('*',pnl1_size)+2,len(pnl1_size)-
	(CHARINDEX('*',pnl1_size)+3)) as money)*0.000001/data0492.upanel1
	else Data0025.unit_sq end as unit_sq_1,

	CASE WHEN Data0492.ORD_REQ_QTY > 0 THEN round(CAST(Data0491.APP_QUAN * 100 AS float) / CAST(data0492.ORD_REQ_QTY AS float), 2) 
	ELSE 0 END AS ct_rate, dbo.Data0491.APP_QUAN, dbo.Data0491.APP_BY_PTR, dbo.Data0010.CUST_CODE, dbo.Data0491.APP_DATE, 
	CASE WHEN data0025.PARENT_PTR IS NULL THEN '外层' ELSE '内层' END AS part_type, dbo.data0492.Con_Flag, dbo.Data0060.PARTS_ORDERED, 
	dbo.Data0025.unit_sq, ROUND(dbo.data0492.ISSUED_QTY * dbo.Data0025.unit_sq, 3) AS iss_sqft, 
	CASE data0492.tstatus WHEN 0 THEN '已审核' WHEN 1 THEN '未审核' END AS app_status, Data0005_1.EMPLOYEE_NAME AS app_by_empl,
	round(data0492.PLANNED_QTY/(1+data0025.EST_SCRAP*0.01),0,1)-data0492.ORD_REQ_QTY as rw_caotou,data0492.PLANNED_QTY,
	round((round(data0492.PLANNED_QTY/(1+data0025.EST_SCRAP*0.01),0,1)-data0492.ORD_REQ_QTY)*dbo.Data0025.unit_sq,3) as rw_caotou_mianji,
	d73.USER_FULL_NAME,data0491.csi_ptr,data0491.ranking,case when Data0491.auth_flag=1  then '是当前审核人' else '不是当前审核人' end as  '当前人员审核' ,Data0491.auth_flag
FROM dbo.Data0491 INNER JOIN
	dbo.data0492 ON dbo.Data0491.MO_PTR = dbo.data0492.rkey INNER JOIN
	dbo.Data0025 ON dbo.data0492.BOM_PTR = dbo.Data0025.RKEY INNER JOIN
	dbo.Data0005 ON dbo.data0492.CREATED_BY_PTR = dbo.Data0005.RKEY LEFT OUTER JOIN
	dbo.Data0060 ON dbo.data0492.SO_NO = dbo.Data0060.SALES_ORDER INNER JOIN
	dbo.Data0010 ON dbo.data0492.COMPLETED = dbo.Data0010.RKEY LEFT OUTER JOIN
	dbo.Data0005 AS Data0005_1 ON dbo.Data0491.APP_BY_PTR = Data0005_1.RKEY
	left  join  Data0073  d73  on Data0491.csi_ptr=d73.rkey
where data0492.TSTATUS<>2 and
	data0492.TSTATUS<>3 and
	data0492.TSTATUS<>4 and
	datediff(month,data0492.ISSUE_DATE,GETDATE())<3
GO
/****** Object:  View [dbo].[View_Auto_OnlinePause]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Auto_OnlinePause]
AS
SELECT  TOP (100) PERCENT         
        dbo.Data0005.EMPLOYEE_NAME AS 业务员,
        dbo.Data0015.ABBR_NAME AS 工厂名称,  
        dbo.Data0010.CUST_CODE AS 客户代码, 
        dbo.Data0010.ABBR_NAME AS 客户简称, 
        Data0010_1.ABBR_NAME AS 关联客户, 
        dbo.Data0060.SALES_ORDER AS 订单编号, 
        CASE dbo.Data0060.so_style 
            WHEN 0 THEN '正式' 
            WHEN 1 THEN '备品' 
        END AS 订单类型, 
        CASE dbo.Data0060.so_tp 
            WHEN 0 THEN '自制' 
            WHEN 1 THEN '外发' 
            WHEN 2 THEN '半制程' 
        END AS 订单类别, 
        CASE STATUS 
            WHEN 1 THEN '有效' 
            WHEN 2 THEN '暂缓' 
            WHEN 3 THEN '关闭' 
            WHEN 4 THEN '完成' 
            WHEN 5 THEN '取消' 
            WHEN 6 THEN '未提交' 
        END AS 订单状态, 
        dbo.Data0034.DEPT_CODE AS 停留工序代码, 
        dbo.Data0034.DEPT_NAME AS 停留工序名称, 
        CASE dbo.Data0006.PROD_STATUS 
            WHEN 2 THEN '待发放' 
            WHEN 3 THEN '生产中' 
            WHEN 4 THEN '外发生产' 
            WHEN 5 THEN '待入仓' 
            WHEN 6 THEN '待分配' 
            WHEN 9 THEN '生产结束' 
            WHEN 102 THEN '生产前暂缓' 
            WHEN 103 THEN '生产中暂缓' 
            WHEN 202 THEN '取消' 
        END AS 作业单状态, 
        ROUND(SUM(dbo.Data0056.QTY_BACKLOG * dbo.Data0025.unit_sq), 2) AS 不含板边面积, 
        dbo.Data0001.CURR_CODE AS 原币代码, 
        dbo.Data0001.CURR_NAME AS 原币名称, 
        ROUND(SUM(dbo.Data0056.QTY_BACKLOG * dbo.Data0025.unit_sq * dbo.Data0060.PARTS_ALLOC), 2) AS [金额(原币不含税)], 
        ROUND(SUM(dbo.Data0056.QTY_BACKLOG * dbo.Data0025.unit_sq * dbo.Data0060.PARTS_ALLOC / dbo.Data0060.EXCH_RATE), 2) AS [金额(人民币不含税)]
FROM    dbo.Data0006 INNER JOIN
        dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO INNER JOIN
        dbo.Data0060 ON dbo.data0492.SO_NO = dbo.Data0060.SALES_ORDER INNER JOIN
        dbo.Data0010 ON dbo.Data0060.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN
        dbo.Data0025 ON dbo.Data0006.BOM_PTR = dbo.Data0025.RKEY INNER JOIN
        dbo.Data0001 ON dbo.Data0060.CURRENCY_PTR = dbo.Data0001.RKEY INNER JOIN
        dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY LEFT OUTER JOIN
        dbo.Data0010 AS Data0010_1 ON dbo.Data0025.ORIG_CUSTOMER = Data0010_1.ABBR_NAME RIGHT OUTER JOIN
        dbo.Data0034 INNER JOIN
        dbo.Data0056 ON dbo.Data0034.RKEY = dbo.Data0056.DEPT_PTR INNER JOIN
        dbo.Data0015 ON dbo.Data0056.LOC_PTR = dbo.Data0015.RKEY ON dbo.Data0006.RKEY = dbo.Data0056.WO_PTR
WHERE  (dbo.Data0006.PROD_STATUS IN (3, 4, 5, 6, 9, 102, 103)) 
   AND (dbo.Data0056.INTIME < DATEADD(month, - 3, GETDATE()))
GROUP BY dbo.Data0010.CUST_CODE, dbo.Data0010.ABBR_NAME, Data0010_1.ABBR_NAME, dbo.Data0001.CURR_CODE, dbo.Data0001.CURR_NAME, 
         CASE STATUS WHEN 1 THEN '有效' WHEN 2 THEN '暂缓' WHEN 3 THEN '关闭' WHEN 4 THEN '完成' WHEN 5 THEN '取消' WHEN 6 THEN '未提交' END, 
         dbo.Data0034.DEPT_CODE, dbo.Data0034.DEPT_NAME, dbo.Data0015.ABBR_NAME, dbo.Data0005.EMPLOYEE_NAME, dbo.Data0060.so_style, 
         dbo.Data0060.SALES_ORDER, dbo.Data0060.so_tp, dbo.Data0006.PROD_STATUS
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0006"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "data0492"
            Begin Extent = 
               Top = 6
               Left = 300
               Bottom = 126
               Right = 497
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0060"
            Begin Extent = 
               Top = 6
               Left = 535
               Bottom = 126
               Right = 772
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0010"
            Begin Extent = 
               Top = 6
               Left = 810
               Bottom = 126
               Right = 1044
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0025"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 246
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0001"
            Begin Extent = 
               Top = 126
               Left = 310
               Bottom = 246
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0005"
            Begin Extent = 
               Top = 126
               Left = 564
               Bottom = 246
               Right = 755
            End
            DisplayFlags =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Auto_OnlinePause'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 280
            TopColumn = 0
         End
         Begin Table = "Data0010_1"
            Begin Extent = 
               Top = 126
               Left = 793
               Bottom = 246
               Right = 1027
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0034"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 366
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0056"
            Begin Extent = 
               Top = 246
               Left = 298
               Bottom = 366
               Right = 487
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0015"
            Begin Extent = 
               Top = 246
               Left = 525
               Bottom = 366
               Right = 728
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Auto_OnlinePause'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Auto_OnlinePause'
GO
/****** Object:  View [dbo].[V_meal]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE
 VIEW  [dbo].[V_meal] 
AS
SELECT 
a.id, 
a.remark2, 
b.employeecode,
b.departmentname,
b.chinesename,
b.ranks,
a.empid,
d.mealtype as meal_type,
 case when a.time_e between '05:40:00' and '09:30:00'  then 1 else 0 end as breakfast,
 case when a.time_e between '10:30:00' and '13:30:00'  then 1 else 0 end as lunch,
 case when a.time_e between '15:30:00' and '19:30:00'  then 1 else 0 end as supper,
 case when a.time_e between '21:00:00' and '23:59:59' or  a.time_e between '00:00:00' and '01:30:00' then 1 else 0 end as [night snack],
 case when (a.time_e  not between '05:40:00' and '09:30:00')
		 and (a.time_e not between '10:30:00' and '13:30:00')
		 and (a.time_e not between '15:30:00' and '19:30:00')
		 and (a.time_e not between '21:00:00' and '23:59:59')
		 and (a.time_e not between '00:00:00'and '01:30:00') then 1 else 0 end as [invalid_card],
 case when a.time_e  between '00:00:00'and '01:30:00' then dateadd(day,-1,a.date_e) else a.date_e end as [meal_date],
 a.card_time,b.status,
substring(d.dev_ip,1,charindex('.',d.dev_ip,8)-1) as ip_addr
 FROM dbo.meal_orginaldata a 
 join (select rkey, employeecode, departmentname, chinesename,ranks,'local' as  factorytype,[status] from v_employeemsg 
union 
select rkey,employeecode,factoryarea,chinesename,'','extra' as factorytype,3 as [status] from  employeemsg_extra where flag in (1,4)) as b on a.empid=b.rkey and a.factorytype=b.factorytype
 join (select * from dev_detail where purpose='m' and devaddr='local' )  d on cast (a.dev_id as int)=cast (d.devid as int)
where a.dev_mark IS NULL or a.dev_mark='ID'
GO
/****** Object:  View [dbo].[_tmp01]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[_tmp01]
AS
SELECT     dbo.OriginalCheckData.employeecard, dbo.OriginalCheckData.card_time, dbo.OriginalCheckData.date_e, dbo.OriginalCheckData.time_e, 
                      dbo.OriginalCheckData.dev_id, dbo.OriginalCheckData.employeeid, dbo.OriginalCheckData.ClassID, dbo.OriginalCheckData.SignDesc, 
                      dbo.OriginalCheckData.QuerySign, dbo.OriginalCheckData.remark
FROM         dbo.OriginalCheckData INNER JOIN
                      dbo.employeemsg ON dbo.OriginalCheckData.employeeid = dbo.employeemsg.rkey
WHERE     (dbo.employeemsg.chinesename LIKE N'%汪庆龙%')
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OriginalCheckData"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 248
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "employeemsg"
            Begin Extent = 
               Top = 0
               Left = 422
               Bottom = 254
               Right = 639
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_tmp01'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_tmp01'
GO
/****** Object:  View [dbo].[bom查材料]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[bom查材料]
AS
SELECT     dbo.Data0496.GROUP_NAME AS Expr1, dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.INV_PART_DESCRIPTION, dbo.Data0017.INV_NAME, 
                      dbo.Data0017.IES_PARAMETER_VALUE1, dbo.Data0017.IES_PARAMETER_VALUE2, dbo.Data0017.IES_PARAMETER_VALUE3, 
                      dbo.Data0017.IES_PARAMETER_VALUE4, dbo.Data0017.IES_PARAMETER_VALUE5, dbo.Data0017.IES_PARAMETER_VALUE6, 
                      dbo.Data0017.IES_PARAMETER_VALUE7, dbo.Data0017.IES_PARAMETER_VALUE8, dbo.Data0017.IES_PARAMETER_VALUE9, 
                      dbo.Data0017.IES_PARAMETER_VALUE10
FROM         dbo.Data0017 INNER JOIN
                      dbo.Data0496 ON dbo.Data0017.GROUP_PTR = dbo.Data0496.RKEY
WHERE     (dbo.Data0496.GROUP_NAME = 'app')
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[31] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0017"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 205
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 64
         End
         Begin Table = "Data0496"
            Begin Extent = 
               Top = 6
               Left = 287
               Bottom = 114
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1785
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'bom查材料'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'bom查材料'
GO
/****** Object:  View [dbo].[VStockQnty]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[VStockQnty]
AS
SELECT t17.INV_PART_NUMBER, t17.INV_PART_DESCRIPTION, t496.GROUP_DESC,
       t16.LOCATION, t22.spec_place, t23.CODE as code_23, t23.ABBR_NAME AS code23,
       t22.QUAN_ON_HAND, t22.QUAN_ON_HAND-t22.QUAN_TO_BE_STOCKED AS quan_total,
       t1.CURR_CODE, t22.tax_price, t22.PRICE, t22.TAX_2,
       ROUND(t22.PRICE * t456.exch_rate, 4) AS L_no_taxprice, t22.tax_price * t456.exch_rate AS L_tax_price,
       ROUND(t22.PRICE * t456.exch_rate * t22.QUAN_ON_HAND, 4) AS amount_notax,
       t22.tax_price * t456.exch_rate * t22.QUAN_ON_HAND AS amount_tax,
       t70.PO_NUMBER, t5.EMPLOYEE_NAME AS po_emplname, t456.GRN_NUMBER, t456.ship_DATE, t22.EXPIRE_DATE, t22.TDATE,
       DateDiff(day,t22.TDATE,getdate()) AS huoling, DateDiff(day,getdate(),t22.EXPIRE_DATE) AS dqts,
       t17.ANALYSIS_CODE1, t2.UNIT_NAME, t5_2.EMPLOYEE_NAME AS ReqName, t5_1.EMPLOYEE_NAME AS RecName,
       '通用库存' AS type, t15.ABBR_NAME AS FactoryName
FROM dbo.Data0022 t22 INNER JOIN
     dbo.Data0017 t17 ON t22.INVENTORY_PTR = t17.RKEY INNER JOIN
     dbo.Data0496 t496 ON t17.GROUP_PTR = t496.RKEY INNER JOIN
     dbo.Data0002 t2 ON t22.LOCATION_PTR_FROM = t2.RKEY INNER JOIN
     dbo.Data0456 t456 ON t22.GRN_PTR = t456.RKEY INNER JOIN
     dbo.Data0015 t15 ON t456.warehouse_ptr = t15.RKEY INNER JOIN
     dbo.Data0023 t23 ON t456.SUPP_PTR = t23.RKEY INNER JOIN
     dbo.Data0016 t16 ON t22.LOCATION_PTR = t16.RKEY INNER JOIN
     dbo.Data0001 t1 ON t456.currency_ptr = t1.RKEY INNER JOIN
     dbo.Data0005 t5_1 ON t5_1.RKEY = t456.CREATE_BY LEFT JOIN
     dbo.Data0070 t70 ON t456.PO_PTR = t70.RKEY LEFT JOIN
     dbo.Data0005 t5 ON t5.RKEY = t70.EMPLOYEE_POINTER LEFT JOIN
     dbo.Data0068 t68 ON t70.FOB = t68.PO_REQ_NUMBER LEFT JOIN
     dbo.Data0005 t5_2 ON t5_2.RKEY = t68.REQ_BY
WHERE (t22.QUAN_ON_HAND > 0)
union all
SELECT t17.INV_PART_NUMBER, t17.INV_PART_DESCRIPTION, t496.GROUP_DESC,
       t16.LOCATION, '' as spec_place, t23.CODE as code_23, t23.ABBR_NAME AS code23,
       t134.QUAN_ON_HAND, t134.QUAN_ON_HAND AS quan_total,
       t1.CURR_CODE, t134.tax_price, t134.PRICE, t134.TAX_2,
       ROUND(t134.PRICE * t133.exch_rate, 4) AS L_no_taxprice, t134.tax_price * t133.exch_rate AS L_tax_price,
       ROUND(t134.PRICE * t133.exch_rate * t134.QUAN_ON_HAND, 4) AS amount_notax,
       t134.tax_price * t133.exch_rate * t134.QUAN_ON_HAND AS amount_tax,
       t70.PO_NUMBER, t5.EMPLOYEE_NAME AS po_emplname, t133.GRN_NUMBER, t133.ship_DATE, t134.EXPIRE_DATE, t134.MANU_DATE AS TDATE,
       DateDiff(day,t134.MANU_DATE,getdate()) AS huoling, DateDiff(day,getdate(),t134.EXPIRE_DATE) AS dqts,
       t17.ANALYSIS_CODE1, t2.UNIT_NAME, t5_2.EMPLOYEE_NAME AS ReqName,t5_1.EMPLOYEE_NAME AS RecName,
       'VMI库存' AS type, t15.ABBR_NAME AS FactoryName
FROM dbo.Data0017 t17 INNER JOIN
     dbo.Data0496 t496 ON t17.GROUP_PTR = t496.RKEY INNER JOIN
     dbo.DATA0134 t134 ON t17.RKEY = t134.INVENTORY_PTR INNER JOIN
     dbo.Data0002 t2 ON t134.UNIT_PTR = t2.RKEY INNER JOIN
     dbo.DATA0133 t133 INNER JOIN
     dbo.Data0015 t15 ON t133.warehouse_ptr = t15.RKEY INNER JOIN
     dbo.Data0023 t23 ON t133.SUPP_PTR = t23.RKEY ON t134.GRN_PTR = t133.RKEY INNER JOIN
     dbo.Data0016 t16 ON t134.LOCATION_PTR = t16.RKEY INNER JOIN
     dbo.Data0001 t1 ON t133.currency_ptr = t1.RKEY INNER JOIN
     dbo.Data0005 t5_1 ON t5_1.RKEY = t133.CREATE_BY LEFT JOIN
     dbo.Data0070 t70 ON t133.PO_PTR = t70.RKEY LEFT JOIN
     dbo.Data0005 t5 ON t5.RKEY = t70.EMPLOYEE_POINTER LEFT JOIN
     dbo.Data0068 t68 ON t70.FOB = t68.PO_REQ_NUMBER LEFT JOIN
     dbo.Data0005 t5_2 ON t5_2.RKEY = t68.REQ_BY
WHERE (t134.quan_on_hand>0)
GO
/****** Object:  View [dbo].[材料库存不等数据]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[材料库存不等数据]
AS
SELECT dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.QUAN_ON_HAND, 
      d1.onhand
FROM dbo.Data0017 INNER JOIN
          (SELECT INVENTORY_PTR, SUM(QUAN_ON_HAND) AS onhand
         FROM dbo.Data0022
         GROUP BY INVENTORY_PTR) d1 ON 
      dbo.Data0017.RKEY = d1.INVENTORY_PTR AND 
      dbo.Data0017.QUAN_ON_HAND <> d1.onhand
GO
/****** Object:  View [dbo].[received_total]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[received_total]
AS
SELECT dbo.Data0017.RKEY, dbo.Data0017.INV_PART_NUMBER, 
 dbo.Data0017.INV_NAME, dbo.Data0017.INV_DESCRIPTION, 
dbo.Data0002.UNIT_NAME, dbo.Data0496.GROUP_NAME,
dbo.Data0019.inv_group_name, ROUND(dbo.Data0017.STD_COST, 3) AS std_cost,
SUM(Data0022.QUANTITY) AS received,
ROUND(SUM(dbo.Data0022.QUANTITY * dbo.Data0022.PRICE * dbo.Data0456.exch_rate),
3) AS received_money, dbo.Data0023.ABBR_NAME,
dbo.Data0456.SUPP_PTR AS rkey23, dbo.Data0017.STOCK_SELL, 
dbo.Data0017.STOCK_BASE
FROM dbo.Data0023 INNER JOIN
dbo.Data0456 INNER JOIN
dbo.Data0022 INNER JOIN
dbo.Data0002 ON dbo.Data0022.LOCATION_PTR_FROM = dbo.Data0002.RKEY ON
dbo.Data0456.RKEY = dbo.Data0022.GRN_PTR ON
dbo.Data0023.RKEY = dbo.Data0456.SUPP_PTR RIGHT OUTER JOIN
dbo.Data0496 INNER JOIN
dbo.Data0017 ON dbo.Data0496.RKEY = dbo.Data0017.GROUP_PTR INNER JOIN
dbo.Data0019 ON dbo.Data0496.group_ptr = dbo.Data0019.rkey ON
dbo.Data0022.INVENTORY_PTR = dbo.Data0017.RKEY
where  Data0456.ship_DATE >= '2018-09-01' and Data0456.ship_DATE <= '2018-11-23'
and data0456.warehouse_PTR=9
GROUP BY all Data0017.RKEY,Data0017.INV_PART_NUMBER,data0017.inv_name,
Data0017.INV_DESCRIPTION, Data0017.STD_COST,
Data0002.UNIT_NAME, Data0496.GROUP_DESC,
Data0496.GROUP_NAME,data0019.inv_group_name,
Data0023.ABBR_NAME,dbo.Data0456.SUPP_PTR,
Data0017.STOCK_SELL,Data0017.STOCK_BASE
GO
/****** Object:  View [dbo].[v_Data0468_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_Data0468_check]
as
SELECT dbo.Data0468.RKEY, dbo.Data0468.FLOW_NO, dbo.Data0468.STEP, dbo.Data0468.DEPT_PTR, dbo.Data0468.INVENT_PTR, 
	dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.INV_PART_DESCRIPTION, dbo.Data0468.QUAN_BOM, dbo.Data0468.QUAN_ISSUED, 
	dbo.Data0002.UNIT_NAME, dbo.Data0468.STATUS, dbo.Data0468.VENDOR
FROM dbo.Data0002 INNER JOIN
	dbo.Data0017 ON dbo.Data0002.RKEY = dbo.Data0017.STOCK_UNIT_PTR INNER JOIN
	dbo.Data0468 ON dbo.Data0017.RKEY = dbo.Data0468.INVENT_PTR
GO
/****** Object:  View [dbo].[v_empmsgforbox]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_empmsgforbox]
AS
SELECT     dbo.employeemsg.employeecode AS EmpCode
, dbo.employeemsg.chinesename AS EmpName
, dbo.employeecardMsg.ICCardno AS ICCardNO
, SUBSTRING(dbo.employeemsg.IDCard, LEN(dbo.employeemsg.IDCard) - 5
, LEN(dbo.employeemsg.IDCard)) AS IdenCardNO
FROM         dbo.employeemsg INNER JOIN
                      dbo.employeecardMsg ON dbo.employeemsg.rkey = dbo.employeecardMsg.employeeid
WHERE     (dbo.employeemsg.status = 1) and (dbo.employeecardmsg.status = 1) 
and (dbo.employeemsg.NeedShoeBox = 1)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "employeemsg"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 227
               Right = 374
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "employeecardMsg"
            Begin Extent = 
               Top = 6
               Left = 412
               Bottom = 245
               Right = 715
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_empmsgforbox'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_empmsgforbox'
GO
/****** Object:  View [dbo].[v_DATA0268_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--领料审批信息view,用途: 1.微信审批列表,2.
CREATE view [dbo].[v_DATA0268_check]
as
SELECT DISTINCT d268.rkey,d268.number,d268.dept_ptr,d34.DEPT_CODE,d34.DEPT_NAME,d268.DATE,
	d268.EMPL_PTR,d05_1.EMPL_CODE,d05_1.EMPLOYEE_NAME,d268.status,
	CASE d268.status WHEN 0 THEN '待提交' WHEN 1 THEN '待审核' WHEN 2 THEN '已审核' WHEN 3 THEN '被退回'  WHEN 4 THEN '已发放' END AS C_STATUS,
	d268.auth_emplptr,d05_2.EMPL_CODE AS auth_EMPL_CODE, d05_2.EMPLOYEE_NAME AS auth_EMPLOYEE_NAME,
	d268.auth_date, d268.auth_ptr, d268.reference,d73.draw_materiel_ptr,Upper(d368.auth_flag) as auth_flag,
	d368.rkey AS rkey368,d368.ranking,d368.auth_date AS auth_date368
FROM DATA0268 d268
	INNER JOIN Data0034 d34 ON d268.dept_ptr = d34.RKEY
	INNER JOIN Data0005 d05_1 ON d268.EMPL_PTR = d05_1.RKEY
	LEFT JOIN Data0005 d05_2 ON d268.auth_emplptr = d05_2.RKEY
	inner JOIN DATA0368 d368 ON d368.apply_ptr = d268.rkey
	INNER JOIN Data0073 d73 ON d73.RKEY = d368.user_ptr
WHERE datediff(month,d268.DATE,GETDATE())<5 and d268.status in (1,2)
GO
/****** Object:  View [dbo].[v_onoffduty_report_20151204]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE        VIEW [dbo].[v_onoffduty_report_20151204]  
 AS  
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
  
case when isnull(resttype,0)=1  then round((isnull(rot,0)+isnull(rwt,0)),2) else 0 end   
 as work4,--周六日加班（绿色加班）  
  
case when isnull(resttype,0)=3 then round((isnull(rot,0)+isnull(rwt,0)),2) else 0 end    
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
    
as orginal_workday,--原出勤天  
  
  
  
  
case when   isnull(resttype,0)=1     and isnull(rwt,0)>7.0 then 1   
else (case when isnull(resttype,0)=1 and isnull(rwt,0)>=3.5 then 0.5 else 0 end )  
end    
as week_workday,--标识周末出勤天  
  
  
case when isnull(resttype,0)=3 then 1.0   
  else 0 end  
as festival ,--法定假天(天蓝色)  
  
  
  
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
left join v_employeemsg b on a.employeeid=b.rkey   
left join class c on a.classid=c.rkey   
left join salaryaccount d on d.rkey=a.editmode   
  
order by employeecode,checkdate   
  
---select  top 1* from  dbo.v_employeemsg  
---select top 1 * from onoffdutydata  
---select top 1 * from class  
--- select  * from dbo.AskForLeave  
/*,,  
select departmentname,employeecode,chinesename,  
round(sum(work1),2) as 正班工时,  
round(sum(work3),2) as 加班工时,  
round(sum(work4),2) as 周末加班,  
round(sum(restday),2) as 调休天数,  
round(sum(qj),2) as 请假  
 from dbo.v_onoffduty_report  
where checkdate between '2012-04-1' and '2012-04-30'  
group by departmentname,employeecode,chinesename  
  
select * from dbo.v_onoffduty_report  
where checkdate between '2012-10-1' and '2012-11-30'  
and employeecode='81670'  
and employeecode='22417'  
order by employeecode  
select round(479/10.00,0)*10  
  
select round(478/10.00,0)*10  
  
select top 100 * from dbo.OriginalCheckData  
  
where date_e='2012-04-16'  
select * from resttypemsg  
select * from class  
  
 **/
GO
/****** Object:  View [dbo].[v_onoffduty_report]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE         VIEW [dbo].[v_onoffduty_report]  
 AS  
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
  
case when isnull(resttype,0)=0  then round(isnull(rot,0),2) else 0 end   
 as work3,--平时加班（灰色加班）  
  
  case   when isnull(resttype,0)=1   and owtflag=1 and isnull(nrwt,0)>0  then round(isnull(rwt,0)-4,2)  
        when isnull(resttype,0)=1   and owtflag=1     then      round((isnull(rot,0)+isnull(rwt,0)),2)    --- else 0 end   
 else  0 end  as work4,--周六日加班（绿色加班）    
   
case    when isnull(resttype,0)=1   and owtflag=0   then round((isnull(rot,0)+isnull(rwt,0)),2)  
        when isnull(resttype,0)=1   and owtflag=1  and isnull(nrwt,0)>0    then      round(isnull(rot,0)+isnull(nrwt,0),2)    --- else 0 end   
else  0 end  as work44,--周六日没有申请的加班    
  
  
  case   when isnull(resttype,0)=3   and owtflag=1 and isnull(nrwt,0)>0  then round(isnull(rwt,0)-4,2)  
        when isnull(resttype,0)=3   and owtflag=1     then      round((isnull(rot,0)+isnull(rwt,0)),2)    --- else 0 end   
 else  0 end  as work10,--节假加班（绿色加班）  

case    when isnull(resttype,0)=3   and owtflag=0   then round((isnull(rot,0)+isnull(rwt,0)),2)  
        when isnull(resttype,0)=3   and owtflag=1  and isnull(nrwt,0)>0    then      round(isnull(rot,0)+isnull(nrwt,0),2)    --- else 0 end   
else  0 end  as work40,--节假没有申请的加班   


  
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
    
as orginal_workday,--原出勤天  
  
  
  
  
case when   isnull(resttype,0)=1     and isnull(rwt,0)>7.0 then 1   
else (case when isnull(resttype,0)=1 and isnull(rwt,0)>=3.5 then 0.5 else 0 end )  
end    
as week_workday,--标识周末出勤天  
  
  
case when isnull(resttype,0)=3 then 1.0   
  else 0 end  
as festival ,--法定假天(天蓝色)  
  
  
  
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
left join v_employeemsg b on a.employeeid=b.rkey   
left join class c on a.classid=c.rkey   
left join salaryaccount d on d.rkey=a.editmode   
  
order by employeecode,checkdate
GO
/****** Object:  View [dbo].[V_0837]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_0837]
as 
SELECT TOP (100) PERCENT 
Case when datepart(HH,BeginTime)>=8 then dbo.Data0837.WorkDate 
else DateAdd(day,-1,dbo.Data0837.WorkDate) end as WorkDate, 
dbo.Data0837.WorkTime, dbo.Data0005.EMPLOYEE_NAME
FROM  dbo.Data0837 INNER JOIN
        dbo.Data0005 ON dbo.Data0837.Empl_ptr = dbo.Data0005.RKEY
ORDER BY dbo.Data0005.EMPLOYEE_NAME, dbo.Data0837.WorkDate
GO
/****** Object:  View [dbo].[v_data0070_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--采购单view,用途: 1.微信审批列表,2.
CREATE view [dbo].[v_data0070_check]
as
SELECT data0070.RKEY,data0070.PO_NUMBER,data0070.STATUS,data0070.SHIPPING_METHOD,
		data0070.PO_DATE,data0070.SUB_TOTAL,data0070.PO_TYPE,data0070.STATE_INVT_TAX_FLAG,
       data0023.abbr_name,
       data0024.FACTORY_LOCATION,data0078.auth_flag,
       data0015.warehouse_code,data0015.warehouse_name,data0015.ABBR_NAME as 工厂简称,
       data0001.curr_code,data0001.curr_name,
       data0005.empl_code,data0005.employee_name,
       data0078.auth_date,data0078.ranking,data0078.user_ptr,
       data0073.rpl_po_ptr,data0073.USER_LOGIN_NAME,data0078.rkey as rkey78
FROM DATA0070,data0023,data0024,data0015,data0001,data0005,data0078,data0073
where data0070.supplier_pointer=data0023.rkey and
      data0070.supp_fac_add_ptr=data0024.rkey and
      data0070.warehouse_pointer=data0015.rkey and
      data0070.employee_pointer=data0005.rkey and
      data0070.currency_ptr=data0001.rkey and
      data0078.po_ptr=data0070.rkey and
      --data0070.status=1 and (data0078.auth_date is null) and
      data0078.user_ptr = data0073.RKEY
      and (data0070.STATUS in (1,5))
GO
/****** Object:  View [dbo].[库存指派直接出仓变动]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[库存指派直接出仓变动]
AS
SELECT dbo.Data0053.RKEY AS rkey53, dbo.Data0050.CUSTOMER_PART_NUMBER, 
      dbo.Data0050.CP_REV, dbo.Data0053.RMA_PTR, 
      dbo.Data0053.QUANTITY AS 入仓数据, dbo.Data0053.QTY_ON_HAND AS 当前库存, 
      SUM(dbo.Data0052.QUAN_SHP) AS 指派汇总, SUM(dbo.Data0465.QUANTITY) 
      AS 直接出仓
FROM dbo.Data0053 INNER JOIN
      dbo.Data0050 ON 
      dbo.Data0053.CUST_PART_PTR = dbo.Data0050.RKEY LEFT OUTER JOIN
      dbo.Data0465 ON 
      dbo.Data0053.RKEY = dbo.Data0465.D0053_PTR LEFT OUTER JOIN
      dbo.Data0052 ON dbo.Data0053.RKEY = dbo.Data0052.DATA0053_PTR
WHERE (dbo.Data0053.QTY_ON_HAND > 0)
GROUP BY dbo.Data0050.CUSTOMER_PART_NUMBER, dbo.Data0050.CP_REV, 
      dbo.Data0053.QUANTITY, dbo.Data0053.QTY_ON_HAND, dbo.Data0053.RKEY, 
      dbo.Data0053.RMA_PTR
GO
/****** Object:  View [dbo].[异常指派数据]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[异常指派数据]
AS
SELECT TOP 100 PERCENT dbo.Data0064.RKEY, dbo.Data0060.SALES_ORDER, 
      dbo.Data0064.DATE_ASSIGN, dbo.Data0064.QUAN_SHIPPED AS 装运数, 
      dbo.Data0064.ovsh_qty AS 溢装数, SUM(dbo.Data0052.QUAN_SHP) AS 出仓数
FROM dbo.Data0064 INNER JOIN
      dbo.Data0052 ON dbo.Data0064.RKEY = dbo.Data0052.SO_SHP_PTR INNER JOIN
      dbo.Data0060 ON dbo.Data0064.SO_PTR = dbo.Data0060.RKEY
GROUP BY dbo.Data0064.DATE_ASSIGN, dbo.Data0064.RKEY, dbo.Data0064.ovsh_qty, 
      dbo.Data0064.QUAN_SHIPPED, dbo.Data0060.SALES_ORDER
HAVING (dbo.Data0064.QUAN_SHIPPED + dbo.Data0064.ovsh_qty <> SUM(dbo.Data0052.QUAN_SHP))
ORDER BY dbo.Data0064.DATE_ASSIGN DESC
GO
/****** Object:  View [dbo].[v_data0697_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--合同审批文件veiw,用途: 1.微信审批列表,2.
CREATE view [dbo].[v_data0697_check]
as
select a.rkey,contract_rkey,file_name,flag,submit_person,
b.employee_name as submit_person_name,
submit_date,modify_person,
c.employee_name as modify_person_name,
modify_date
 from dbo.data0697 a 
left join data0005 b on a.submit_person=b.rkey
left join data0005 c on a.modify_person=c.rkey
GO
/****** Object:  View [dbo].[V_DeptDayProduce]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_DeptDayProduce]
as 
select d.RKEY AS d34_ptr,
	   d.DEPT_CODE,
	   d.DEPT_NAME,
	   d.PPC_LAST_LOT, 
	   ROUND(SUM(b.panel_ln * b.panel_wd / 1000000 / b.PARTS_PER_PANEL * a.QTY_PROD),2) AS hbbmj,
	   ROUND(SUM(c.unit_sq * a.QTY_PROD), 2) AS bhbbmj,
	   CASE WHEN DATEDIFF(hh,CONVERT(datetime, CONVERT(nvarchar(11), a.OUTTIME, 120) + '08:00:00', 120), a.OUTTIME) < 0 
		    THEN CONVERT(datetime, CONVERT(nvarchar(11), dateadd(dd, - 1, a.OUTTIME), 120), 120) 
			ELSE CONVERT(datetime, CONVERT(nvarchar(11), a.OUTTIME, 120), 120) 
		END AS day

from  dbo.Data0048 as a,
	  dbo.Data0006 as b,
	  dbo.Data0025 as c,
	  dbo.Data0034 as d
where a.OUTTIME >= CONVERT(DATETIME, '2012-03-1 08:00:00', 120) and
	  a.OUTTIME <= CONVERT(DATETIME, CONVERT(nvarchar(11), GETDATE(), 120) + '08:00:00', 120) and
	  a.WTYPE = 0 and
	  a.WO_PTR = b.RKEY and
	  b.BOM_PTR =c.RKEY and
	  a.FM_DEPT_PTR = d.RKEY
group by 
	   CASE WHEN DATEDIFF(hh, CONVERT(datetime, CONVERT(nvarchar(11), a.OUTTIME, 120) + '08:00:00', 120), a.OUTTIME) < 0 
			THEN CONVERT(datetime, CONVERT(nvarchar(11), dateadd(dd, - 1, a.OUTTIME), 120), 120) 
            ELSE CONVERT(datetime, CONVERT(nvarchar(11), a.OUTTIME, 120), 120) 
			END,
			d.PPC_LAST_LOT, 
            d.RKEY,
			d.DEPT_CODE,
			d.DEPT_NAME
GO
/****** Object:  View [dbo].[ppp]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ppp]
as
select Data0006.RKEY as rkey06,Data0023.ABBR_NAME,Data0034.dept_name  from wzdata305
inner join WZDATA300 on WZDATA305.EPIBOLY_PTR=WZDATA300.rkey
inner join Data0006 on Data0006.RKEY=WZDATA305.wo_ptr
inner join Data0023 on Data0023.RKEY=WZDATA300.supp_ptr
inner join Data0034 on Data0034.rkey=wzdata300.dept_ptr
GO
/****** Object:  View [dbo].[flowtime]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[flowtime]
AS
SELECT     TOP (100) PERCENT a.SOURCE_PTR, a.STEP_NUMBER, b.TType, SUM(b.DataValues) AS DataValues
FROM         (SELECT     dbo.Data0038.SOURCE_PTR, dbo.Data0038.STEP_NUMBER, dbo.Data0586.DataValues
                       FROM          dbo.Data0038 INNER JOIN
                                              dbo.Data0586 ON dbo.Data0038.DEPT_PTR = dbo.Data0586.RKey34
                       WHERE      (dbo.Data0038.SOURCE_PTR IN
                                                  (SELECT DISTINCT BOM_PTR
                                                    FROM          dbo.Data0006 AS d62
                                                    WHERE      (CUT_NO IN
                                                                               (SELECT     D61.CUT_NO
                                                                                 FROM          dbo.Data0056 AS D561 INNER JOIN
                                                                                                        dbo.Data0006 AS D61 ON D561.WO_PTR = D61.RKEY))))) AS a INNER JOIN
                          (SELECT     Data0038_1.SOURCE_PTR, Data0038_1.STEP_NUMBER, Data0586_1.DataValues, Data0586_1.TType
                            FROM          dbo.Data0038 AS Data0038_1 INNER JOIN
                                                   dbo.Data0586 AS Data0586_1 ON Data0038_1.DEPT_PTR = Data0586_1.RKey34
                            WHERE      (Data0038_1.SOURCE_PTR IN
                                                       (SELECT DISTINCT BOM_PTR
                                                         FROM          dbo.Data0006 AS d62
                                                         WHERE      (CUT_NO IN
                                                                                    (SELECT     D61.CUT_NO
                                                                                      FROM          dbo.Data0056 AS D561 INNER JOIN
                                                                                                             dbo.Data0006 AS D61 ON D561.WO_PTR = D61.RKEY))))) AS b ON a.SOURCE_PTR = b.SOURCE_PTR AND a.STEP_NUMBER <= b.STEP_NUMBER
GROUP BY a.SOURCE_PTR, a.STEP_NUMBER, b.TType
ORDER BY a.SOURCE_PTR, a.STEP_NUMBER
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[22] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 108
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 123
               Right = 428
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2880
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'flowtime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'flowtime'
GO
/****** Object:  View [dbo].[钻板情况统计]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[钻板情况统计]
AS
SELECT     GETDATE() AS 本数据生成时间, a.ID码总分配数, a.总已钻数量, a.[总占比%], b.总采集数量, c.过去一天的ID码分配数, c.过去一天的已钻数量, c.[当日钻板占比%], d.过去一天采集数量
FROM         (SELECT     total AS ID码总分配数, zed AS 总已钻数量, CAST(zed * 100.0 / total AS decimal(6, 3)) AS [总占比%]
                       FROM          (SELECT     COUNT(*) AS total, SUM(CASE WHEN z_status = 1 THEN 0 + 1 ELSE 0 END) AS zed
                                               FROM          dbo.Y1407) AS t1) AS a CROSS JOIN
                          (SELECT     COUNT(*) AS 总采集数量
                            FROM          dbo.Y1408) AS b CROSS JOIN
                          (SELECT     total AS 过去一天的ID码分配数, zed AS 过去一天的已钻数量, CAST(zed * 100.0 / total AS decimal(6, 3)) AS [当日钻板占比%]
                            FROM          (SELECT     COUNT(*) AS total, SUM(CASE WHEN z_status = 1 THEN 0 + 1 ELSE 0 END) AS zed
                                                    FROM          dbo.Y1407 AS Y1407_1 INNER JOIN
                                                                           dbo.Y1406 ON dbo.Y1406.rkey = Y1407_1.Y1406_RKEY
                                                    WHERE      (dbo.Y1406.ENT_DATETIME BETWEEN CONVERT(VARCHAR, GETDATE() - 1, 23) + ' 08:00:00' AND CONVERT(VARCHAR, GETDATE(), 23) + ' 08:00:00')) AS t1_1) 
                      AS c CROSS JOIN
                          (SELECT     COUNT(*) AS 过去一天采集数量
                            FROM          dbo.Y1408 AS tb
                            WHERE      (T_DATE BETWEEN CONVERT(VARCHAR, GETDATE() - 1, 23) + ' 08:00:00' AND CONVERT(VARCHAR, GETDATE(), 23) + ' 08:00:00')) AS d
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[37] 2[3] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 108
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 78
               Right = 385
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 423
               Bottom = 108
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 669
               Bottom = 78
               Right = 854
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'钻板情况统计'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'钻板情况统计'
GO
/****** Object:  View [dbo].[v_data0068_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--请购单view,用途: 1.微信审批列表,2.
CREATE view [dbo].[v_data0068_check]
as
SELECT data0068.RKEY,data0068.PO_REQ_NUMBER,data0068.STATUS,data0068.REQ_DATE,
      data0068.DEPARTMENT_NAME,data0068.flag,data0068.ENT_DATE,data0068.EDITED_DATE,
      data0068.user_name,data0068.user_phone,
      data0005.empl_code,data0005.employee_name,
      data0015.abbr_name,data0015.warehouse_code,
      data0094.code code94,data0094.PURCHASE_APPROV_DESC ,
      data0362.code code362,data0362.DESCRIPTION,
      data0276.auth_date authdate276,data0276.ranking,data0276.user_ptr authUser_ptr,
      dbo.data0276.auth_flag,data0276.rkey rkey276,Data0073.USER_FULL_NAME,
      data0073.rpl_pr_ptr,Data0073.USER_LOGIN_NAME
from data0068 inner join  data0005 on data0068.req_by=data0005.rkey inner join
                        data0015 on data0068.WHSE_PTR=data0015.rkey inner join
                        data0094 on  data0068.auth_type=data0094.rkey inner join 
                        data0362 on data0068.budget_ptr=data0362.rkey INNER JOIN    
                        data0276 ON Data0068.RKEY = dbo.data0276.purchase_ptr INNER JOIN
                        Data0073 ON data0276.user_ptr = dbo.Data0073.RKEY
where (Data0068.STATUS in (1,3))
GO
/****** Object:  View [dbo].[part_number]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[part_number]
AS
SELECT     dbo.Data0025.RKEY, dbo.Data0025.MANU_PART_NUMBER, dbo.Data0025.MANU_PART_DESC, dbo.Data0010.CUST_CODE, dbo.Data0010.ABBR_NAME, 
                      dbo.Data0008.PROD_CODE, dbo.Data0008.PRODUCT_NAME, Data0005_3.EMPLOYEE_NAME AS employee_createname, dbo.Data0025.CUSTPART_ENT_DATE, 
                      dbo.Data0025.PROD_ROUTE_PTR, Data0005_1.EMPLOYEE_NAME AS employee_auditname, dbo.Data0025.AUDITED_DATE, dbo.Data0025.TSTATUS, 
                      Data0005_2.EMPLOYEE_NAME AS employee_editname, dbo.Data0025.LAST_MODIFIED_DATE, dbo.Data0025.SAMPLE_NR, dbo.Data0025.ANALYSIS_CODE_2, 
                      dbo.Data0025.QTY_ON_HAND, dbo.Data0025.LAYERS, dbo.Data0025.green_flag, 
                      CASE Data0025.ONHOLD_SALES_FLAG WHEN 0 THEN '有效' WHEN 1 THEN '过期' END AS overdue, 
                      CASE Data0025.TSTATUS WHEN 0 THEN '待制作' WHEN 1 THEN '已审核' WHEN 2 THEN '审退回' WHEN 3 THEN '待检查' WHEN 4 THEN '待审核' WHEN 5 THEN '检退回'
                       WHEN 6 THEN '未提交' END AS state, CASE Data0025.ttype WHEN 0 THEN '量产' WHEN 1 THEN '样板' END AS batch_or_former, dbo.Data0025.set_lngth, 
                      dbo.Data0025.set_width, dbo.Data0025.set_qty, dbo.Data0025.ANALYSIS_CODE_1
FROM         dbo.Data0008 INNER JOIN
                      dbo.Data0025 ON dbo.Data0008.RKEY = dbo.Data0025.PROD_CODE_PTR INNER JOIN
                      dbo.Data0010 ON dbo.Data0025.CUSTOMER_PTR = dbo.Data0010.RKEY LEFT OUTER JOIN
                      dbo.Data0005 AS Data0005_2 ON dbo.Data0025.LAST_MODIFIED_BY_PTR = Data0005_2.RKEY LEFT OUTER JOIN
                      dbo.Data0005 AS Data0005_1 ON dbo.Data0025.AUDITED_BY_PTR = Data0005_1.RKEY LEFT OUTER JOIN
                      dbo.Data0005 AS Data0005_3 ON dbo.Data0025.CREATED_BY_EMPL_PTR = Data0005_3.RKEY
WHERE     (dbo.Data0025.PARENT_PTR IS NULL)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0008"
            Begin Extent = 
               Top = 37
               Left = 395
               Bottom = 156
               Right = 609
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Data0025"
            Begin Extent = 
               Top = 99
               Left = 13
               Bottom = 332
               Right = 231
            End
            DisplayFlags = 344
            TopColumn = 54
         End
         Begin Table = "Data0010"
            Begin Extent = 
               Top = 0
               Left = 394
               Bottom = 119
               Right = 612
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Data0005_2"
            Begin Extent = 
               Top = 95
               Left = 456
               Bottom = 214
               Right = 631
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Data0005_1"
            Begin Extent = 
               Top = 180
               Left = 449
               Bottom = 299
               Right = 624
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Data0005_3"
            Begin Extent = 
               Top = 140
               Left = 451
               Bottom = 259
               Right = 626
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 27
         Width = 284
         Width = 1335
         Width' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'part_number'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1140
         Width = 1110
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'part_number'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'part_number'
GO
/****** Object:  View [dbo].[V_0842_0848]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_0842_0848]
as 
select TOP (100) PERCENT 
Case when ((datepart(HH,data0842.BeginTime)<8)and(datepart(HH,data0842.EndTime)>=8)and (data0842.DayShift=2))
or((datepart(HH,data0842.BeginTime)<8)and(datepart(HH,data0842.EndTime)<8)) 
then DateAdd(day,-1,dbo.data0842.WorkDate)else dbo.data0842.WorkDate  end as WorkDate, 
data0842.WorkTime,data0005.EMPLOYEE_NAME ,data0567.WHOUSE_PTR
from data0842 join data0005 on data0842.Empl_ptr=data0005.rkey
join data0567 on data0567.rkey=data0842.Work_ptr
join data0855 on data0842.Empl_ptr=data0855.D005_ptr
join data0840 on data0855.d840_ptr=data0840.rkey and data0840.OutsPrep=0 and data0840.active=1
order by data0855.d840_ptr,data0855.D005_ptr, data0842.WorkDate
union all
select TOP (100) PERCENT 
Case when ((datepart(HH,data0848.BeginTime)<8)and(datepart(HH,data0848.EndTime)>=8)and (data0848.DayShift=2))
or((datepart(HH,data0848.BeginTime)<8)and(datepart(HH,data0848.EndTime)<8)) 
then DateAdd(day,-1,dbo.data0848.WorkDate)else dbo.data0848.WorkDate  end as WorkDate, 
data0848.WorkTime,data0005.EMPLOYEE_NAME ,data0417.warehouse_ptr
from data0848 join data0005 on data0848.Empl_ptr=data0005.rkey
join data0831 on data0831.rkey=data0848.Work_ptr
join data0417 on data0831.DeviNumb=data0417.FASSET_CODE
join data0855 on data0848.Empl_ptr=data0855.D005_ptr
join data0840 on data0855.d840_ptr=data0840.rkey and data0840.OutsPrep=0 and data0840.active=1
order by data0855.d840_ptr, data0855.D005_ptr,data0848.WorkDate
GO
/****** Object:  View [dbo].[v_data0693_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--合同审批信息,用途: 1.微信审批列表,2.
CREATE view [dbo].[v_data0693_check]
as
select a.rkey,a.d696_ptr,d34_index,d34_ptr,check_person,check_status,
check_time,check_suggestion,b.employee_name,c.dept_name ,
case when isnull(check_status,0)=0 and isnull(check_person,0)=0 then '未审核' 
        when isnull(check_status,0)=0 and isnull(check_person,0)<>0 then '待重审'
       when isnull(check_status,0)=1  then '已审核' else '未知' end as [状态]
from data0693 a left join data0005 b on a.check_person=b.rkey
 left join data0034 c on a.d34_ptr=c.rkey
GO
/****** Object:  View [dbo].[v_data0696_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--合同审批veiw,用途: 1.微信审批列表,2.
--合同审批权限(权限为4)
CREATE view [dbo].[v_data0696_check]
as
select a.rkey,isnull(a.submit_person,0) as submit_person,
isnull(a.submit_department,0) as submit_department,
isnull(a.check_status,0) as check_status,
isnull(a.circle,0) as circle,
a.check_type,
row_number() over(order by a.rkey ) as 序号,
a.contract_number as 合同编号,
a.contract_name as 合同名称,
a.part_A_name_ch as [甲方（客户）名称],
a.part_A_name_en as [甲方（客户）名称en],
a.submit_date  as 提交日期,
(select dept_name from data0034 where rkey=a.submit_department) as  送审人部门 ,
isnull((select employee_name from data0005 where rkey=a.submit_person),'') as 送审人,
isnull((select employee_name from data0005 where rkey=a.Audit_Prt),'') as 部门审核人,
a.Audit_Date as 部门审核时间,a.submit_suggestion as 送审人意见,
case when ( a.check_status=0  and a.circle=1 ) then'未提交'
         when  ( a.check_status=0  and a.circle>1 ) then '待重提交'
         when   a.check_status=1 then '待审核'
         when  a.check_status=2 then  '全部通过审核' 
         when a.check_status=5 then '待允许联审' end as 状态,
a.submit_suggestion,a.remark, a.party_a,d.employee_ptr as user_ptr,b.d34_ptr,b.d34_index,
b.rkey as d0693_rkey,depchk_status=case when b.check_status=0 then 'Y' else 'N' end,
(select top 1 d34_ptr from data0693 where d696_ptr=a.rkey order by d34_index desc) as d34last_ptr,
b.check_person,d.USER_LOGIN_NAME,b.check_suggestion,g.dept_name
from  data0696 a,data0693 b,data0005 c,Data0073 d,Data0074 e,Data0419 f,Data0034 g
where a.rkey=b.d696_ptr and b.d34_ptr=c.EMPLOYEE_ID and c.RKEY=d.EMPLOYEE_PTR
	and a.check_status not in(-1,0,5) and DATEDIFF(month,submit_date,GETDATE())<=2
	and e.FUNCTION_ID=f.RKEY and f.PROGRAME='contract_control.exe'
	and d.RKEY=e.USER_PTR and e.USER_RIGHTS=4
	and b.d34_ptr=g.RKEY
GO
/****** Object:  View [dbo].[ERP权限]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ERP权限]
AS
SELECT     TOP (100) PERCENT dbo.Data0073.USER_FULL_NAME AS 用户名, dbo.Data0073.USER_LOGIN_NAME AS 登录名, 
                      dbo.SYSTEM_MAIN.DESCRIPTION AS 主模块, dbo.SYSTEM_MENU.DESCRIPTION AS 分模块, dbo.Data0419.DESCRIPTION AS 程序, 
                      dbo.Data0419.RKEY, dbo.Data0074.USER_RIGHTS AS 权限值
FROM         dbo.SYSTEM_MENU INNER JOIN
                      dbo.SYSTEM_MAIN ON dbo.SYSTEM_MENU.MAIN_PTR = dbo.SYSTEM_MAIN.RKEY INNER JOIN
                      dbo.Data0419 ON dbo.SYSTEM_MENU.RKEY = dbo.Data0419.manu_ptr INNER JOIN
                      dbo.Data0074 ON dbo.Data0419.RKEY = dbo.Data0074.FUNCTION_ID INNER JOIN
                      dbo.Data0073 ON dbo.Data0074.USER_PTR = dbo.Data0073.RKEY
ORDER BY 用户名, dbo.SYSTEM_MAIN.seq_no, dbo.SYSTEM_MENU.seq_no, dbo.Data0419.SEQ_NO
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SYSTEM_MENU"
            Begin Extent = 
               Top = 7
               Left = 191
               Bottom = 115
               Right = 339
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "SYSTEM_MAIN"
            Begin Extent = 
               Top = 13
               Left = 5
               Bottom = 121
               Right = 153
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0419"
            Begin Extent = 
               Top = 6
               Left = 410
               Bottom = 114
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0074"
            Begin Extent = 
               Top = 6
               Left = 596
               Bottom = 114
               Right = 745
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Data0073"
            Begin Extent = 
               Top = 132
               Left = 580
               Bottom = 240
               Right = 758
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ERP权限'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ERP权限'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ERP权限'
GO
/****** Object:  View [dbo].[v_data0597_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--品质索赔申请评审view,用途: 1.微信审批列表,2.
CREATE view [dbo].[v_data0597_check]
as
SELECT     dbo.data0597.status AS ststusr, dbo.data0597.rkey, dbo.data0597.spNumber, dbo.Data0010.ABBR_NAME, dbo.Data0073.USER_FULL_NAME, 
                      dbo.Data0001.CURR_NAME, dbo.data0597.v_ttype, dbo.data0597.Number, dbo.data0597.spmoney, dbo.Data0015.ABBR_NAME AS ABBR_NAME_1, 
                      dbo.Data0005.EMPLOYEE_NAME AS yw05, dbo.data0597.EntryTime, CASE dbo.data0597.Debit WHEN 0 THEN '否' WHEN 1 THEN '是' ELSE '其它' END AS debita, 
                      dbo.data0597.Remarks, 
                      CASE dbo.data0597.status WHEN 1 THEN '未提交' WHEN 2 THEN '评审中' WHEN 3 THEN '已评审' WHEN 4 THEN '退回' ELSE '其它' END AS v_status, 
                      dbo.data0597.submit_date, dbo.data0597.ywexplain, dbo.data0597.rkey73, dbo.data0599.status, dbo.data0599.rkey73 as d599_rkey73, dbo.data0599.seq_no,
                      CASE dbo.data0599.mark WHEN 1 THEN 'Y' ELSE 'N' END AS auth_flag,dbo.data0599.auth_date,d73_1.USER_LOGIN_NAME
FROM         dbo.Data0073 INNER JOIN
                      dbo.data0597 INNER JOIN
                      dbo.Data0010 ON dbo.data0597.rkey10 = dbo.Data0010.RKEY ON dbo.Data0073.RKEY = dbo.data0597.rkey73 INNER JOIN
                      dbo.Data0001 ON dbo.data0597.rkey01 = dbo.Data0001.RKEY INNER JOIN
                      dbo.Data0015 ON dbo.data0597.rkey15 = dbo.Data0015.RKEY INNER JOIN
                      dbo.Data0005 ON dbo.data0597.Salesman = dbo.Data0005.RKEY INNER JOIN
                      dbo.data0599 ON dbo.data0597.rkey = dbo.data0599.rkey597 inner join
                      dbo.Data0073 d73_1 on d73_1.RKEY=dbo.data0599.rkey73
--微信审批只显示未审及一个月内已审的单据
--暂时只显示未全部审完的单据(PS:此情况最后审核人无法取消审批)
where dbo.data0597.status=2 --or (dbo.data0597.status=3 and datediff(month,dbo.data0597.submit_date,GETDATE())<2)
GO
/****** Object:  View [dbo].[v_employee_salarychangetimes]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_employee_salarychangetimes] 
as 
select employeeid,count(employeeid) as salarychangetimes
 from dbo.basicsalary_Alteration a 
join employeemsg b on a.employeeid=b.rkey
where datafield='F2'
and effect_date>b.ondutytime
group by employeeid
GO
/****** Object:  View [dbo].[固定资产原值修改]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[固定资产原值修改]
AS
SELECT dbo.Data0517.FASSET_CODE, dbo.Data0517.FASSET_NAME, 
      dbo.data0325.orig_curr_orig_value, dbo.data0325.curr_ptr, dbo.data0325.ex_rate, 
      dbo.data0325.d327_ptr, dbo.Data0517.FASSET_DESC
FROM dbo.data0325 INNER JOIN
      dbo.Data0517 ON dbo.data0325.fasset_ptr = dbo.Data0517.RKEY
WHERE (dbo.Data0517.FASSET_CODE = 'FA00000635')
GO
/****** Object:  View [dbo].[v_employee_workage_detail]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_employee_workage_detail] 
as
select rkey, 
  (datediff(month,ondutytime,getdate())-
case when day(ondutytime)>day(getdate()) then 1 else 0 end)/12
as 年,
  (datediff(month,ondutytime,getdate())-
case when day(ondutytime)>day(getdate()) then 1 else 0 end)%12
as 月,
case when 
dateadd(month,datediff(month,ondutytime,getdate()),ondutytime)>getdate()  
then day(getdate())+   
 (datediff(day,ondutytime, dateadd(month,1,convert(datetime,(substring(convert (nvarchar(20),ondutytime,120),1,7)+'-01'),120) ) )-1)
else day(getdate())-day(ondutytime) end as 天
,ondutytime,
  cast ( 
((datediff(month,ondutytime,getdate())-
case when day(ondutytime)>day(getdate()) then 1 else 0 end)/12)
as nvarchar(10))+'年'+
cast(
 ( (datediff(month,ondutytime,getdate())-
case when day(ondutytime)>day(getdate()) then 1 else 0 end)%12)
as nvarchar(10))+'月'+
cast(
(case when 
dateadd(month,datediff(month,ondutytime,getdate()),ondutytime)>getdate()  
then day(getdate())+   
 (datediff(day,ondutytime, dateadd(month,1,convert(datetime,(substring(convert (nvarchar(20),ondutytime,120),1,7)+'-01'),120) ) )-1)
else day(getdate())-day(ondutytime) end)
 as nvarchar(10))+'天' as workagestr
 from employeemsg
GO
/****** Object:  View [dbo].[V_employee_yearholiday]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE
 VIEW  [dbo].[V_employee_yearholiday] 
AS 
/*select 1  as dd */

select b.departmentname,b.employeecode,b.chinesename,b.ondutytime,
a.qualified,a.year_s3,a.year_s1,a.shouldhav,a.h_used,(a.shouldhav-a.h_used)*a.qualified as h_left
from 
(
select t1.employeeid,t1.ondutytime,t1.Qualified,
cast((cast(t1.year_s1 as int)-1 ) as varchar(4)) as year_s3,
t1.year_s1,
case when ondutytime between cast ((cast(year_s1-1 as varchar(4))+'-01-01') as datetime) 
      and cast((cast(year_s1-1 as varchar(4))+'-12-31') as datetime )
      then  
round((datediff(day,ondutytime,cast((cast(year_s1-1 as varchar(4))+'-12-31') as datetime )) 
/365.00*5.00),0)
     when ondutytime <(cast (year_s1-1 as varchar(4))+'-01-01') then 5 
      else 0 end as shouldhav,
isnull(t2.h_used,0) as h_used
from 
(
select emp.rkey as employeeid,
     emp.ondutytime,
	 (case when dateadd(year,1,ondutytime)<=getdate() then 1 else 0 end ) as Qualified,
     year_s1
from employeemsg  as emp  
join (select distinct employeeid,year(checkdate) as year_s1 from onoffdutydata ) as onoff1
on emp.rkey=onoff1.employeeid 
where emp.outdutytime is null 
or (emp.outdutytime between dateadd(day,-30,getdate()) and getdate())
) as t1
outer apply 
(
select  employeeid,year(checkdate) as year_s2,
sum(case when sumlt between 200 and 300 then 0.5 
         when sumlt >400 then 1.0 else 0 end) 
as h_used
from onoffdutydata as onoff2
where (ln1=11 or ln2=11 or ln3=11 ) 
and ( employeeid=t1.employeeid and  year(checkdate)=t1.year_s1)
group by employeeid,year(checkdate)
)  as t2

) as  a
join 
v_employeemsg b on a.employeeid=b.rkey
GO
/****** Object:  View [dbo].[invt_returen]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[invt_returen]
AS
SELECT dbo.Data0096.INVT_PTR, SUM(dbo.Data0096.QUAN_REJD) AS quan_returen,
ROUND(SUM(dbo.Data0096.QUAN_REJD * dbo.Data0022.PRICE * dbo.Data0456.exch_rate),
3) AS amount_returen, dbo.Data0456.SUPP_PTR
FROM Data0096 INNER JOIN
dbo.Data0022 ON dbo.Data0096.INV_TRAN_PTR = dbo.Data0022.RKEY INNER JOIN
dbo.Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY
where (Data0096.FLAG = '2') and
(Data0096.tdate >= '2018-09-01') and
(Data0096.tdate <= '2018-11-23')
and data0456.warehouse_ptr=9
GROUP BY Data0096.INVT_PTR, dbo.Data0456.SUPP_PTR
GO
/****** Object:  View [dbo].[invt_scrap]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[invt_scrap]
AS
 SELECT dbo.Data0096.INVT_PTR, SUM(dbo.Data0096.QUAN_REJD) AS quan_scrap, 
ROUND(SUM(dbo.Data0096.QUAN_REJD * dbo.Data0022.PRICE * dbo.Data0456.exch_rate),
3) AS amount_csrap, dbo.Data0456.SUPP_PTR
FROM dbo.Data0096 INNER JOIN
dbo.Data0022 ON dbo.Data0096.INV_TRAN_PTR = dbo.Data0022.RKEY INNER JOIN
dbo.Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY
where (Data0096.FLAG = '1') and
(Data0096.tdate >= '2018-09-01') and
(Data0096.tdate <= '2018-11-23')
and data0456.warehouse_PTR=9
GROUP BY Data0096.INVT_PTR, dbo.Data0456.SUPP_PTR
GO
/****** Object:  View [dbo].[V_0842_0848备份20140307]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_0842_0848备份20140307]
as 
select  TOP (100) PERCENT 
        Case when ((datepart(HH,data0842.BeginTime)<8)and(datepart(HH,data0842.EndTime)>=8)and (data0842.DayShift=2))
                or((datepart(HH,data0842.BeginTime)<8)and(datepart(HH,data0842.EndTime)<8)) 
             then DateAdd(day,-1,dbo.data0842.WorkDate)else dbo.data0842.WorkDate  
        end as WorkDate, 
        data0842.WorkTime,data0005.EMPLOYEE_NAME ,data0567.WHOUSE_PTR
from    data0842 join data0005 on data0842.Empl_ptr=data0005.rkey
        join data0567 on data0567.rkey=data0842.Work_ptr
order by data0567.WHOUSE_PTR,data0005.EMPLOYEE_NAME, data0842.WorkDate
union all
select  TOP (100) PERCENT 
        Case    when ((datepart(HH,data0848.BeginTime)<8)and(datepart(HH,data0848.EndTime)>=8)and (data0848.DayShift=2))
                   or((datepart(HH,data0848.BeginTime)<8)and(datepart(HH,data0848.EndTime)<8)) 
                then DateAdd(day,-1,dbo.data0848.WorkDate)else dbo.data0848.WorkDate  
        end as WorkDate, 
        data0848.WorkTime,data0005.EMPLOYEE_NAME ,data0417.warehouse_ptr
from    data0848 join data0005 on data0848.Empl_ptr=data0005.rkey
        join data0831 on data0831.rkey=data0848.Work_ptr
        join data0417 on data0831.DeviNumb=data0417.FASSET_CODE
order by data0417.warehouse_ptr,data0005.EMPLOYEE_NAME, data0848.WorkDate
GO
/****** Object:  View [dbo].[stock_total]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[stock_total]
AS
SELECT TOP 100 PERCENT CUST_PART_PTR, SUM(QTY_ON_HAND)
AS quantity_hand
FROM dbo.Data0053
where  Data0053.mfg_date <= '2018-11-28'
and data0053.WHSE_PTR=1
GROUP BY CUST_PART_PTR
GO
/****** Object:  View [dbo].[内层分配的外层工单]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[内层分配的外层工单]
AS
SELECT dbo.Data0006.WORK_ORDER_NUMBER, dbo.Data0489.SOURCE_PTR, 
      Data0006_1.WORK_ORDER_NUMBER AS Expr1, dbo.Data0489.QTY
FROM dbo.Data0489 INNER JOIN
      dbo.Data0006 ON dbo.Data0489.WO_PTR = dbo.Data0006.RKEY INNER JOIN
      dbo.Data0006 Data0006_1 ON 
      dbo.Data0489.SOURCE_PTR = Data0006_1.RKEY
WHERE (dbo.Data0006.WORK_ORDER_NUMBER = 'B0015739-0-6-1')
GO
/****** Object:  View [dbo].[v_data0598_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--品质索赔申请评审view,用途: 1.微信审批列表,2.
create view [dbo].[v_data0598_check]
as
SELECT     data0598.rkey597,dbo.DATA0598.rec_no, dbo.Tier3_CustomerFiles.FileName, dbo.Data0005.EMPL_CODE, dbo.Data0005.EMPLOYEE_NAME, dbo.DATA0598.remark, 
                      dbo.Tier3_CustomerFiles.UploadTime, dbo.Tier3_CustomerFiles.Ftp_fileName, dbo.Tier3_CustomerFiles.IDKey, dbo.Tier3_CustomerFiles.Ftp_Ptr
FROM         dbo.DATA0598 INNER JOIN
                      dbo.Tier3_CustomerFiles ON dbo.DATA0598.FtpIDKey = dbo.Tier3_CustomerFiles.IDKey INNER JOIN
                      dbo.Data0005 ON dbo.Tier3_CustomerFiles.UploadUser_d05ptr = dbo.Data0005.RKEY
GO
/****** Object:  View [dbo].[v_data0599_check]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--品质索赔申请审批信息view,用途: 1.微信审批列表,2.
create view [dbo].[v_data0599_check]
as
SELECT     dbo.data0599.rkey597, dbo.data0599.PUTH_INFO, dbo.data0599.seq_no, 
	dbo.data0599.auth_date, dbo.Data0073.USER_FULL_NAME,
	case  dbo.data0599.status when 0 then '未审核' when 1 then '已审核'else '退回'  end as status1
FROM         dbo.data0599 LEFT OUTER JOIN
                      dbo.Data0073 ON dbo.data0599.rkey73 = dbo.Data0073.RKEY
GO
/****** Object:  View [dbo].[v_weixinCheck_auth]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_weixinCheck_auth]
as
select data0073.USER_LOGIN_NAME,PROGRAME=upper(replace(Data0419.PROGRAME,'.exe','')),
	data0074.USER_RIGHTS,data0073.RKEY
from data0073,data0074,Data0419 
where data0073.RKEY=data0074.USER_PTR
	and data0074.FUNCTION_ID=Data0419.RKEY
	--and ModID in(28,30,291,701,497,527,750) 看起来ModID不是关键字段
	and PROGRAME in('EP057.EXE','EP053.EXE','A_EP169.exe','BOMBaoJiaAuth.exe',
		'wzau268.exe','contract_control.exe','Pu597.exe','WZAU0491.exe')
GO
/****** Object:  View [dbo].[stock]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[stock]
AS
SELECT Data0022.INVENTORY_PTR, SUM(Data0022.QUAN_ON_HAND) AS stock,
ROUND(SUM(dbo.Data0022.QUAN_ON_HAND * dbo.Data0022.PRICE * dbo.Data0456.exch_rate),
3) AS amount, dbo.Data0456.SUPP_PTR
FROM Data0022 INNER JOIN
dbo.Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY
and data0456.warehouse_PTR=9
GROUP BY dbo.Data0022.INVENTORY_PTR, dbo.Data0456.SUPP_PTR
GO
/****** Object:  View [dbo].[成品盘点差异数据]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[成品盘点差异数据]
AS
SELECT dbo.Data0053.RKEY, SUM(dbo.Data0113.QUANTITY) AS 盘点差异
FROM dbo.Data0053 INNER JOIN
      dbo.Data0113 ON dbo.Data0053.RKEY = dbo.Data0113.DEST_PTR
WHERE (dbo.Data0113.TRAN_TYPE = 3)
GROUP BY dbo.Data0053.RKEY
GO
/****** Object:  View [dbo].[成品转移数据]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[成品转移数据]
AS
SELECT dbo.Data0053.RKEY, SUM(dbo.Data0113.QUANTITY) AS 转移数量
FROM dbo.Data0053 INNER JOIN
      dbo.Data0113 ON dbo.Data0053.RKEY = dbo.Data0113.SRCE_PTR
WHERE (dbo.Data0113.TRAN_TYPE = 2)
GROUP BY dbo.Data0053.RKEY
GO
/****** Object:  View [dbo].[vw_OADeptERP]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_OADeptERP]
AS
WITH CTEDG AS  --东莞五株
(
        SELECT rkey,departmentcode,departmentname,0 as lv,cast('01' as nvarchar(max)) as code,'DGWZ' AS FACTORY FROM dbo.datadepartment WHERE superior=0
        UNION all
    SELECT dept.rkey,dept.departmentcode,dept.departmentname,CTEDG.lv +1
                ,CTEDG.code + RIGHT('00'+ CAST(ROW_NUMBER() OVER(ORDER BY dept.departmentcode) AS NVARCHAR(8)),2)  as code ,'DGWZ' AS FACTORY
        FROM dbo.datadepartment AS dept INNER JOIN CTEDG ON dept.superior = CTEDG.rkey
        WHERE dept.invalid = 0
)
, CTESZ AS  ---深圳
(
        SELECT rkey,departmentcode,departmentname,0 as lv,cast('03' as nvarchar(max)) as code,'SZWZ' AS FACTORY FROM [172.16.0.8].sj_v20_live.dbo.datadepartment WHERE superior=0
        UNION all
    SELECT dept.rkey,dept.departmentcode,dept.departmentname,CTESZ.lv +1
                ,CTESZ.code + RIGHT('00'+ CAST(ROW_NUMBER() OVER(ORDER BY dept.departmentcode) AS NVARCHAR(8)),2)  as code ,'SZWZ' AS FACTORY
        FROM [172.16.0.8].sj_v20_live.dbo.datadepartment AS dept INNER JOIN CTESZ ON dept.superior = CTESZ.rkey
        WHERE dept.invalid = 0
)
, CTEMZ AS  --梅州一二厂
(
        SELECT rkey,departmentcode,departmentname,0 as lv,cast('02' as nvarchar(max)) as code,'MZZH' AS FACTORY FROM [172.17.0.187].wisdompcb.dbo.datadepartment WHERE superior=0
        UNION all
    SELECT dept.rkey,dept.departmentcode,dept.departmentname,CTEMZ.lv +1
                ,CTEMZ.code + RIGHT('00'+ CAST(ROW_NUMBER() OVER(ORDER BY dept.departmentcode) AS NVARCHAR(8)),2)   as code ,'MZZH' AS FACTORY
        FROM [172.17.0.187].wisdompcb.dbo.datadepartment AS dept INNER JOIN CTEMZ ON dept.superior = CTEMZ.rkey
        WHERE dept.invalid = 0
)
, CTEHY AS  --浩远
(
        SELECT rkey,departmentcode,departmentname,0 as lv,cast('06' as nvarchar(max)) as code,'DGHY' AS FACTORY FROM [172.18.9.9].wisdompcb_hy.dbo.datadepartment WHERE superior=0
        UNION all
    SELECT dept.rkey,dept.departmentcode,dept.departmentname,CTEHY.lv +1
                ,CTEHY.code + RIGHT('00'+ CAST(ROW_NUMBER() OVER(ORDER BY dept.departmentcode) AS NVARCHAR(8)),2) as code,'DGHY' AS FACTORY
        FROM [172.18.9.9].wisdompcb_hy.dbo.datadepartment AS dept INNER JOIN CTEHY ON dept.superior = CTEHY.rkey
        WHERE dept.invalid = 0
)
, CTEWLG AS  --威力固
(
        SELECT rkey,departmentcode,departmentname,0 as lv,cast('05' as nvarchar(max)) as code,'DGWLG' AS FACTORY FROM [172.18.12.2].wisdompcb_wlg.dbo.datadepartment WHERE superior=0
        UNION all
    SELECT dept.rkey,dept.departmentcode,dept.departmentname,CTEWLG.lv +1
                ,CTEWLG.code + RIGHT('00'+ CAST(ROW_NUMBER() OVER(ORDER BY dept.departmentcode) AS NVARCHAR(8)),2) as code,'DGWLG' AS FACTORY
        FROM [172.18.12.2].wisdompcb_wlg.dbo.datadepartment AS dept INNER JOIN CTEWLG ON dept.superior = CTEWLG.rkey
        WHERE dept.invalid = 0
)
, CTEHGC AS  --化工厂
(
        SELECT rkey,departmentcode,departmentname,0 as lv,cast('09' as nvarchar(max)) as code,'DGHGC' AS FACTORY FROM [172.18.9.10].wisdompcb_hgc.dbo.datadepartment WHERE superior=0
        UNION all
    SELECT dept.rkey,dept.departmentcode,dept.departmentname,CTEHGC.lv +1
                ,CTEHGC.code + RIGHT('00'+ CAST(ROW_NUMBER() OVER(ORDER BY dept.departmentcode) AS NVARCHAR(8)),2) as code,'DGHGC' AS FACTORY
        FROM [172.18.9.10].wisdompcb_hgc.dbo.datadepartment AS dept INNER JOIN CTEHGC ON dept.superior = CTEHGC.rkey
        WHERE dept.invalid = 0
)
, CTEJXZH AS  --江西志浩
(
        SELECT rkey,departmentcode,departmentname,0 as lv,cast('08' as nvarchar(max)) as code,'JXZH' AS FACTORY FROM [172.19.9.1].wisdompcb_jx.dbo.datadepartment WHERE superior=0
        UNION all
    SELECT dept.rkey,dept.departmentcode,dept.departmentname,CTEJXZH.lv +1
                ,CTEJXZH.code + RIGHT('00'+ CAST(ROW_NUMBER() OVER(ORDER BY dept.departmentcode) AS NVARCHAR(8)),2) as code,'JXZH' AS FACTORY
        FROM [172.19.9.1].wisdompcb_jx.dbo.datadepartment AS dept INNER JOIN CTEJXZH ON dept.superior = CTEJXZH.rkey
        WHERE dept.invalid = 0
)

SELECT ('03' + CAST(rkey as nvarchar(10))) as OArkey,* FROM CTESZ
UNION
SELECT ('01' + CAST(rkey as nvarchar(10))) as OArkey,* FROM CTEDG
UNION
SELECT ('02' + CAST(rkey as nvarchar(10))) as OArkey,* FROM CTEMZ
UNION
SELECT ('05' + CAST(rkey as nvarchar(10))) as OArkey,* FROM CTEWLG
UNION
SELECT ('06' + CAST(rkey as nvarchar(10))) as OArkey,* FROM CTEHY
UNION
SELECT ('09' + CAST(rkey as nvarchar(10))) as OArkey,* FROM CTEHGC
UNION
SELECT ('08' + CAST(rkey as nvarchar(10))) as OArkey,* FROM CTEJXZH
GO
/****** Object:  View [dbo].[V_bhmx_list]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[V_bhmx_list]
as
SELECT  D58.MRB_NO as 报废单号, dbo.Data0006.WORK_ORDER_NUMBER as 作业单号, dbo.Data0039.REJECT_DESCRIPTION as 缺陷名称, 
                      CASE dbo.Data0039.rej_type WHEN 0 THEN '工厂报废' WHEN 1 THEN '供应商报废' WHEN 2 THEN '客户报废' WHEN 3 THEN '市场报废' WHEN 4 THEN '其它' END AS
                       缺陷分类, D58.QTY_REJECT as 报废PCS,dbo.Data0025.SAMPLE_NR as 测试成型备注, D58.PANELS as 报废PNL,  dbo.Data0034.DEPT_NAME as 责任工序名称, dbo.Data0025.MANU_PART_NUMBER as 本厂编号, 
                       dbo.Data0008.PRODUCT_NAME as 类型名称,  dbo.Data0010.ABBR_NAME as 客户简称, dbo.Data0025.set_qty as 交货单元数, dbo.Data0025.ANALYSIS_CODE_1 as 交货尺寸,convert(decimal(18,10), dbo.Data0025.unit_sq) as 单只面积 ,convert(decimal(18,10), D58.QTY_REJECT * dbo.Data0025.unit_sq) AS 报废面积, 
                      CAST(D58.QTY_REJECT * dbo.Data0025.unit_sq / dbo.GetParentNum(dbo.Data0025.RKEY) AS decimal(30, 10)) AS '顶层报废面积', 
                      dbo.Data0034.cost_name as 成本中心名称, 
                     convert(decimal(18,10), CASE WHEN data0006.PARTS_PER_PANEL > 0 THEN D58.QTY_REJECT * data0006.panel_ln * data0006.panel_wd * 0.000001 / data0006.PARTS_PER_PANEL ELSE D58.QTY_REJECT
                       * dbo.Data0025.unit_sq END) AS  报率面积含板边, dbo.Data0060.ORIG_CUSTOMER as 关联原客户, Data0034_1.DEPT_NAME AS 申请工序名称,
                       CASE D58.TTYPE WHEN 0 THEN '生产报废' WHEN 1 THEN '盘点报废' END AS 报废类型, dbo.data0492.SO_NO as 销售订单, dbo.Data0097.PO_NUMBER as 客户订单号, 
                      dbo.Data0015.ABBR_NAME AS 工厂简称,  ISNULL(Data0034_2.DEPT_NAME, 
                      dbo.Data0034.DEPT_NAME) AS 责任班组部门名称, dbo.Data0025.CPJS as 产品阶数, dbo.Data0025.LAYERS as 层数 , dbo.data0492.ISSUED_QTY as 投产数量 , dbo.data0492.ORD_REQ_QTY as 待计数订单数, 
                      dbo.data0492.QTY_REJECT AS 报废数量,D58.TDATETIME AS 报废日期,convert(varchar,D58.TDATETIME,23) as 日期,convert(varchar(7),D58.TDATETIME,23) as 月份
FROM         dbo.Data0058 AS D58 INNER JOIN
                      dbo.Data0006 ON D58.WO_PTR = dbo.Data0006.RKEY INNER JOIN
                      dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO INNER JOIN
                      dbo.Data0039 ON D58.REJECT_PTR = dbo.Data0039.RKEY INNER JOIN
                      dbo.Data0005 ON D58.EMPL_PTR = dbo.Data0005.RKEY INNER JOIN
                      dbo.Data0034 ON D58.RESP_DEPT_PTR = dbo.Data0034.RKEY LEFT OUTER JOIN
                      dbo.Data0034 AS Data0034_2 ON dbo.Data0034.BIG_DEPT_PTR = Data0034_2.RKEY INNER JOIN
                      dbo.Data0025 ON dbo.Data0006.BOM_PTR = dbo.Data0025.RKEY INNER JOIN
                      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN
                      dbo.Data0034 AS Data0034_1 ON D58.DEPT_PTR = Data0034_1.RKEY INNER JOIN
                      dbo.Data0010 ON dbo.data0492.COMPLETED = dbo.Data0010.RKEY LEFT OUTER JOIN 
                      dbo.Data0060 ON dbo.Data0060.SALES_ORDER = dbo.data0492.SO_NO LEFT OUTER JOIN
                      dbo.Data0097 ON dbo.Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.RKEY  LEFT OUTER JOIN
                      dbo.Data0005 AS d05 ON D58.AUDIT_EMPL_PTR = d05.RKEY INNER JOIN
                      dbo.Data0015 ON D58.warehouse_ptr = dbo.Data0015.RKEY
GO
/****** Object:  View [dbo].[V_bhmx]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_bhmx]
AS
SELECT     D58.TDATETIME, D58.MRB_NO AS 报废单号, dbo.Data0006.CUT_NO AS 配料单号, dbo.Data0006.WORK_ORDER_NUMBER AS 作业单号, 
                      dbo.Data0039.REJECT_DESCRIPTION AS 缺陷名称, 
                      CASE dbo.Data0039.rej_type WHEN 0 THEN '工厂报废' WHEN 1 THEN '供应商报废' WHEN 2 THEN '客户报废' WHEN 3 THEN '市场报废' WHEN 4 THEN '其它' END AS
                       缺陷分类, D58.QTY_REJECT AS 报废PCS, dbo.Data0025.SAMPLE_NR AS 测试成型备注, D58.PANELS AS 报废PNL, dbo.Data0034.DEPT_NAME AS 责任工序名称, 
                      dbo.Data0025.MANU_PART_NUMBER AS 本厂编号, dbo.Data0008.PRODUCT_NAME AS 类型名称, dbo.Data0010.ABBR_NAME AS 客户简称, 
                      dbo.Data0025.set_qty AS 交货单元数, dbo.Data0025.ANALYSIS_CODE_1 AS 交货尺寸, CONVERT(decimal(18, 10), dbo.Data0025.unit_sq) AS 单只面积, 
                      CONVERT(decimal(18, 10), D58.QTY_REJECT * dbo.Data0025.unit_sq) AS 报废面积, 
                      CAST(D58.QTY_REJECT * dbo.Data0025.unit_sq / dbo.GetParentNum(dbo.Data0025.RKEY) AS decimal(30, 10)) AS '顶层报废面积', 
                      dbo.Data0034.cost_name AS 成本中心名称, CONVERT(decimal(18, 10), 
                      CASE WHEN data0006.PARTS_PER_PANEL > 0 THEN D58.QTY_REJECT * data0006.panel_ln * data0006.panel_wd * 0.000001 / data0006.PARTS_PER_PANEL ELSE D58.QTY_REJECT
                       * dbo.Data0025.unit_sq END) AS 报率面积含板边, dbo.Data0060.ORIG_CUSTOMER AS 关联原客户, Data0034_1.DEPT_NAME AS 申请工序名称, 
                      CASE D58.TTYPE WHEN 0 THEN '生产报废' WHEN 1 THEN '盘点报废' END AS 报废类型, dbo.data0492.SO_NO AS 销售订单, 
                      dbo.Data0097.PO_NUMBER AS 客户订单号, dbo.Data0015.ABBR_NAME AS 工厂简称, ISNULL(Data0034_2.DEPT_NAME, dbo.Data0034.DEPT_NAME) 
                      AS 责任班组部门名称, dbo.Data0025.CPJS AS 产品阶数, dbo.Data0025.LAYERS AS 层数, dbo.data0492.ISSUED_QTY AS 投产数量, 
                      dbo.data0492.ORD_REQ_QTY AS 待计数订单数, dbo.data0492.QTY_REJECT AS 报废数量, D58.TDATETIME AS 日期
FROM         dbo.Data0058 AS D58 INNER JOIN
                      dbo.Data0006 ON D58.WO_PTR = dbo.Data0006.RKEY INNER JOIN
                      dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO INNER JOIN
                      dbo.Data0039 ON D58.REJECT_PTR = dbo.Data0039.RKEY INNER JOIN
                      dbo.Data0005 ON D58.EMPL_PTR = dbo.Data0005.RKEY INNER JOIN
                      dbo.Data0034 ON D58.RESP_DEPT_PTR = dbo.Data0034.RKEY LEFT OUTER JOIN
                      dbo.Data0034 AS Data0034_2 ON dbo.Data0034.BIG_DEPT_PTR = Data0034_2.RKEY INNER JOIN
                      dbo.Data0025 ON dbo.Data0006.BOM_PTR = dbo.Data0025.RKEY INNER JOIN
                      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN
                      dbo.Data0034 AS Data0034_1 ON D58.DEPT_PTR = Data0034_1.RKEY INNER JOIN
                      dbo.Data0010 ON dbo.data0492.COMPLETED = dbo.Data0010.RKEY LEFT OUTER JOIN
                      dbo.Data0060 ON dbo.Data0060.SALES_ORDER = dbo.data0492.SO_NO LEFT OUTER JOIN
                      dbo.Data0097 ON dbo.Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.RKEY LEFT OUTER JOIN
                      dbo.Data0005 AS d05 ON D58.AUDIT_EMPL_PTR = d05.RKEY INNER JOIN
                      dbo.Data0015 ON D58.warehouse_ptr = dbo.Data0015.RKEY
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[11] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "D58"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0006"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 125
               Right = 460
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "data0492"
            Begin Extent = 
               Top = 6
               Left = 498
               Bottom = 125
               Right = 679
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0039"
            Begin Extent = 
               Top = 6
               Left = 717
               Bottom = 125
               Right = 918
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0005"
            Begin Extent = 
               Top = 6
               Left = 956
               Bottom = 125
               Right = 1131
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0034"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0034_2"
            Begin Extent = 
               Top = 126
               Left = 282
               Bottom = 245
               Right = 488
            End
            DisplayFlags = 280' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_bhmx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
            TopColumn = 0
         End
         Begin Table = "Data0025"
            Begin Extent = 
               Top = 126
               Left = 526
               Bottom = 245
               Right = 744
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0008"
            Begin Extent = 
               Top = 126
               Left = 782
               Bottom = 245
               Right = 996
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0034_1"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0010"
            Begin Extent = 
               Top = 246
               Left = 282
               Bottom = 365
               Right = 500
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0060"
            Begin Extent = 
               Top = 246
               Left = 538
               Bottom = 365
               Right = 759
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0097"
            Begin Extent = 
               Top = 246
               Left = 797
               Bottom = 365
               Right = 966
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d05"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 485
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0015"
            Begin Extent = 
               Top = 366
               Left = 251
               Bottom = 485
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_bhmx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_bhmx'
GO
/****** Object:  View [dbo].[v_Data0058_list]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_Data0058_list]
as
SELECT  D58.MRB_NO as 报废单号, dbo.Data0006.WORK_ORDER_NUMBER as 作业单号, dbo.Data0039.REJECT_DESCRIPTION as 缺陷名称, 
                      CASE dbo.Data0039.rej_type WHEN 0 THEN '工厂报废' WHEN 1 THEN '供应商报废' WHEN 2 THEN '客户报废' WHEN 3 THEN '市场报废' WHEN 4 THEN '其它' END AS
                       缺陷分类, D58.QTY_REJECT as 报废PCS,dbo.Data0025.SAMPLE_NR as 测试成型备注, D58.PANELS as 报废PNL,  dbo.Data0034.DEPT_NAME as 责任工序名称, dbo.Data0025.MANU_PART_NUMBER as 本厂编号, 
                       dbo.Data0008.PRODUCT_NAME as 类型名称,  dbo.Data0010.ABBR_NAME as 客户简称, dbo.Data0025.set_qty as 交货单元数, dbo.Data0025.ANALYSIS_CODE_1 as 交货尺寸, dbo.Data0025.unit_sq as 单只面积 , D58.QTY_REJECT * dbo.Data0025.unit_sq AS 报废面积, 
                      CAST(D58.QTY_REJECT * dbo.Data0025.unit_sq / dbo.GetParentNum(dbo.Data0025.RKEY) AS decimal(30, 18)) AS '顶层报废面积', dbo.Data0025.TUSAGE as [大料利用率], 
                      dbo.Data0034.cost_name as 成本中心名称, 
                      CASE WHEN data0006.PARTS_PER_PANEL > 0 THEN D58.QTY_REJECT * data0006.panel_ln * data0006.panel_wd * 0.000001 / data0006.PARTS_PER_PANEL ELSE D58.QTY_REJECT
                       * dbo.Data0025.unit_sq END AS  报率面积含板边, dbo.Data0060.ORIG_CUSTOMER as 关联原客户, Data0034_1.DEPT_NAME AS 申请工序名称,
                       CASE D58.TTYPE WHEN 0 THEN '生产报废' WHEN 1 THEN '盘点报废' END AS 报废类型, dbo.data0492.SO_NO as 销售订单, dbo.Data0097.PO_NUMBER as 客户订单号, 
                      dbo.Data0015.ABBR_NAME AS 工厂简称,  ISNULL(Data0034_2.DEPT_NAME, 
                      dbo.Data0034.DEPT_NAME) AS 责任班组部门名称, dbo.Data0025.CPJS as 产品阶数, dbo.Data0025.LAYERS as 层数 , dbo.data0492.ISSUED_QTY as 投产数量 , dbo.data0492.ORD_REQ_QTY as 待计数订单数, 
                      dbo.data0492.QTY_REJECT AS 报废数量,D58.TDATETIME as 日期
FROM         dbo.Data0060 LEFT OUTER JOIN
                      dbo.Data0097 ON dbo.Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.RKEY RIGHT OUTER JOIN
                      dbo.Data0058 AS D58 INNER JOIN
                      dbo.Data0006 ON D58.WO_PTR = dbo.Data0006.RKEY INNER JOIN
                      dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO INNER JOIN
                      dbo.Data0039 ON D58.REJECT_PTR = dbo.Data0039.RKEY INNER JOIN
                      dbo.Data0005 ON D58.EMPL_PTR = dbo.Data0005.RKEY INNER JOIN
                      dbo.Data0034 ON D58.RESP_DEPT_PTR = dbo.Data0034.RKEY LEFT OUTER JOIN
                      dbo.Data0034 AS Data0034_2 ON dbo.Data0034.BIG_DEPT_PTR = Data0034_2.RKEY INNER JOIN
                      dbo.Data0025 ON dbo.Data0006.BOM_PTR = dbo.Data0025.RKEY INNER JOIN
                      dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN
                      dbo.Data0034 AS Data0034_1 ON D58.DEPT_PTR = Data0034_1.RKEY INNER JOIN
                      dbo.Data0010 ON dbo.data0492.COMPLETED = dbo.Data0010.RKEY ON dbo.Data0060.SALES_ORDER = dbo.data0492.SO_NO LEFT OUTER JOIN
                      dbo.Data0005 AS d05 ON D58.AUDIT_EMPL_PTR = d05.RKEY INNER JOIN
                      dbo.Data0015 ON D58.warehouse_ptr = dbo.Data0015.RKEY
WHERE     (D58.TDATETIME >= '2017-02-11 00:00:00') AND (D58.TDATETIME <= '2017-02-11 7:00:00') AND (D58.TTYPE <> 2)
GO
/****** Object:  View [dbo].[partrece_ext_total]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[partrece_ext_total]
AS
SELECT partrece_total.RKEY, partrece_total.manu_PART_NUMBER,
partrece_total.manu_PART_DESC,
partrece_total.ABBR_NAME,partrece_total.PROD_CODE,
partrece_total.unit_sq,partrece_total.rece_total,
partrece_total.mianqi,
SUM(data0052.quan_shp) AS ext_total,
ROUND(SUM(data0052.quan_shp
* partrece_total.unit_sq), 4) AS ext_mianqi
FROM Data0064 INNER JOIN Data0052 ON
Data0064.RKEY = Data0052.SO_SHP_PTR INNER JOIN
Data0053 ON Data0052.DATA0053_PTR = Data0053.RKEY RIGHT OUTER JOIN
partrece_total ON Data0053.CUST_PART_PTR = partrece_total.RKEY
where  Data0064.date_assign >= '2018-10-28' and Data0064.date_assign <= '2018-11-28'
and data0053.WHSE_PTR=1
GROUP BY partrece_total.RKEY, partrece_total.manu_PART_NUMBER,
partrece_total.manu_PART_DESC,
partrece_total.ABBR_NAME, partrece_total.PROD_CODE,
partrece_total.unit_sq, partrece_total.rece_total,
partrece_total.mianqi
GO
/****** Object:  View [dbo].[V_employeebasicsalary_20151204]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  
 VIEW  [dbo].[V_employeebasicsalary_20151204]   
AS  
SELECT   
b.departmentname,  
b.employeecode,  
b.chinesename,  
b.position_item,  
a.yearmonth,  
a.employeeid,  
b.status,  
dbo.Get_wagetype(a.employeeid,a.yearmonth,b.wagetype) as accountid,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f1,1) as F1,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f2,2) as F2,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f3,3) as F3,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f4,4) as F4,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f5,5) as F5,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f6,6) as F6,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f7,7) as F7,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f8,8) as F8,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f9,9) as F9,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f10,10) as F10  
/**,  
0 as F11,  
0 as F12,  
0 as F13,  
0 as F14,  
0 as F15,  
0 as F16,  
0 as F17,  
0 as F18,  
0 as F19,  
0 as F20,  
0 as F21,  
0 as F22,  
0 as F23,  
0 as F24,  
0 as F25,  
0 as F26,  
0 as F27,  
0 as F28,  
0 as F29,  
0 as F30,  
0 as F41,  
0 as F42,  
0 as F43,  
0 as F44,  
0 as F45,  
0 as F46,  
0 as F47,  
0 as F48,  
0 as F49,  
0 as F50,  
0 as F51,  
0 as F52,  
0 as F53,  
0 as F54,  
0 as F55,  
0 as F56,  
0 as F57,  
0 as F58,  
0 as F59,  
0 as F60,  
0 as F61,  
0 as F62,  
0 as F63,  
0 as F64,  
0 as F65,  
0 as F66,  
0 as F67,  
0 as F68,  
0 as F69,  
0 as F70,  
0 as F71,  
0 as F72,  
0 as F73,  
0 as F74,  
0 as F75,  
0 as F76,  
0 as F77,  
0 as F78,  
0 as F79,  
0 as F80  
**/  
/**  
dbo.get_FX(a.employeeid,a.yearmonth,c.f11,11) as F11,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f12,12) as F12,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f13,13) as F13,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f14,14) as F14,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f15,15) as F15,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f16,16) as F16,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f17,17) as F17,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f18,18) as F18,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f19,19) as F19,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f20,20) as F20,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f21,21) as F21,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f22,22) as F22,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f23,23) as F23,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f24,24) as F24,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f25,25) as F25,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f26,26) as F26,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f27,27) as F27,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f28,28) as F28,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f29,29) as F29,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f30,30) as F30,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f31,31) as F31,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f32,32) as F32,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f33,33) as F33,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f34,34) as F34,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f35,35) as F35,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f36,36) as F36,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f37,37) as F37,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f38,38) as F38,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f39,39) as F39,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f40,40) as F40,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f41,41) as F41,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f42,42) as F42,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f43,43) as F43,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f44,44) as F44,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f45,45) as F45,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f46,46) as F46,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f47,47) as F47,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f48,48) as F48,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f49,49) as F49,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f50,50) as F50,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f51,51) as F51,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f52,52) as F52,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f53,53) as F53,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f54,54) as F54,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f55,55) as F55,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f56,56) as F56,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f57,57) as F57,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f58,58) as F58,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f59,59) as F59,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f60,60) as F60,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f61,61) as F61,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f62,62) as F62,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f63,63) as F63,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f64,64) as F64,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f65,65) as F65,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f66,66) as F66,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f67,67) as F67,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f68,68) as F68,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f69,69) as F69,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f70,71) as F70,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f71,72) as F71,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f72,72) as F72,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f73,73) as F73,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f74,74) as F74,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f75,75) as F75,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f76,76) as F76,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f77,77) as F77,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f78,78) as F78,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f79,79) as F79,  
dbo.get_FX(a.employeeid,a.yearmonth,c.f80,80) as F80**/  
 from employeesalary a   
join v_employeemsg b   
on a.employeeid=b.rkey  
join employeebasicsalary c   
on a.employeeid=c.employeeid  
  
   
  
----select * from dbo.meal_orginaldata  
----select * from employeemsg_extra where rkey =20   
----- select * from V_meal where departmentname='锌智泉'  
---- select * from dev_detail  
  
/*[Get_FX]  
(@employeeid int,  
@yearmonth nvarchar(10),  
@F float,  
@index int)  
*/
GO
/****** Object:  View [dbo].[V_employeebasicsalary]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     
 VIEW  [dbo].[V_employeebasicsalary]     
AS    
SELECT     
b.departmentname, b.employeecode, b.chinesename,b.position_item, a.yearmonth, a.employeeid,  b.status,    

dbo.Get_wagetype(a.employeeid,a.yearmonth,b.wagetype) as accountid,    
dbo.get_FX(a.employeeid,a.yearmonth,c.f1,1) as F1,    
case when  isnull(a.F53,0)>0   then a.F53  
   else dbo.get_FX(a.employeeid,a.yearmonth,c.f2,2) end  as F2,   
dbo.get_FX(a.employeeid,a.yearmonth,c.f3,3) as F3,    
dbo.get_FX(a.employeeid,a.yearmonth,c.f4,4) as F4,    
dbo.get_FX(a.employeeid,a.yearmonth,c.f5,5) as F5,    
dbo.get_FX(a.employeeid,a.yearmonth,c.f6,6) as F6,    
dbo.get_FX(a.employeeid,a.yearmonth,c.f7,7) as F7,    
dbo.get_FX(a.employeeid,a.yearmonth,c.f8,8) as F8,    
dbo.get_FX(a.employeeid,a.yearmonth,c.f9,9) as F9,    
dbo.get_FX(a.employeeid,a.yearmonth,c.f10,10) as F10     
 from employeesalary a     
join v_employeemsg b  on a.employeeid=b.rkey    
join employeebasicsalary c  on a.employeeid=c.employeeid    
    
     
    
----select * from dbo.meal_orginaldata    
----select * from employeemsg_extra where rkey =20     
----- select * from V_meal where departmentname='锌智泉'    
---- select * from dev_detail    
    
/*  
31
72
77
78
92
108
114
142
174
  
select top 10 * From [V_employeebasicsalary]  
select top  10 * from employeebasicsalary  
  
select   top  10  * from employeesalary  
  
[Get_FX]    
(@employeeid int,    
@yearmonth nvarchar(10),    
@F float,    
@index int)    
*/
GO
/****** Object:  View [dbo].[received_extend_total]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[received_extend_total]
AS
SELECT dbo.received_total.RKEY, dbo.received_total.INV_PART_NUMBER,
dbo.received_total.INV_NAME, dbo.received_total.INV_DESCRIPTION,
dbo.received_total.UNIT_NAME, dbo.received_total.GROUP_NAME,
dbo.received_total.inv_group_name, dbo.received_total.std_cost, 
dbo.received_total.received, dbo.received_total.received_money, 
SUM(dbo.Data0207.QUANTITY) AS extend, 
ROUND(SUM(dbo.Data0207.QUANTITY * dbo.Data0022.PRICE * dbo.Data0456.exch_rate),
3) AS extend_money, dbo.received_total.ABBR_NAME, dbo.received_total.rkey23,
dbo.received_total.STOCK_SELL, dbo.received_total.STOCK_BASE
FROM dbo.Data0207 INNER JOIN
dbo.Data0022 ON dbo.Data0207.D0022_PTR = dbo.Data0022.RKEY INNER JOIN
dbo.Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY INNER JOIN
dbo.Data0457 ON 
dbo.Data0207.GON_PTR = dbo.Data0457.RKEY RIGHT OUTER JOIN
dbo.received_total ON dbo.Data0456.SUPP_PTR = dbo.received_total.rkey23 AND 
dbo.Data0207.INVENTORY_PTR = dbo.received_total.RKEY
where  Data0457.CREATE_DATE >= '2018-09-01' and Data0457.CREATE_DATE <= '2018-11-23'
and data0457.warehouse_PTR=9
GROUP BY all received_total.RKEY,received_total.INV_PART_NUMBER,received_total.INV_name,
received_total.INV_DESCRIPTION, received_total.STD_COST,
received_total.received, received_total.received_money,
received_total.UNIT_NAME,received_total.GROUP_NAME,received_total.inv_group_name,
received_total.ABBR_NAME,received_total.rkey23,
received_total.STOCK_SELL,received_total.STOCK_BASE
GO
/****** Object:  View [dbo].[ft2]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ft2]
AS
WITH cte AS (SELECT     RKEY, PARENT_PTR, STEP_NUMBER, TType, stime1, stime1 AS rtime1, stime2, stime2 AS rtime2, stime3, stime3 AS rtime3
                             FROM         dbo.ft1 AS a
                             WHERE     (PARENT_PTR IS NULL)
                             UNION ALL
                             SELECT     b.RKEY, b.PARENT_PTR, b.STEP_NUMBER, b.TType, b.stime1, d.rtime1 + b.stime1 AS rtime1, b.stime2, d.rtime2 + b.stime2 AS rtime2, b.stime3, d.rtime2 + b.stime3 AS rtime3
                             FROM         dbo.ft1 AS b INNER JOIN
                                                   cte AS d ON d.rkey = b.PARENT_PTR AND d.step_number = 1
                             WHERE     (NOT (b.PARENT_PTR IS NULL)))
    SELECT     TOP (100) PERCENT RKEY, PARENT_PTR, STEP_NUMBER, TType, stime1, rtime1, stime2, rtime2, stime3, rtime3
     FROM         cte AS cte_1
     ORDER BY RKEY, STEP_NUMBER
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[33] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "cte_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ft2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ft2'
GO
/****** Object:  View [dbo].[成品变动数据汇总]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[成品变动数据汇总]
AS
SELECT dbo.库存指派直接出仓变动.CUSTOMER_PART_NUMBER AS 本厂编号, 
      dbo.库存指派直接出仓变动.CP_REV AS 版本, 
      CASE dbo.库存指派直接出仓变动.RMA_PTR WHEN 0 THEN '正常过数入仓' WHEN 1 THEN
       '退货重检入仓' WHEN 2 THEN '返修重检入仓' WHEN 3 THEN '直接入仓' WHEN 4 THEN
       '委外加工入仓' WHEN 5 THEN '委外加工退货入仓' WHEN 6 THEN '销售退货入仓' WHEN
       7 THEN '转换入仓' WHEN 8 THEN '盘点入仓' END AS 入仓类型, 
      dbo.库存指派直接出仓变动.入仓数据, dbo.库存指派直接出仓变动.当前库存, 
      dbo.库存指派直接出仓变动.指派汇总, dbo.库存指派直接出仓变动.直接出仓, 
      dbo.成品盘点差异数据.盘点差异, dbo.成品转移数据.转移数量
FROM dbo.库存指派直接出仓变动 LEFT OUTER JOIN
      dbo.成品转移数据 ON 
      dbo.库存指派直接出仓变动.rkey53 = dbo.成品转移数据.RKEY LEFT OUTER JOIN
      dbo.成品盘点差异数据 ON 
      dbo.库存指派直接出仓变动.rkey53 = dbo.成品盘点差异数据.RKEY
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1 [56] 4 [18] 2))"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "库存指派直接出仓变动"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 109
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "成品转移数据"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 81
               Right = 410
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "成品盘点差异数据"
            Begin Extent = 
               Top = 84
               Left = 276
               Bottom = 159
               Right = 410
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      RowHeights = 240
      Begin ColumnWidths = 10
         Width = 284
         Width = 1440
         Width = 1440
         Width = 1440
         Width = 1440
         Width = 1440
         Width = 1440
         Width = 1440
         Width = 1440
         Width = 1440
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'成品变动数据汇总'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'成品变动数据汇总'
GO
/****** Object:  View [dbo].[vw_OAUserERP]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_OAUserERP]
AS
SELECT v_employeemsg.rkey,v_employeemsg.employeecode
,v_employeemsg.chinesename,v_employeemsg.departmentname
,v_employeemsg.position_item
,vw_OADeptERP.factory,vw_OADeptERP.departmentcode,vw_OADeptERP.code
from V_employeemsg
        inner JOIN vw_OADeptERP ON v_employeemsg.factory = vw_OADeptERP.factory
                                        AND v_employeemsg.departmentid = vw_OADeptERP.rkey
WHERE v_employeemsg.status = 0 OR v_employeemsg.status = 1                                     
UNION
SELECT v_employeemsg.rkey,v_employeemsg.employeecode
,v_employeemsg.chinesename,v_employeemsg.departmentname
,v_employeemsg.position_item
,vw_OADeptERP.factory,vw_OADeptERP.departmentcode,vw_OADeptERP.code
from [172.16.0.8].sj_v20_live.dbo.V_employeemsg
        inner JOIN vw_OADeptERP ON v_employeemsg.factory = vw_OADeptERP.factory
                                        AND v_employeemsg.departmentid = vw_OADeptERP.rkey
WHERE v_employeemsg.status = 0 OR v_employeemsg.status = 1                                     
UNION
SELECT v_employeemsg.rkey,v_employeemsg.employeecode
,v_employeemsg.chinesename,v_employeemsg.departmentname
,v_employeemsg.position_item
,vw_OADeptERP.factory,vw_OADeptERP.departmentcode,vw_OADeptERP.code
from [172.17.0.187].wisdompcb.dbo.V_employeemsg
        inner JOIN vw_OADeptERP ON v_employeemsg.factory = vw_OADeptERP.factory
                                        AND v_employeemsg.departmentid = vw_OADeptERP.rkey
WHERE v_employeemsg.status = 0 OR v_employeemsg.status = 1
UNION
SELECT v_employeemsg.rkey,v_employeemsg.employeecode
,v_employeemsg.chinesename,v_employeemsg.departmentname
,v_employeemsg.position_item
,vw_OADeptERP.factory,vw_OADeptERP.departmentcode,vw_OADeptERP.code
from [172.18.9.9].wisdompcb_hy.dbo.V_employeemsg
        inner JOIN vw_OADeptERP ON v_employeemsg.factory = vw_OADeptERP.factory
                                        AND v_employeemsg.departmentid = vw_OADeptERP.rkey
WHERE v_employeemsg.status = 0 OR v_employeemsg.status = 1
UNION
SELECT v_employeemsg.rkey,v_employeemsg.employeecode
,v_employeemsg.chinesename,v_employeemsg.departmentname
,v_employeemsg.position_item
,vw_OADeptERP.factory,vw_OADeptERP.departmentcode,vw_OADeptERP.code
from [172.18.12.2].wisdompcb_wlg.dbo.V_employeemsg
        inner JOIN vw_OADeptERP ON v_employeemsg.factory = vw_OADeptERP.factory
                                        AND v_employeemsg.departmentid = vw_OADeptERP.rkey
WHERE v_employeemsg.status = 0 OR v_employeemsg.status = 1
UNION
SELECT v_employeemsg.rkey,v_employeemsg.employeecode
,v_employeemsg.chinesename,v_employeemsg.departmentname
,v_employeemsg.position_item
,vw_OADeptERP.factory,vw_OADeptERP.departmentcode,vw_OADeptERP.code
from [172.18.9.10].wisdompcb_hgc.dbo.V_employeemsg
        inner JOIN vw_OADeptERP ON v_employeemsg.factory = vw_OADeptERP.factory
                                        AND v_employeemsg.departmentid = vw_OADeptERP.rkey
WHERE v_employeemsg.status = 0 OR v_employeemsg.status = 1
UNION
SELECT v_employeemsg.rkey,v_employeemsg.employeecode
,v_employeemsg.chinesename,v_employeemsg.departmentname
,v_employeemsg.position_item
,vw_OADeptERP.factory,vw_OADeptERP.departmentcode,vw_OADeptERP.code
from [172.19.9.1].wisdompcb_jx.dbo.V_employeemsg
        inner JOIN vw_OADeptERP ON v_employeemsg.factory = vw_OADeptERP.factory
                                        AND v_employeemsg.departmentid = vw_OADeptERP.rkey
WHERE v_employeemsg.status = 0 OR v_employeemsg.status = 1
GO
/****** Object:  View [dbo].[partrece_jft_total]    Script Date: 11/27/2018 15:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[partrece_jft_total]
AS
SELECT     dbo.partrece_ext_total.RKEY, dbo.partrece_ext_total.manu_PART_NUMBER,
dbo.partrece_ext_total.manu_PART_DESC, dbo.partrece_ext_total.ABBR_NAME,
dbo.partrece_ext_total.PROD_CODE, dbo.partrece_ext_total.unit_sq,
dbo.partrece_ext_total.rece_total, dbo.partrece_ext_total.mianqi,
dbo.partrece_ext_total.ext_total, dbo.partrece_ext_total.ext_mianqi,
SUM(dbo.Data0465.QUANTITY) AS t_quantity,
ROUND(SUM(dbo.Data0465.QUANTITY * dbo.partrece_ext_total.unit_sq), 4) AS t_mianqi
FROM         dbo.Data0465 INNER JOIN
dbo.Data0053 ON dbo.Data0465.D0053_PTR = dbo.Data0053.RKEY INNER JOIN
dbo.data0415 ON dbo.Data0465.heard_ptr = dbo.data0415.rkey RIGHT OUTER JOIN
dbo.partrece_ext_total ON dbo.Data0053.CUST_PART_PTR = dbo.partrece_ext_total.RKEY
WHERE     (dbo.data0415.status IN (3, 4)) 
and  data0415.sys_date >= '2018-10-28' and data0415.sys_date <= '2018-11-28'
and data0053.WHSE_PTR=1
GROUP BY dbo.partrece_ext_total.RKEY, dbo.partrece_ext_total.manu_PART_NUMBER,
dbo.partrece_ext_total.manu_PART_DESC, dbo.partrece_ext_total.ABBR_NAME,
dbo.partrece_ext_total.PROD_CODE,dbo.partrece_ext_total.ext_mianqi,
dbo.partrece_ext_total.unit_sq, dbo.partrece_ext_total.rece_total,
dbo.partrece_ext_total.mianqi, dbo.partrece_ext_total.ext_total
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Data0465"
            Begin Extent = 
               Top = 5
               Left = 102
               Bottom = 213
               Right = 261
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Data0053"
            Begin Extent = 
               Top = 10
               Left = 348
               Bottom = 229
               Right = 542
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "data0415"
            Begin Extent = 
               Top = 88
               Left = 361
               Bottom = 315
               Right = 520
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "partrece_ext_total"
            Begin Extent = 
               Top = 0
               Left = 724
               Bottom = 200
               Right = 921
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'partrece_jft_total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'partrece_jft_total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'partrece_jft_total'
GO








Create VIEW [dbo].[View_SMS]  
--with encryption  
AS  
SELECT  TOP 1  
        当日入库.当日入库面积,  
        当日入库.当日入库产值,  
        月累计入库.月累计入库面积,  
        月累计入库.月累计入库产值,   
        当日出库.当日出库面积,   
        当日出库.当日出库产值,   
        月累计出库.月累计出库面积,   
        月累计出库.月累计出库产值,  
        ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) AS 当日报废面积,   
        ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0) AS 月累计报废面积,   
        CASE  WHEN ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0) <> 0   
              THEN ROUND(ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0)   
                            / (当日入库.当日入库面积 + ROUND(当日报废.当日报废面积 + 当日尾数入仓.当日尾数入仓面积 - 当日尾数出仓.当日尾数出仓面积, 0)) * 100, 2)   
              ELSE 0 END AS 当日报废率,   
        CASE  WHEN ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0) <> 0   
              THEN ROUND(ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0)   
                            / (月累计入库.月累计入库面积 + ROUND(月累计报废.月累计报废面积 + 月累计尾数入仓.月尾数入仓面积 - 月累计尾数出仓.月累计尾数出仓面积, 0)) * 100, 2)   
              ELSE 0 END AS 月报废率,   
        当日订单.当日订单面积,   
        当日订单.当日订单未投面积,   
        月累计订单.月累计订单面积,   
        月累计订单.月累计订单未投面积,   
        当前库存.当前库存面积,   
        当前库存.当前库存金额,   
        超周期库存.超周期库存面积,   
        超周期库存.超周期库存金额,  
        当前在线.当前在线面积,   
        当前在线暂缓.当前在线暂缓面积,   
        当日退货.当日退货面积,   
        月累计退货面积.月累计退货面积,   
        当日尾数入仓.当日尾数入仓面积,   
        当日尾数出仓.当日尾数出仓面积,   
        月累计尾数入仓.月尾数入仓面积,  
        月累计尾数出仓.月累计尾数出仓面积  
FROM   (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(dbo.Data0053.QUANTITY * dbo.Data0025.unit_sq, 4)), 0), 0) AS 当日入库面积,   
                ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE, 4),6)   
                                      ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4), 6)   
                                                ELSE Data0025.LATEST_PRICE END END * dbo.Data0053.QUANTITY) / 10000, 0), 0) AS 当日入库产值  
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN  
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN  
                dbo.data0416 INNER JOIN  
                dbo.Data0025 INNER JOIN  
                dbo.Data0053 INNER JOIN  
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN  
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY ON dbo.Data0025.RKEY = dbo.Data0053.CUST_PART_PTR ON   
                dbo.data0416.rkey = dbo.Data0053.NPAD_PTR LEFT OUTER JOIN  
                dbo.Data0006 ON dbo.Data0053.WORK_ORDER_PTR = dbo.Data0006.RKEY LEFT OUTER JOIN  
                dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO ON Data0060_2.SALES_ORDER = dbo.data0492.SO_NO ON   
                data0060_1.RKEY = dbo.data0416.so_ptr  
        WHERE  (dbo.Data0053.QUANTITY > 0) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND   
               (dbo.Data0053.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND   
               (dbo.Data0053.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND   
               (dbo.Data0016.CODE = 'ST005' OR dbo.Data0016.CODE = 'ST020') AND (dbo.Data0053.RMA_PTR = 0))   
    AS 当日入库 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(Data0053_1.QUANTITY * Data0025_1.unit_sq, 4)), 0), 0) AS 月累计入库面积,   
                ISNULL(ROUND(SUM(CASE WHEN Data0060_2.part_price >= 0 THEN ROUND(Data0060_2.PARTS_ALLOC * ROUND(1 / Data0060_2.EXCH_RATE,4), 6)   
                                      ELSE CASE WHEN Data0060_1.part_price >= 0 THEN ROUND(Data0060_1.PARTS_ALLOC * ROUND(1 / Data0060_1.EXCH_RATE, 4),6)   
                                                ELSE Data0025_1.LATEST_PRICE END END * Data0053_1.QUANTITY) / 10000, 0), 0) AS 月累计入库产值  
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN  
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN  
                dbo.data0416 AS data0416_1 INNER JOIN  
                dbo.Data0025 AS Data0025_1 INNER JOIN  
                dbo.Data0053 AS Data0053_1 INNER JOIN  
                dbo.Data0015 AS Data0015_1 ON Data0053_1.WHSE_PTR = Data0015_1.RKEY INNER JOIN  
                dbo.Data0016 AS Data0016_1 ON Data0053_1.LOC_PTR = Data0016_1.RKEY ON Data0025_1.RKEY = Data0053_1.CUST_PART_PTR ON   
                data0416_1.rkey = Data0053_1.NPAD_PTR LEFT OUTER JOIN  
                dbo.Data0006 AS Data0006_1 ON Data0053_1.WORK_ORDER_PTR = Data0006_1.RKEY LEFT OUTER JOIN  
                dbo.data0492 AS data0492_1 ON Data0006_1.CUT_NO = data0492_1.CUT_NO ON Data0060_2.SALES_ORDER = data0492_1.SO_NO ON   
                data0060_1.RKEY = data0416_1.so_ptr  
        WHERE  (Data0053_1.QUANTITY > 0) AND (Data0015_1.WAREHOUSE_CODE = 'D0001') AND   
               (Data0053_1.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND   
               (Data0053_1.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND   
               (Data0016_1.CODE = 'ST005' OR Data0016_1.CODE = 'ST020') AND (Data0053_1.RMA_PTR = 0))   
    AS 月累计入库 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(dbo.Data0052.QUAN_SHP * Data0025_13.unit_sq, 4)), 0), 0) AS 当日出库面积,   
                ISNULL(ROUND(SUM(ROUND(dbo.Data0052.QUAN_SHP * dbo.Data0060.PARTS_ALLOC / dbo.Data0060.EXCH_RATE, 4))/ 10000, 0), 0) AS 当日出库产值  
        FROM    dbo.Data0052 INNER JOIN  
                dbo.Data0064 ON dbo.Data0052.SO_SHP_PTR = dbo.Data0064.RKEY INNER JOIN  
                dbo.Data0060 ON dbo.Data0064.SO_PTR = dbo.Data0060.RKEY INNER JOIN  
                dbo.Data0053 AS Data0053_6 ON dbo.Data0052.DATA0053_PTR = Data0053_6.RKEY INNER JOIN  
                dbo.Data0015 AS Data0015_13 ON Data0053_6.WHSE_PTR = Data0015_13.RKEY INNER JOIN  
                dbo.Data0016 AS Data0016_6 ON Data0053_6.LOC_PTR = Data0016_6.RKEY INNER JOIN  
                dbo.Data0025 AS Data0025_13 ON Data0053_6.CUST_PART_PTR = Data0025_13.RKEY INNER JOIN  
                dbo.Data0001 ON dbo.Data0060.CURRENCY_PTR = dbo.Data0001.RKEY LEFT OUTER JOIN  
                dbo.data0416 AS data0416_3 ON Data0053_6.NPAD_PTR = data0416_3.rkey LEFT OUTER JOIN  
                dbo.data0439 ON dbo.Data0064.packing_list_ptr = dbo.data0439.rkey LEFT OUTER JOIN  
                dbo.Data0006 AS Data0006_6 ON Data0053_6.WORK_ORDER_PTR = Data0006_6.RKEY  
        WHERE  (Data0016_6.CODE = 'ST005') AND (Data0015_13.WAREHOUSE_CODE = 'D0001') AND   
               (dbo.Data0064.DATE_ASSIGN >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND   
               (dbo.Data0064.DATE_ASSIGN <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND   
               (dbo.Data0064.PACKING_SLIP_FLAG = '1') AND (Data0025_13.ttype = 0) AND (dbo.Data0052.QUAN_SHP > 0))   
    AS 当日出库 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(Data0052_1.QUAN_SHP * Data0025_14.unit_sq, 4)), 0), 0) AS 月累计出库面积,   
                ISNULL(ROUND(SUM(ROUND(Data0052_1.QUAN_SHP * Data0060_7.PARTS_ALLOC / Data0060_7.EXCH_RATE, 4))/ 10000, 0), 0) AS 月累计出库产值  
        FROM    dbo.Data0052 AS Data0052_1 INNER JOIN  
                dbo.Data0064 AS Data0064_1 ON Data0052_1.SO_SHP_PTR = Data0064_1.RKEY INNER JOIN  
                dbo.Data0060 AS Data0060_7 ON Data0064_1.SO_PTR = Data0060_7.RKEY INNER JOIN  
                dbo.Data0053 AS Data0053_7 ON Data0052_1.DATA0053_PTR = Data0053_7.RKEY INNER JOIN  
                dbo.Data0015 AS Data0015_14 ON Data0053_7.WHSE_PTR = Data0015_14.RKEY INNER JOIN  
                dbo.Data0016 AS Data0016_7 ON Data0053_7.LOC_PTR = Data0016_7.RKEY INNER JOIN  
                dbo.Data0025 AS Data0025_14 ON Data0053_7.CUST_PART_PTR = Data0025_14.RKEY INNER JOIN  
                dbo.Data0001 AS Data0001_1 ON Data0060_7.CURRENCY_PTR = Data0001_1.RKEY LEFT OUTER JOIN  
                dbo.data0416 AS data0416_4 ON Data0053_7.NPAD_PTR = data0416_4.rkey LEFT OUTER JOIN  
                dbo.data0439 AS data0439_1 ON Data0064_1.packing_list_ptr = data0439_1.rkey LEFT OUTER JOIN  
                dbo.Data0006 AS Data0006_7 ON Data0053_7.WORK_ORDER_PTR = Data0006_7.RKEY  
        WHERE  (Data0016_7.CODE = 'ST005') AND (Data0015_14.WAREHOUSE_CODE = 'D0001') AND   
               (Data0064_1.DATE_ASSIGN >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND   
               (Data0064_1.DATE_ASSIGN <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND   
               (Data0064_1.PACKING_SLIP_FLAG = '1') AND (Data0025_14.ttype = 0) AND (Data0052_1.QUAN_SHP > 0))   
    AS 月累计出库 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(dbo.Data0058.QTY_REJECT * Data0025_2.unit_sq), 0), 0) AS 当日报废面积  
        FROM    dbo.Data0058 INNER JOIN  
                dbo.Data0006 AS Data0006_2 ON dbo.Data0058.WO_PTR = Data0006_2.RKEY INNER JOIN  
                dbo.Data0025 AS Data0025_2 ON Data0006_2.BOM_PTR = Data0025_2.RKEY INNER JOIN  
                dbo.Data0015 AS Data0015_2 ON dbo.Data0058.warehouse_ptr = Data0015_2.RKEY  
        WHERE  (Data0015_2.WAREHOUSE_CODE = 'D0001') AND (dbo.Data0058.TTYPE <> 2) AND   
               (dbo.Data0058.TDATETIME >= CONVERT(DATETIME, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND   
               (dbo.Data0058.TDATETIME <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)))   
    AS 当日报废 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(Data0058_1.QTY_REJECT * Data0025_3.unit_sq), 0), 0) AS 月累计报废面积  
        FROM    dbo.Data0058 AS Data0058_1 INNER JOIN  
                dbo.Data0006 AS Data0006_3 ON Data0058_1.WO_PTR = Data0006_3.RKEY INNER JOIN  
                dbo.Data0025 AS Data0025_3 ON Data0006_3.BOM_PTR = Data0025_3.RKEY INNER JOIN  
                dbo.Data0015 AS Data0015_3 ON Data0058_1.warehouse_ptr = Data0015_3.RKEY  
        WHERE  (Data0015_3.WAREHOUSE_CODE = 'D0001') AND (Data0058_1.TTYPE <> 2) AND   
               (Data0058_1.TDATETIME >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND   
               (Data0058_1.TDATETIME <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)))   
    AS 月累计报废 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(dbo.Data0060.PARTS_ORDERED * Data0025_8.unit_sq), 0), 0) AS 当日订单面积,   
                ISNULL(ROUND(SUM(dbo.Data0060.TO_BE_PLANNED * Data0025_8.unit_sq), 0), 0) AS 当日订单未投面积  
        FROM    dbo.Data0060 INNER JOIN  
                dbo.Data0025 AS Data0025_8 ON dbo.Data0060.CUST_PART_PTR = Data0025_8.RKEY INNER JOIN  
                dbo.Data0015 AS Data0015_8 ON dbo.Data0060.SHIP_REG_TAX_ID = Data0015_8.RKEY  
        WHERE  (Data0015_8.WAREHOUSE_CODE = 'D0001') AND   
               (dbo.Data0060.ENT_DATE >= CONVERT(DATETIME, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND   
               (dbo.Data0060.so_style = 0) AND (Data0025_8.ttype = 0) AND (dbo.Data0060.so_tp = 0) AND   
               (dbo.Data0060.ENT_DATE <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)))   
    AS 当日订单 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(Data0060_4.PARTS_ORDERED * Data0025_7.unit_sq), 0), 0) AS 月累计订单面积,   
                ISNULL(ROUND(SUM(Data0060_4.TO_BE_PLANNED * Data0025_7.unit_sq), 0), 0) AS 月累计订单未投面积  
        FROM    dbo.Data0060 AS Data0060_4 INNER JOIN  
                dbo.Data0025 AS Data0025_7 ON Data0060_4.CUST_PART_PTR = Data0025_7.RKEY INNER JOIN  
                dbo.Data0015 AS Data0015_7 ON Data0060_4.SHIP_REG_TAX_ID = Data0015_7.RKEY  
        WHERE  (Data0015_7.WAREHOUSE_CODE = 'D0001') AND   
               (Data0060_4.ENT_DATE >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND   
               (Data0060_4.so_style = 0) AND (Data0025_7.ttype = 0) AND (Data0060_4.so_tp = 0) AND   
               (Data0060_4.ENT_DATE <= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)))   
    AS 月累计订单 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(Data0053_2.QTY_ON_HAND * Data0025_6.unit_sq, 4)), 0), 0) AS 当前库存面积,   
                ISNULL(ROUND(SUM(Data0025_6.LATEST_PRICE * Data0053_2.QTY_ON_HAND)/ 10000, 0), 0) AS 当前库存金额  
        FROM    dbo.Data0023 RIGHT OUTER JOIN  
                dbo.Data0008 INNER JOIN  
                dbo.Data0025 AS Data0025_6 ON dbo.Data0008.RKEY = Data0025_6.PROD_CODE_PTR INNER JOIN  
                dbo.Data0010 ON Data0025_6.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN  
                dbo.Data0053 AS Data0053_2 INNER JOIN  
                dbo.Data0015 AS Data0015_6 ON Data0053_2.WHSE_PTR = Data0015_6.RKEY INNER JOIN  
                dbo.Data0016 AS Data0016_2 ON Data0053_2.LOC_PTR = Data0016_2.RKEY ON   
                Data0025_6.RKEY = Data0053_2.CUST_PART_PTR INNER JOIN  
                dbo.data0416 AS data0416_6 ON Data0053_2.NPAD_PTR = data0416_6.rkey LEFT OUTER JOIN  
                dbo.Data0060 AS Data0060_1 LEFT OUTER JOIN  
                dbo.Data0010 AS Data0010_2 ON Data0060_1.CUSTOMER_PTR = Data0010_2.RKEY ON data0416_6.so_ptr = Data0060_1.RKEY ON   
                dbo.Data0023.RKEY = Data0060_1.supplier_ptr LEFT OUTER JOIN  
                dbo.Data0006 AS Data0006_9 LEFT OUTER JOIN  
                dbo.data0492 AS data0492_6 LEFT OUTER JOIN  
                dbo.Data0001 AS Data0001_3 RIGHT OUTER JOIN  
                dbo.Data0010 AS Data0010_1 RIGHT OUTER JOIN  
                dbo.Data0060 AS Data0060_9 ON Data0010_1.RKEY = Data0060_9.CUSTOMER_PTR ON   
                Data0001_3.RKEY = Data0060_9.CURRENCY_PTR ON data0492_6.SO_NO = Data0060_9.SALES_ORDER ON   
                Data0006_9.CUT_NO = data0492_6.CUT_NO ON Data0053_2.WORK_ORDER_PTR = Data0006_9.RKEY  
        WHERE  (Data0015_6.WAREHOUSE_CODE = 'D0001') AND (Data0025_6.ttype = 0) AND (Data0016_2.CODE = 'ST005') AND (Data0053_2.QTY_ON_HAND > 0))   
    AS 当前库存 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(Data0053_8.QTY_ON_HAND * Data0025_15.unit_sq, 4)), 0), 0) AS 超周期库存面积,  
                ISNULL(ROUND(SUM(Data0025_15.LATEST_PRICE * Data0053_8.QTY_ON_HAND)/ 10000, 0), 0) AS 超周期库存金额  
        FROM    dbo.Data0023 AS Data0023_1 RIGHT OUTER JOIN  
                dbo.Data0008 AS Data0008_1 INNER JOIN  
                dbo.Data0025 AS Data0025_15 ON Data0008_1.RKEY = Data0025_15.PROD_CODE_PTR INNER JOIN  
                dbo.Data0010 AS Data0010_3 ON Data0025_15.CUSTOMER_PTR = Data0010_3.RKEY INNER JOIN  
                dbo.Data0053 AS Data0053_8 INNER JOIN  
                dbo.Data0015 AS Data0015_15 ON Data0053_8.WHSE_PTR = Data0015_15.RKEY INNER JOIN  
                dbo.Data0016 AS Data0016_8 ON Data0053_8.LOC_PTR = Data0016_8.RKEY ON   
                Data0025_15.RKEY = Data0053_8.CUST_PART_PTR INNER JOIN  
                dbo.data0416 AS data0416_5 ON Data0053_8.NPAD_PTR = data0416_5.rkey LEFT OUTER JOIN  
                dbo.Data0060 AS Data0060_1 LEFT OUTER JOIN  
                dbo.Data0010 AS Data0010_2 ON Data0060_1.CUSTOMER_PTR = Data0010_2.RKEY ON data0416_5.so_ptr = Data0060_1.RKEY ON   
                Data0023_1.RKEY = Data0060_1.supplier_ptr LEFT OUTER JOIN  
                dbo.Data0006 AS Data0006_8 LEFT OUTER JOIN  
                dbo.data0492 AS data0492_5 LEFT OUTER JOIN  
                dbo.Data0001 AS Data0001_2 RIGHT OUTER JOIN  
                dbo.Data0010 AS Data0010_1 RIGHT OUTER JOIN  
                dbo.Data0060 AS Data0060_8 ON Data0010_1.RKEY = Data0060_8.CUSTOMER_PTR ON   
                Data0001_2.RKEY = Data0060_8.CURRENCY_PTR ON data0492_5.SO_NO = Data0060_8.SALES_ORDER ON   
                Data0006_8.CUT_NO = data0492_5.CUT_NO ON Data0053_8.WORK_ORDER_PTR = Data0006_8.RKEY  
        WHERE  (Data0015_15.WAREHOUSE_CODE = 'D0001') AND (Data0025_15.ttype = 0) AND (Data0016_8.CODE = 'ST005') AND   
               (Data0053_8.MFG_DATE + /*Data0025_15.REVIEW_DAYS*/ 180 < GETDATE()) AND (Data0053_8.QTY_ON_HAND > 0))   
    AS 超周期库存 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(Data0025_5.unit_sq * dbo.Data0056.QTY_BACKLOG, 4)), 0), 0) AS 当前在线面积  
        FROM    dbo.Data0025 AS Data0025_5 INNER JOIN  
                dbo.Data0006 AS Data0006_4 ON Data0006_4.BOM_PTR = Data0025_5.RKEY INNER JOIN  
                dbo.Data0056 ON dbo.Data0056.WO_PTR = Data0006_4.RKEY INNER JOIN  
                dbo.data0492 AS data0492_3 ON data0492_3.CUT_NO = Data0006_4.CUT_NO INNER JOIN  
                dbo.Data0015 AS Data0015_5 ON data0492_3.WHOUSE_PTR = Data0015_5.RKEY  
        WHERE  (Data0025_5.ttype = 0) AND (ISNULL(Data0025_5.PARENT_PTR, 0) = 0) AND (ISNULL(dbo.Data0056.WTYPE, 0) = 0) AND   
               (Data0015_5.WAREHOUSE_CODE = 'D0001'))   
    AS 当前在线 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(Data0025_5.unit_sq * Data0056_1.QTY_BACKLOG, 4)), 0), 0) AS 当前在线暂缓面积  
        FROM    dbo.Data0025 AS Data0025_5 INNER JOIN  
                dbo.Data0006 AS Data0006_4 ON Data0006_4.BOM_PTR = Data0025_5.RKEY INNER JOIN  
                dbo.Data0056 AS Data0056_1 ON Data0056_1.WO_PTR = Data0006_4.RKEY INNER JOIN  
                dbo.data0492 AS data0492_4 ON data0492_4.CUT_NO = Data0006_4.CUT_NO INNER JOIN  
                dbo.Data0015 AS Data0015_5 ON data0492_4.WHOUSE_PTR = Data0015_5.RKEY  
        WHERE  (Data0025_5.ttype = 0) AND (ISNULL(Data0025_5.PARENT_PTR, 0) = 0) AND (Data0015_5.WAREHOUSE_CODE = 'D0001') AND   
               (Data0006_4.PROD_STATUS = 103))   
    AS 当前在线暂缓 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(dbo.Data0098.QTY_RECD * Data0025_9.unit_sq, 4)), 0), 0) AS 当日退货面积  
        FROM    dbo.Data0098 INNER JOIN  
                dbo.Data0025 AS Data0025_9 ON dbo.Data0098.CUSTOMER_PART_PTR = Data0025_9.RKEY LEFT OUTER JOIN  
                dbo.Data0060 AS Data0060_5 LEFT OUTER JOIN  
                dbo.Data0015 AS Data0015_9 ON Data0060_5.SHIP_REG_TAX_ID = Data0015_9.RKEY ON   
                dbo.Data0098.SO_PTR = Data0060_5.RKEY  
        WHERE  (Data0015_9.WAREHOUSE_CODE = 'D0001') AND   
               (dbo.Data0098.RMA_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120), 120)) AND   
               (dbo.Data0098.RMA_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120), 120)))   
    AS 当日退货 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(Data0098_1.QTY_RECD * Data0025_4.unit_sq, 4)), 0), 0) AS 月累计退货面积  
        FROM    dbo.Data0098 AS Data0098_1 INNER JOIN  
                dbo.Data0025 AS Data0025_4 ON Data0098_1.CUSTOMER_PART_PTR = Data0025_4.RKEY LEFT OUTER JOIN  
                dbo.Data0060 AS Data0060_3 LEFT OUTER JOIN  
                dbo.Data0015 AS Data0015_4 ON Data0060_3.SHIP_REG_TAX_ID = Data0015_4.RKEY ON   
                Data0098_1.SO_PTR = Data0060_3.RKEY  
        WHERE  (Data0015_4.WAREHOUSE_CODE = 'D0001') AND   
               (Data0098_1.RMA_DATE >= CONVERT(datetime, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01', 120)) AND   
               (Data0098_1.RMA_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120), 120)))   
    AS 月累计退货面积 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(Data0053_3.QUANTITY * Data0025_10.unit_sq, 4)), 2), 0) AS 当日尾数入仓面积  
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN  
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN  
                dbo.data0416 AS data0416_2 INNER JOIN  
                dbo.Data0025 AS Data0025_10 INNER JOIN  
                dbo.Data0053 AS Data0053_3 INNER JOIN  
                dbo.Data0015 AS Data0015_10 ON Data0053_3.WHSE_PTR = Data0015_10.RKEY INNER JOIN  
                dbo.Data0016 AS Data0016_3 ON Data0053_3.LOC_PTR = Data0016_3.RKEY ON Data0025_10.RKEY = Data0053_3.CUST_PART_PTR ON   
                data0416_2.rkey = Data0053_3.NPAD_PTR LEFT OUTER JOIN  
                dbo.Data0006 AS Data0006_5 ON Data0053_3.WORK_ORDER_PTR = Data0006_5.RKEY LEFT OUTER JOIN  
                dbo.data0492 AS data0492_2 ON Data0006_5.CUT_NO = data0492_2.CUT_NO ON Data0060_2.SALES_ORDER = data0492_2.SO_NO ON   
                data0060_1.RKEY = data0416_2.so_ptr  
        WHERE  (Data0053_3.QUANTITY > 0) AND (Data0015_10.WAREHOUSE_CODE = 'D0001') AND   
               (Data0053_3.MFG_DATE >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND   
               (Data0053_3.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND   
               (Data0016_3.CODE = 'ST007') AND (Data0053_3.RMA_PTR = 0))   
    AS 当日尾数入仓 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(dbo.Data0465.QUANTITY * dbo.Data0025.unit_sq, 4)), 2), 0) AS 当日尾数出仓面积  
        FROM    dbo.Data0465 INNER JOIN  
                dbo.data0415 ON dbo.Data0465.heard_ptr = dbo.data0415.rkey INNER JOIN  
                dbo.Data0025 ON dbo.data0415.custpart_ptr = dbo.Data0025.RKEY INNER JOIN  
                dbo.Data0053 ON dbo.Data0465.D0053_PTR = dbo.Data0053.RKEY INNER JOIN  
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN  
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY  
        WHERE  (dbo.Data0016.CODE = 'ST007') AND (dbo.data0415.type = 4) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND   
               (dbo.data0415.sys_date >= CONVERT(datetime, CONVERT(varchar(10), DATEADD(day, - 1, GETDATE()), 120) + ' 08:00:00', 120)) AND   
               (dbo.data0415.sys_date <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)))   
    AS 当日尾数出仓 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(Data0053_3.QUANTITY * Data0025_10.unit_sq, 4)), 2), 0) AS 月尾数入仓面积  
        FROM    dbo.Data0060 AS data0060_1 RIGHT OUTER JOIN  
                dbo.Data0060 AS Data0060_2 RIGHT OUTER JOIN  
                dbo.data0416 AS data0416_2 INNER JOIN  
                dbo.Data0025 AS Data0025_10 INNER JOIN  
                dbo.Data0053 AS Data0053_3 INNER JOIN  
                dbo.Data0015 AS Data0015_10 ON Data0053_3.WHSE_PTR = Data0015_10.RKEY INNER JOIN  
                dbo.Data0016 AS Data0016_3 ON Data0053_3.LOC_PTR = Data0016_3.RKEY ON Data0025_10.RKEY = Data0053_3.CUST_PART_PTR ON   
                data0416_2.rkey = Data0053_3.NPAD_PTR LEFT OUTER JOIN  
                dbo.Data0006 AS Data0006_5 ON Data0053_3.WORK_ORDER_PTR = Data0006_5.RKEY LEFT OUTER JOIN  
                dbo.data0492 AS data0492_2 ON Data0006_5.CUT_NO = data0492_2.CUT_NO ON Data0060_2.SALES_ORDER = data0492_2.SO_NO ON   
                data0060_1.RKEY = data0416_2.so_ptr  
        WHERE  (Data0053_3.QUANTITY > 0) AND (Data0015_10.WAREHOUSE_CODE = 'D0001') AND   
               (Data0053_3.MFG_DATE >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND   
               (Data0053_3.MFG_DATE <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)) AND   
               (Data0016_3.CODE = 'ST007') AND (Data0053_3.RMA_PTR = 0))   
    AS 月累计尾数入仓 CROSS JOIN  
       (SELECT  TOP (100) PERCENT   
                ISNULL(ROUND(SUM(ROUND(dbo.Data0465.QUANTITY * dbo.Data0025.unit_sq, 4)), 2), 0) AS 月累计尾数出仓面积  
        FROM    dbo.Data0465 INNER JOIN  
                dbo.data0415 ON dbo.Data0465.heard_ptr = dbo.data0415.rkey INNER JOIN  
                dbo.Data0025 ON dbo.data0415.custpart_ptr = dbo.Data0025.RKEY INNER JOIN  
                dbo.Data0053 ON dbo.Data0465.D0053_PTR = dbo.Data0053.RKEY INNER JOIN  
                dbo.Data0015 ON dbo.Data0053.WHSE_PTR = dbo.Data0015.RKEY INNER JOIN  
                dbo.Data0016 ON dbo.Data0053.LOC_PTR = dbo.Data0016.RKEY  
        WHERE  (dbo.Data0016.CODE = 'ST007') AND (dbo.data0415.type = 4) AND (dbo.Data0015.WAREHOUSE_CODE = 'D0001') AND   
               (dbo.data0415.sys_date >= CONVERT(DATETIME, CONVERT(varchar(8), DATEADD(day, - 1, GETDATE()), 120) + '01 08:00:00', 120)) AND   
               (dbo.data0415.sys_date <= CONVERT(datetime, CONVERT(varchar(10), GETDATE(), 120) + ' 08:00:00', 120)))   
    AS 月累计尾数出仓  