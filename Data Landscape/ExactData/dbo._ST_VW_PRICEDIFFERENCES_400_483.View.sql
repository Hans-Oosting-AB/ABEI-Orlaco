/****** Object:  View [dbo].[_ST_VW_PRICEDIFFERENCES_400_483]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[_ST_VW_PRICEDIFFERENCES_400_483]
AS
Select top 100 percent i400.itemcode,
	i400.Description,				
	i400.IsSalesItem, 				
	i400.Condition AS Condition400, 	
	i400.eenh_verk AS Unitcode,
	i400.SalesPackagePrice AS SalesPackagePrice400, 				
	s400.prijs83 AS SalesPrice400, 	
	i483.Condition AS Condition483,
	i483.SalesPackagePrice AS SalesPackagePrice483, 				
	s483.prijs83 AS SalesPrice483,
	i400.CostPriceStandard  AS CostPrice400,
	i483.CostPriceStandard			   AS CostPrice483
from [400]..Items i400(nolock)
LEFT OUTER JOIN [400]..staffl s400 (NOLOCK) ON s400.prijslijst = 'SALESPRICE' AND i400.itemcode = s400.artcode AND s400.validto IS NULL	
LEFT OUTER JOIN [483]..Items i483 (NOLOCK) ON i400.itemcode = i483.itemcode
LEFT OUTER JOIN [483]..staffl s483 (NOLOCK) ON s483.prijslijst = 'SALESPRICE' AND i483.itemcode = s483.artcode  AND s483.validto IS NULL			
ORDER BY i400.ItemCode	
			
GO
