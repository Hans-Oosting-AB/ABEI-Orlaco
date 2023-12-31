/****** Object:  View [dbo].[_ST_VW_ItemPricelist]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[_ST_VW_ItemPricelist] AS
SELECT 
i.[Itemcode] AS [Itemcode], 
i.userfield_04 AS [PMC], 
i.Userfield_02 AS [Category1],
i.Userfield_03 AS [Category2],
CONVERT(int,RTRIM(LEFT(UserField_02, CHARINDEX('.', UserField_02)-1))) AS [OrdCat1],
CONVERT(int,RTRIM(SUBSTRING(UserField_03, CHARINDEX('.', UserField_03) + 1,2))) AS [OrdCat2],
ISNULL(i.Userfield_05, i.[Description]) as [SalesDescription], 
s400.Price AS [NL_EUR],
s484.Price [USA_USD], 
s484E.Price AS [USA_EUR],
ISNULL(i.UserNumber_01,0) AS [NL_Leadtime],
ISNULL(i.UserNumber_02,0) AS [USA_Leadtime],
i.Class_09 AS [DiscountCode],
ic.Description as [Discount],
i.sysmodified AS ItemModified,
i.sysmodifier AS ItemModifier
FROM [orlaco].dbo.items i with (NOLOCK) 
LEFT JOIN [orlaco].dbo.ItemClasses ic with (NOLOCK) on ic.ClassID = 9 and i.Class_09 = ic.ItemClassCode
LEFT JOIN (SELECT artcode, MIN(ROUND(prijs83,2)) as Price from [400]..staffl WITH (NOLOCK)
			WHERE prijslijst = 'SALESPRICE' and ISNULL(validfrom, GETDATE()) <= GETDATE() AND ISNULL(validto, GETDATE()) >= GETDATE()
			GROUP BY artcode ) s400 on i.itemcode = s400.artcode
LEFT JOIN (SELECT artcode, MIN(ROUND(prijs83,2)) as Price from [484]..staffl WITH (NOLOCK)
			WHERE prijslijst = 'SALESPRICE' and ISNULL(validfrom, GETDATE()) <= GETDATE() AND ISNULL(validto, GETDATE()) >= GETDATE()
			GROUP BY artcode ) s484 on i.itemcode = s484.artcode
LEFT JOIN (SELECT artcode, MIN(ROUND(prijs83,2)) as Price from [484]..staffl WITH (NOLOCK)
			WHERE prijslijst = 'SALESPRICE_EURO' and ISNULL(validfrom, GETDATE()) <= GETDATE() AND ISNULL(validto, GETDATE()) >= GETDATE()
			GROUP BY artcode ) s484E on i.itemcode = s484E.artcode
WHERE i.UserYesNo_03 = 1 and i.Condition = 'A' AND NOT (ISNULL(i.UserField_02,'') = '' or ISNULL(i.UserField_03,'') = '' OR ISNULL(i.UserField_04,'') = '')
GO
