/****** Object:  View [dbo].[_ST_VW_Syn_CRD_STATE]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[_ST_VW_Syn_CRD_STATE]
AS
SELECT TOP 100 PERCENT c.cmp_wwn, c.cmp_code, c.crdnr, c.cmp_name, c.cmp_status

, (SELECT MAX(v) FROM (VALUES (o400.mutdate), (o483.mutdate), (o484.mutdate)) AS VALUE (v)) AS mutdate
, CASE WHEN c.syscreated < DATEADD(YEAR,-3,GETDATE()) AND 
		( (SELECT MAX(v) FROM (VALUES (o400.mutdate), (o483.mutdate), (o484.mutdate)) AS VALUE (v)) IS NULL OR 
			(SELECT MAX(v) FROM (VALUES (o400.mutdate), (o483.mutdate), (o484.mutdate)) AS VALUE (v)) < DATEADD(YEAR,-3,GETDATE()) ) THEN 'B' 
	ELSE 'A' END AS newstatus
, CASE WHEN c.syscreated < DATEADD(YEAR,-3,GETDATE()) AND 
		( (SELECT MAX(v) FROM (VALUES (o400.mutdate), (o483.mutdate), (o484.mutdate)) AS VALUE (v)) IS NULL OR 
			(SELECT MAX(v) FROM (VALUES (o400.mutdate), (o483.mutdate), (o484.mutdate)) AS VALUE (v)) < DATEADD(YEAR,-3,GETDATE()) ) THEN
		CASE WHEN CONVERT(VARCHAR(MAX),c.cmp_note) IS NULL THEN '' ELSE CONVERT(VARCHAR(MAX),c.cmp_note) + ' 

' END + '[' + CONVERT(VARCHAR, GETDATE(), 120) + '] Blocked – 3 years no activity. ' 
  ELSE CONVERT(VARCHAR(MAX),c.cmp_note) END  as cmp_note 
from [orlaco]..cicmpy (nolock) as c	
left join [ExactData].._ST_VW_400CrdOrddat as o400 ON c.crdnr = o400.crdnr	
left join [ExactData].._ST_VW_483CrdOrddat as o483 ON c.crdnr = o483.crdnr	
left join [ExactData].._ST_VW_484CrdOrddat as o484 ON c.crdnr = o484.crdnr	

where c.cmp_type = 'S' and c.cmp_status = 'A' 
group by c.cmp_wwn, c.cmp_code, c.crdnr, c.cmp_name, c.cmp_status, c.syscreated, CONVERT(VARCHAR(MAX),c.cmp_note), o400.mutdate, o483.mutdate, o484.mutdate 
order by c.crdnr	
GO
