/****** Object:  View [dbo].[_AB_vw_DetailPacklist_TransferProduction]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[_AB_vw_DetailPacklist_TransferProduction]
AS
-- =======================================================================================================
-- Author     : AB Software & Consultacy, GvB
-- Create date: 2019-05-23 Anne & Ger  
--
-- Modified   : 2019-12-05 LVE
--       
-- Description: Details Paklijst ten bevoeve van production transfer 60 -> 62 en USA
-- =======================================================================================================

SELECT t.HID, t.absenceid, t.itemcode, i.description
	, t.itemnumber as serialnumber, t.statisticalnumber, t.quantity
	, t.packagedescription as unit, t.origin
	, CONVERT(VARCHAR(12),t.syscreated,105) AS transferdate
FROM dbo._AB_tb_TransfersOrders t WITH (NOLOCK)
	INNER JOIN dbo._AB_sy_Items i WITH (NOLOCK)
		ON i.ItemCode = t.ItemCode COLLATE DATABASE_DEFAULT

-- Old
--SELECT 
--	[OA_AB].HID AS HID
--	, LTRIM(RTRIM([ABTOS].absenceid)) AS absenceid
--	, LTRIM(RTRIM([ABTOS].itemcode)) AS itemcode
--	, LTRIM(RTRIM([OA_ITEMS].[description])) AS [description]
--	, LTRIM(RTRIM([ABTOS].[itemnumbernumber])) AS serialnumber
--	, LTRIM(RTRIM([ABTOS].statisticalnumber)) AS [statisticalnumber]
--	, [ABTOS].quantity AS [quantity]
--	, LTRIM(RTRIM([ABTOS].packagedescription)) as [unit]
--	, LTRIM(RTRIM([ABTOS].orgin)) as [origin]
--	, CONVERT (VARCHAR(12),[ABTOS].syscreated,105) AS [transferdate]
--FROM  [ABSC_Data].[dbo].[_AB_tb_TransfersOrders] AS ABTOS WITH (nolock)

-- OUTER APPLY 
--    (
--        SELECT TOP(1)
--            [AB].HID
--        FROM [ABSC_Data].[dbo].[_AB_tb_TransfersAbsenceIdReg] AS AB WITH (nolock)
--        WHERE 1 = 1 
--        AND [AB].[absenceid] = [ABTOS].[absenceid]
--    ) AS OA_AB

--	 OUTER APPLY 
--    (
--        SELECT TOP(1)
--            [I].Description AS [description]
--            , [I].glaccountdistribution
--        FROM [100].[dbo].[Items] AS [I] WITH (nolock)
--        WHERE 1 = 1 
--        AND [I].ItemCode = [ABTOS].itemcode COLLATE database_Default
--    ) AS OA_ITEMS



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
         Begin Table = "_AB_tb_TransfersOrders"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 235
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_AB_vw_DetailPacklist_TransferProduction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_AB_vw_DetailPacklist_TransferProduction'
GO
