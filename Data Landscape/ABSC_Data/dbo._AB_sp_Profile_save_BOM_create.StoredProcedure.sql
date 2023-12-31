/****** Object:  StoredProcedure [dbo].[_AB_sp_Profile_save_BOM_create]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		AB, LVE
-- Create date: 2021-04-20
-- Description:	Save BOM lines to update
-- =============================================
CREATE PROCEDURE [dbo].[_AB_sp_Profile_save_BOM_create]
	-- Add the parameters for the stored procedure here
	@itemcode varchar(30)
	, @partid varchar(50) 
	, @runid uniqueidentifier
	, @seqno int = 200
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- NOTE; The lines query is the same query as _AB_sp_Profile_save_BOM_update, only here the checks in exact are enabled
	-- Please note the isUpdate field, it is 0 for this SP

    -- Insert statements for procedure here	
	-- Create
	-- Header
	INSERT INTO dbo._AB_tb_Profile_BOM_header (
		partid, itemcode, [action]
		, headerid, itemprod
		, [description], MainVersion, [version], eff_date, quantity, drawingno
		, pos_no -- Lead time

		, runid, rowstatus, seqno
		, isUpdate)
	SELECT 
		@partid as partid
		, @itemcode as itemcode
		, 'CREATE' as [Action]

		, Convert(varchar(36), P.NFT_GUID) as headerid
		, @itemcode as itemprod 
	
		, CONCAT(dbo._AB_sy_PRO_GetFormattedRevision(P.NFT_IDNR, 2) COLLATE DATABASE_DEFAULT, '-', dbo._AB_sy_PRO_GetFormattedVersion(P.NFT_IDNR, 2) COLLATE DATABASE_DEFAULT) AS Description
		, 1 AS MainVersion 
		, 1 as version    
		, CONVERT(date, GETDATE()) as Eff_Date
		, ISNULL(r.quantity, 1) as quantity
		, ISNULL(r.quantity, 1) as drawingno

		, ISNULL(r.pos_no, 1) as pos_no

		, @runid as runid
		, 1 as rowstatus
		, @seqno as seqno

		, 0 as isUpdate

	FROM dbo._AB_sy_PRO_NFSTAMM AS P WITH (NOLOCK) 
		LEFT JOIN dbo._AB_sy_recipe AS R WITH (NOLOCK) ON R.itemprod collate database_default = P.NFT_STK5 collate database_default AND R.sequenceno = 0 AND r.Mainversion = 1
		--LEFT JOIN [ABEI].dbo._AB_entity_results_log l WITH (NOLOCK) ON l.runid = '%runid%' and l.jobid = '%jobid%' and l.rowstatus <> -1 and l.Property = 'Quantity' and l.Action = 'update' and l.entity = 'BOMHeader'
	WHERE P.NFT_IDNR = @partid AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND P.NFT_STK0 <> 'Yes'-- Geen Variant 
		AND (SELECT COUNT(*) FROM dbo._AB_sy_PRO_TEILLIST WITH (NOLOCK) WHERE TL_VIDNR = @partid AND TL_RELEVANT = 1) > 0 -- has parts
		AND (SELECT COUNT(*) FROM dbo._AB_sy_recipe WITH (NOLOCK) WHERE itemprod collate database_default = P.NFT_STK5 collate database_default ) = 0 -- not in Exact yet. could be a not exists as well

	--- Remove BOM header if an corrupt BOM header (without lines) exists 

	INSERT INTO [dbo].[_AB_tb_Profile_log] (partid,itemcode,runid,[action],retrycount,sysmessage)
		SELECT @partid, @itemcode, @runid, 'BOMDELETE', 0, CONCAT('Starting delete of corrupt bomheader lines', ID)
		FROM dbo._AB_sy_recipe
	WHERE itemprod  = @itemcode AND sequenceno = 0 and itemreq IS NULL AND ID IN (
		SELECT MAX(ID) as ID
		FROM dbo._AB_sy_recipe  WITH (NOLOCK)
		GROUP BY itemprod, version
		HAVING COUNT(*) = 1 )

	DELETE FROM dbo._AB_sy_recipe
	WHERE itemprod  = @itemcode AND sequenceno = 0 and itemreq IS NULL AND ID IN (
		SELECT MAX(ID) as ID
		FROM dbo._AB_sy_recipe  WITH (NOLOCK)
		GROUP BY itemprod, version
		HAVING COUNT(*) = 1 )

	-- Original from ABEI
	/*
	SELECT TOP 100 percent
    Convert(varchar(36), P.NFT_GUID) as headerid, 
    0 AS sequenceno, 
    '%param_itemcode%' as itemprod, 
    dbo.PRO_FN_GetFormattedRevision(P.NFT_IDNR, 2) + '-' + dbo.PRO_FN_GetFormattedVersion(P.NFT_IDNR, 2) AS Description,
    1 AS MainVersion, 
    1 as version,
    CONVERT(int, ISNULL(R.Quantity, ISNULL(l.valueFloat, 1))) AS Quantity, 
    CONVERT(date, GETDATE()) as Eff_Date

    FROM NFSTAMM AS P WITH (NOLOCK) 
    LEFT JOIN [%abeitargetdb%].dbo.recipe AS R WITH (NOLOCK) ON R.itemprod collate database_default = P.NFT_STK5 collate database_default AND R.sequenceno = 0 AND r.Mainversion = 1
    LEFT JOIN [ABEI].dbo._AB_entity_results_log l WITH (NOLOCK) ON l.runid = '%runid%' and l.jobid = '%jobid%' and l.rowstatus <> -1 and l.Property = 'Quantity' and l.Action = 'update' and l.entity = 'BOMHeader'
    WHERE P.NFT_IDNR = '%param_partid%' AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND P.NFT_STK0 <> 'Yes'-- Geen Variant 
    AND (SELECT COUNT(*) FROM TEILLIST WITH (NOLOCK) WHERE TL_VIDNR = '%param_partid%' AND TL_RELEVANT = 1) > 0
    AND (SELECT COUNT(*) FROM [%abeitargetdb%].dbo.recipe WITH (NOLOCK) WHERE itemprod collate database_default = P.NFT_STK5 collate database_default ) = 0 
	*/

	-- Lines
	INSERT INTO dbo._AB_tb_Profile_BOM_lines (
		partid, itemcode
		
		, sequenceno, position, freefield7, [action], headerid, itemprod, linetype, itemreq, variant, backflush, quantity
		, FromDay, ToDay
		
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
		, a.headerid
		, a.itemprod
		, a.LineType
		, a.itemreq
		, 'N' AS Variant
		, 1 AS BackFlush 
		, a.Quantity AS Quantity

		, ISNULL(a.FromDay, 1)
		, ISNULL(a.ToDay, 1)

		, @runid as runid
		, 1 as rowstatus
		, @seqno as seqno

		, 0 as isUpdate
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
			AND '1000-LABOR' not in (SELECT r.itemreq collate database_default from dbo._AB_sy_recipe r WITH (NOLOCK) WHERE R.itemprod = @itemcode AND R.sequenceno > 0) -- not in Exact yet
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
			AND C.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM dbo._AB_sy_recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) = r.pos_no collate database_default)
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
			AND CC.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM dbo._AB_sy_recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) = r.pos_no  collate database_default)
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
			AND CC.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM dbo._AB_sy_recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) = r.pos_no  collate database_default)
			AND (CCC.NFT_ZUST != 360) -- NO Tech release articles

	) a 
	ORDER BY possort

	-- Original from ABEI
	/*
	SELECT TOP 100 percent
		ROW_NUMBER() OVER (ORDER BY possort) AS sequenceno,
		Position,
		position as pos_no,
		position as freefield7,
		'ADDNEW' as Action,
		headerid,
		itemprod,
		LineType,
		itemreq,
		'N' AS Variant,
		1 AS  BackFlush, 
		Quantity

	FROM (
		SELECT  TOP 1000
			FORMAT(0, 'd3') AS possort,
			'0' as position,
			CONVERT(VARCHAR(36), P.NFT_GUID) AS headerid, -- GUID
			P.NFT_STK5 AS itemprod,
			'L' AS LineType, 
			'1000-LABOR' AS itemreq,
			1 AS Quantity
		FROM NFSTAMM AS P WITH (NOLOCK) 
		INNER JOIN TEILLIST AS T WITH (NOLOCK) ON T.TL_VIDNR = P.NFT_IDNR
		WHERE P.NFT_IDNR = '%param_partid%' AND P.NFT_STK0 <> 'Yes'  -- Variant
		AND P.NFT_STL2 != 'Trade parts' AND TL_RELEVANT = 1 AND P.NFT_STL2 != 'Virtual part'
			AND '1000-LABOR' not in (SELECT r.itemreq collate database_default from [%abeitargetdb%].dbo.recipe r WITH (NOLOCK) WHERE R.itemprod = '%param_itemcode%' AND R.sequenceno > 0)
		GROUP BY P.NFT_GUID, P.NFT_STK5
		HAVING COUNT(*) > 0 
    
	UNION

		SELECT  TOP 1000
			FORMAT(T.TL_POSNR, 'd3') AS possort,
			CONVERT(VARCHAR(5), T.TL_POSNR) as position,
			CONVERT(VARCHAR(36), P.NFT_GUID) AS headerid, -- GUID
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
			AND C.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM [%abeitargetdb%].dbo.recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) = r.pos_no collate database_default)
			AND (C.NFT_ZUST != 360) -- NO Tech release articles

	UNION

		SELECT TOP 1000
			FORMAT(T.TL_POSNR, 'd3') + '.' + FORMAT(CT.TL_POSNR, 'd3') AS possort,
			CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) as position,
			CONVERT(VARCHAR(36), P.NFT_GUID) AS headerid, -- GUID
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
			AND P.NFT_STL2 != 'Trade parts' AND P.NFT_STL2 != 'Virtual part' AND T.TL_RELEVANT = 1 AND CT.TL_RELEVANT = 1 AND (C.NFT_STL2 = 'Virtual part' OR T.TL_STL3 = 'Phantom')
			AND CC.NFT_STK5 NOT IN (SELECT r.itemreq collate database_default FROM [%abeitargetdb%].dbo.recipe r WITH (NOLOCK) WHERE r.itemprod collate database_default = P.NFT_STK5 ) -- AND CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) = r.pos_no  collate database_default)
			AND (CC.NFT_ZUST != 360) -- NO Tech release articles
        
	UNION

		SELECT TOP 1000
			FORMAT(T.TL_POSNR, 'd3') + '.' + FORMAT(CT.TL_POSNR, 'd3') + '.' + FORMAT(CCT.TL_POSNR, 'd3') AS possort,
			CONVERT(VARCHAR(5), T.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CT.TL_POSNR) + '.' + CONVERT(VARCHAR(5), CCT.TL_POSNR) as position,
			CONVERT(VARCHAR(36), P.NFT_GUID) AS headerid, -- GUID
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
	) a ORDER BY possort


	*/



END
GO
