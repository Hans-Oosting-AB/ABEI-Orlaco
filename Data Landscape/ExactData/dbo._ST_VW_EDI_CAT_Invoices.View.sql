/****** Object:  View [dbo].[_ST_VW_EDI_CAT_Invoices]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[_ST_VW_EDI_CAT_Invoices] AS
SELECT f.OrderNr
 ,f.faknr AS Invoice 
 ,FORMAT(f.fakdat, 'yyMMdd') AS InvoiceDate 
 ,ic.textfield5 AS Sender 
 ,ic.TextField11 AS Receiver 
 ,ic.TextField15 AS FacilityCode 
 ,LEFT(UPPER(bc.cmp_name),30) as BuyerName
 ,bc.TextField15 as BuyerCode
 ,f.valcode AS Currency
 ,f.pakbon_nr AS ShippingNote 
 ,FORMAT(f.afldat, 'yyMMdd') AS ShipmentDate
 ,LEFT(UPPER(dc.cmp_name),30) AS ShipToName 
 ,dc.TextField15 AS ShipToCode
 ,LEFT(UPPER(dc.cmp_fadd1),30) AS ShipToAddress
 ,UPPER(dc.cmp_fcity) AS ShipToCity
 ,LEFT(UPPER(dc.cmp_fpc),7) AS ShipToZipCode
 ,UPPER(dc.cmp_fctry) AS ShipToCountry
 ,UPPER(b.bedrnm) AS ShipFromName
 ,ISNULL(dc.TextField5,ic.TextField5) AS ShipFromCode
 ,UPPER(b.adr) AS ShipFromAddress
 ,UPPER(b.woonpl) AS ShipFromCity
 ,b.pstcd AS ShipFromZipCode
 ,b.landcode AS ShipFromCountry
 ,f.refer1 AS PONumber
 ,f.refer2 as POCallId
 ,r.artcode as Itemcode
 ,CASE WHEN CHARINDEX('EC',ia.ItemCodeAccount) = 0 THEN ia.ItemCodeAccount 
	ELSE LEFT(ia.ItemCodeAccount,CHARINDEX('EC', ia.ItemCodeAccount)-1) END AS CustomerItemCode
,CASE WHEN CHARINDEX('EC',ia.ItemCodeAccount) = 0 THEN ''
	ELSE RIGHT(ia.ItemCodeAccount,2) END AS ECLevel
 ,UPPER(r.oms45) AS ItemDescription
 ,CONVERT(varchar,r.prijs83) AS ItemPrice
 ,CONVERT(varchar,r.esr_aantal) AS ItemPieces
 ,CONVERT(varchar,f.bdr_val) AS Total
 , f.refer, f.docnumber,o.debnr,f.fakdebnr, o.verzdebnr
from [400]..frhkrg f WITH (NOLOCK)
INNER JOIN [400]..frhsrg r WITH (NOLOCK) ON f.faknr = r.faknr and r.ar_soort in ( 'V', 'T' ) and r.korting < 100
LEFT JOIN [400]..orhkrg o WITH (NOLOCK) ON o.ordernr = f.ordernr and f.pakbon_nr = o.pakbon_nr
INNER JOIN [400]..bedryf b WITH (NOLOCK) ON b.bedrnr = '400'
INNER JOIN [400]..cicmpy bc WITH (NOLOCK) ON bc.debnr = f.debnr 
INNER JOIN [400]..cicmpy ic WITH (NOLOCK) ON ic.debnr = f.fakdebnr 
LEFT JOIN [400]..cicmpy dc WITH (NOLOCK) ON dc.debnr = o.verzdebnr
LEFT JOIN [400]..ItemAccounts ia WITH (NOLOCK) on r.artcode = ia.ItemCode and ia.AccountCode = ic.cmp_wwn
where f.fakdat > '2020-01-01' AND ic.YesNofield4 = 1 and ic.YesNofield5 = 1 

UNION 


SELECT f.OrderNr
 ,f.faknr AS Invoice 
 ,FORMAT(f.fakdat, 'yyMMdd') AS InvoiceDate 
 ,ic.textfield5 AS Sender 
 ,ic.TextField11 AS Receiver 
 ,ic.TextField15 AS FacilityCode 
 ,LEFT(UPPER(bc.cmp_name),30) as BuyerName
 ,bc.TextField15 as BuyerCode
 ,f.valcode AS Currency
 ,f.pakbon_nr AS ShippingNote 
 ,FORMAT(f.afldat, 'yyMMdd') AS ShipmentDate
 ,LEFT(UPPER(dc.cmp_name),30) AS ShipToName 
 ,dc.TextField15 AS ShipToCode
 ,LEFT(UPPER(dc.cmp_fadd1),30) AS ShipToAddress
 ,UPPER(dc.cmp_fcity) AS ShipToCity
 ,LEFT(UPPER(dc.cmp_fpc),7) AS ShipToZipCode
 ,UPPER(dc.cmp_fctry) AS ShipToCountry
 ,UPPER(b.bedrnm) AS ShipFromName
 ,ISNULL(dc.TextField5,ic.TextField5) AS ShipFromCode
 ,UPPER(b.adr) AS ShipFromAddress
 ,UPPER(b.woonpl) AS ShipFromCity
 ,b.pstcd AS ShipFromZipCode
 ,b.landcode AS ShipFromCountry
 ,f.refer1 AS PONumber
 ,f.refer2 as POCallId
 ,r.artcode as Itemcode
 ,CASE WHEN CHARINDEX('EC',ia.ItemCodeAccount) = 0 THEN ia.ItemCodeAccount 
	ELSE LEFT(ia.ItemCodeAccount,CHARINDEX('EC', ia.ItemCodeAccount)-1) END AS CustomerItemCode
 ,CASE WHEN CHARINDEX('EC',ia.ItemCodeAccount) = 0 THEN ''
	ELSE RIGHT(ia.ItemCodeAccount,2) END AS ECLevel
 ,UPPER(r.oms45) AS ItemDescription
 ,CONVERT(varchar,r.prijs83) AS ItemPrice
 ,CONVERT(varchar,r.esr_aantal) AS ItemPieces
 ,CONVERT(varchar,f.bdr_val) AS Total
 , f.refer, f.docnumber,o.debnr,f.fakdebnr, o.verzdebnr
from [484]..frhkrg f WITH (NOLOCK)
INNER JOIN [484]..frhsrg r WITH (NOLOCK) ON f.faknr = r.faknr and r.ar_soort in ( 'V', 'T' ) and r.korting < 100
LEFT JOIN [484]..orhkrg o WITH (NOLOCK) ON o.ordernr = f.ordernr and f.pakbon_nr = o.pakbon_nr
INNER JOIN [484]..bedryf b WITH (NOLOCK) ON b.bedrnr = '484'
INNER JOIN [400]..cicmpy bc WITH (NOLOCK) ON bc.debnr = f.debnr 
INNER JOIN [484]..cicmpy ic WITH (NOLOCK) ON ic.debnr = f.fakdebnr 
LEFT JOIN [484]..cicmpy dc WITH (NOLOCK) ON dc.debnr = o.verzdebnr
LEFT JOIN [484]..ItemAccounts ia WITH (NOLOCK) on r.artcode = ia.ItemCode and ia.AccountCode = ic.cmp_wwn
where f.fakdat > '2020-01-01' AND ic.YesNofield4 = 1 and ic.YesNofield5 = 1 
GO
