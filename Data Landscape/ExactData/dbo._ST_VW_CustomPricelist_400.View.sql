/****** Object:  View [dbo].[_ST_VW_CustomPricelist_400]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[_ST_VW_CustomPricelist_400] AS

select 
i.ItemCode, 
i.Description, 
sa.prijs83 AS SalesPrice, 
s.prijslijst AS Pricelist, 
sf.valcode as Currency, 
s.kort_pbn as PriceType, 
sa.prijs83 AS GrossPrice, 
s.bedr1 as Discount,
case when s.kort_pbn = 'p' then s.prijs83 - s.prijs83* s.bedr1/100 else s.bedr1 end as NetPrice, 
s.AccountID, s.ValidFrom, s.ValidTo,
case when IR.itemcode is not null then 1 else 0 end as IsSetItem,
CASE WHEN s.AccountID IS NULL THEN 'Pricelist' ELSE 'Priceagreement' END AS Source
FROM [400]..staffl S with (nolock)
INNER JOIN [400]..items I with (nolock) on I.ItemCode = S.artcode
INNER JOIN [400]..stfoms sf WITH (NOLOCK) ON sf.prijslijst = s.prijslijst
LEFT JOIN (SELECT DISTINCT Itemcode FROM [400]..ItemRelations with (nolock) ) IR on IR.ItemCode = i.ItemCode
LEFT JOIN [400]..staffl SA with (nolock) on SA.artcode = i.Itemcode and SA.prijslijst = 'SALESPRICE ' AND SA.validfrom < GETDATE() and ISNULL(sA.validTo,'2099-01-01') > GETDATE()
WHERE I.Condition = 'A' and I.IsSalesItem = 1 AND S.validfrom < GETDATE() and ISNULL(s.validTo,'2099-01-01') > GETDATE()  

GO
