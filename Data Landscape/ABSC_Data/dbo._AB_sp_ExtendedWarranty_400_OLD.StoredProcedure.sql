/****** Object:  StoredProcedure [dbo].[_AB_sp_ExtendedWarranty_400_OLD]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		AB, LVE
-- Create date: 2020-12-22
-- Description:	Register Extended Warranty
-- =============================================
CREATE PROCEDURE [dbo].[_AB_sp_ExtendedWarranty_400_OLD] 
	-- Add the parameters for the stored procedure here
	@runid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @administration nvarchar(128) = '400';
	
	-- 1. Warranty order lines
	WITH wo AS (
		SELECT k.ordernr, k.debnr
			, r.regel, r.artcode, r.oms45, r.sysguid, r.afldat

			-- Warranty from order
			, wo.artcode as warranty_artcode
			, wo.oms45 as warranty_order_description
			, ISNULL(wo.mo_item, 2*12) as mo_item -- default 2 yr

			-- Warranty from customer	
			, c.numberfield3 as mo_customer

			-- Valid warranty
			, CASE WHEN ISNULL(c.numberfield3, 0) > ISNULL(wo.mo_item, 2*12) THEN ISNULL(c.numberfield3, 0) ELSE ISNULL(wo.mo_item, 2*12) END as mo_longest

			-- LotNumber
			, CASE WHEN ISNULL(c.numberfield3, 0) > 0 OR ISNULL(wo.mo_item, 0) > 0 THEN 'EW' END as EW
		FROM [400].dbo.orkrg k WITH (NOLOCK)
			INNER JOIN [400].dbo.orsrg r WITH (NOLOCK) ON r.ordernr = k.ordernr
			INNER JOIN [400].dbo.Items i WITH (NOLOCK) ON i.Itemcode = r.artcode
			INNER JOIN [400].dbo.cicmpy c WITH (NOLOCK) ON c.debnr = k.debnr

			-- Warranty in order
			LEFT JOIN (
				SELECT k.ordernr
					, r.regel-1 as prev_line
					, r.artcode
					, r.oms45
					, i.UserNumber_08*12 as mo_item
				FROM [400].dbo.orkrg k WITH (NOLOCK)
					INNER JOIN [400].dbo.orsrg r WITH (NOLOCK) ON r.ordernr = k.ordernr
					INNER JOIN [400].dbo.Items i WITH (NOLOCK) ON i.Itemcode = r.artcode
				WHERE 1=1
					AND k.ord_soort = 'V'
					AND r.ar_soort != 'P'
					AND i.Assortment = 70 -- Extended warranty
			) wo ON wo.ordernr = k.ordernr AND wo.prev_line = r.regel
		WHERE 1=1
			AND k.ord_soort = 'V'
			AND r.ar_soort != 'P'
			AND r.uitgifte = 1 -- Delivered
			AND i.Assortment <> 70 -- Extended warranty
			AND i.userNumber_05 = 1 -- Garantie artikel?
			AND r.afldat > '2020-12-01' -- Limit selection so we don't go too far back
			AND NOT EXISTS (SELECT 1 FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n WITH (NOLOCK) WHERE n.administration = @administration AND n.sysguid = r.sysguid)
	)
	-- !!! INSERT
	INSERT INTO [dbo].[_AB_tb_ExtendedWarranty_ItemNumbers]
		([ordernr],[debnr],[regel],[artcode],[oms45],[sysguid],[afldat],[warranty_artcode],[warranty_order_description]
		,[mo_item],[mo_customer],[mo_longest],[EW]
		,[ID],[number],[DateEnd],[LotNumber],[DateEnd_old],[Classification]
		,[abei_runid],[abei_rowstatus]
		,[administration])
	SELECT wo.ordernr, wo.debnr, wo.regel, wo.artcode, wo.oms45, wo.sysguid, wo.afldat, wo.warranty_artcode, wo.warranty_order_description
		, wo.mo_item, wo.mo_customer, wo.mo_longest, wo.EW
		, itn.ID
		, itn.number
		, DATEADD(MONTH, wo.mo_longest, wo.afldat) as DateEnd
		, ISNULL(wo.EW, itn.LotNumber) as LotNumber
		, itn.DateEnd as DateEnd_old
		, itn.Classification
		, @runid
		, 1 as abei_rowstatus
		, @administration 
	FROM wo
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
			FROM [400].dbo.gbkmut g WITH (NOLOCK) 
				INNER JOIN [400].dbo.Items i WITH (NOLOCK) ON i.itemcode = g.artcode AND g.reknr = i.GLAccountDistribution
			WHERE 1=1
				AND g.Transtype IN ('N', 'C', 'P') 
				AND g.Transsubtype = 'B' 
				AND g.debnr IS NOT NULL
				AND g.bkstnr_sub IS NOT NULL
				AND g.facode IS NOT NULL -- We are only interested in serial numbers
		) del ON wo.sysguid = del.LinkedLine -- del.ordernr = k.ordernr AND del.debnr = k.debnr AND del.artcode = r.artcode AND 
		-- Item number
		INNER JOIN [400].dbo.ItemNumbers itn WITH (NOLOCK) ON itn.number = del.serialnumber
	WHERE 1=1
		AND NOT EXISTS (SELECT 1 FROM dbo._AB_tb_ExtendedWarranty_ItemNumbers n WITH (NOLOCK) WHERE n.administration = @administration AND n.ID = itn.ID)


	-- 2. Na leveren
	-- This one makes no sense and gives no results, so skip

	-- 3. Empty enddate
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
			FROM   [400].dbo.gbkmut gbk WITH (NOLOCK)
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

	-- 3b. New ones
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
	FROM    [400].dbo.itemnumbers itn with(nolock)
			Left outer join (   SELECT  gbk.artcode as artcode 
										,gbk.oms25
										,gbk.bkstnr_sub AS ordernr
										,gbk.facode

								FROM   [400].dbo.gbkmut gbk WITH (NOLOCK)  

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

END
GO
