/****** Object:  View [dbo].[_ST_PRD_Prod_All]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[_ST_PRD_Prod_All] AS


Select t.ProductionOrder, p.productcode AS ItemCode, t.Quantity AS ProductionPlanned,  t.EndTime
From [192.168.0.3].[Production].[dbo].TblRegBatch t
Inner Join [192.168.0.3].[Production].[dbo].TblRegProducts rp On rp.BatchId = t.BatchId
Inner Join [192.168.0.3].[Production].[dbo].TblProducts p On p.ProductId = t.ProductId
where t.ProductionOrder Like 'PROD%' 
Group By p.productcode,  t.ProductionOrder,  t.Quantity,t.EndTime

GO
