USE [ProdGlobe_live]
GO

/****** Object:  StoredProcedure [dbo].[_AB_sp_New_interf_2_table]    Script Date: 8/10/2023 11:35:08 AM ******/
DROP PROCEDURE [dbo].[_AB_sp_New_interf_2_table]
GO

/****** Object:  StoredProcedure [dbo].[_AB_sp_New_interf_2_table]    Script Date: 8/10/2023 11:35:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[_AB_sp_New_interf_2_table] 

as
begin

INSERT INTO _AB_Interfiliaal_proces (Productieorder, Mag, Artikel, Serienummer, Aantal, Proddatum, Vrrdrek, CostPriceStandard,Eenheid, Status_Interfiliaal, SentMail, Uitgegeven, Imp_attempts)

SELECT     ari.Productieorder, gbkm.warehouse, ari.Artikel, ari.Serienummer, ari.Aantal, ari.Proddatum, ari.Vrrdrek, ari.CostpriceStandard, ari.Eenheid, '0', '0', ari.Uitgegeven, '0'
FROM         dbo._AB_Interfiliaal_proces aip with (nolock)

RIGHT OUTER JOIN dbo._AB_Rework_interfiliaal ari with (nolock) ON  aip.Artikel = ari.Artikel 
AND isnull(aip.Serienummer,1) = isnull(ari.Serienummer,1) 
and ari.Productieorder = aip.Productieorder --aanpassing 24-08-2015

inner join 
(select project, warehouse from [400].dbo.gbkmut with(nolock) where transtype = 'B' and transsubtype = 'A' and project like 'PROD%'  
group by project, warehouse) gbkm on ari.Productieorder = gbkm.project

WHERE     (aip.Artikel IS NULL) 
 
end

GO


