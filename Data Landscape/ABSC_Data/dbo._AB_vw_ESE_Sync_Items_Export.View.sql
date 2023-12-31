/****** Object:  View [dbo].[_AB_vw_ESE_Sync_Items_Export]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[_AB_vw_ESE_Sync_Items_Export] AS
-- Export items
SELECT        
	i.ItemCode
	,i.Description
	,i.SecurityLevel
	,'S' AS Type
	,i.Assortment
	,i.Class_01
	,i.Class_02
	,i.Class_03
	,i.Class_04
	,i.Class_05
	,i.Class_06
	,i.Class_07
	,i.Class_08
	,i.Class_09
	,i.Class_10
	,i.IsSalesItem
	,1 AS IsPurchaseItem -- Export items are Purchase in other dbs
	,i.IsServiceItem
	,i.IsTextItem
	,i.IsStockItem
	,i.IsSerialNumberItem
	,0 AS IsSubAssemblyItem -- No subassembly for Export
	,i.IsPriceRegulationItem
	,i.IsBackOrderItem
	,i.IsFractionAllowedItem
	,i.IsPrintItem
	,i.EANCode
	,i.BARCode
	,i.BARCodeType
	,i.StockCurrency
	,i.StockValuationType
	,i.StockValuationDate
	,'1' AS WareHouse
	--,i.WareHouseLocation
	
	-- EUR prices
	---Added 22-09-2021 LS: calculate costprice and purchase price from ICL list----
	--,i.CostPriceCurrency-- AS CostPriceCurrency_DE
	--,i.CostPriceCalculated AS CostPriceCalculated_DE
	--,i.CostPriceCalculatedManually AS CostPriceCalculatedManually_DE
	--,i.CostPriceStandard AS CostPriceStandard_DE
	--,i.PurchaseCurrency --AS PurchaseCurrency_DE
	--,i.PurchasePrice AS PurchasePrice_DE
	--,i.PurchaseVATPerc --AS PurchaseVATPerc_DE
	--,i.PurchaseVATIncl --AS PurchaseVATIncl_DE

	-- 2021-11-29: 05.300.086 Use costprice for purchase and costprice in 483 an 484. 
	-- Purchase price in USA and German are both in EUR 
	,'EUR' AS PurchaseCurrency
    ,CONVERT(DECIMAL(8,3),i.CostPriceStandard) AS PurchasePrice

	,'EUR' AS CostPriceCurrency_DE
    ,CONVERT(DECIMAL(8,3),i.CostPriceStandard) AS CostPriceStandard_DE

	-- Costprice in USD
	,'USD' AS CostPriceCurrency_US
    ,CONVERT(DECIMAL(8,3),i.CostPriceStandard / r.rate) AS CostPriceStandard_US
	,r.rate AS USD_Rate

	--,s400.bedr1 as PurchasePrice -- 2021-11-29 05.300.086 DO NOT USE ICL list
	-- German cost price in EUR from ICL price list except Set Items and Text Items
	--,CASE WHEN ir400.ItemCoderelated IS NOT NULL OR i.istextitem = 1 THEN 0 ELSE s400.bedr1 END as CostPriceStandard_DE
	-- USA Cost price in USD is ICL Price * actual rate except Set Items and Text Items
	--,CASE WHEN ir400.ItemCoderelated IS NOT NULL OR i.istextitem = 1 THEN 0 ELSE ROUND(s400.bedr1 * r.rate, 3) END AS CostPriceStandard_US
	
	,i.SalesPackagePrice AS SalesPackagePrice_DE
	,i.SalesPackagePrice AS SalesPrice_DE
	
	-- USA SALES Price in USD is Sales Price + AdditionalCosts * fixed rate
	, CONVERT(DECIMAL(8,3), CASE WHEN i.SalesPackagePrice = 0 THEN 0 ELSE (i.SalesPackagePrice + apr.additionalcosts) * apr.rate END ) AS SalesPackagePrice_US
	, CONVERT(DECIMAL(8,3), CASE WHEN i.SalesPackagePrice = 0 THEN 0 ELSE (i.SalesPackagePrice + apr.additionalcosts) * apr.rate END ) AS SalesPrice_US
	
	,i.SalesPriceType
	,i.DimensionsInText
	,i.WeightInText
	--,i.Picture
	--,i.PictureFilename
	,ISNULL(i.UserField_01,'') AS UserField_01 -- 400: Entry check doc
	,ISNULL(i400.UserField_02,'') AS UserField_02_483 -- 400: Warehouse location NL  => 484: Warehouse location USA // Synergy: Category 1
	,ISNULL(i400.UserField_03,'') AS UserField_03_483 -- 400: 2-Bin location NL => 484: 2-Bin location USA 		    // Synergy: Category 2
	,ISNULL(i400.UserField_04,'') AS UserField_04_483 -- 400: Bulk location NL => 484: Bulk location USA 		    // Synergy: PMC
	,ISNULL(i400.UserField_05,'') AS UserField_05 -- 400: Packaging // Synergy: Sales description
	--ISNULL(i.UserField_06,'') AS UserField_06 - 400: Warehouse location Service // Synergy: Set Items 
	--ISNULL(i.UserField_07,'') AS UserField_07 - 400: Bulk location Service // Synergy : Notes
	,ISNULL(i.UserField_08,'') AS UserField_08 -- 400: Product decoding key
	,ISNULL(i.UserField_09,'') AS UserField_09 -- 400: Private label
	,ISNULL(i.UserField_10,'') AS UserField_10 -- 400: Customer article code
	--,i.UserDate_01    -- 400: 
	--,i.UserDate_02    -- 400: 
	--,i.UserDate_03    -- 400: 
	--,i.UserDate_04    -- 400: 
	--,i.UserDate_05    -- 400: 
	,i.UserNumber_01 AS Usernumber_13_483 -- 400: // Synergy: Leadtime NL
	,i.UserNumber_02 AS Usernumber_13_484 -- 400: // Synergy: Leadtime USA
	,i.UserNumber_03    -- 400: CTS 
	,i.UserNumber_04    -- 400: Revision
	,i.UserNumber_05    -- 400: Warranty article?
	,i.UserNumber_06    -- 400: Export license required?
	--,i.UserNumber_07  -- 400: 
	--,i.UserNumber_08  -- 400: 
	,i.UserNumber_09    -- 400: Statist. nr. import
	,i.UserNumber_10    -- 400: Statist. nr. import dl. 2. 
	--,i.UserNumber_11  -- 400: Kardex
	--,i.UserNumber_12  -- 400: / 484: USD Price
	--,i.UserNumber_13  -- 400: 
	,i.UserYesNo_01	    -- 400: Entry check required?
	,i.UserYesNo_02	    -- 400: Serial article?
	,i400.UserYesNo_03  -- 400: Kan-Ban? // Synergy : Pricelist?
	,i.UserYesNo_04	    -- 400: Barcode on product?
	,i.UserYesNo_05	    -- 400: Set article?
	,i.RegulationType
	,i.RegulationFixedAmount
	,i.RegulationAmount
	,i.RegulationCurrency
	,i.RegulationPercentage
	,i.RegulationItemsIncluded
	,i.RegulationItemsExcluded
	,i.RegulationPriority
	,i.ItemCodeReplacement
	,i.ItemType
	,0 AS IsAssembled -- No assembly for export
	,i.SearchCode
	,i.eenh_verk
	,i.aant_verp	
	,i.PurchaseOrderAdviceCode
	--,i.SalesVatCode
	--,i.PurchaseVatCode
	,i.StatisticalNumber
	,i.PackageDescription
	,i.SerialBatchItem
	,i.IsBatchItem
	,i.IsBackToBackOrder
	,i.PurchaseFactor
	,i.SalesFactor
	,i.StatisticalUnits
	,i.NetWeight
	,i.GrossWeight
	,i.ExtraDutyVATcode
	,i.SalesMarginPercent
	--,i.status
	,i.Condition AS Condition_ESE
	,'B' AS Condition_US_NEW -- LS 19-01-30 : 04.829.437
	,i.IsDiscount
	,i.IsExplode
	,i.IsCentralItem
	,'151048' AS lev_crdnr -- Default for Export
	,i.Percentage_1
	,i.Percentage_2
	,i.Description_0
	,i.Description_1
	,i.Description_2
	,i.Description_3
	,i.Description_4
	,i.LongDescription
	,i.TextDescription
	,i.GLAccountRevenue
	,i.GLAccountCost
	,i.GLAccountDistribution AS GLAccountDistribution_NEW -- Do NOT UPDATE GLAccountDistribution because of loss of inventory
	--,i.GLAccountAsset
	--,i.LevelCode
	--,i.CountingCycle
	,i.RequiresApprovedSupplier
	--,i.OrderPolicyCode
	,i.PeriodOrderDays
	,i.StatisticalFactorSales
	,i.StatisticalFactorPurchase
	,i.TaxItemClassification
	,i.ConfigurationClass
	,i.ConfigurationModel
	,i.ValuationMethod
	,i.Shelflife
	,i.Warranty
	,i.IsOutsideProcess
	,i.GLAccountStkCoverage
	,i.GLAccountStkChange
	,i.ItemToBeReceivedLedger
	--,i.Division
	,i.IsBillableItem
	,i.IsProductiveItem
	--,i.syscreator
	,i.sysmodified AS ESE_sysmodified
	,CURRENT_TIMESTAMP AS sysmodified
	,i.TsCRC
	

	FROM dbo._AB_sy_ESE_Items i WITH (NOLOCK)
	INNER JOIN [400].dbo.items i400 WITH (NOLOCK) ON i400.Itemcode = i.Itemcode
	
	LEFT JOIN ( 
		SELECT itemcode, MAX(itemcoderelated) AS itemcoderelated
		FROM [400].dbo.ItemRelations ir WITH (NOLOCK) 
		GROUP BY itemcode
	) ir400 ON i.itemcode = ir400.itemcode

	-- Purchase price from ICL pricelist
	LEFT JOIN (
		SELECT artcode, MAX(bedr1) AS bedr1
		FROM [400].dbo.staffl s WITH (NOLOCK) 
		WHERE s.prijslijst = 'ICL' AND s.kort_pbn = 'N' AND s.aantal1 = 1 AND s.accountid IS NULL 
		AND ISNULL(s.validfrom,GETDATE()) <= GETDATE() AND ISNULL(s.validto,GETDATE()) >= GETDATE() 
		GROUP BY artcode ) s400 ON s400.artcode = i.itemcode

	-- US Price rates
	OUTER APPLY (
		SELECT TOP (1) (CASE WHEN y.rate_exchange=0 THEN 0 ELSE 1/y.rate_exchange END ) AS rate
			FROM (	SELECT source_currency AS CurrencyCode,  rates.date_l , rates.rate_exchange 
					FROM dbo._AB_sy_US_Rates rates WHERE rates.target_Currency = 'USD') y 
						INNER JOIN dbo._AB_sy_US_valuta v ON y.CurrencyCode = v.valcode 
						INNER JOIN (SELECT DISTINCT s.Cur, MAX (s.date_l) AS LastDate 
									FROM (	SELECT source_currency AS Cur, date_l 
											FROM dbo._AB_sy_US_Rates) s  
											WHERE s.Date_l <= CURRENT_TIMESTAMP GROUP BY s.cur
									) AS x 
							ON x.Cur = y.currencycode AND x.LastDate = y.date_l 
					WHERE v.Active = 1 AND y.date_l <= CURRENT_TIMESTAMP--{d '2018-03-15'}
						AND y.CurrencyCode = 'EUR'
		ORDER BY y.rate_exchange DESC
	) r
	-- Item Price rates
	OUTER APPLY (
		SELECT TOP (1) apr.rate, apr.additionalcosts
		FROM dbo._AB_sy_US_ArticlePriceRates apr WITH (NOLOCK)
		WHERE 1=1
			AND (i.ItemCode LIKE apr.Code + '%')
			OR apr.Code = '00' -- Default
		ORDER BY apr.Code DESC -- Default last
	) apr
WHERE 1=1
	AND i.IsSalesItem = 1 -- In Sales administration only sales items
	AND (i.Warehouse = '1' OR i.Warehouse = 'S20') -- Default warehouse and Service
	AND (i.Type = 'S' OR i.Type = 'B') -- Standard Items and Bulk Items



--SELECT TOP (1) (case when y.rate_exchange=0 then 0 else 1/y.rate_exchange end ) as rate
--	FROM (	SELECT source_currency AS CurrencyCode,  rates.date_l , rates.rate_exchange 
--			FROM dbo._AB_sy_US_Rates rates WHERE rates.target_Currency = 'USD') y 
--				INNER JOIN dbo._AB_sy_US_valuta v ON y.CurrencyCode = v.valcode 
--				INNER JOIN (SELECT DISTINCT s.Cur, max (s.date_l) AS LastDate 
--							FROM (	SELECT source_currency AS Cur, date_l 
--									FROM dbo._AB_sy_US_Rates) s  
--									WHERE s.Date_l <= CURRENT_TIMESTAMP GROUP BY s.cur
--							) AS x 
--					ON x.Cur = y.currencycode AND x.LastDate = y.date_l 
--			WHERE v.Active = 1 AND y.date_l <= CURRENT_TIMESTAMP--{d '2018-03-15'}
--				and y.CurrencyCode = 'EUR'
--ORDER BY y.rate_exchange DESC

--SELECT TOP (1) apr.rate
--FROM dbo._AB_sy_US_ArticlePriceRates apr WITH (NOLOCK)
--WHERE 1=1
--	AND ('0208902' LIKE apr.Code + '%')
--	OR apr.Code = '00' -- Default
--ORDER BY apr.Code DESC -- Default last























GO
