/****** Object:  StoredProcedure [dbo].[_AB_SentMail_FailedImports_ProdGer]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sander van der Loo
-- Create date: 14-12-2011
-- Description:	Sent mail failed imports
-- =============================================
CREATE PROCEDURE [dbo].[_AB_SentMail_FailedImports_ProdGer] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @tableHTML  NVARCHAR(MAX) 
Declare @New_records varchar(50) ;
DECLARE @p_recipients as nvarchar(max) ;

SET @p_recipients = N'sysint@orlaco.com;m.bakkenes@orlaco.nl;Logistics2@Orlaco.com' 
set @New_records = (select top 1 Productieorder from _AB_GerProd_proces 
				  where Productieorder is not null and Productieorder <> '' and Status_ProdGer = '4' and SentMail = 0 and Imp_attempts = '1')

if @New_records is null goto Geen_records

SET @tableHTML =
    N'<th>Dear user,</th>' +
    N'<br>' +
    N'<br>' +
    N'<th>The following production receipts are not imported correctly due to errors.</th>' +
    N'<br>' +
    N'<br>' +
    N'<th>Please check these productionorders and correct manually.</th>' +
    N'<br>' +
    N'<br>' +
    N'<table border="1">' +
    N'<tr><th>ID</th><th>Productieorder</th>' +
    N'<th>Artikel</th><th>Serienummer</th><th>Productie datum</th><th>Magazijn</th>' +
    CAST ( ( SELECT td = GerProd.ID,       '',
                    td = GerProd.Productieorder, '',
                    td = GerProd.Artikel, '',
                    td = GerProd.Serienummer, '',
                    td = GerProd.Proddatum, '',
					td = g.warehouse, ''
              from [ProdGlobe_live].dbo._AB_GerProd_proces as GerProd 
			  inner join (
							select 

										  g.warehouse
										, g.project 
							
							
							from		[400].dbo.gbkmut g with(nolock)
										inner join [400].dbo.items it with(nolock) on g.artcode = it.itemcode and g.reknr = it.GLAccountDistribution
										inner join [400].dbo.prproject p with(nolock) on p.ProjectNr = g.project and p.type = 'P'

							where		1=1
										and g.transsubtype in ('A', 'J') 


							group by	g.warehouse, g.project) g on GerProd.Productieorder = g.Project 

			  where Productieorder is not null and Productieorder <> ''  and Status_ProdGer = 4 and SentMail = 0 and Imp_attempts = '1'
			  order by productieorder
    FOR XML PATH('tr'), TYPE) AS NVARCHAR(MAX) ) +
    N'</table>'+ 
    N'<br>' +
    N'<th>Best regards,</th>'+
    N'<br>' +
    N'<th>Orlaco database mailer</th>';

EXEC msdb.dbo.sp_send_dbmail @recipients=@p_recipients,
    @subject = 'Failed imports ProdGer Orlaco',
    @body = @tableHTML,
    @body_format = 'HTML' ,
    @profile_name = 'Orlaco database mailer';

update dbo._AB_GerProd_proces with(rowlock,nowait) set SentMail = '1' where Productieorder is not null and Productieorder <> ''  and Status_ProdGer = 4 and SentMail = 0 and Imp_attempts = '1'

geen_records:

END

GO
