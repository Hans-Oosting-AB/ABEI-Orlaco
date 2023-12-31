/****** Object:  StoredProcedure [dbo].[_AB_sp_Profile_save_BOM_delete]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		AB, LVE
-- Create date: 2021-10-19
-- Description:	Delete BOM lines with logging
-- =============================================
CREATE PROCEDURE [dbo].[_AB_sp_Profile_save_BOM_delete]
	-- Add the parameters for the stored procedure here
	@itemcode varchar(30)
	, @partid varchar(50) 
	, @runid uniqueidentifier
	, @seqno int = 40
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @rowcount int = 0;
	SELECT @rowcount = COUNT(r.ID)
	FROM dbo._AB_sy_recipe r WITH (NOLOCK)
		INNER JOIN dbo._AB_sy_recipe rheader WITH (NOLOCK)
			ON r.itemprod = rheader.itemprod and r.version = rheader.version and rheader.sequenceno = 0 and rheader.mainversion = 1
	WHERE 1=1
		AND r.itemprod = @itemcode
		AND r.sequenceno > 0 
		--AND r.quantity <> 0
		--and r.itemreq != '1000-LABOR'

	IF (@rowcount > 0)
	BEGIN

		INSERT INTO [dbo].[_AB_tb_Profile_log] (partid,itemcode,runid,[action],retrycount,sysmessage)
		SELECT @partid, @itemcode, @runid, 'BOMDELETE', 0, CONCAT('Starting delete of ', COUNT(r.ID), ' lines')
		FROM dbo._AB_sy_recipe r WITH (NOLOCK)
			INNER JOIN dbo._AB_sy_recipe rheader WITH (NOLOCK)
				ON r.itemprod = rheader.itemprod and r.version = rheader.version and rheader.sequenceno = 0 and rheader.mainversion = 1
		WHERE 1=1
			AND r.itemprod = @itemcode
			AND r.sequenceno > 0 
			--AND r.quantity <> 0
			--and r.itemreq != '1000-LABOR'

		/*
		Select top 1000 r.ID, 'DELETE' AS Action, r.sequenceno, r.itemreq, rheader.ID AS HeaderId, r.itemprod, 0 as quantity, r.pos_no as position, r.variant
		 from [%abeitargetdb%].dbo.recipe r WITH (NOLOCK) 
			inner join [%abeitargetdb%].dbo.recipe rheader with (nolock) on r.itemprod = rheader.itemprod and r.version = rheader.version and rheader.sequenceno = 0 and rheader.mainversion = 1
			WHERE r.itemprod = '%param_itemcode%' and r.sequenceno > 0 --and r.itemreq != '1000-LABOR'
		 order by r.sequenceno desc
		*/

		DECLARE @i as int = 0
		SET ROWCOUNT  100000
		WHILE  (@i < 100)
		BEGIN
			SET @i = @i + 1
			BEGIN TRAN
				BEGIN TRY
					DELETE FROM [400].dbo.recipe
					WHERE ID IN (
							SELECT TOP (200) r.ID
							FROM [400].dbo.recipe r WITH (NOLOCK)
								INNER JOIN [400].dbo.recipe rh WITH (NOLOCK) ON rh.itemprod = r.itemprod AND rh.version = r.version AND rh.sequenceno = 0 and rh.mainversion = 1
							WHERE 1=1
								AND r.itemprod = @itemcode
								AND r.sequenceno > 0
								--and r.itemreq != '1000-LABOR'
							)
			
					IF @@ROWCOUNT = 0 SET @i = 1000
					COMMIT
				END TRY
				BEGIN CATCH
					ROLLBACK
					INSERT INTO [dbo].[_AB_tb_Profile_log] (partid,itemcode,runid,[action],retrycount,sysmessage)
					SELECT @partid, @itemcode, @runid, 'BOMDELETE', 0, CONCAT('Failed to delete the lines;', ERROR_MESSAGE())
				END CATCH
		END

		INSERT INTO [dbo].[_AB_tb_Profile_log] (partid,itemcode,runid,[action],retrycount,sysmessage)
		SELECT @partid, @itemcode, @runid, 'BOMDELETE', 0, CONCAT('Finished delete with ', COUNT(r.ID), ' lines')
		FROM dbo._AB_sy_recipe r WITH (NOLOCK)
			INNER JOIN dbo._AB_sy_recipe rheader WITH (NOLOCK)
				ON r.itemprod = rheader.itemprod and r.version = rheader.version and rheader.sequenceno = 0 and rheader.mainversion = 1
		WHERE 1=1
			AND r.itemprod = @itemcode
			AND r.sequenceno > 0 
			--AND r.quantity <> 0
			--and r.itemreq != '1000-LABOR'

	END -- rowcount > 0

END

GO
