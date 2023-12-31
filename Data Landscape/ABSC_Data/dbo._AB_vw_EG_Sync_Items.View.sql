/****** Object:  View [dbo].[_AB_vw_EG_Sync_Items]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

















CREATE VIEW [dbo].[_AB_vw_EG_Sync_Items] AS
-- Internal items
SELECT
	i.ItemCode
	,i.Description
	,i.SecurityLevel
	,i.Type
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
	,i.IsPurchaseItem
	,i.IsServiceItem
	,i.IsTextItem
	,i.IsStockItem
	,i.IsSerialNumberItem
	,i.IsSubAssemblyItem
	,i.IsPriceRegulationItem
	,i.IsBackOrderItem
	,i.IsFractionAllowedItem
	,i.IsPrintItem
	--,i.EANCode
	--,i.BARCode
	--,i.BARCodeType
	--,i.StockCurrency
	--,i.StockValuationType
	--,i.StockValuationDate
	,i.WareHouse
	--,i.WareHouseLocation
	,i.CostPriceCurrency
	,i.CostPriceCalculated 
	,i.CostPriceCalculatedManually 
	,i.CostPriceStandard
	--,i.PurchaseCurrency
	--,i.PurchasePrice
	--,i.PurchaseVATPerc
	--,i.PurchaseVATIncl
	,i.SalesPriceType
	--,i.DimensionsInText
	--,i.WeightInText
	--,cast(i.Picture as varchar(1000)) as Picture
	--,i.PictureFilename
	,ISNULL(i.UserField_01,'') AS UserField_01 -- 400: Entry check doc
	--,ISNULL(i.UserField_02,'') AS UserField_02 -- 400: Warehouse location NL / 484: Warehouse location USA / Synergy: Category 1
	--,ISNULL(i.UserField_03,'') AS UserField_03 -- 400: 2-BIN location NL / 484: 2-BIN location USA / Synergy : Category 2
	--,ISNULL(i.UserField_04,'') AS UserField_04 -- 400: Bulk location NL / 484: Bulk location USA / Synergy : PMC
	--,ISNULL(i.UserField_05,'') AS UserField_05 -- 400: Packaging / Synergy: Sales Description
	--,ISNULL(i.UserField_06,'') AS UserField_06 -- 400: Warehouse location Service  / Synergy: Set Items
	,ISNULL(CONVERT(VARCHAR(MAX),
		(SELECT  CONVERT(VARCHAR(MAX),ir.Quantity) + 'x ' + ir.ItemCodeRelated +  ' - ' + 
		LEFT(iri.DESCRIPTION, 
			(255 - ((SELECT COUNT(*) FROM [400]..itemrelations irc WITH (NOLOCK) WHERE i.itemcode = irc.itemcode) * 16))/
					(SELECT COUNT(*) FROM [400]..itemrelations irc WITH (NOLOCK) WHERE i.itemcode = irc.itemcode) 
		) + '; '  
		FROM [400]..itemrelations ir WITH (NOLOCK)
		INNER JOIN [400]..items iri WITH (NOLOCK) ON iri.itemcode = ir.itemcoderelated
		WHERE i.itemcode = ir.itemcode
		FOR XML PATH(''), TYPE )
	),'') AS UserField_06    -- Synergy: Set items
	--,ISNULL(i.UserField_07 , '') AS UserField_07 -- 400: Bulk location Service   / Synergy: Notes
	,ISNULL(i.UserField_08 , '') AS UserField_08  -- 400: Product decoding key
	,ISNULL(i.UserField_09 , '') AS UserField_09  -- 400: Private label
	,ISNULL(i.UserField_10 , '') AS UserField_10  -- 400: Customer article code
	,ISNULL(i.UserDate_01  , '') AS UserDate_01   -- 400: 
	,ISNULL(i.UserDate_02  , '') AS UserDate_02   -- 400: 
	,ISNULL(i.UserDate_03  , '') AS UserDate_03   -- 400: 
	,ISNULL(i.UserDate_04  , '') AS UserDate_04   -- 400: 
	,ISNULL(i.UserDate_05  , '') AS UserDate_05   -- 400: 
	--,ISNULL(i.UserNumber_01, '') AS UserNumber_01 -- 400:  / Synergy : Delivery time in weeks
	--,ISNULL(i.UserNumber_02, '') AS UserNumber_02 -- 400:  / Synergy : Delivery time USA in weeks
	,ISNULL(i.UserNumber_03, '') AS UserNumber_03 -- 400: CTS
	,ISNULL(i.UserNumber_04, '') AS UserNumber_04 -- 400: Revision
	,ISNULL(i.UserNumber_05, '') AS UserNumber_05 -- 400: Warranty article?
	,ISNULL(i.UserNumber_06, '') AS UserNumber_06 -- 400: Export license required?
	,ISNULL(i.UserNumber_07, '') AS UserNumber_07 -- 400: 
	,ISNULL(i.UserNumber_08, '') AS UserNumber_08 -- 400:  
	,ISNULL(i.UserNumber_09, '') AS UserNumber_09 -- 400: Statist. nr. import
	,ISNULL(i.UserNumber_10, '') AS UserNumber_10 -- 400: Statist. nr. import dl.2
	,ISNULL(i.UserNumber_11, '') AS UserNumber_11 -- 400: Kardex
	--,ISNULL(i.UserNumber_12, '') AS UserNumber_12 -- 400:  / 484: USD Price
	,ISNULL(i.UserNumber_13, '') AS UserNumber_13 -- 400: 
	,ISNULL(i.UserYesNo_01	, '') AS UserYesNo_01	-- 400: Entry check required?
	,ISNULL(i.UserYesNo_02	, '') AS UserYesNo_02	-- 400: Serial article?
	--,ISNULL(i.UserYesNo_03	, '') AS UserYesNo_03	-- 400: Kan-Ban? / Synergy: Pricelist?
	,ISNULL(i.UserYesNo_04	, '') AS UserYesNo_04	-- 400: Barcode on product?
	,ISNULL(i.UserYesNo_05	, '') AS UserYesNo_05	-- 400: Set article?
	--,i.RegulationType
	--,i.RegulationFixedAmount
	--,i.RegulationAmount
	--,i.RegulationCurrency
	--,i.RegulationPercentage
	--,i.RegulationItemsIncluded
	--,i.RegulationItemsExcluded
	--,i.RegulationPriority
	,i.ItemCodeReplacement
	,i.ItemType
	,i.IsAssembled
	,i.SearchCode
	,i.eenh_verk
	,i.aant_verp
	,CONVERT(NUMERIC(8,3),ISNULL(sp.SalesPrice,0)) AS SalesPrice  -- GET SalesPrice from SALESPRICE pricelist because SalesPackagePrice is not allways set
	,CONVERT(NUMERIC(8,3),ISNULL(sp.SalesPrice,0)) AS SalesPackagePrice
	--,i.SalesPackagePrice
	--,i.PurchaseOrderAdviceCode
	,i.SalesVatCode
	,i.PurchaseVatCode
	,i.StatisticalNumber
	--,i.PackageDescription
	,i.SerialBatchItem
	,i.IsBatchItem
	,i.IsBackToBackOrder
	--,i.PurchaseFactor
	--,i.SalesFactor
	,i.StatisticalUnits 
	,i.NetWeight
	,i.GrossWeight
	,i.ExtraDutyVATcode
	,i.SalesMarginPercent 
	,i.STATUS
	,i.Condition
	,i.IsDiscount
	,i.IsExplode
	--,i.IsCentralItem
	,i.lev_crdnr
	,i.Percentage_1
	,i.Percentage_2
	,i.Description_0
	,i.Description_1
	,i.Description_2
	,i.Description_3
	,i.Description_4
	--,i.LongDescription
	,i.TextDescription
	,i.GLAccountRevenue
	,i.GLAccountCost
	,i.GLAccountDistribution
	,i.GLAccountAsset
	,i.LevelCode
	,i.CountingCycle
	,i.RequiresApprovedSupplier
	,i.OrderPolicyCode
	,i.PeriodOrderDays
	,i.StatisticalFactorSales
	,i.StatisticalFactorPurchase
	,i.TaxItemClassification
	,i.ConfigurationClass
	,i.ValuationMethod
	,i.Shelflife
	,i.Warranty
	--,i.IsOutsideProcess
	--,i.GLAccountStkCoverage
	--,i.GLAccountStkChange
	--,i.ItemToBeReceivedLedger
	--,i.Division
	--,i.IsBillableItem
	--,i.IsProductiveItem
	--,i.syscreator
	,i.sysmodified AS EG_sysmodified
	,CURRENT_TIMESTAMP AS sysmodified
	--,i.TsCRC
FROM dbo._AB_sy_Items i WITH (NOLOCK)
LEFT JOIN 
(SELECT artcode, MAX(prijs83) AS SalesPrice 
	FROM dbo._AB_sy_staffl s WITH (NOLOCK) WHERE s.prijslijst = 'SALESPRICE' AND ISNULL(s.ValidTO,GETDATE()) >= GETDATE() 
	GROUP BY artcode ) sp ON i.itemcode = sp.artcode 
WHERE --IsSalesItem = 1 AND  -- LS: Parts and materials needs to be in synergy for purchase end quality control
	 (i.Warehouse = '1' OR i.Warehouse = 'S20') -- Default warehouse and Service
	 AND (i.TYPE = 'S' OR i.TYPE = 'B') -- Standard Items and Bulk Items
















GO
