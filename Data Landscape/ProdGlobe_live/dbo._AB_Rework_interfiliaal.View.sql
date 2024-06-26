/****** Object:  View [dbo].[_AB_Rework_interfiliaal]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[_AB_Rework_interfiliaal]
AS

-- EDIT 2022-12-01: Added [_ST_PRD_Process_Cummulative]
--- replaced  CAST(DATEPART(yyyy, Proddatum) AS NVARCHAR) + '-' + (CASE WHEN (DATEPART(mm, proddatum) < 10)  THEN '0' + CAST(DATEPART(mm, proddatum) AS NVARCHAR) ELSE CAST(DATEPART(mm, proddatum) AS NVARCHAR) END) + '-' + (CASE WHEN (DATEPART(dd, proddatum) < 10) THEN '0' + CAST(DATEPART(dd, proddatum) AS NVARCHAR) ELSE CAST(DATEPART(dd, proddatum) AS NVARCHAR) END) AS
--  by  FORMAT (proddatum, 'yyyy-MM-dd')
--  Added and Proddatum > '2022-11-01'
--  replaced productieorder is not null by Productieorder LIKE 'PROD%'

SELECT     dbo.GerProd_rework.Artikel, dbo.GerProd_rework.Serienummer, dbo.GerProd_rework.Aantal, FORMAT (proddatum, 'yyyy-MM-dd') AS Proddatum, 
				LTRIM([400].dbo.Items.GLAccountDistribution) AS Vrrdrek, 
                      [400].dbo.Items.CostPriceStandard, dbo.GerProd_rework.Productieorder, [400].dbo.Items.PackageDescription AS Eenheid, 
                      dbo.GerProd_rework.Uitgegeven
FROM         [400].dbo.Items WITH (NOLOCK) RIGHT OUTER JOIN
                      dbo.GerProd_rework WITH (NOLOCK) ON [400].dbo.Items.ItemCode = dbo.GerProd_rework.Artikel
WHERE     (dbo.GerProd_rework.Productieorder LIKE 'PROD%' AND GerProd_rework.Proddatum > '2022-11-01')


UNION 
 SELECT p.[Itemcode], p.[SerialNr] ,p.QtyReject, FORMAT (p.[syscreated], 'yyyy-MM-dd') , LTRIM(i.GLAccountDistribution) AS Vrrdrek, 
                      i.CostPriceStandard, p.Productionorder, i.PackageDescription, 0
 FROM [ProdGlobe_live].[dbo].[_ST_PRD_Process_Cummulative] p
 INNER JOIN [400]..items i WITH (NOLOCK) ON i.itemcode = p.Itemcode
 WHERE 1=1
   --SR (exact.Orlaco.nl) 05.375.706
  --SR  (customers.absc.nl) 02.926.144
 AND p.QtyReject > 0
--	AND p.OrderStatus = 1 --(This is part of the change)
 AND p.Status = 2




GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[22] 2[20] 3) )"
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
         Begin Table = "Items (400.dbo)"
            Begin Extent = 
               Top = 15
               Left = 307
               Bottom = 123
               Right = 524
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GerProd_rework"
            Begin Extent = 
               Top = 10
               Left = 80
               Bottom = 118
               Right = 247
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
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 2745
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
         Column = 5595
         Alias = 900
         Table = 2655
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_AB_Rework_interfiliaal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_AB_Rework_interfiliaal'
GO
