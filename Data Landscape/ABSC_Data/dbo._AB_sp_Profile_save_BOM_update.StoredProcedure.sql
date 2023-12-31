/****** Object:  StoredProcedure [dbo].[_AB_sp_Profile_save_BOM_update]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		AB, LVE
-- Create date: 2021-04-20
-- Description:	Save BOM lines to update
-- =============================================
CREATE PROCEDURE [dbo].[_AB_sp_Profile_save_BOM_update] 
	-- Add the parameters for the stored procedure here
	@itemcode varchar(30)
	, @partid varchar(50) 
	, @runid uniqueidentifier
	, @seqno int = 100
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- NOTE; The lines query is the same query as _AB_sp_Profile_save_BOM_create, only here the checks in exact are disabled
	-- Please note the isUpdate field, it is 1 for this SP

    -- Insert statements for procedure here
	-- Update
	-- Header
	INSERT INTO dbo._AB_tb_Profile_BOM_header (
		partid, itemcode, [action]
		, headerid, itemprod, [description], [version], eff_date, quantity, drawingno
		, pos_no -- Lead time

		, runid, rowstatus, seqno
		, isUpdate)
	SELECT 
		@partid as partid
		, @itemcode as itemcode
		, 'UPDATE' as [Action]

		, r.ID as HeaderID
		, r.Itemprod
		, (SELECT TOP (1)  CONCAT(dbo._AB_sy_PRO_GetFormattedRevision(NFT_IDNR, 2) COLLATE DATABASE_DEFAULT, '-', dbo._AB_sy_PRO_GetFormattedVersion(NFT_IDNR, 2) COLLATE DATABASE_DEFAULT)
			FROM dbo._AB_sy_PRO_NFSTAMM
			WHERE NFT_IDNR = @partid ) AS Description
		, r.version
		, r.eff_date
		, r.quantity
		, r.drawingno

		, ISNULL(r.pos_no, 1) -- Original Lead time

		, @runid as runid
		, 1 as rowstatus
		, @seqno as seqno

		, 1 as isUpdate

	FROM dbo._AB_sy_recipe r WITH (NOLOCK)  
	WHERE 1=1
		AND r.itemprod = @itemcode
		AND r.sequenceno = 0
		AND r.mainversion = 1

	-- original from ABEI
	/*
	SELECT ID, ID as headerid, 
		(SELECT dbo.PRO_FN_GetFormattedRevision(NFT_IDNR, 2) + '-' + dbo.PRO_FN_GetFormattedVersion(NFT_IDNR, 2) FROM [%abeisourcedb%]..NFSTAMM WHERE NFT_IDNR = '%param_partid%' )AS Description
		, r.quantity as drawingno
	FROM [%abeitargetdb%].dbo.recipe r WITH (NOLOCK)  
	WHERE itemprod = '%param_itemcode%' and sequenceno = '0' and mainversion = 1
	*/

	-- Lines
	INSERT INTO dbo._AB_tb_Profile_BOM_lines (
		partid, itemcode
		
		, sequenceno, position, freefield7, [action], headerid, itemprod, linetype, itemreq, variant, backflush, quantity
		, FromDay, ToDay, [version]
		
		, runid, rowstatus, seqno
		, isUpdate
		, possort)
	SELECT 
		@partid as partid
		, @itemcode as itemcode    
	
		, ROW_NUMBER() OVER (ORDER BY possort) AS sequenceno
		--a.Position,
		, a.position as pos_no
		, a.position as freefield7
		, 'ADDNEW' as Action
		, rh.ID AS headerid
		, rh.itemprod
		, a.LineType
		, a.itemreq
		, 'N' AS Variant
		, 1 AS BackFlush 
		, a.Quantity * ISNULL(rh.quantity,1) AS Quantity

		, ISNULL(a.FromDay, 1)
		, ISNULL(a.ToDay, 1)
		, rh.[version]

		, @runid as runid
		, 1 as rowstatus
		, @seqno as seqno

		, 1 as isUpdate
		, a.possort

	FROM (

		-- 1/4 1000-LABOR line
		SELECT 
			FORMAT(0, 'd3') AS possort
			, '0' as position
			, CONVERT(VARCHAR(36), P.NFT_GUID) AS headerid -- GUID
			, P.NFT_STK5 AS itemprod
			, 'L' AS LineType 
			, '1000-LABOR' AS itemreq
			, 1 AS Quantity
			, 1 as FromDay
			, 1 as ToDay
		FROM dbo._AB_sy_PRO_NFSTAMM AS P WITH (NOLOCK) 
		INNER JOIN dbo._AB_sy_PRO_TEILLIST AS T WITH (NOLOCK) ON T.TL_VIDNR = P.NFT_IDNR
		WHERE P.NFT_IDNR = @partid AND P.NFT_STK0 <> 'Yes'  -- Variant
		AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND TL_RELEVANT = 1
			--AND '1000-LABOR' not in (SELECT TOP 100 r.itemreq collate database_default from dbo._AB_sy_recipe r (NOLOCK) 
			--WHERE R.itemprod = @itemcode AND R.sequenceno > 0 AND R.Itemreq = '1000-LABOR' AND r.Version = '       1'  )
		GROUP BY P.NFT_GUID, P.NFT_STK5
		HAVING COUNT(*) > 0 
    
	UNION
		
		-- 2/4 Items
		SELECT 
			FORMAT(T.TL_POSNR, 'd3') AS possort
			, CONVERT(VARCHAR(5), T.TL_POSNR) as position
			, CONVERT(VARCHAR(36), P.NFT_GUID) AS headerid -- GUID
			, P.NFT_STK5 AS itemprod
			, 'I' AS LineType
			, C.NFT_STK5 AS itemreq
			, CASE WHEN C.NFT_STK4 = 'mm' THEN (T.TL_FLO0 * T.TL_FLO1) / 1000
				ELSE T.TL_FLO0 * T.TL_FLO1 END AS Quantity

			, 1 as FromDay
			, 1 as ToDay
		FROM dbo._AB_sy_PRO_NFSTAMM AS P WITH (NOLOCK) 
		INNER JOIN dbo._AB_sy_PRO_TEILLIST AS T WITH (NOLOCK) ON T.TL_VIDNR = P.NFT_IDNR
		INNER JOIN dbo._AB_sy_PRO_NFSTAMM AS C WITH (NOLOCK) ON T.TL_SIDNR = C.NFT_IDNR
		WHERE P.NFT_IDNR = @partid AND P.NFT_STK0 <> 'Yes'  -- Variant
			AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND C.NFT_STL2 != 'Virtual part' AND T.TL_RELEVANT = 1 AND T.TL_STL3 != 'Phantom'
			--AND C.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM dbo._AB_sy_recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) = r.pos_no collate database_default)
			AND (C.NFT_ZUST != 360) -- NO Tech release articles

	UNION

		-- 3/4 Phantoms
		SELECT 
			FORMAT(T.TL_POSNR, 'd3') + '.' + FORMAT(CT.TL_POSNR, 'd3') AS possort
			, CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) as position
			, CONVERT(VARCHAR(36), P.NFT_GUID) AS headerid -- GUID
			, P.NFT_STK5 AS itemprod
			, 'I' AS LineType    
			, CC.NFT_STK5 AS itemreq
			, CASE WHEN C.NFT_STK4 = 'mm' THEN (T.TL_FLO0 * T.TL_FLO1 * CT.TL_FLO0 * CT.TL_FLO1) / 1000
				ELSE T.TL_FLO0 * T.TL_FLO1 * CT.TL_FLO0 * CT.TL_FLO1 END AS Quantity

			, 1 as FromDay
			, 1 as ToDay
		FROM dbo._AB_sy_PRO_NFSTAMM AS P WITH (NOLOCK) 
		INNER JOIN dbo._AB_sy_PRO_TEILLIST AS T WITH (NOLOCK) ON T.TL_VIDNR = P.NFT_IDNR
		INNER JOIN dbo._AB_sy_PRO_NFSTAMM AS C WITH (NOLOCK) ON T.TL_SIDNR = C.NFT_IDNR
		INNER JOIN dbo._AB_sy_PRO_TEILLIST AS CT WITH (NOLOCK) ON CT.TL_VIDNR = C.NFT_IDNR
		INNER JOIN dbo._AB_sy_PRO_NFSTAMM AS CC WITH (NOLOCK) ON CT.TL_SIDNR = CC.NFT_IDNR
		WHERE P.NFT_IDNR = @partid AND P.NFT_STK0 <> 'Yes'  -- Variant
			AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND T.TL_RELEVANT = 1 AND CT.TL_RELEVANT = 1  AND (C.NFT_STL2 = 'Virtual part' OR T.TL_STL3 = 'Phantom')
			--AND CC.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM dbo._AB_sy_recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) = r.pos_no  collate database_default)
			AND (CC.NFT_ZUST != 360) -- NO Tech release articles
      
	UNION

		-- 4/4 Virtuals or Pantoms next level
		SELECT 
			FORMAT(T.TL_POSNR, 'd3') + '.' + FORMAT(CT.TL_POSNR, 'd3') + '.' + FORMAT(CCT.TL_POSNR, 'd3') AS possort
			, CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CCT.TL_POSNR) as position
			, CONVERT(VARCHAR(36), P.NFT_GUID) AS headerid -- GUID
			, P.NFT_STK5 AS itemprod
			, 'I' AS LineType    
			, CCC.NFT_STK5 AS itemreq
			, CASE WHEN CC.NFT_STK4 = 'mm' THEN (T.TL_FLO0 * T.TL_FLO1 * CT.TL_FLO0 * CT.TL_FLO1 * CCT.TL_FLO0 * CCT.TL_FLO1) / 1000
				ELSE T.TL_FLO0 * T.TL_FLO1 * CT.TL_FLO0 * CT.TL_FLO1 * CCT.TL_FLO0 * CCT.TL_FLO1 END AS Quantity

			, 1 as FromDay
			, 1 as ToDay
		FROM _AB_sy_PRO_NFSTAMM AS P WITH (NOLOCK) 
		INNER JOIN _AB_sy_PRO_TEILLIST AS T WITH (NOLOCK) ON T.TL_VIDNR = P.NFT_IDNR
		INNER JOIN _AB_sy_PRO_NFSTAMM AS C WITH (NOLOCK) ON T.TL_SIDNR = C.NFT_IDNR
		INNER JOIN _AB_sy_PRO_TEILLIST AS CT WITH (NOLOCK) ON CT.TL_VIDNR = C.NFT_IDNR
		INNER JOIN _AB_sy_PRO_NFSTAMM AS CC WITH (NOLOCK) ON CT.TL_SIDNR = CC.NFT_IDNR
		INNER JOIN _AB_sy_PRO_TEILLIST AS CCT WITH (NOLOCK) ON CCT.TL_VIDNR = CC.NFT_IDNR
		INNER JOIN _AB_sy_PRO_NFSTAMM AS CCC WITH (NOLOCK) ON CCT.TL_SIDNR = CCC.NFT_IDNR
		WHERE P.NFT_IDNR = @partid AND P.NFT_STK0 <> 'Yes'  -- Variant
			AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND T.TL_RELEVANT = 1 AND CT.TL_RELEVANT = 1 AND CCT.TL_RELEVANT = 1 
			AND (C.NFT_STL2 = 'Virtual part' OR T.TL_STL3 = 'Phantom')
			AND (CC.NFT_STL2 = 'Virtual part' OR CT.TL_STL3 = 'Phantom')
			--AND CC.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM dbo._AB_sy_recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) = r.pos_no  collate database_default)
			AND (CCC.NFT_ZUST != 360) -- NO Tech release articles

	) a 
	INNER JOIN dbo._AB_sy_recipe AS rh WITH (NOLOCK) ON rh.itemprod = @itemcode AND rh.sequenceno = 0 AND rh.MainVersion = 1 
	ORDER BY possort

	-- LVE 211019 save the fromDay and toDay from the labor line so we can restore it
	UPDATE l WITH (ROWLOCK, NOWAIT) SET 
		FromDay = DATEDIFF(DAY, '2000-01-01', r.eff_date)+1
		, ToDay = DATEDIFF(DAY, '2000-01-01', r.exp_date)+1
		--, quantity = r.quantity
	FROM dbo._AB_tb_Profile_BOM_lines l
		INNER JOIN dbo._AB_sy_recipe AS rh WITH (NOLOCK) ON rh.itemprod = l.itemprod AND rh.sequenceno = 0 AND rh.MainVersion = 1 -- main version
		INNER JOIN dbo._AB_sy_recipe AS r WITH (NOLOCK) ON r.itemprod = l.itemprod AND r.version = rh.version AND r.sequenceno > 0 AND r.itemreq = l.itemreq -- existing labor line
	WHERE 1=1
		AND l.runid = @runid
		AND l.itemreq = '1000-LABOR'

	-- The leadtime from the header should be atleast the last day of the last ToDay, otherwise the FromDay and ToDay won't work
	;WITH p AS (
		SELECT 
			h.ID
			, pos_no = CASE WHEN MAX(ISNULL(l.ToDay, 1)) > CAST(h.pos_no as int) THEN MAX(ISNULL(l.ToDay, 1)) ELSE h.pos_no END
		FROM dbo._AB_tb_Profile_BOM_header h WITH (NOLOCK)
			INNER JOIN dbo._AB_tb_Profile_BOM_lines l WITH (NOLOCK) ON l.runid = h.runid AND l.itemprod = h.itemprod --AND l.isUpdate = h.isUpdate
		WHERE 1=1
			AND h.runid = @runid
		GROUP BY h.ID, h.itemprod, h.pos_no
		HAVING MAX(ISNULL(l.ToDay, 1)) > CAST(h.pos_no as int)
	)
	UPDATE h WITH (ROWLOCK, NOWAIT) SET 
		pos_no = p.pos_no
	FROM dbo._AB_tb_Profile_BOM_header h
		INNER JOIN p ON p.ID = h.ID
	WHERE 1=1
		AND h.runid = @runid



	-- original from ABEI
	/*	
	SELECT TOP 100 percent
		ROW_NUMBER() OVER (ORDER BY possort) AS sequenceno,
		a.Position,
		a.position as pos_no,
		a.position as freefield7,
		'ADDNEW' as Action,
		rh.ID AS headerid,
		rh.itemprod,
		a.LineType,
		a.itemreq,
		'N' AS Variant,
		1 AS  BackFlush, 
		a.Quantity * ISNULL(rh.quantity,1) AS Quantity

	FROM (
		SELECT  TOP 100 percent
			FORMAT(0, 'd3') AS possort,
			'0' as position,
			P.NFT_STK5 AS itemprod,
			'L' AS LineType, 
			'1000-LABOR' AS itemreq,
			1 AS Quantity
		FROM NFSTAMM AS P WITH (NOLOCK) 
		INNER JOIN TEILLIST AS T WITH (NOLOCK) ON T.TL_VIDNR = P.NFT_IDNR
		WHERE P.NFT_IDNR = '%param_partid%' AND P.NFT_STK0 <> 'Yes'  -- Variant
		AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND TL_RELEVANT = 1
		--AND '1000-LABOR' not in (SELECT TOP 100 r.itemreq collate database_default from [%abeitargetdb%].dbo.recipe r (NOLOCK) 
		--WHERE R.itemprod = '%param_itemcode%' AND R.sequenceno > 0 AND R.Itemreq = '1000-LABOR' AND r.Version = '       1'  )
		GROUP BY P.NFT_STK5
		HAVING COUNT(*) > 0 
    
	UNION

		SELECT  TOP 100 percent
			FORMAT(T.TL_POSNR, 'd3') AS possort,
			CONVERT(VARCHAR(5), T.TL_POSNR) as position,
			P.NFT_STK5 AS itemprod,
			'I' AS LineType,    
			C.NFT_STK5 AS itemreq,
			CASE WHEN C.NFT_STK4 = 'mm' THEN (T.TL_FLO0 * T.TL_FLO1) / 1000
				ELSE T.TL_FLO0 * T.TL_FLO1 END AS Quantity
		FROM NFSTAMM AS P WITH (NOLOCK) 
		INNER JOIN TEILLIST AS T WITH (NOLOCK) ON T.TL_VIDNR = P.NFT_IDNR
		INNER JOIN NFSTAMM AS C WITH (NOLOCK) ON T.TL_SIDNR = C.NFT_IDNR
		WHERE P.NFT_IDNR = '%param_partid%' AND P.NFT_STK0 <> 'Yes'  -- Variant
		AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND C.NFT_STL2 != 'Virtual part' AND T.TL_RELEVANT = 1 AND T.TL_STL3 != 'Phantom'
		--AND C.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM [%abeitargetdb%].dbo.recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) = r.pos_no collate database_default)
			AND (C.NFT_ZUST != 360) -- NO Tech release articles

	UNION

		SELECT TOP 100 percent
			FORMAT(T.TL_POSNR, 'd3') + '.' + FORMAT(CT.TL_POSNR, 'd3') AS possort,
			CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) as position,
			P.NFT_STK5 AS itemprod,
			'I' AS LineType,    
			CC.NFT_STK5 AS itemreq,
			CASE WHEN C.NFT_STK4 = 'mm' THEN (T.TL_FLO0 * T.TL_FLO1 * CT.TL_FLO0 * CT.TL_FLO1) / 1000
				ELSE T.TL_FLO0 * T.TL_FLO1 * CT.TL_FLO0 * CT.TL_FLO1 END AS Quantity
		FROM NFSTAMM AS P WITH (NOLOCK) 
		INNER JOIN TEILLIST AS T WITH (NOLOCK) ON T.TL_VIDNR = P.NFT_IDNR
		INNER JOIN NFSTAMM AS C WITH (NOLOCK) ON T.TL_SIDNR = C.NFT_IDNR
		INNER JOIN TEILLIST AS CT WITH (NOLOCK) ON CT.TL_VIDNR = C.NFT_IDNR
		INNER JOIN NFSTAMM AS CC WITH (NOLOCK) ON CT.TL_SIDNR = CC.NFT_IDNR
		 WHERE P.NFT_IDNR = '%param_partid%' AND P.NFT_STK0 <> 'Yes'  -- Variant
		 AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND T.TL_RELEVANT = 1 AND CT.TL_RELEVANT = 1  AND (C.NFT_STL2 = 'Virtual part' OR T.TL_STL3 = 'Phantom')
		 --AND CC.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM [%abeitargetdb%].dbo.recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) = r.pos_no  collate database_default)
			AND (CC.NFT_ZUST != 360) -- NO Tech release articles

        
	UNION

		SELECT TOP 100 percent
			FORMAT(T.TL_POSNR, 'd3') + '.' + FORMAT(CT.TL_POSNR, 'd3') + '.' + FORMAT(CCT.TL_POSNR, 'd3') AS possort,
			CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CCT.TL_POSNR) as position,
			P.NFT_STK5 AS itemprod,
			'I' AS LineType,    
			CCC.NFT_STK5 AS itemreq,
			CASE WHEN CC.NFT_STK4 = 'mm' THEN (T.TL_FLO0 * T.TL_FLO1 * CT.TL_FLO0 * CT.TL_FLO1 * CCT.TL_FLO0 * CCT.TL_FLO1) / 1000
				ELSE T.TL_FLO0 * T.TL_FLO1 * CT.TL_FLO0 * CT.TL_FLO1 * CCT.TL_FLO0 * CCT.TL_FLO1 END AS Quantity
		FROM NFSTAMM AS P WITH (NOLOCK) 
		INNER JOIN TEILLIST AS T WITH (NOLOCK) ON T.TL_VIDNR = P.NFT_IDNR
		INNER JOIN NFSTAMM AS C WITH (NOLOCK) ON T.TL_SIDNR = C.NFT_IDNR
		INNER JOIN TEILLIST AS CT WITH (NOLOCK) ON CT.TL_VIDNR = C.NFT_IDNR
		INNER JOIN NFSTAMM AS CC WITH (NOLOCK) ON CT.TL_SIDNR = CC.NFT_IDNR
		INNER JOIN TEILLIST AS CCT WITH (NOLOCK) ON CCT.TL_VIDNR = CC.NFT_IDNR
		INNER JOIN NFSTAMM AS CCC WITH (NOLOCK) ON CCT.TL_SIDNR = CCC.NFT_IDNR
		 WHERE P.NFT_IDNR = '%param_partid%' AND P.NFT_STK0 <> 'Yes'  -- Variant
		 AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND T.TL_RELEVANT = 1 AND CT.TL_RELEVANT = 1 AND CCT.TL_RELEVANT = 1 
		 AND (C.NFT_STL2 = 'Virtual part' OR T.TL_STL3 = 'Phantom')
		 AND (CC.NFT_STL2 = 'Virtual part' OR CT.TL_STL3 = 'Phantom')
		 --AND CC.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM [%abeitargetdb%].dbo.recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) = r.pos_no  collate database_default)
			AND (CCC.NFT_ZUST != 360) -- NO Tech release articles
	) a 
	LEFT JOIN [%abeitargetdb%].dbo.recipe AS rh WITH (NOLOCK) ON rh.itemprod = '%param_itemcode%' AND rh.sequenceno = 0 AND rh.MainVersion = 1 
	ORDER BY possort
	*/

END
GO
