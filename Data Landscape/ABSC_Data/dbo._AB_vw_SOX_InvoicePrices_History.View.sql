/****** Object:  View [dbo].[_AB_vw_SOX_InvoicePrices_History]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[_AB_vw_SOX_InvoicePrices_History] AS

SELECT r.id AS frhsrgid, k.ordernr,  k.faknr,  k.fak_soort, k.fakdebnr, k.inv_debtor_name, k.refer, k.docnumber, k.fakdat
	, r.regel, r.artcode, r.esr_aantal, r.magcode, r.ar_soort

	, r.prijs83 AS GPrice_Order
	, po.prijs83 AS GPrice_OrderList
	, pd.prijs83 AS GPrice_DebtorList
	, ps.prijs83 AS GPrice_SalesList
	, COALESCE(pd.prijs83, po.prijs83, ps.prijs83) AS GPrice_Exact
	
	, r.prijs_n AS NPrice_Order -- This can be 0 when discount is 100
	, po.calc_bedr1 AS NPrice_OrderList
	, pd.calc_bedr1 AS NPrice_DebtorList
	, ps.calc_bedr1 AS NPrice_SalesList
	, COALESCE(pd.calc_bedr1, po.calc_bedr1, ps.calc_bedr1) AS NPrice_Exact

	, r.korting AS Discount
	, r.prijslijst AS PriceList_Order
	, c.PriceList AS PriceList_Debtor

	, r.sysmodified
	

	, CASE WHEN ISNULL(r.prijslijst,'SALESPRICE') != ISNULL(c.PriceList, 'SALESPRICE') AND pd.prijs83 IS NOT NULL AND ABS(pd.prijs83 - r.prijs83) > 0.01 THEN 'Pricelist differs and gross price differs; ' 
	  WHEN ISNULL(r.prijslijst,'SALESPRICE') != ISNULL(c.PriceList, 'SALESPRICE') AND pd.calc_bedr1 IS NOT NULL AND ABS(pd.calc_bedr1 - r.prijs_n ) > 0.01 THEN 'Pricelist differs and net price differs; ' 
	  WHEN ABS(COALESCE(pd.prijs83, po.prijs83, ps.prijs83) - r.prijs83) > 0.01 THEN 'Gross price differs from default price; ' 
	  WHEN ABS(COALESCE(pd.calc_bedr1, po.calc_bedr1, ps.calc_bedr1) - r.prijs_n) > 0.01 THEN 'Net price differs from default price; ' 
	  ELSE NULL END AS check_mssg
	, CASE WHEN ISNULL(r.prijslijst,'SALESPRICE') != ISNULL(c.PriceList, 'SALESPRICE') AND pd.prijs83 IS NOT NULL AND ABS(pd.prijs83 - r.prijs83) > 0.01 THEN -1
	  WHEN ISNULL(r.prijslijst,'SALESPRICE') != ISNULL(c.PriceList, 'SALESPRICE') AND pd.calc_bedr1 IS NOT NULL AND ABS(pd.calc_bedr1 - r.prijs_n ) > 0.01 THEN -2
	  WHEN ABS(COALESCE(pd.prijs83, po.prijs83, ps.prijs83) - r.prijs83) > 0.01 THEN -3
	  WHEN ABS(COALESCE(pd.calc_bedr1, po.calc_bedr1, ps.calc_bedr1) - r.prijs_n) > 0.01 THEN -4 
	  ELSE 1 END AS check_status


FROM dbo._AB_sy_frhkrg k WITH (NOLOCK)
	INNER JOIN dbo._AB_sy_frhsrg r WITH (NOLOCK)
		ON k.faknr = r.faknr
	INNER JOIN dbo._AB_sy_cicmpy c WITH (NOLOCK)
		ON c.debnr = k.fakdebnr
	-- Pricelist debtor
	OUTER APPLY (
		SELECT TOP (1) s.ID, s.AccountID, s.prijs83, s.kort_pbn, s.aantal1, s.bedr1, s.aantal2, s.bedr2
			,CASE WHEN s.bedr1 = 0 THEN s.prijs83 
			 WHEN s.kort_pbn = 'P' THEN s.prijs83 - (s.bedr1*s.prijs83/100) 
			 ELSE s.bedr1 END AS calc_bedr1 
		FROM dbo._AB_sy_staffl s WITH (NOLOCK)
		WHERE 1=1
			AND s.prijslijst = ISNULL(c.PriceList, 'SALEPRICE')
			AND s.artcode = r.artcode 
			AND r.afldat BETWEEN s.validfrom AND ISNULL(s.validto, '2099-01-01')
			AND (s.AccountID IS NULL -- Default price in pricelist
				OR s.AccountID = c.cmp_wwn) -- Price agreement for debtor, we want this price when it is filled
		ORDER BY s.AccountID DESC -- Filled one first
	) pd
	-- Pricelist order
	OUTER APPLY (
		SELECT TOP (1) s.ID, s.AccountID, s.prijs83, s.kort_pbn, s.aantal1, s.bedr1, s.aantal2, s.bedr2
			, CASE WHEN s.bedr1 = 0 THEN s.prijs83 
			 WHEN s.kort_pbn = 'P' THEN s.prijs83 - (s.bedr1*s.prijs83/100) 
			 ELSE s.bedr1 END AS calc_bedr1
		FROM dbo._AB_sy_staffl s WITH (NOLOCK)
		WHERE 1=1
			AND s.prijslijst = ISNULL(r.prijslijst, 'SALEPRICE')
			AND s.artcode = r.artcode 
			AND r.afldat BETWEEN s.validfrom AND ISNULL(s.validto, '2099-01-01')
			AND (s.AccountID IS NULL -- Default price in pricelist
				OR s.AccountID = c.cmp_wwn) -- Price agreement for debtor, we want this price when it is filled
		ORDER BY s.AccountID DESC -- Filled one first
	) po
	-- Pricelist order
	OUTER APPLY (
		SELECT TOP (1) s.ID, s.AccountID, s.prijs83, s.kort_pbn, s.aantal1, s.bedr1, s.aantal2, s.bedr2
			,CASE WHEN s.bedr1 = 0 THEN s.prijs83 
			 WHEN s.kort_pbn = 'P' THEN s.prijs83 - (s.bedr1*s.prijs83/100) 
			 ELSE s.bedr1 END AS calc_bedr1
		FROM dbo._AB_sy_staffl s WITH (NOLOCK)
		WHERE 1=1
			AND s.prijslijst = 'SALESPRICE'
			AND s.artcode = r.artcode 
			AND r.afldat BETWEEN s.validfrom AND ISNULL(s.validto, '2099-01-01')
			AND (s.AccountID IS NULL -- Default price in pricelist
				OR s.AccountID = c.cmp_wwn) -- Price agreement for debtor, we want this price when it is filled
		ORDER BY s.AccountID DESC -- Filled one first
	) ps

WHERE  k.syscreated > '2020-01-01'



GO
