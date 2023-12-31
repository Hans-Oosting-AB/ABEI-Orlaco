/****** Object:  View [dbo].[_ST_VW_484CrdOrdDat]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[_ST_VW_484CrdOrdDat]
AS 
SELECT TOP 100 PERCENT c.cmp_wwn, c.cmp_code, c.crdnr, c.cmp_name, c.cmp_status
, MAX(g.sysmodified) AS mutdate
, CASE WHEN c.syscreated < DATEADD(YEAR,-3,GETDATE()) AND 
		(MAX(g.sysmodified) IS NULL OR MAX(g.sysmodified) < DATEADD(YEAR,-3,GETDATE())) THEN 'B' ELSE 'A' END AS newstatus
, CASE WHEN c.syscreated < DATEADD(YEAR,-3,GETDATE()) AND 
		(MAX(g.sysmodified) IS NULL OR MAX(g.sysmodified) < DATEADD(YEAR,-3,GETDATE())) THEN
	CASE WHEN CONVERT(VARCHAR(MAX),c.cmp_note) IS NULL THEN '' 
	ELSE CONVERT(VARCHAR(MAX),c.cmp_note) + ' 

' END + '[' + CONVERT(VARCHAR, GETDATE(), 120) + '] Blocked – 3 years no activity. ' 
ELSE CONVERT(VARCHAR(MAX),c.cmp_note) END as cmp_note 

FROM [484]..cicmpy c (NOLOCK) 
LEFT JOIN [484]..gbkmut g(NOLOCK) ON g.crdnr = c.crdnr 
WHERE c.cmp_type = 'S' AND c.cmp_status = 'A' 
GROUP BY  c.cmp_wwn, c.cmp_code,c.crdnr, c.cmp_name, c.cmp_status, c.syscreated, CONVERT(VARCHAR(MAX),c.cmp_note)
ORDER BY  c.crdnr
GO
