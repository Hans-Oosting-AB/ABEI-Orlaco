/****** Object:  StoredProcedure [dbo].[_AB_SentMail_FailedImports_Interfiliaal]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sander van der Loo
-- Create date: 14-12-2011
-- Description:	Sent mail failed imports
-- =============================================
CREATE PROCEDURE [dbo].[_AB_SentMail_FailedImports_Interfiliaal] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @tableHTML  NVARCHAR(MAX) 
Declare @New_records varchar(50)
DECLARE @p_recipients as nvarchar(max) ;

SET @p_recipients = N's.vd.loo@absc.nl;m.bakkenes@orlaco.nl;Logistics2@Orlaco.com' 

set @New_records = (select top 1 Productieorder from _AB_Interfiliaal_proces 
				  where Productieorder is not null and Productieorder <> '' and Status_Interfiliaal = '4' and SentMail = 0 and Imp_attempts = '3')

if @New_records is null goto Geen_records

SET @tableHTML =
    N'<th>Dear user,</th>' +
    N'<br>' +
    N'<br>' +
    N'<th>The following interbrance transactions (rework) are not imported correctly due to errors.</th>' +
    N'<br>' +
    N'<br>' +
    N'<th>Please check these productionorders and correct manually.</th>' +
    N'<br>' +
    N'<br>' +
    N'<table border="1">' +
    N'<tr><th>ID</th><th>Productieorder</th>' +
    N'<th>Artikel</th><th>Serienummer</th><th>Productie datum</th>' +
    CAST ( ( SELECT td = Interfiliaal.ID,       '',
                    td = Interfiliaal.Productieorder, '',
                    td = Interfiliaal.Artikel, '',
                    td = Interfiliaal.Serienummer, '',
                    td = Interfiliaal.Proddatum, ''
              from [ProdGlobe_live].dbo._AB_Interfiliaal_proces as Interfiliaal where Productieorder is not null and Productieorder <> '' and Status_Interfiliaal = '4' and SentMail = 0 and Imp_attempts = '3'
			  order by Productieorder 
    FOR XML PATH('tr'), TYPE) AS NVARCHAR(MAX) ) +
    N'</table>'+ 
    N'<br>' +
    N'<th>Best regards,</th>'+
    N'<br>' +
    N'<th>Orlaco database mailer</th>';


EXEC msdb.dbo.sp_send_dbmail @recipients=@p_recipients,
    @subject = 'Failed imports interbranch Orlaco',
    @body = @tableHTML,
    @body_format = 'HTML' ,
    @profile_name = 'Orlaco database mailer';

update dbo._AB_Interfiliaal_proces with(rowlock,nowait) set SentMail = '1' where Productieorder is not null and Productieorder <> '' and Status_Interfiliaal = '4' and SentMail = 0 and Imp_attempts = '3'

geen_records:

END

GO
