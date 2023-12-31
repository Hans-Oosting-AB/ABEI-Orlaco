/****** Object:  View [dbo].[_ST_VW_DIFFERENT_VATCODES]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[_ST_VW_DIFFERENT_VATCODES] AS
SELECT distinct  OK.ordernr, O.btw_code AS OrderBTW, bo.oms30_0 AS 'Order btw Omschrijving', 
C.VatCode AS RelatieBTW, br.oms30_0 AS 'Relatie btw Omschrijving',c.cmp_code, C.cmp_name, CAST(o.syscreated as Date) as created, del_landcode
FROM       [400]..orkrg OK with (NOLOCK)
INNER JOIN [400]..cicmpy C with (NOLOCK) ON (OK.fakdebnr = C.debnr OR OK.fakdebnr = C.debcode)
INNER JOIN [400]..orsrg O WITH (NOLOCK) ON O.ordernr = ok.ordernr
INNER JOIN [400]..btwtrs bo with (NOLOCK) ON BO.btwtrans = O.btw_code
INNER JOIN [400]..btwtrs br with (NOLOCK) ON br.btwtrans = c.VatCode
INNER JOIN [400]..Items I with (nolock) on I.Itemcode = O.artcode
WHERE 
((del_landcode = 'NL' AND (
	(O.btw_code = 0 AND C.VatCode = 203) OR 
	(O.btw_code = 203 AND C.VatCode = 0) OR 
	(O.btw_code = 220 OR O.btw_code = 225))) OR 
 (del_landcode <> 'NL' AND O.btw_code = 203)) 
 AND (c.cmp_code != '              280153') -- LS 07-01-22: Exclude Alewijnse Marine Galati S.A.

AND ok.ord_soort = 'V' AND o.artcode IS NOT NULL  and itemtype <> 'I' and  ok.afgehandld = 0 and DATEDIFF(DAY, o.syscreated, GETDATE()) < 4
group by O.btw_code,  OK.ordernr, 
bo.oms30_0,
C.VatCode,
br.oms30_0,
c.cmp_code, C.cmp_name, del_landcode,
CAST(o.syscreated as Date)

UNION

SELECT distinct  OK.ordernr, O.btw_code AS OrderBTW, bo.oms30_0 AS 'Order btw Omschrijving', 
C.VatCode AS RelatieBTW, br.oms30_0 AS 'Relatie btw Omschrijving', c.cmp_code, C.cmp_name, CAST(o.syscreated as Date) as created, del_landcode
FROM       [483]..orkrg OK with (NOLOCK)
INNER JOIN [483]..cicmpy C with (NOLOCK) ON (OK.fakdebnr = C.debnr OR OK.fakdebnr = C.debcode)
INNER JOIN [483]..orsrg O WITH (NOLOCK) ON O.ordernr = ok.ordernr
INNER JOIN [483]..btwtrs bo with (NOLOCK) ON BO.btwtrans = O.btw_code
INNER JOIN [483]..btwtrs br with (NOLOCK) ON br.btwtrans = c.VatCode
INNER JOIN [483]..Items I with (nolock) on I.Itemcode = O.artcode
WHERE 
((O.btw_code = 0 AND C.VatCode = 203) OR (O.btw_code = 203 AND C.VatCode = 0) OR (O.btw_code = 203 AND C.VatCode = 220 AND del_landcode <> 'NL')
OR (O.btw_code = 203 AND C.VatCode = 225) OR (O.btw_code = 220 AND C.VatCode = 203) OR (O.btw_code = 225 AND C.VatCode = 203) 
OR (O.btw_code = 203 AND del_landcode <> 'NL') OR (O.btw_code = 220 AND del_landcode = 'NL') OR (O.btw_code = 225 AND del_landcode = 'NL')
OR (O.btw_code = '713') OR (O.btw_code = '803')  ) -- 16% codes
AND ok.ord_soort = 'V' AND o.artcode IS NOT NULL  and itemtype <> 'I' and  ok.afgehandld = 0 and DATEDIFF(DAY, o.syscreated, GETDATE()) < 4
group by O.btw_code,  OK.ordernr, 
bo.oms30_0,
C.VatCode,
br.oms30_0,
c.cmp_code, C.cmp_name, del_landcode,
CAST(o.syscreated as Date)

UNION

SELECT distinct  OK.ordernr, O.btw_code AS OrderBTW, bo.oms30_0 AS 'Order btw Omschrijving', 
C.VatCode AS RelatieBTW, br.oms30_0 AS 'Relatie btw Omschrijving', c.cmp_code, C.cmp_name, CAST(o.syscreated as Date) as created, del_landcode
FROM       [484]..orkrg OK with (NOLOCK)
INNER JOIN [484]..cicmpy C with (NOLOCK) ON (OK.fakdebnr = C.debnr OR OK.fakdebnr = C.debcode)
INNER JOIN [484]..orsrg O WITH (NOLOCK) ON O.ordernr = ok.ordernr
INNER JOIN [484]..btwtrs bo with (NOLOCK) ON BO.btwtrans = O.btw_code
INNER JOIN [484]..btwtrs br with (NOLOCK) ON br.btwtrans = c.VatCode
INNER JOIN [484]..Items I with (nolock) on I.Itemcode = O.artcode
WHERE ((O.btw_code = 0 AND C.VatCode = 203) OR (O.btw_code = 203 AND C.VatCode = 0) OR (O.btw_code = 203 AND C.VatCode = 220 AND del_landcode <> 'NL')
OR (O.btw_code = 203 AND C.VatCode = 225) OR (O.btw_code = 220 AND C.VatCode = 203) OR (O.btw_code = 225 AND C.VatCode = 203) 
OR (O.btw_code = 203 AND del_landcode <> 'NL') OR (O.btw_code = 220 AND del_landcode = 'NL') OR (O.btw_code = 225 AND del_landcode = 'NL'))
AND ok.ord_soort = 'V' AND o.artcode IS NOT NULL  and itemtype <> 'I' and  ok.afgehandld = 0 and DATEDIFF(DAY, o.syscreated, GETDATE()) < 4
group by O.btw_code,  OK.ordernr, 
bo.oms30_0,
C.VatCode,
br.oms30_0,
c.cmp_code, C.cmp_name, del_landcode,
CAST(o.syscreated as Date)


GO
