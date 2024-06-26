/****** Object:  View [dbo].[GereedmeldingProductie]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[GereedmeldingProductie]
AS
/*FROM (*/ SELECT gp.Productieorder, gp.Artikel, CASE WHEN i.IsSerialNumberItem = 1 THEN gp.Serienummer ELSE NULL END AS Serienummer, gp.Aantal, FORMAT(gp.proddatum, 'yyyy-MM-dd') AS Proddatum, gp.Geimp_Globe, 
                         gp.XML_gegenereerd, gp.Uitgegeven, gp.Timestamp, CASE WHEN Serienummer IS NULL OR
                         i.IsSerialNumberItem = 0 THEN gp.Timestamp ELSE NULL END AS Ser, gp.id AS SourceId, 'GerProd' AS SourceTable
FROM            dbo.GerProd gp WITH (NOLOCK) INNER JOIN
                         [400]..items i WITH (NOLOCK) ON i.itemcode = Artikel
WHERE        gp.Productieorder LIKE 'PROD%' 
			AND gp.Proddatum > DATEADD(DAY, - 100, GETDATE()) 
			AND gp.Artikel NOT IN ('1003030', '1003050', '1003965','1003287', '1002820', '1003288', '1004340', '1004341')
UNION ALL
SELECT        gp.Productieorder, gp.Artikel, CASE WHEN i.IsSerialNumberItem = 1 THEN gp.Serienummer ELSE NULL END AS Serienummer, gp.Aantal, FORMAT(gp.proddatum, 'yyyy-MM-dd') AS Proddatum, gp.Geimp_Globe, 
                         gp.XML_gegenereerd, gp.Uitgegeven, gp.Timestamp, CASE WHEN gp.Serienummer IS NULL OR
                         i.IsSerialNumberItem = 0 THEN gp.Timestamp ELSE NULL END AS Ser, gp.id AS SourceId, 'GerProd_rework' AS SourceTable
FROM            dbo.GerProd_rework gp WITH (NOLOCK) INNER JOIN
                         [400]..items i WITH (NOLOCK) ON i.itemcode = Artikel LEFT JOIN
                         dbo.gerprod g WITH (NOLOCK) ON g.Productieorder = gp.Productieorder AND g.Artikel = gp.artikel AND g.Serienummer IS NOT NULL AND 
                         g.Serienummer = gp.Serienummer
/* added 25-01-23 to exclude double bookings in gerprod and gerprod_rework*/ 
WHERE		gp.Productieorder LIKE 'PROD%' 
		AND gp.Proddatum > DATEADD(DAY, - 100, GETDATE()) 
		AND g.id IS NULL 
		AND gp.Artikel NOT IN ('1003030', '1003050', '1003965','1003287', '1002820', '1003288', '1004340', '1004341')
/*) A GROUP BY Productieorder,	Artikel,	Serienummer,	Aantal,	Proddatum,	Geimp_Globe,	XML_gegenereerd,	Uitgegeven, SER, SourceId, SourceTable*/ UNION
SELECT        [ProductionOrder], [Itemcode], [SerialNr], [Quantity], FORMAT([syscreated], 'yyyy-MM-dd') AS proddate, 0, 0, 0, 0, 0, id, 
                         '_ST_PRD_Process_Cummulative'
/* CONVERT(Timestamp, CASE WHEN OrderStatus  = 1 THEN QtyReady + QtyReject ELSE QtyReady END)*/ FROM [ProdGlobe_live].[dbo].[_ST_PRD_Process_Cummulative]
WHERE        Status = 0
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[23] 2[32] 3) )"
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
         Top = -96
         Left = 0
      End
      Begin Tables = 
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
         Width = 1590
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 11610
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GereedmeldingProductie'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GereedmeldingProductie'
GO
