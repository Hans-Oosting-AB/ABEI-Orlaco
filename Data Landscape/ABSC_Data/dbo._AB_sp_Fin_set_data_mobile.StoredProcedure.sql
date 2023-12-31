/****** Object:  StoredProcedure [dbo].[_AB_sp_Fin_set_data_mobile]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      A.B. Software & Consultancy
-- Create date: 2020-04-17
-- Description: Insert data for Fin
-- =============================================
Create PROCEDURE [dbo].[_AB_sp_Fin_set_data_mobile] 
    -- Add the parameters for the stored procedure here
    @runid uniqueidentifier = null 
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- Settings
    DECLARE @dagbknr char(10) = '60';
    DECLARE @targetDB varchar(250) = '400';
    DECLARE @mailto varchar(150) = 'ap@orlaco.com';

	UPDATE i WITH (ROWLOCK, NOWAIT) SET
		runid = @runid
		, sysmodified = CURRENT_TIMESTAMP
	FROM dbo._AB_tb_EXCEL_import_Mobile i
	WHERE i.runid IS NULL
    
    INSERT INTO dbo._AB_tb_Fin_Data (targetDB, referencekey, HeaderID, fType, dagbknr
		, datum, oms25, bedrag, kstplcode, reknr
		, freefield1, HeaderDescription
		, runid)

	SELECT @targetDB as targetDB
		, i.ID as referencekey
		, i.saveguid as HeaderID
		, 'U' as fType
		, @dagbknr as dagbknr
		, i.regdate as datum
		, RIGHT(CONCAT('Mobile ', i.Name),60) as oms25
		, x.l*i.Amount as bedrag
		, i.Costcenter as kstplcode
		, CASE x.l WHEN 1 THEN i.reknr ELSE '2746' END as reknr
		, i.ID as freefield1
		, 'Memoriaalboeking mobiele telefoonkosten' AS HeaderDescription
		, @runid as runid
	FROM dbo._AB_tb_EXCEL_import_Mobile i WITH (NOLOCK)
		CROSS APPLY (VALUES (1), (-1)) x(l)
	WHERE i.runid = @runid
    
END
GO
