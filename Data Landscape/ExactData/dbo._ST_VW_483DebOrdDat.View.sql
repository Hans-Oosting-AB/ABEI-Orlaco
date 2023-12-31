/****** Object:  View [dbo].[_ST_VW_483DebOrdDat]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[_ST_VW_483DebOrdDat]
AS 
SELECT c.debnr, c.Category_01, MAX(o.orddat) AS deborddat , MAX(b.orddat) AS catorddat, ISNULL( MAX(b.orddat),MAX(o.orddat)) AS orddat
FROM [483]..cicmpy c (NOLOCK) 
LEFT JOIN [483]..orkrg o(NOLOCK) ON o.debnr = c.debnr  OR o.fakdebnr = c.debnr OR o.verzdebnr = c.debnr OR o.einddebnr = c.debnr
LEFT JOIN (
	SELECT c.Category_01, MAX(o.orddat) AS orddat 
	FROM [483]..cicmpy c (NOLOCK) 
	INNER JOIN [483]..orkrg o(NOLOCK) 
	ON o.debnr = c.debnr  OR o.fakdebnr = c.debnr OR o.verzdebnr = c.debnr OR o.einddebnr = c.debnr
	WHERE NOT c.Category_01 IS NULL
	GROUP BY c.Category_01 ) B ON c.Category_01 = B.Category_01

GROUP BY c.debnr, c.Category_01


GO
