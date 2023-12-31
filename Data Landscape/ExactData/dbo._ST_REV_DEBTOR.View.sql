/****** Object:  View [dbo].[_ST_REV_DEBTOR]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[_ST_REV_DEBTOR] AS

SELECT ltrim(a.c2Debcode) AS debcode
		,a.c2cmp_name AS InvoiceDebName
		,ROUND(SUM(a.Amt_Ordered),0) as Ordered_This_Month
		,ROUND(SUM(b.Amt_Ordered),0) as  Ordered_After_This_Month
		,ROUND(SUM(a.Amt_Invoiced),0) as Invoiced
		,A.Accountmanager
		,400 as 'Admin'
		FROM 
(SELECT  c2.debcode AS c2Debcode 
		,c2.cmp_name as c2cmp_name, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') THEN -g.bdr_hfl END) AS Amt_Ordered, 
		SUM(CASE WHEN Transsubtype = 'B' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal > 0 THEN g.bdr_hfl WHEN Transsubtype = 'H' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal < 0 THEN g.bdr_hfl ELSE 0 END) AS Amt_Fulfilled, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') AND (g.Checked=1 AND g.Reviewed =1 AND g.BlockItem=1) THEN -g.bdr_hfl ELSE 0 END) AS Amt_Invoiced, 
		h.fullname as Accountmanager
FROM [400]..gbkmut g with (nolock)
JOIN (SELECT reknr,omzrek FROM [400]..grtbk with (nolock) WHERE grtbk.omzrek IN ('J','K','D','N')) AS a ON a.reknr = g.reknr 
JOIN (SELECT cmp_wwn, debnr, debcode, cmp_name FROM [400]..cicmpy with (nolock)) AS c ON c.cmp_wwn = g.orderdebtor  
JOIN [400]..orkrg with (nolock) ON orkrg.ordernr = g.bkstnr_sub AND orkrg.ord_soort = 'V'  AND ISNULL(orkrg.selcode,'') <> 'ZZ' 
JOIN [400]..cicmpy c2 with (nolock) ON c2.debnr = g.debnr 
left join [400]..humres h with (nolock) on h.res_id = c2.cmp_acc_man
 WHERE g.Transtype = 'B' AND orkrg.ord_soort = 'v' and g.Transsubtype IN ('K','C','B','H') AND g.freefield1 = 'V' AND g.bud_vers = 'MRP' AND g.artcode <> g.shipment 
 AND g.afldat BETWEEN DATEADD(yy, DATEDIFF(yy,0,getdate()), 0) AND  DATEADD(s,-1, DATEADD(mm,+1,DATEADD(mm,DATEDIFF(mm,0,Getdate()),0))) AND g.debnr IS NOT NULL 
 AND g.orderdebtor IS NOT NULL and orkrg.magcode NOT IN(
's20',
's3',
's60',
's70',
's94',
's95',
's96',
'S97',
'S98',
'S99')   GROUP BY  c2.debcode, c2.cmp_name, h.fullname
)   a 
LEFT JOIN (
SELECT  c2.debcode AS c2Debcode 
		,c2.cmp_name as c2cmp_name, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') THEN -g.bdr_hfl END) AS Amt_Ordered, 
		SUM(CASE WHEN Transsubtype = 'B' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal > 0 THEN g.bdr_hfl WHEN Transsubtype = 'H' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal < 0 THEN g.bdr_hfl ELSE 0 END) AS Amt_Fulfilled, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') AND (g.Checked=1 AND g.Reviewed =1 AND g.BlockItem=1) THEN -g.bdr_hfl ELSE 0 END) AS Amt_Invoiced, 
	h.fullname as Accountmanager
FROM [400]..gbkmut g with (nolock)
JOIN (SELECT reknr,omzrek FROM [400]..grtbk with (nolock) WHERE grtbk.omzrek IN ('J','K','D','N')) AS a ON a.reknr = g.reknr 
JOIN (SELECT cmp_wwn, debnr, debcode, cmp_name FROM [400]..cicmpy with (nolock)) AS c ON c.cmp_wwn = g.orderdebtor  
JOIN [400]..orkrg with (nolock) ON orkrg.ordernr = g.bkstnr_sub AND orkrg.ord_soort = 'V'  AND ISNULL(orkrg.selcode,'') <> 'ZZ' 
JOIN [400]..cicmpy c2 with (nolock) ON c2.debnr = g.debnr 
left join [400]..humres h with (nolock) on h.res_id = c2.cmp_acc_man
 WHERE g.Transtype = 'B' AND orkrg.ord_soort = 'v' and g.Transsubtype IN ('K','C','B','H') AND g.freefield1 = 'V' AND g.bud_vers = 'MRP' AND g.artcode <> g.shipment 
 AND g.afldat > DATEADD(s,-1, DATEADD(mm,+1,DATEADD(mm,DATEDIFF(mm,0,Getdate()),0))) AND g.debnr IS NOT NULL AND g.orderdebtor IS NOT NULL and orkrg.magcode NOT IN(
's20',
's3',
's60',
's70',
's94',
's95',
's96',
'S97',
'S98',
'S99')   GROUP BY  c2.debcode, c2.cmp_name, h.fullname
)   b on b.c2Debcode = a.c2Debcode
group by a.c2Debcode, a.c2cmp_name, a.Accountmanager


UNION

SELECT ltrim(a.c2Debcode)
		,a.c2cmp_name AS InvoiceDebName
		,ROUND(SUM(a.Amt_Ordered),0) as Ordered_This_Month
		,ROUND(SUM(b.Amt_Ordered),0) as  Ordered_After_This_Month
		,ROUND(SUM(a.Amt_Invoiced),0) as Invoiced
		,A.Accountmanager
		,483 as 'Admin'
		FROM 
(SELECT  c2.debcode AS c2Debcode 
		,c2.cmp_name as c2cmp_name, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') THEN -g.bdr_hfl END) AS Amt_Ordered, 
		SUM(CASE WHEN Transsubtype = 'B' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal > 0 THEN g.bdr_hfl WHEN Transsubtype = 'H' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal < 0 THEN g.bdr_hfl ELSE 0 END) AS Amt_Fulfilled, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') AND (g.Checked=1 AND g.Reviewed =1 AND g.BlockItem=1) THEN -g.bdr_hfl ELSE 0 END) AS Amt_Invoiced, 
		h.fullname as Accountmanager
FROM [483]..gbkmut g with (nolock)
JOIN (SELECT reknr,omzrek FROM [483]..grtbk with (nolock) WHERE grtbk.omzrek IN ('J','K','D','N')) AS a ON a.reknr = g.reknr 
JOIN (SELECT cmp_wwn, debnr, debcode, cmp_name FROM [483]..cicmpy with (nolock)) AS c ON c.cmp_wwn = g.orderdebtor  
JOIN [483]..orkrg with (nolock) ON orkrg.ordernr = g.bkstnr_sub AND orkrg.ord_soort = 'V'  AND ISNULL(orkrg.selcode,'') <> 'ZZ' 
JOIN [483]..cicmpy c2 with (nolock) ON c2.debnr = g.debnr 
left join [483]..humres h with (nolock) on h.res_id = c2.cmp_acc_man
 WHERE g.Transtype = 'B' AND orkrg.ord_soort = 'v' and g.Transsubtype IN ('K','C','B','H') AND g.freefield1 = 'V' AND g.bud_vers = 'MRP' AND g.artcode <> g.shipment 
 AND g.afldat BETWEEN DATEADD(yy, DATEDIFF(yy,0,getdate()), 0) AND  DATEADD(s,-1, DATEADD(mm,+1,DATEADD(mm,DATEDIFF(mm,0,Getdate()),0))) AND g.debnr IS NOT NULL
  AND g.orderdebtor IS NOT NULL and orkrg.magcode NOT IN(
's20',
's3',
's60',
's70',
's94',
's95',
's96',
'S97',
'S98',
'S99')   GROUP BY  c2.debcode, c2.cmp_name, h.fullname
)   a 
LEFT JOIN (
SELECT  c2.debcode AS c2Debcode 
		,c2.cmp_name as c2cmp_name, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') THEN -g.bdr_hfl END) AS Amt_Ordered, 
		SUM(CASE WHEN Transsubtype = 'B' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal > 0 THEN g.bdr_hfl WHEN Transsubtype = 'H' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal < 0 THEN g.bdr_hfl ELSE 0 END) AS Amt_Fulfilled, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') AND (g.Checked=1 AND g.Reviewed =1 AND g.BlockItem=1) THEN -g.bdr_hfl ELSE 0 END) AS Amt_Invoiced, 
			h.fullname as Accountmanager
FROM [483]..gbkmut g with (nolock)
JOIN (SELECT reknr,omzrek FROM [483]..grtbk with (nolock) WHERE grtbk.omzrek IN ('J','K','D','N')) AS a ON a.reknr = g.reknr 
JOIN (SELECT cmp_wwn, debnr, debcode, cmp_name FROM [483]..cicmpy with (nolock)) AS c ON c.cmp_wwn = g.orderdebtor  
JOIN [483]..orkrg with (nolock) ON orkrg.ordernr = g.bkstnr_sub AND orkrg.ord_soort = 'V'  AND ISNULL(orkrg.selcode,'') <> 'ZZ' 
JOIN [483]..cicmpy c2 with (nolock) ON c2.debnr = g.debnr 
left join [483]..humres h with (nolock) on h.res_id = c2.cmp_acc_man
 WHERE g.Transtype = 'B' AND orkrg.ord_soort = 'v' and g.Transsubtype IN ('K','C','B','H') AND g.freefield1 = 'V' AND g.bud_vers = 'MRP' AND g.artcode <> g.shipment 
 AND g.afldat > DATEADD(s,-1, DATEADD(mm,+1,DATEADD(mm,DATEDIFF(mm,0,Getdate()),0))) AND g.debnr IS NOT NULL AND g.orderdebtor IS NOT NULL and orkrg.magcode NOT IN(
's20',
's3',
's60',
's70',
's94',
's95',
's96',
'S97',
'S98',
'S99')   GROUP BY  c2.debcode, c2.cmp_name, h.fullname
)   b on b.c2Debcode = a.c2Debcode
group by a.c2Debcode, a.c2cmp_name, a.Accountmanager

UNION

SELECT ltrim(a.c2Debcode)
		,a.c2cmp_name AS InvoiceDebName
		,ROUND(SUM(a.Amt_Ordered),0)*0.9 as Ordered_This_Month
		,ROUND(SUM(b.Amt_Ordered),0)*0.9 as Ordered_After_This_Month
		,ROUND(SUM(a.Amt_Invoiced),0)*0.9 as Invoiced
		,A.Accountmanager
		,484 as 'Admin'
		FROM 
(SELECT  c2.debcode AS c2Debcode 
		,c2.cmp_name as c2cmp_name, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') THEN -g.bdr_hfl END) AS Amt_Ordered, 
		SUM(CASE WHEN Transsubtype = 'B' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal > 0 THEN g.bdr_hfl WHEN Transsubtype = 'H' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal < 0 THEN g.bdr_hfl ELSE 0 END) AS Amt_Fulfilled, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') AND (g.Checked=1 AND g.Reviewed =1 AND g.BlockItem=1) THEN -g.bdr_hfl ELSE 0 END) AS Amt_Invoiced, 
			h.fullname as Accountmanager
FROM [484]..gbkmut g with (nolock)
JOIN (SELECT reknr,omzrek FROM [484]..grtbk with (nolock) WHERE grtbk.omzrek IN ('J','K','D','N')) AS a ON a.reknr = g.reknr 
JOIN (SELECT cmp_wwn, debnr, debcode, cmp_name FROM [484]..cicmpy with (nolock)) AS c ON c.cmp_wwn = g.orderdebtor  
JOIN [484]..orkrg with (nolock) ON orkrg.ordernr = g.bkstnr_sub AND orkrg.ord_soort = 'V'  AND ISNULL(orkrg.selcode,'') <> 'ZZ' 
JOIN [484]..cicmpy c2 with (nolock) ON c2.debnr = g.debnr 
left join [484]..humres h with (nolock) on h.res_id = c2.cmp_acc_man
 WHERE g.Transtype = 'B' AND orkrg.ord_soort = 'v' and g.Transsubtype IN ('K','C','B','H') AND g.freefield1 = 'V' AND g.bud_vers = 'MRP' AND g.artcode <> g.shipment 
 AND g.afldat BETWEEN DATEADD(yy, DATEDIFF(yy,0,getdate()), 0) AND  DATEADD(s,-1, DATEADD(mm,+1,DATEADD(mm,DATEDIFF(mm,0,Getdate()),0))) AND g.debnr IS NOT NULL
  AND g.orderdebtor IS NOT NULL and  orkrg.magcode NOT IN(
's20',
's3',
's60',
's70',
's94',
's95',
's96',
'S97',
'S98',
'S99')   GROUP BY  c2.debcode, c2.cmp_name, h.fullname
)   a 
LEFT JOIN (
SELECT  c2.debcode AS c2Debcode 
		,c2.cmp_name as c2cmp_name, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') THEN -g.bdr_hfl END) AS Amt_Ordered, 
		SUM(CASE WHEN Transsubtype = 'B' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal > 0 THEN g.bdr_hfl WHEN Transsubtype = 'H' AND a.omzrek IN ('J','K','N') AND (g.Reviewed =1 AND g.BlockItem=1) AND g.aantal < 0 THEN g.bdr_hfl ELSE 0 END) AS Amt_Fulfilled, 
		SUM(CASE WHEN Transsubtype IN ('K','C') AND a.omzrek IN ('J','K','N') AND (g.Checked=1 AND g.Reviewed =1 AND g.BlockItem=1) THEN -g.bdr_hfl ELSE 0 END) AS Amt_Invoiced, 
		h.fullname as Accountmanager
FROM [484]..gbkmut g with (nolock)
JOIN (SELECT reknr,omzrek FROM [484]..grtbk with (nolock) WHERE grtbk.omzrek IN ('J','K','D','N')) AS a ON a.reknr = g.reknr 
JOIN (SELECT cmp_wwn, debnr, debcode, cmp_name FROM [484]..cicmpy with (nolock)) AS c ON c.cmp_wwn = g.orderdebtor  
JOIN [484]..orkrg with (nolock) ON orkrg.ordernr = g.bkstnr_sub AND orkrg.ord_soort = 'V'  AND ISNULL(orkrg.selcode,'') <> 'ZZ' 
JOIN [484]..cicmpy c2 with (nolock) ON c2.debnr = g.debnr 
left join [484]..humres h with (nolock) on h.res_id = c2.cmp_acc_man
 WHERE g.Transtype = 'B' AND orkrg.ord_soort = 'v' and g.Transsubtype IN ('K','C','B','H') AND g.freefield1 = 'V' AND g.bud_vers = 'MRP' AND g.artcode <> g.shipment 
 AND g.afldat > DATEADD(s,-1, DATEADD(mm,+1,DATEADD(mm,DATEDIFF(mm,0,Getdate()),0))) AND g.debnr IS NOT NULL AND g.orderdebtor IS NOT NULL and orkrg.magcode NOT IN(
's20',
's3',
's60',
's70',
's94',
's95',
's96',
'S97',
'S98',
'S99')   GROUP BY  c2.debcode, c2.cmp_name, h.fullname
)   b on b.c2Debcode = a.c2Debcode
group by a.c2Debcode, a.c2cmp_name, a.Accountmanager


GO
