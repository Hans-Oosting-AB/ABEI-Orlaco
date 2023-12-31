/****** Object:  StoredProcedure [dbo].[_AB_End_not_responding_job_Interfiliaal]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sander van der Loo
-- Create date: 14-12-2011
-- Description:	Sent mail haning job
-- =============================================
CREATE PROCEDURE [dbo].[_AB_End_not_responding_job_Interfiliaal] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @tableHTML  NVARCHAR(MAX) 
Declare @New_records varchar(50) ;
DECLARE @p_recipients as nvarchar(max) ;

SET @p_recipients = N's.vd.loo@absc.nl' 
set @New_records = (
SELECT     msdb.dbo.sysjobs.job_id
FROM         msdb.dbo.sysjobactivity INNER JOIN
                      msdb.dbo.sysjobs ON msdb.dbo.sysjobactivity.job_id = msdb.dbo.sysjobs.job_id
WHERE     (msdb.dbo.sysjobactivity.stop_execution_date IS NULL) AND (msdb.dbo.sysjobactivity.start_execution_date =
                          (SELECT     MAX(start_execution_date) AS Expr1
                            FROM          msdb.dbo.sysjobactivity AS sysjobactivity_1
                            WHERE      (job_id = sysjobactivity.job_id)
                            GROUP BY job_id)) AND (DATEDIFF(ss, msdb.dbo.sysjobactivity.start_execution_date, CURRENT_TIMESTAMP) >= 240) AND 
                      (msdb.dbo.sysjobs.job_id = 'A57D86C5-8BDD-4978-B4A7-F8A585AEC036')
)

if @New_records is null goto Geen_records

SET @tableHTML =
    N'<th>Dear user,</th>' +
    N'<br>' +
    N'<br>' +
    N'<th>The following job has not respond for a long time and was restarted.</th>' +
    N'<br>' +
    N'<br>' +
    N'<table border="1">' +
    N'<tr><th>Job ID</th>' +
    N'<th>Job name</th><th>Actual run time</th>' +
    CAST ( ( SELECT 
                    td = [msdb].dbo.sysjobs.name, '',
                    td = CASE WHEN [msdb].dbo.sysjobactivity.stop_execution_date IS NULL THEN DATEDIFF(ss, [msdb].dbo.sysjobactivity.start_execution_date, 
                      CURRENT_TIMESTAMP) ELSE 0 END, '',
                    td = [msdb].dbo.sysjobs.job_id,       ''
               FROM         msdb.dbo.sysjobactivity INNER JOIN
                      msdb.dbo.sysjobs ON msdb.dbo.sysjobactivity.job_id = msdb.dbo.sysjobs.job_id
WHERE     (msdb.dbo.sysjobactivity.stop_execution_date IS NULL) AND (msdb.dbo.sysjobactivity.start_execution_date =
                          (SELECT     MAX(start_execution_date) AS Expr1
                            FROM          msdb.dbo.sysjobactivity AS sysjobactivity_1
                            WHERE      (job_id = sysjobactivity.job_id)
                            GROUP BY job_id)) AND (DATEDIFF(ss, msdb.dbo.sysjobactivity.start_execution_date, CURRENT_TIMESTAMP) >= 240) AND 
                      (msdb.dbo.sysjobs.job_id = 'A57D86C5-8BDD-4978-B4A7-F8A585AEC036')
			
    FOR XML PATH('tr'), TYPE) AS NVARCHAR(MAX) ) +
    N'</table>'+ 
    N'<br>' +
    N'<th>Best regards,</th>'+
    N'<br>' +
    N'<th>Orlaco database mailer</th>';

EXEC msdb.dbo.sp_send_dbmail @recipients=@p_recipients,
    @subject = 'Orlaco job was not responding',
    @body = @tableHTML,
    @body_format = 'HTML' ;

EXEC [msdb].dbo.sp_stop_job @job_id = 'A57D86C5-8BDD-4978-B4A7-F8A585AEC036'

geen_records:

END
GO
