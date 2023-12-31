/****** Object:  View [dbo].[_ST_VW_USAPriceDifference]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[_ST_VW_USAPriceDifference]
AS
SELECT TOP 100 PERCENT i400.Itemcode, 					
	i400.Description,				
	i400.IsSalesItem, 				
	i400.Condition AS Condition400, 	
	i400.eenh_verk AS Unitcode,
	i400.SalesPackagePrice AS SalesPackagePrice400, 				
	s400.prijs83 AS SalesPrice400, 				
	i484.Condition AS Condition484, 				
	ROUND( CASE WHEN s400.prijs83 = 0 THEN 0 				
				ELSE CASE WHEN apr.rate IS NULL 	
					THEN (SELECT (i400.SalesPackagePrice + apr2.AdditionalCosts) * apr2.Rate FROM [484].dbo._AB_ArticlePriceRates apr2 WITH (NOLOCK) WHERE apr2.code = '00') 
					ELSE (i400.SalesPackagePrice + apr.AdditionalCosts) * apr.Rate END END, 3 ) AS CalculatedDollarPrice,
	i484.SalesPackagePrice AS SalesPackagePrice484, 				
	s484.prijs83 AS SalesPrice484, 				
	ROUND( CASE WHEN s400.prijs83 = 0 THEN 0 				
				ELSE CASE WHEN apr.rate IS NULL 	
					THEN (SELECT (i400.SalesPackagePrice + apr2.AdditionalCosts) * apr2.ImportDuty FROM [484].dbo._AB_ArticlePriceRates apr2 WITH (NOLOCK) WHERE apr2.code = '00') 
					ELSE (i400.SalesPackagePrice + apr.AdditionalCosts) * apr.ImportDuty END END, 3 ) AS CalculatedEuroPrice, 
	se484.prijs83 AS SalesPriceEuro484,
	i400.CostPriceStandard			   AS CostPrice400,
	ROUND((SELECT i400.CostPriceStandard / (CASE WHEN y.rate_exchange=0 THEN 0 ELSE 1/y.rate_exchange END ) 
        FROM (SELECT source_currency AS CurrencyCode,  rates.date_l , rates.rate_exchange FROM [484].dbo.rates WHERE rates.target_Currency = 'USD') y 
        INNER JOIN [484].dbo.valuta v ON y.CurrencyCode = v.valcode 
        INNER JOIN (SELECT DISTINCT s.Cur, MAX (s.date_l) AS LastDate FROM (SELECT source_currency AS Cur, date_l FROM [484].dbo.Rates) s  WHERE s.Date_l <= CURRENT_TIMESTAMP GROUP BY s.cur) AS x 
        ON x.Cur = y.currencycode AND x.LastDate = y.date_l 
        WHERE v.Active = 1 AND y.date_l <= CURRENT_TIMESTAMP--{d '2018-03-15'}
        AND y.CurrencyCode = 'EUR' ),3) AS CostpriceCalculated,
	i484.CostPriceStandard			   AS CostPrice484

FROM [400]..Items i400 (NOLOCK)					
LEFT OUTER JOIN [400]..staffl s400 (NOLOCK) ON s400.prijslijst = 'SALESPRICE' AND i400.itemcode = s400.artcode AND s400.validto IS NULL					
LEFT OUTER JOIN [484]..Items i484 (NOLOCK) ON i400.itemcode = i484.itemcode 				
LEFT OUTER JOIN [484].dbo._AB_ArticlePriceRates apr WITH (NOLOCK) ON i484.ItemCode LIKE apr.Code + '%'					
LEFT OUTER JOIN [484]..staffl s484 (NOLOCK) ON s484.prijslijst = 'SALESPRICE' AND i484.itemcode = s484.artcode  AND s484.validto IS NULL					
LEFT OUTER JOIN [484]..staffl se484 (NOLOCK) ON se484.prijslijst = 'SALESPRICE_EURO' AND i484.itemcode = se484.artcode  AND se484.validto IS NULL					
ORDER BY i400.ItemCode					

GO
