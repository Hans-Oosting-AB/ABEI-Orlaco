USE [ProdGlobe_live]
GO

/****** Object:  StoredProcedure [dbo].[_AB_sp_New_prod_2_table]    Script Date: 8/10/2023 11:10:56 AM ******/
DROP PROCEDURE [dbo].[_AB_sp_New_prod_2_table]
GO

/****** Object:  StoredProcedure [dbo].[_AB_sp_New_prod_2_table]    Script Date: 8/10/2023 11:10:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[_AB_sp_New_prod_2_table] 

as
begin

INSERT INTO _AB_GerProd_proces (Productieorder, Artikel,  Serienummer, 
Aantal, Proddatum,  Status_ProdGer, SentMail, Uitgegeven, Imp_attempts, [SourceId], [SourceTable])

SELECT gp.Productieorder, gp.Artikel, gp.Serienummer, gp.Aantal,  gp.Proddatum, 0, 0, gp.Uitgegeven, 0, gp.SourceId, gp.SourceTable
FROM   dbo._AB_GerProd_proces agp with (nolock) 

RIGHT OUTER JOIN dbo.GereedmeldingProductie gp with (nolock) ON  agp.Artikel = gp.Artikel 
and agp.Productieorder = gp.Productieorder --toegevoegd 03-07-2014
AND isnull(agp.Serienummer,1) = isnull(gp.Serienummer,1) 
AND isnull(agp.Aantal,1) = isnull(gp.Aantal,1) -- toegevoegd 20-05-2022 voor PROD00212686
and agp.Proddatum = gp.Proddatum -- toegevoegd 22-12-2022 
and (agp.sourceid is null or ( agp.sourceid = gp.sourceid and agp.sourcetable = gp.sourcetable))
WHERE 1=1
and agp.Artikel IS NULL 
and gp.Proddatum >='2022-05-18' 

end
GO


