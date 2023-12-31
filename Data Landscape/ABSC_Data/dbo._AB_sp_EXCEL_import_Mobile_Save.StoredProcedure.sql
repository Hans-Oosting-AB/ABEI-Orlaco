/****** Object:  StoredProcedure [dbo].[_AB_sp_EXCEL_import_Mobile_Save]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		AB, LVE
-- Create date: 2021-04-20
-- Description:	Save Import
-- =============================================
CREATE PROCEDURE [dbo].[_AB_sp_EXCEL_import_Mobile_Save]
	-- Add the parameters for the stored procedure here
	@Datum datetime = NULL,
	@Name varchar(255) = '',
	@Amount float = 0,
	@Costcenter varchar(10) = '',
	@Reknr varchar(9) = '',
	@SaveGuid varchar(255) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo._AB_tb_EXCEL_import_Mobile
           ([RegDate]
           ,[Name]
           ,[Amount]
           ,[Costcenter]
           ,[Reknr]
           ,[SaveGuid])
	SELECT @Datum, @Name, @Amount, @Costcenter, @Reknr, @SaveGuid


END
GO
