/****** Object:  View [dbo].[_ST_PRD_Exact_Planned]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[_ST_PRD_Exact_Planned] AS

select  p.ProjectNr as ProductionOrder, i.ItemCode, p.Status, SUM(gbk.aantal) as ExactPlanned, max(gbk.sysmodified) as LastModified
from  [400]..PRProject p with(NOLOCK) 
inner join [400]..gbkmut gbk with (NOLOCK) on gbk.project = p.ProjectNr AND gbk.transtype = 'B' AND gbk.transsubtype IN ('A', 'J')
		AND NOT (gbk.checked=0 AND gbk.blockitem=1 and gbk.reviewed=1)  AND gbk.freefield1 = 'P' AND gbk.bud_vers = 'MRP'  
inner join [400]..Items i with (NOLOCK) on i.ItemCode = gbk.artcode and gbk.reknr = i.[GLAccountDistribution]
WHERE p.Type = 'P'
Group by p.ProjectNr, i.ItemCode, p.Status

GO
