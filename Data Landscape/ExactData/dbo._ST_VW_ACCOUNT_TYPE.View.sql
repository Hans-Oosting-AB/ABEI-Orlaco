/****** Object:  View [dbo].[_ST_VW_ACCOUNT_TYPE]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[_ST_VW_ACCOUNT_TYPE]
AS
select	top 100 percent
C.cmp_wwn,	
RTRIM(LTRIM(c.cmp_code)) AS Code, 	
RTRIM(c.cmp_name) AS Relatienaam, 	
LTRIM(c.debcode) AS Debiteurcode, 	
c.cmp_status AS Status, 	
c.cmp_type AS TypeCode, 

CASE WHEN C.cmp_type = 'C' THEN 'Customer'	
	 WHEN c.cmp_type = 'L' THEN 'Lead'
	 WHEN c.cmp_type = 'P' THEN 'Prospect'
	 WHEN c.cmp_type = 'T' THEN 'Suspect'
END AS TypeDescription,	
isnull(isnull(isnull(o400.Category_01,o482.Category_01),o483.Category_01),o484.Category_01) AS Category,
CASE WHEN (SELECT MAX(v) FROM (VALUES (o400.orddat), (o482.orddat),(o483.orddat), (o484.orddat)) AS VALUE (v)) > DATEADD(YEAR,-5.5,GETDATE()) THEN 'C'	
	ELSE CASE WHEN (MAX(aq.StatusChanged) > DATEADD(YEAR,-2.5,GETDATE())) then 'P'
	ELSE CASE WHEN (MAX(acm.StatusChanged) > DATEADD(YEAR,-2,GETDATE())) then 'L'
	ELSE 'T' END END END AS 'NewTypeCode',
CASE WHEN (SELECT MAX(v) FROM (VALUES (o400.orddat), (o482.orddat),(o483.orddat), (o484.orddat)) AS VALUE (v)) > DATEADD(YEAR,-5.5,GETDATE()) THEN 'CUSTOMER'	
	ELSE CASE WHEN (MAX(aq.StatusChanged) > DATEADD(YEAR,-2.5,GETDATE())) then 'PROSPECT'
	ELSE CASE WHEN (MAX(acm.StatusChanged) > DATEADD(YEAR,-2,GETDATE())) then 'LEAD'
	ELSE 'SUSPECT' END END END AS 'NewTypeDescription'
,(SELECT MAX(v) FROM (VALUES (o400.orddat), (o482.orddat),(o483.orddat), (o484.orddat)) AS VALUE (v)) AS maxorddat	
	
,MAX(acm.StatusChanged) as MaxContactDat,MAX(aq.StatusChanged) as MaxQuotDat	
from [orlaco]..cicmpy (nolock) as c	
left join [orlaco]..cicmpy (nolock) as cp on c.cmp_parent = cp.cmp_wwn	
left join [orlaco]..Absences (nolock) as acm on acm.customerid = c.cmp_wwn	
left join [orlaco]..Absences (nolock) as aq on aq.customerid = c.cmp_wwn and aq.type = 213 -- quotation	
left join [ExactData].._ST_VW_400DebOrddat as o400 ON c.debnr = o400.debnr	
left join [ExactData].._ST_VW_482DebOrddat as o482 ON c.debnr = o482.debnr	
left join [ExactData].._ST_VW_483DebOrddat as o483 ON c.debnr = o483.debnr	
left join [ExactData].._ST_VW_484DebOrddat as o484 ON c.debnr = o484.debnr	

where c.cmp_type IN ('C','L','P','T') and c.cmp_status = 'A' 	
group by c.cmp_wwn,c.cmp_code,c.cmp_name,c.debcode,c.cmp_status,c.cmp_type ,o400.orddat, o482.orddat,o483.orddat, o484.orddat,
isnull(isnull(isnull(o400.Category_01,o482.Category_01),o483.Category_01),o484.Category_01)
order by c.cmp_code	
GO
