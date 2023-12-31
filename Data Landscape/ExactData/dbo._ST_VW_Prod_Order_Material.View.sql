/****** Object:  View [dbo].[_ST_VW_Prod_Order_Material]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[_ST_VW_Prod_Order_Material] 
AS

select ProjectNr,  p.Description as ProjectDesc, InitialStartDate, g.aantal as ParentQuantity, g.oms25 as Parentdescription,
		 g.artcode as Parentcode,  r.itemreq as Childcode, i.Description as ChildDescription, r.quantity as ChildQuantity, g.aantal*r.quantity as TotalQuantity
from [400]..PRProject P (nolock)
	inner join [400]..gbkmut g (nolock) ON g.project = p.ProjectNr
	inner join [400]..recipe r (nolock) ON r.itemprod = g.artcode
	inner join [400]..items i (nolock) ON i.ItemCode = r.itemreq
where ProjectNr like 'prod%' and InitialEndDate > getdate() 
GO
