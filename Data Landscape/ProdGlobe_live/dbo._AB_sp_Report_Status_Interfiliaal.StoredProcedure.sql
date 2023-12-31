/****** Object:  StoredProcedure [dbo].[_AB_sp_Report_Status_Interfiliaal]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[_AB_sp_Report_Status_Interfiliaal] 

as
begin
update dbo._AB_Interfiliaal_proces with (rowlock, nowait) set dbo._AB_Interfiliaal_proces.Imp_attempts = dbo._AB_Interfiliaal_proces.Imp_attempts + 1 where Status_Interfiliaal = '1'

update dbo._AB_Interfiliaal_proces with(rowlock,nowait) set Status_Interfiliaal = dbo._AB_Interfiliaal_check.geimporteerd
FROM         dbo._AB_Interfiliaal_proces INNER JOIN
                      dbo._AB_Interfiliaal_check ON dbo._AB_Interfiliaal_proces.Productieorder = dbo._AB_Interfiliaal_check.Productieorder AND 
                      dbo._AB_Interfiliaal_proces.Artikel = dbo._AB_Interfiliaal_check.Artikel AND 
                      dbo._AB_Interfiliaal_proces.Serienummer = dbo._AB_Interfiliaal_check.Serienummer

end
GO
