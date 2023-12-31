/****** Object:  View [dbo].[_ST_PRD_Exact_Received_Open]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[_ST_PRD_Exact_Received_Open] AS


select  p.ProjectNr as ProductionOrder, i.ItemCode, SUM(gbk.aantal) as ExactReceived, max(gbk.sysmodified) as LastModified
from  [400]..PRProject p with(NOLOCK) 
inner join [400]..gbkmut gbk with (NOLOCK) on gbk.project = p.ProjectNr and gbk.transtype = 'N' and (gbk.transsubtype = 'A' or gbk.transsubtype = 'J')
inner join [400]..grtbk gbkp with (nolock) on gbk.reknr = gbkp.reknr and gbkp.omzrek = 'G' and gbkp.bal_vw = 'B'
inner join [400]..Items i with (NOLOCK) on i.ItemCode = gbk.artcode and gbk.reknr = i.[GLAccountDistribution]
WHERE p.Type = 'P' and p.Status = 'A'
Group by p.ProjectNr, i.ItemCode

GO
