/****** Object:  View [dbo].[_ST_Stock_Productcode_484]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[_ST_Stock_Productcode_484]
AS
SELECT TOP (100) PERCENT it.ItemCode, it.Description, it.Assortment, 
it.Class_08, 
ROUND( it.CostPriceStandard, 3) AS CostPrice, 
g.warehouse AS Warehouse, 
ROUND(SUM(g.aantal),3) AS Stock,
ROUND(SUM(g.aantal) * it.CostPriceStandard,3) AS StockCostPrice
FROM     [484].dbo.gbkmut AS g WITH (nolock) INNER JOIN
                  [484].dbo.Items AS it WITH (nolock) ON g.artcode = it.ItemCode AND g.reknr = it.GLAccountDistribution
WHERE  (g.transtype = 'N')
GROUP BY it.ItemCode, it.Description, it.Assortment, it.Class_08, it.CostPriceStandard, it.PurchasePrice, g.warehouse
HAVING SUM(g.aantal) > 0

GO
