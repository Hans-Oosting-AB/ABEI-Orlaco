/****** Object:  View [dbo].[_ST_VW_SYNERGY_RELATIONTYPES]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[_ST_VW_SYNERGY_RELATIONTYPES]
AS
SELECT
C.cmp_wwn,
RTRIM(LTRIM(c.cmp_code)) AS Code, 
RTRIM(c.cmp_name) AS Relatienaam, 
LTRIM(c.debcode) AS Debiteurcode, 
c.ClassificationId,
c.cmp_status AS Status, 
c.cmp_type AS TypeCode,
CASE WHEN C.cmp_type = 'C' THEN 'Customer'
	 WHEN c.cmp_type = 'L' THEN 'Lead'
	 WHEN c.cmp_type = 'P' THEN 'Prospect'
	 WHEN c.cmp_type = 'T' THEN 'Suspect'
END AS TypeDescription,
CASE WHEN (c.cmp_type = 'C' and c.type_since > DATEADD(YEAR, -2, GETDATE())) THEN 'C' 
	ELSE CASE WHEN (C.cmp_type = 'C' AND (SELECT MAX(v) FROM (VALUES (o400.orddat), (o482.orddat),(o483.orddat), (o484.orddat)) AS VALUE (v)) > DATEADD(YEAR,-5.5,GETDATE())) THEN 'C'
	ELSE CASE WHEN (MAX(aq.StatusChanged) > DATEADD(YEAR,-2.5,GETDATE())) THEN 'P'
	ELSE CASE WHEN (MAX(acm.StatusChanged) > DATEADD(YEAR,-2,GETDATE())) THEN 'L'
	ELSE 'T' END END END END AS 'NewTypeCode',
CASE WHEN (c.cmp_type = 'C' and c.type_since > DATEADD(YEAR, -2, GETDATE())) THEN 'Customer' 
	ELSE CASE WHEN (C.cmp_type = 'C' AND (SELECT MAX(v) FROM (VALUES (o400.orddat), (o482.orddat),(o483.orddat), (o484.orddat)) AS VALUE (v)) > DATEADD(YEAR,-5.5,GETDATE())) THEN 'Customer'
	ELSE CASE WHEN (MAX(aq.StatusChanged) > DATEADD(YEAR,-2.5,GETDATE())) THEN 'Prospect'
	ELSE CASE WHEN (MAX(acm.StatusChanged) > DATEADD(YEAR,-2,GETDATE())) THEN 'Lead'
	ELSE 'Suspect' END END END END AS 'NewTypeDescription'
,(SELECT MAX(v) FROM (VALUES (o400.orddat), (o482.orddat),(o483.orddat), (o484.orddat)) AS VALUE (v)) AS maxorddat

,MAX(acm.StatusChanged) AS MaxContactDat,MAX(aq.StatusChanged) AS MaxQuotDat, c.type_since
FROM [orlaco]..cicmpy (NOLOCK) AS c
LEFT JOIN [orlaco]..cicmpy (NOLOCK) AS cp ON c.cmp_parent = cp.cmp_wwn
LEFT JOIN [orlaco]..Absences (NOLOCK) AS acm ON acm.customerid = c.cmp_wwn
LEFT JOIN [orlaco]..Absences (NOLOCK) AS aq ON aq.customerid = c.cmp_wwn AND aq.type = 213 -- quotation
LEFT JOIN [ExactData].._ST_VW_400DebOrddat AS o400 ON c.debnr = o400.debnr
LEFT JOIN [ExactData].._ST_VW_482DebOrddat AS o482 ON c.debnr = o482.debnr
LEFT JOIN [ExactData].._ST_VW_483DebOrddat AS o483 ON c.debnr = o483.debnr
LEFT JOIN [ExactData].._ST_VW_484DebOrddat AS o484 ON c.debnr = o484.debnr

WHERE c.cmp_type IN ('C','L','P','T') AND c.cmp_status = 'A' 
GROUP BY c.cmp_wwn,c.cmp_code,c.cmp_name,c.debcode,c.ClassificationId, c.cmp_status,c.cmp_type,c.type_since,o400.orddat, o482.orddat,o483.orddat, o484.orddat
--order by c.cmp_code



GO
