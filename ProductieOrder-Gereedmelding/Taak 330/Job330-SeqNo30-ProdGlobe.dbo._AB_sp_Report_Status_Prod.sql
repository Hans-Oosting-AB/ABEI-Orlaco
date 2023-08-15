USE [ProdGlobe_live]
GO

/****** Object:  StoredProcedure [dbo].[_AB_sp_Report_Status_Prod]    Script Date: 8/10/2023 11:18:00 AM ******/
DROP PROCEDURE [dbo].[_AB_sp_Report_Status_Prod]
GO

/****** Object:  StoredProcedure [dbo].[_AB_sp_Report_Status_Prod]    Script Date: 8/10/2023 11:18:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[_AB_sp_Report_Status_Prod] 

as
begin
update dbo._AB_GerProd_proces set dbo._AB_GerProd_proces.Imp_attempts = dbo._AB_GerProd_proces.Imp_attempts + 1 where Status_ProdGer = '1' and not Serienummer is null

update dbo._AB_GerProd_proces with(rowlock,nowait) set Status_ProdGer = dbo._AB_Ger_Prod_check.geimporteerd
FROM         dbo._AB_GerProd_proces INNER JOIN
                      dbo._AB_Ger_Prod_check ON dbo._AB_GerProd_proces.Productieorder = dbo._AB_Ger_Prod_check.Productieorder AND 
                      dbo._AB_GerProd_proces.Artikel = dbo._AB_Ger_Prod_check.Artikel AND 
                      dbo._AB_GerProd_proces.Serienummer = dbo._AB_Ger_Prod_check.Serienummer

end
GO


