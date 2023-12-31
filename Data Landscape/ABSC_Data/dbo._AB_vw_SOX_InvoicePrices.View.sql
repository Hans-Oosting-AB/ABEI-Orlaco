/****** Object:  View [dbo].[_AB_vw_SOX_InvoicePrices]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[_AB_vw_SOX_InvoicePrices] AS
SELECT k.ordernr, k.faknr, k.fak_soort, k.fakdebnr, k.refer, k.docnumber
	, r.regel, r.artcode, r.esr_aantal, r.magcode

	, r.prijs83 AS GPrice_Order
	, COALESCE(pd.prijs83, po.prijs83, i.SalesPackagePrice) AS GPrice_Order_Exact
	
	, r.prijs_n AS NPrice_Order -- This can be 0 when discount is 100
	, COALESCE(pd.calc_bedr1, po.calc_bedr1, i.SalesPackagePrice) AS NPrice_Order_Exact

	, r.korting AS Discount
	, r.prijslijst AS PriceList_Order
	, c.PriceList AS PriceList_Debtor

	, i.SalesPackagePrice AS Price_Item
	, pd.prijs83 AS GPrice_PriceList_Debtor
	, po.prijs83 AS GPrice_PriceList_Order	

	, pd.calc_bedr1 AS NPrice_PriceList_Debtor
	, po.calc_bedr1 AS NPrice_PriceList_Order

	, r.sysmodified
	, 0 AS isHistory

	, CONCAT(CASE WHEN ISNULL(r.prijslijst,'') != ISNULL(c.PriceList, '') AND pd.prijs83 IS NOT NULL THEN 'Pricelist order differs from Debtor pricelist and price available; ' END
		, CASE WHEN ISNULL(r.prijslijst,'') != ISNULL(c.PriceList, '') AND pd.prijs83 IS NULL THEN 'Pricelist order differs from Debtor pricelist but item is not in pricelist debtor; ' END
		-- GPrice_PriceList_Debtor, GPrice_PriceList_Order
		, CASE WHEN ABS(COALESCE(pd.prijs83, po.prijs83, i.SalesPackagePrice) - r.prijs83) > 0.01 THEN 'Gross price differs from default price; ' END
		, CASE WHEN ABS(COALESCE(pd.calc_bedr1, po.calc_bedr1, i.SalesPackagePrice) - r.prijs_n) > 0.01 THEN 'Net price differs from default price; ' END
		) AS check_mssg
	, CASE WHEN ISNULL(r.prijslijst,'') != ISNULL(c.PriceList, '') AND pd.prijs83 IS NOT NULL THEN -1
		WHEN ISNULL(r.prijslijst,'') != ISNULL(c.PriceList, '') AND pd.prijs83 IS NULL THEN 1
		-- GPrice_PriceList_Debtor, GPrice_PriceList_Order
		WHEN ABS(COALESCE(pd.prijs83, po.prijs83, i.SalesPackagePrice) - r.prijs83) > 0.01 THEN -1
		WHEN ABS(COALESCE(pd.calc_bedr1, po.calc_bedr1, i.SalesPackagePrice) - r.prijs_n) > 0.01 THEN -1
		ELSE 2 END AS check_status 

FROM dbo._AB_sy_frkrg k WITH (NOLOCK)
	INNER JOIN dbo._AB_sy_frsrg r WITH (NOLOCK)
		ON k.fakt_code = r.fakt_code AND k.volgnr5 = r.volgnr5
	INNER JOIN dbo._AB_sy_cicmpy c WITH (NOLOCK)
		ON c.debnr = k.fakdebnr
	-- Pricelist debtor
	OUTER APPLY (
		SELECT TOP (1) s.ID, s.AccountID, s.prijs83, s.kort_pbn, s.aantal1, s.bedr1, s.aantal2, s.bedr2
			, CASE WHEN s.kort_pbn = 'P' THEN s.prijs83 - (s.bedr1*s.prijs83/100) ELSE s.bedr1 END AS calc_bedr1 
		FROM dbo._AB_sy_staffl s WITH (NOLOCK)
		WHERE 1=1
			AND s.prijslijst = c.PriceList
			AND s.artcode = r.artcode 
			AND r.afldat BETWEEN s.validfrom AND ISNULL(s.validto, GETDATE())
			AND (s.AccountID IS NULL -- Default price in pricelist
				OR s.AccountID = c.cmp_wwn) -- Price agreement for debtor, we want this price when it is filled
		ORDER BY s.AccountID DESC -- Filled one first
	) pd
	-- Pricelist order
	OUTER APPLY (
		SELECT TOP (1) s.ID, s.AccountID, s.prijs83, s.kort_pbn, s.aantal1, s.bedr1, s.aantal2, s.bedr2
			, CASE WHEN s.kort_pbn = 'P' THEN s.prijs83 - (s.bedr1*s.prijs83/100) ELSE s.bedr1 END AS calc_bedr1
		FROM dbo._AB_sy_staffl s WITH (NOLOCK)
		WHERE 1=1
			AND s.prijslijst = r.prijslijst
			AND s.artcode = r.artcode 
			AND r.afldat BETWEEN s.validfrom AND ISNULL(s.validto, GETDATE())
			AND (s.AccountID IS NULL -- Default price in pricelist
				OR s.AccountID = c.cmp_wwn) -- Price agreement for debtor, we want this price when it is filled
		ORDER BY s.AccountID DESC -- Filled one first
	) po
	-- Item
	INNER JOIN dbo._AB_sy_Items i WITH (NOLOCK)
		ON i.Itemcode = r.artcode

WHERE 1=1
	AND r.ar_soort = 'V'
	AND k.syscreated > '2020-01-01'
UNION ALL
-- History
SELECT k.ordernr,  k.faknr,  k.fak_soort, k.fakdebnr, k.refer, k.docnumber
	, r.regel, r.artcode, r.esr_aantal, r.magcode

	, r.prijs83 AS GPrice_Order
	, COALESCE(pd.prijs83, po.prijs83, i.SalesPackagePrice) AS GPrice_Order_Exact
	
	, r.prijs_n AS NPrice_Order -- This can be 0 when discount is 100
	, COALESCE(pd.calc_bedr1, po.calc_bedr1, i.SalesPackagePrice) AS NPrice_Order_Exact

	, r.korting AS Discount
	, r.prijslijst AS PriceList_Order
	, c.PriceList AS PriceList_Debtor

	, i.SalesPackagePrice AS Price_Item
	, pd.prijs83 AS GPrice_PriceList_Debtor
	, po.prijs83 AS GPrice_PriceList_Order	

	, pd.calc_bedr1 AS NPrice_PriceList_Debtor
	, po.calc_bedr1 AS NPrice_PriceList_Order

	, r.sysmodified
	, 1 AS isHistory

	, CONCAT(CASE WHEN ISNULL(r.prijslijst,'') != ISNULL(c.PriceList, '') AND pd.prijs83 IS NOT NULL THEN 'Pricelist order differs from Debtor pricelist and price available; ' END
		, CASE WHEN ISNULL(r.prijslijst,'') != ISNULL(c.PriceList, '') AND pd.prijs83 IS NULL THEN 'Pricelist order differs from Debtor pricelist but item is not in pricelist debtor; ' END
		-- GPrice_PriceList_Debtor, GPrice_PriceList_Order
		, CASE WHEN ABS(COALESCE(pd.prijs83, po.prijs83, i.SalesPackagePrice) - r.prijs83) > 0.01 THEN 'Gross price differs from default price; ' END
		, CASE WHEN ABS(COALESCE(pd.calc_bedr1, po.calc_bedr1, i.SalesPackagePrice) - r.prijs_n) > 0.01 THEN 'Net price differs from default price; ' END
		) AS check_mssg
	, CASE WHEN ISNULL(r.prijslijst,'') != ISNULL(c.PriceList, '') AND pd.prijs83 IS NOT NULL THEN -1
		WHEN ISNULL(r.prijslijst,'') != ISNULL(c.PriceList, '') AND pd.prijs83 IS NULL THEN 1
		-- GPrice_PriceList_Debtor, GPrice_PriceList_Order
		WHEN ABS(COALESCE(pd.prijs83, po.prijs83, i.SalesPackagePrice) - r.prijs83) > 0.01 THEN -1
		WHEN ABS(COALESCE(pd.calc_bedr1, po.calc_bedr1, i.SalesPackagePrice) - r.prijs_n) > 0.01 THEN -1
		ELSE 2 END AS check_status 

FROM dbo._AB_sy_frhkrg k WITH (NOLOCK)
	INNER JOIN dbo._AB_sy_frhsrg r WITH (NOLOCK)
		ON k.ordernr = r.ordernr
	INNER JOIN dbo._AB_sy_cicmpy c WITH (NOLOCK)
		ON c.debnr = k.fakdebnr
	-- Pricelist debtor
	OUTER APPLY (
		SELECT TOP (1) s.ID, s.AccountID, s.prijs83, s.kort_pbn, s.aantal1, s.bedr1, s.aantal2, s.bedr2
			, CASE WHEN s.kort_pbn = 'P' THEN s.prijs83 - (s.bedr1*s.prijs83/100) ELSE s.bedr1 END AS calc_bedr1 
		FROM dbo._AB_sy_staffl s WITH (NOLOCK)
		WHERE 1=1
			AND s.prijslijst = c.PriceList
			AND s.artcode = r.artcode 
			AND r.afldat BETWEEN s.validfrom AND s.validto 
			AND (s.AccountID IS NULL -- Default price in pricelist
				OR s.AccountID = c.cmp_wwn) -- Price agreement for debtor, we want this price when it is filled
		ORDER BY s.AccountID DESC -- Filled one first
	) pd
	-- Pricelist order
	OUTER APPLY (
		SELECT TOP (1) s.ID, s.AccountID, s.prijs83, s.kort_pbn, s.aantal1, s.bedr1, s.aantal2, s.bedr2
			, CASE WHEN s.kort_pbn = 'P' THEN s.prijs83 - (s.bedr1*s.prijs83/100) ELSE s.bedr1 END AS calc_bedr1
		FROM dbo._AB_sy_staffl s WITH (NOLOCK)
		WHERE 1=1
			AND s.prijslijst = r.prijslijst
			AND s.artcode = r.artcode 
			AND r.afldat BETWEEN s.validfrom AND s.validto 
			AND (s.AccountID IS NULL -- Default price in pricelist
				OR s.AccountID = c.cmp_wwn) -- Price agreement for debtor, we want this price when it is filled
		ORDER BY s.AccountID DESC -- Filled one first
	) po
	-- Item
	INNER JOIN dbo._AB_sy_Items i WITH (NOLOCK)
		ON i.Itemcode = r.artcode

WHERE 1=1
	AND r.ar_soort = 'V'
	AND k.syscreated > '2020-01-01'
	--AND k.fak_soort = ?

	-- Test
	--AND k.fakt_code = 0
	--AND k.volgnr5 = '  364'
	--AND r.prijs_n <> r.prijs83
--ORDER BY fakt_code, volgnr5, ordernr DESC, regel





GO
