/****** Object:  View [dbo].[_ST_VW_OpenOrders]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[_ST_VW_OpenOrders] AS
     select o.debnr, o.ordernr, o.refer, o.orddat, o.afldat, 400 as [admin] from [400]..orkrg o with (nolock) 
where afgehandld = 0 and ord_soort = 'v' and pakbon_afg = 0 and afgehandld=0 

union
select o.debnr, o.ordernr, o.refer, o.orddat, o.afldat, 483 as [admin] from [483]..orkrg o with (nolock) 
where afgehandld = 0 and ord_soort = 'v' and pakbon_afg = 0 and afgehandld=0 

union

select o.debnr, o.ordernr, o.refer, o.orddat, o.afldat, 484 as [admin] from [484]..orkrg o with (nolock) 
where afgehandld = 0 and ord_soort = 'v' and pakbon_afg = 0 and afgehandld=0 


GO
