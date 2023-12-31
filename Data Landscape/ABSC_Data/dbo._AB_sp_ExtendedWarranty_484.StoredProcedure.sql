/****** Object:  StoredProcedure [dbo].[_AB_sp_ExtendedWarranty_484]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		AB, LVE
-- Create date: 2020-12-22
-- Description:	Register Extended Warranty
-- =============================================
CREATE PROCEDURE [dbo].[_AB_sp_ExtendedWarranty_484] 
	-- Add the parameters for the stored procedure here
	@runid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/*
		1) Extended Warranty bij de verkooporder
		•	Artikel 0900500 (voor 3 jaar extra garantie) of artikel 0900700 (voor 5 jaar extra garantie) wordt toegevoegd op de order
		•	De serienummers die daaronder op de order staan worden én die aangemerkt zijn als 'Garantie artikel' op de artikelkaart krijgen resp 5 of 7 jaar garantie.
		2) Extended Warranty achteraf
		•	Artikel 0900500 (voor 3 jaar extra garantie) of artikel 0900700 (voor 5 jaar extra garantie) wordt toegevoegd op de order
		•	De serienummers die in het tekstveld van het artikel 0900500 of 0900700 vermeld staan én die aangemerkt zijn als 'Garantie artikel' op de artikelkaart krijgen resp 5 of 7 jaar garantie.
		3) Extended Warranty op de klantkaart
		•	Klanten met extra garantie op de klantkaart krijgen die garantie in maanden toegevoegd op de standaard garantie van 24 maanden. 
		•	Dat geldt voor alle serienummerartikelen vanaf het moment dat de garantie is ingevoerd, ongeacht of een artikel aangemerkt is als 'Garantie artikel' of niet. 
	*/

    -- Insert statements for procedure here
	DECLARE @administration nvarchar(128) = '484';
	DECLARE @mindate datetime = DATEADD(MONTH, -2, CAST(CURRENT_TIMESTAMP as date)); --'2020-12-01';
	DECLARE @mindate_stock datetime = DATEADD(YEAR, -2, CAST(CURRENT_TIMESTAMP as date)); --'2018-12-01';

	-- 1. Register new deliveries for serialnumbers
	WITH delivered_lines AS (
		SELECT k.ordernr, k.debnr
			, r.regel, r.artcode, r.oms45, r.sysguid, r.afldat

			-- Default warranty
			, 24 as mo_default

			-- Warranty from customer	
			, ISNULL(c.numberfield3, 0) as mo_customer

			-- LotNumber
			, CASE WHEN ISNULL(c.numberfield3, 0) > 0 THEN 'EW' END as EW

		FROM [484].dbo.orkrg k WITH (NOLOCK)
			INNER JOIN [484].dbo.orsrg r WITH (NOLOCK) ON r.ordernr = k.ordernr
			INNER JOIN [484].dbo.Items i WITH (NOLOCK) ON i.Itemcode = r.artcode
			INNER JOIN [484].dbo.cicmpy c WITH (NOLOCK) ON c.debnr = k.debnr
		WHERE 1=1
			AND k.ord_soort = 'V'
			AND r.ar_soort != 'P'
			AND r.uitgifte = 1 -- Delivered
			AND i.Assortment <> 70 -- Extended warranty
			AND i.IsSerialNumberItem = 1 -- Only serialnumber items
			AND r.afldat > @mindate -- Limit selection so we don't go too far back
			AND NOT EXISTS (SELECT 1 FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n WITH (NOLOCK) WHERE n.administration = @administration AND n.sysguid = r.sysguid)
	)
	-- !!! INSERT
	INSERT INTO [dbo].[_AB_tb_ExtendedWarranty_ItemNumbers]
		([ordernr],[debnr],[regel],[artcode],[oms45],[sysguid],[afldat],[warranty_artcode],[warranty_order_description]
		,[mo_default],[mo_customer],[mo_item],[mo_longest],[EW]
		,[ID],[number],[DateEnd],[LotNumber],[DateEnd_old],[Classification]
		,[abei_runid],[abei_rowstatus]
		,[administration])
	SELECT dl.ordernr, dl.debnr, dl.regel, dl.artcode, dl.oms45, dl.sysguid, dl.afldat, NULL, NULL
		, dl.mo_default, dl.mo_customer, 0 as mo_item, mo_default+mo_customer as mo_longest, dl.EW
		, itn.ID
		, itn.number
		, NULL as DateEnd
		, NULL as LotNumber
		, itn.DateEnd as DateEnd_old
		, itn.Classification

		, @runid
		, 1 as abei_rowstatus
		, @administration 
	FROM delivered_lines dl
		-- Deliveries
		INNER JOIN (
			SELECT g.ID
				, g.Datum AS afldat
				, g.artcode
				, (g.aantal*-1) AS Qty			
				, g.facode AS serialnumber
				, g.Bkstnr_sub AS ordernr
				, g.bkstnr AS entryno
				, g.LinkedLine
			FROM [484].dbo.gbkmut g WITH (NOLOCK) 
				INNER JOIN [484].dbo.Items i WITH (NOLOCK) ON i.itemcode = g.artcode AND g.reknr = i.GLAccountDistribution
			WHERE 1=1
				AND g.Transtype IN ('N', 'C', 'P') 
				AND g.Transsubtype = 'B' 
				AND g.debnr IS NOT NULL
				AND g.bkstnr_sub IS NOT NULL
				AND g.facode IS NOT NULL -- We are only interested in serial numbers
		) del ON dl.sysguid = del.LinkedLine -- del.ordernr = k.ordernr AND del.debnr = k.debnr AND del.artcode = r.artcode AND 
		-- Item number
		INNER JOIN [484].dbo.ItemNumbers itn WITH (NOLOCK) ON itn.number = del.serialnumber AND itn.ItemCode = dl.artcode
	WHERE 1=1
		-- No filter on ID because one number can be used for multiple deliveries, or a return
		--AND NOT EXISTS (SELECT 1 FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n WITH (NOLOCK) WHERE n.administration = @administration AND n.ID = itn.ID)


	-- 2.1 Register extended warranty from the salesorder
	UPDATE n WITH (ROWLOCK, NOWAIT) SET
		warranty_artcode = wo.artcode
		, warranty_order_description = wo.oms45
		, mo_item = ISNULL(wo.mo_item, 0)
	FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n
		INNER JOIN [484].dbo.Items i WITH (NOLOCK) ON i.Itemcode = n.artcode 
		-- Warranty in order
		LEFT JOIN (
			SELECT k.ordernr
				, r.regel+1 as next_line
				, r.artcode
				, r.oms45
				, i.UserNumber_08*12 as mo_item
			FROM [484].dbo.orkrg k WITH (NOLOCK)
				INNER JOIN [484].dbo.orsrg r WITH (NOLOCK) ON r.ordernr = k.ordernr
				INNER JOIN [484].dbo.Items i WITH (NOLOCK) ON i.Itemcode = r.artcode
			WHERE 1=1
				AND k.ord_soort = 'V'
				AND r.ar_soort != 'P'
				AND i.Assortment = 70 -- Extended warranty
		) wo ON wo.ordernr = n.ordernr AND wo.next_line = n.regel
	WHERE 1=1
		-- Lines we are processing in this run for this administration..
		AND n.abei_runid = @runid
		AND n.administration = @administration;
		---- Item should be registered as Warranty item to be eligible for extended warranty (moved check)
		--AND i.userNumber_05 = 1; -- Garantie artikel
	
	
	-- 2.2 Register extra warranty that was sold afterwards
	WITH delivered_warranty_lines AS (
		SELECT k.ordernr, k.debnr
			, r.regel, r.artcode, r.oms45, r.sysguid, r.afldat

			-- Default warranty
			, 24 as mo_default

			-- Warranty from customer	
			, ISNULL(c.numberfield3, 0) as mo_customer

			-- Warranty from wo item
			, r.artcode as warranty_artcode
			, x.TextDescription as warranty_order_description
			, i.UserNumber_08*12 as mo_item_after

		FROM [484].dbo.orkrg k WITH (NOLOCK)
			INNER JOIN [484].dbo.orsrg r WITH (NOLOCK) ON r.ordernr = k.ordernr
			INNER JOIN [484].dbo.orstx x WITH (NOLOCK) ON x.ordernr = r.ordernr AND x.regel = r.regel
			INNER JOIN [484].dbo.Items i WITH (NOLOCK) ON i.Itemcode = r.artcode
			INNER JOIN [484].dbo.cicmpy c WITH (NOLOCK) ON c.debnr = k.debnr
		WHERE 1=1
			AND k.ord_soort = 'V'
			AND r.ar_soort != 'P'
			AND r.uitgifte = 1 -- Delivered
			AND i.Assortment = 70 -- Extended warranty			
			AND r.afldat > @mindate -- Limit selection so we don't go too far back (2018 because we need some tests and this doesn't happen that often)
			AND x.TextDescription IS NOT NULL -- There should be some codes in here
			AND NOT EXISTS (SELECT 1 FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n WITH (NOLOCK) WHERE n.administration = @administration AND n.sysguid = r.sysguid)
	)
	-- !!! INSERT
	INSERT INTO [dbo].[_AB_tb_ExtendedWarranty_ItemNumbers]
		([ordernr],[debnr],[regel],[artcode],[oms45],[sysguid],[afldat],[warranty_artcode],[warranty_order_description]
		,[mo_default],[mo_customer],[mo_item_after]
		,[ID],[number],[DateEnd],[LotNumber],[DateEnd_old],[Classification]
		,[isAfterSales]
		,[abei_runid],[abei_rowstatus],abei_message
		,[administration])
	SELECT dl.ordernr, dl.debnr, dl.regel, dl.artcode, dl.oms45, dl.sysguid, NULL as afldat, dl.warranty_artcode, dl.warranty_order_description
		, dl.mo_default, dl.mo_customer, dl.mo_item_after
		, NULL as ID --itn.ID
		, LEFT(n.Number, 30) as Number --itn.number
		, NULL as DateEnd
		, NULL as LotNumber
		, NULL as DateEnd_old --itn.DateEnd as DateEnd_old
		, NULL as Classification --itn.Classification
		, 1 as isAfterSales

		, @runid
		, 10 as abei_rowstatus --CASE WHEN itn.Number IS NULL THEN 10 ELSE 1 END as abei_rowstatus
		, 'Not yet ready to process' as abei_message --CASE WHEN itn.Number IS NULL THEN CONCAT('ItemNumber ', n.Number, ' not found') END as [abei_message]
		, @administration 	
	FROM delivered_warranty_lines dl 
		-- Split the numbers in the TextDescription and join them with itemnumbers to see if they are valid itemnumbers
		CROSS APPLY ( SELECT LTRIM(RTRIM(Item)) as Number FROM dbo._AB_fn_DelimitedSplit8K(dl.warranty_order_description, ',') ) n
		-- Item number
		--LEFT JOIN [484].dbo.ItemNumbers itn WITH (NOLOCK) ON itn.number = n.Number COLLATE DATABASE_DEFAULT
		-- Last delivery date		
		--OUTER APPLY (
		--	SELECT MAX(g.datum) as afldat
  --              , g.facode
  --           FROM   [484].dbo.gbkmut g WITH (NOLOCK)
		--		INNER JOIN [484].dbo.Items i WITH (NOLOCK) ON i.itemcode = g.artcode AND g.reknr = i.GLAccountDistribution 
  --           WHERE  1=1
  --              AND (g.transtype IN ('N', 'C', 'P')) 
  --              AND (g.transsubtype = 'B')				
		--		AND g.datum > '2018-12-01' -- Limit selection so we don't go too far back (2018 because we need some tests and this doesn't happen that often)
		--		AND g.facode IS NOT NULL -- We are only interested in serial numbers
		--		AND g.facode = itn.Number
  --           GROUP BY g.facode) lev --on lev.facode = itn.Number
	WHERE 1=1
		-- Skip this check. The sysguid check in delivered_warranty_lines should take care of this.
		--AND NOT EXISTS (SELECT 1 FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n WITH (NOLOCK) WHERE n.administration = @administration AND n.ID = itn.ID AND n.isAfterSales = 1)

	-- 2.2.0 Fill ItemNumber data in separate query to speed up SP
	UPDATE n WITH (ROWLOCK, NOWAIT) SET
		ID = itn.ID
		, Number = itn.Number
		, DateEnd_old = itn.DateEnd
		, Classification = itn.Classification
		, abei_rowstatus = CASE WHEN itn.Number IS NULL THEN 10 ELSE 1 END
		, abei_checkmessage = CASE WHEN itn.Number IS NULL THEN CONCAT('ItemNumber ', n.Number COLLATE DATABASE_DEFAULT, ' not found') ELSE '' END
	FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n
		-- Cannot join on itemcode as well because this is the warranty itemcode
		-- This means if one serialnumber is used for 2 or more items, we update only one
		-- Select the last created here
		OUTER APPLY (
			SELECT TOP (1) itn.ID, itn.Number, itn.ItemCode, itn.Classification, itn.DateEnd
			FROM [484].dbo.ItemNumbers itn WITH (NOLOCK) 
			WHERE itn.number = n.Number
			ORDER BY itn.syscreated DESC
		) itn
		--LEFT JOIN [484].dbo.ItemNumbers itn WITH (NOLOCK) ON itn.number = n.Number
	WHERE 1=1
		-- Lines we are processing in this run for this administration..
		AND n.abei_runid = @runid
		AND n.administration = @administration
		AND n.isAfterSales = 1		

	-- 2.2.1 Calculate deliverydate for isAfterSales entries
	UPDATE n WITH (ROWLOCK, NOWAIT) SET
		afldat = lev.afldat
		, abei_rowstatus = CASE WHEN lev.afldat IS NULL THEN 10 ELSE n.abei_rowstatus END
		, abei_checkmessage = CASE WHEN lev.afldat IS NULL THEN 'No delivery date found, cant calculate end date' ELSE n.abei_checkmessage END
	FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n
		-- Join the itemnumber on ID, so we can be sure we select the correct itemcode
		INNER JOIN [484].dbo.ItemNumbers itn WITH (NOLOCK) ON itn.ID = n.ID
		-- Find the last delivery date for Number and ItemCode
		OUTER APPLY (
			SELECT MAX(g.datum) as afldat
             FROM   [484].dbo.gbkmut g WITH (NOLOCK)
				INNER JOIN [484].dbo.Items i WITH (NOLOCK) ON i.itemcode = g.artcode AND g.reknr = i.GLAccountDistribution 
             WHERE  1=1
                AND (g.transtype IN ('N', 'C', 'P')) 
                AND (g.transsubtype = 'B')				
				AND g.datum > @mindate_stock -- Limit selection so we don't go too far back
				AND g.facode IS NOT NULL -- We are only interested in serial numbers
				AND g.artcode = itn.ItemCode
				AND g.facode = n.Number
             GROUP BY g.facode) lev --on lev.facode = itn.Number
	WHERE 1=1
		-- Lines we are processing in this run for this administration..
		AND n.abei_runid = @runid
		AND n.administration = @administration
		AND n.isAfterSales = 1
		AND n.Number IS NOT NULL -- only when number is found

	-- 3. Calculate the warranty
	UPDATE n WITH (ROWLOCK, NOWAIT) SET
		-- Add all the possible warranty values
		mo_longest = CASE WHEN ISNULL(i.userNumber_05, 0) = 1 
			-- Warranty item: count everything
			THEN n.mo_default + n.mo_customer + n.mo_item + n.mo_item_after
			-- No warranty item: only count the defaults
			ELSE n.mo_default + n.mo_customer END

		-- New end date
		, DateEnd = CASE WHEN ISNULL(i.userNumber_05, 0) = 1 
			-- Warranty item: count everything
			THEN DATEADD(MONTH, (n.mo_default + n.mo_customer + n.mo_item + n.mo_item_after), n.afldat)
			-- No warranty item: only count the defaults
			ELSE DATEADD(MONTH, (n.mo_default + n.mo_customer), n.afldat) END

		-- Register as Extended Warranty
		, LotNumber = CASE 
				-- Warranty item: count everything
				WHEN ISNULL(i.userNumber_05, 0) = 1 AND (n.mo_customer > 0 OR n.mo_item > 0 OR n.mo_item_after > 0) THEN 'EW'
				-- No warranty item: only count the defaults
				WHEN ISNULL(i.userNumber_05, 0) <> 1 AND (n.mo_customer > 0) THEN 'EW'
				-- Else default
				ELSE itn.LotNumber END

		-- 4. Check if item is Warranty item. LVE 210420 Only give the warranty message when extra warranty is given
		, abei_checkmessage = CASE WHEN ISNULL(i.userNumber_05, 0) <> 1 AND (n.mo_item + n.mo_item_after > 0)
				THEN CONCAT('Item ', i.ItemCode COLLATE DATABASE_DEFAULT, ' is not a warranty item!') 
				ELSE n.abei_checkmessage END
	
	FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n
		-- Item number
		INNER JOIN [484].dbo.ItemNumbers itn WITH (NOLOCK) ON itn.ID = n.ID
		-- Item, join on itemnumber because itemcode in n can be the warrany itemcode as well
		INNER JOIN [484].dbo.Items i WITH (NOLOCK) ON i.ItemCode = itn.ItemCode
	WHERE 1=1
		-- Lines we are processing in this run for this administration..
		AND n.abei_runid = @runid
		AND n.administration = @administration

	-- 4. Check if item is Warranty item (moved to ^)
	--UPDATE n WITH (ROWLOCK, NOWAIT) SET
	--	abei_rowstatus = 10
	--	, abei_message = CONCAT('Item ', i.ItemCode COLLATE DATABASE_DEFAULT, ' is not a warranty item!')
	--FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n
	--	-- Item number
	--	INNER JOIN [484].dbo.ItemNumbers itn WITH (NOLOCK) ON itn.number = n.Number
	--	-- Item
	--	INNER JOIN [484].dbo.Items i WITH (NOLOCK) ON i.ItemCode = itn.ItemCode
	--WHERE 1=1
	--	-- Lines we are processing in this run for this administration..
	--	AND n.abei_runid = @runid
	--	AND n.administration = @administration
	--	-- Item should be registered as Warranty item to be eligible for extended warranty
	--	AND ISNULL(i.userNumber_05, 0) <> 1; -- Garantie artikel

	-- Empty enddate off
	/*
	-- 4. Empty enddate when no delivery was found
	-- This should actually be startdate + 24 months?
	UPDATE n WITH (ROWLOCK, NOWAIT) SET
		DateEnd = NULL
		, abei_message = 'Set date to NULL'
	FROM [ABSC_Data].dbo._AB_tb_ExtendedWarranty_ItemNumbers n 
		-- Delivery
		Left outer join (   
			SELECT  gbk.artcode as artcode 
					,gbk.oms25
					,gbk.bkstnr_sub AS ordernr
					,gbk.facode
			FROM   [484].dbo.gbkmut gbk WITH (NOLOCK)
			WHERE   1=1
					and (gbk.transtype IN ('N', 'C', 'P')) 
					AND (gbk.transsubtype = 'B') 
					AND (gbk.regel % 2 = 1)
					and (gbk.debnr IS NOT NULL)
					AND (gbk.facode IS NOT NULL)) lev on lev.facode = n.number
	WHERE 1=1
		AND n.abei_runid = @runid
		AND n.administration = @administration

		AND lev.ordernr is null
		AND n.DateEnd_old is not null
		AND n.Classification = 'B' 

	-- 4b. New ones
	INSERT INTO [dbo].[_AB_tb_ExtendedWarranty_ItemNumbers]
		([ID],[number],[DateEnd]
		,[abei_runid],[abei_rowstatus],[abei_message]
		,[administration])
	SELECT 
		itn.id, itn.number, null as dateend
		, @runid
		, 1 as abei_rowstatus
		, 'Set date to NULL' as abei_message
		, @administration
	FROM    [484].dbo.itemnumbers itn with(nolock)
			Left outer join (   SELECT  gbk.artcode as artcode 
										,gbk.oms25
										,gbk.bkstnr_sub AS ordernr
										,gbk.facode

								FROM   [484].dbo.gbkmut gbk WITH (NOLOCK)  

								WHERE   1=1
										and (gbk.transtype IN ('N', 'C', 'P')) 
										AND (gbk.transsubtype = 'B') 
										AND (gbk.regel % 2 = 1)
										and (gbk.debnr IS NOT NULL)
										AND (gbk.facode IS NOT NULL)) lev on lev.facode = itn.number
	where   1=1
			AND lev.ordernr is null
			AND itn.dateEnd is not null
			AND itn.Classification = 'B' 

			AND NOT EXISTS (SELECT 1 FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n WITH (NOLOCK) WHERE n.administration = @administration AND n.ID = itn.ID)	
	*/
END






GO
