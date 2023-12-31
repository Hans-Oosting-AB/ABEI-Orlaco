/****** Object:  View [dbo].[_ST_VW_EDI_CAT_ASNs]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[_ST_VW_EDI_CAT_ASNs] AS
SELECT TOP 100 PERCENT o.OrderNr
 ,o.pakbon_nr AS ShippingNote 
 ,FORMAT(GETDATE(), 'yyMMdd') AS ShipmentDate
-- ,FORMAT(o.afldat, 'yyMMdd') AS ShipmentDate
 ,oc.textfield5 AS Sender 
 ,oc.TextField11 AS Receiver 
 ,oc.TextField15 AS FacilityCode 
 ,LEFT(UPPER(dc.cmp_name),30) AS ShipToName 
 ,dc.TextField15 AS ShipToCode
 ,LEFT(UPPER(dc.cmp_fadd1),30) AS ShipToAddress
 ,UPPER(dc.cmp_fcity) AS ShipToCity
 ,LEFT(UPPER(dc.cmp_fpc),7) AS ShipToZipCode
 ,UPPER(dc.cmp_fctry) AS ShipToCountry
 ,UPPER(b.bedrnm) AS ShipFromName
 ,dc.TextField5 AS ShipFromCode
 ,UPPER(b.adr) AS ShipFromAddress
 ,UPPER(b.woonpl) AS ShipFromCity
 ,b.pstcd AS ShipFromZipCode
 ,b.landcode AS ShipFromCountry
 ,o.refer1 AS PONumber
 ,o.refer2 as POCallId
 ,r.artcode as Itemcode
 ,CASE WHEN CHARINDEX('EC',ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount)) = 0 THEN ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount)
	ELSE LEFT(ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount),CHARINDEX('EC',ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount))-1) END AS CustomerItemCode
,CASE WHEN CHARINDEX('EC',ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount)) = 0 THEN ''
	ELSE RIGHT(ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount),2) END AS ECLevel
 ,UPPER(r.oms45) AS ItemDescription
 ,CONVERT(varchar,r.prijs83) AS ItemPrice
 ,CONVERT(varchar,r.aant_gelev) AS ItemPieces
 ,CONVERT(varchar,o.bdr_val) AS Total
 ,CONVERT(varchar,ROUND(i.NetWeight * r.aant_gelev,0)) AS NetWeight
 , o.refer, o.docnumber,o.debnr,o.fakdebnr, o.verzdebnr, r.regel

FROM [400]..orhkrg o WITH (NOLOCK)
INNER JOIN [400]..orhsrg r WITH (NOLOCK) ON o.ordernr = r.ordernr and o.pakbon_nr = r.pakbon_nr and r.korting < 100
INNER JOIN [400]..items i with (NOLOCK) ON i.itemcode = r.artcode
INNER JOIN [400]..bedryf b WITH (NOLOCK) ON b.bedrnr = '400'
INNER JOIN [400]..cicmpy oc WITH (NOLOCK) ON oc.debnr = o.debnr 
INNER JOIN [400]..cicmpy dc WITH (NOLOCK) ON dc.debnr = o.verzdebnr
LEFT JOIN [484]..ItemAccounts iad WITH (NOLOCK) on r.artcode = iad.ItemCode and iad.AccountCode = dc.cmp_wwn
LEFT JOIN [484]..ItemAccounts iao WITH (NOLOCK) on r.artcode = iao.ItemCode and iao.AccountCode = oc.cmp_wwn
where o.pakbon_dat > '2020-01-01' 

UNION 


SELECT TOP 100 PERCENT o.OrderNr
 ,o.pakbon_nr AS ShippingNote 
 ,FORMAT(GETDATE(), 'yyMMdd') AS ShipmentDate
-- ,FORMAT(o.afldat, 'yyMMdd') AS ShipmentDate
 ,oc.textfield5 AS Sender 
 ,oc.TextField11 AS Receiver 
 ,oc.TextField15 AS FacilityCode 
 ,LEFT(UPPER(dc.cmp_name),30) AS ShipToName 
 ,dc.TextField15 AS ShipToCode
 ,LEFT(UPPER(dc.cmp_fadd1),30) AS ShipToAddress
 ,UPPER(dc.cmp_fcity) AS ShipToCity
 ,LEFT(UPPER(dc.cmp_fpc),7) AS ShipToZipCode
 ,UPPER(dc.cmp_fctry) AS ShipToCountry
 ,UPPER(b.bedrnm) AS ShipFromName
 ,oc.TextField5 AS ShipFromCode
 ,UPPER(b.adr) AS ShipFromAddress
 ,UPPER(b.woonpl) AS ShipFromCity
 ,b.pstcd AS ShipFromZipCode
 ,b.landcode AS ShipFromCountry
 ,o.refer1 AS PONumber
 ,o.refer2 as POCallId
 ,r.artcode as Itemcode
 ,CASE WHEN CHARINDEX('EC',ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount)) = 0 THEN ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount)
	ELSE LEFT(ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount),CHARINDEX('EC',ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount))-1) END AS CustomerItemCode
,CASE WHEN CHARINDEX('EC',ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount)) = 0 THEN ''
	ELSE RIGHT(ISNULL(iad.ItemCodeAccount,iao.ItemCodeAccount),2) END AS ECLevel
 ,UPPER(r.oms45) AS ItemDescription
 ,CONVERT(varchar,r.prijs83) AS ItemPrice
 ,CONVERT(varchar,r.aant_gelev) AS ItemPieces
 ,CONVERT(varchar,o.bdr_val) AS Total
 ,CONVERT(varchar,ROUND(i.NetWeight * r.aant_gelev,0)) AS NetWeight
 , o.refer, o.docnumber,o.debnr,o.fakdebnr, o.verzdebnr, r.regel

FROM [484]..orhkrg o WITH (NOLOCK)
INNER JOIN [484]..orhsrg r WITH (NOLOCK) ON o.ordernr = r.ordernr and o.pakbon_nr = r.pakbon_nr and r.korting < 100
INNER JOIN [484]..items i with (NOLOCK) ON i.itemcode = r.artcode
INNER JOIN [484]..bedryf b WITH (NOLOCK) ON b.bedrnr = '484'
INNER JOIN [484]..cicmpy oc WITH (NOLOCK) ON oc.debnr = o.debnr 
INNER JOIN [484]..cicmpy dc WITH (NOLOCK) ON dc.debnr = o.verzdebnr
LEFT JOIN [484]..ItemAccounts iad WITH (NOLOCK) on r.artcode = iad.ItemCode and iad.AccountCode = dc.cmp_wwn
LEFT JOIN [484]..ItemAccounts iao WITH (NOLOCK) on r.artcode = iao.ItemCode and iao.AccountCode = oc.cmp_wwn
where o.pakbon_dat > '2020-01-01' 

order by r.regel 
GO
