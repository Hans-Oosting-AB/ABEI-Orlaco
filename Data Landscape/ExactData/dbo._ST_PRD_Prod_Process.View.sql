/****** Object:  View [dbo].[_ST_PRD_Prod_Process]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[_ST_PRD_Prod_Process] AS


select Productieorder as ProductionOrder, 
			Artikel as ItemCode,
			SUM(Aantal) AS ProcessReady,
			MAX(syscreated) AS LastModified
		from  [ProdGlobe_live].._AB_GerProd_proces 
		group by productieorder, Artikel

GO
