/****** Object:  View [dbo].[_AB_prkrg]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[_AB_prkrg]
AS
SELECT     TOP (100) PERCENT [400].dbo.gbkmut.project, [400].dbo.Items.ItemCode, [400].dbo.Items.Description, [400].dbo.PRProject.Status, 
                      [400].dbo.PRProject.Description AS Projectomschrijving, [400].dbo.gbkmut.oms25 AS Productieomschrijving, [400].dbo.Items.Class_01, 
                      [400].dbo.Items.Type, [400].dbo.Items.PackageDescription, [400].dbo.Items.UserNumber_01, [400].dbo.Items.UserYesNo_01 AS COA, 
                      [400].dbo.gbkmut.bkstnr_sub AS ordernr, [400].dbo.gbkmut.faktuurnr, SUM(CASE WHEN gbkmut.transtype = 'B' AND 
                      gbkmut.freefield1 = 'P' THEN gbkmut.aantal ELSE 0 END) AS Aantal, SUM(CASE WHEN gbkmut.transtype IN ('N', 'X') THEN gbkmut.aantal ELSE 0 END) 
                      AS QtyActual, MIN([400].dbo.gbkmut.StartTime) AS Datum, MAX([400].dbo.gbkmut.EndTime) AS EndDate, [400].dbo.gbkmut.warehouse
FROM         [400].dbo.gbkmut WITH (nolock) INNER JOIN
                      [400].dbo.Items WITH (nolock) ON [400].dbo.Items.ItemCode = [400].dbo.gbkmut.artcode AND 
                      [400].dbo.gbkmut.reknr = [400].dbo.Items.GLAccountDistribution INNER JOIN
                      [400].dbo.PRProject WITH (nolock) ON [400].dbo.PRProject.ProjectNr = [400].dbo.gbkmut.project AND [400].dbo.PRProject.Type = 'P'
WHERE     ([400].dbo.gbkmut.transsubtype IN ('A', 'J'))
GROUP BY [400].dbo.gbkmut.project, [400].dbo.gbkmut.artcode, [400].dbo.Items.ItemCode, [400].dbo.Items.Description, [400].dbo.PRProject.Status, 
                      [400].dbo.PRProject.Description, [400].dbo.Items.Class_01, [400].dbo.Items.Type, [400].dbo.Items.PackageDescription, 
                      [400].dbo.Items.UserNumber_01, [400].dbo.Items.UserYesNo_01, [400].dbo.gbkmut.bkstnr_sub, [400].dbo.gbkmut.faktuurnr, [400].dbo.gbkmut.oms25, 
                      [400].dbo.gbkmut.warehouse
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[23] 2[20] 3) )"
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
         Begin Table = "gbkmut (400.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 294
            End
            DisplayFlags = 280
            TopColumn = 85
         End
         Begin Table = "Items (400.dbo)"
            Begin Extent = 
               Top = 26
               Left = 663
               Bottom = 134
               Right = 896
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PRProject (400.dbo)"
            Begin Extent = 
               Top = 139
               Left = 1204
               Bottom = 247
               Right = 1437
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
      Begin ColumnWidths = 23
         Width = 284
         Width = 1500
         Width = 1245
         Width = 1545
         Width = 1500
         Width = 1815
         Width = 1980
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
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 1845
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_AB_prkrg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       Filter = 3015
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_AB_prkrg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_AB_prkrg'
GO
