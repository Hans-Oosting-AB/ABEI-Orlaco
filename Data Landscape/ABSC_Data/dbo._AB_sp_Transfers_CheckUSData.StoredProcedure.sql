/****** Object:  StoredProcedure [dbo].[_AB_sp_Transfers_CheckUSData]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		A.B. Software & Consultancy, LVE
-- Create date: 2019-12-03
-- Description:	Check Creation of required entities in US
-- =============================================
CREATE PROCEDURE [dbo].[_AB_sp_Transfers_CheckUSData] 
	-- Add the parameters for the stored procedure here
	@runid uniqueidentifier,
	@seqno int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- Check availability of item
	UPDATE t WITH (ROWLOCK, NOWAIT) SET
		rowstatus = -1
		, errormessage = 'Item not available in US, retry'
		, sysmodified = CURRENT_TIMESTAMP
	FROM dbo._AB_tb_TransfersOrders t 
	WHERE 1 = 1
		AND t.runid = @runid
		AND t.seqno = 30
		-- Not yet available in US
		AND NOT EXISTS ( SELECT 1 FROM dbo._AB_sy_US_Items AS iusa WITH (nolock) WHERE iusa.ItemCode = t.Itemcode COLLATE DATABASE_DEFAULT )

	-- Check availablitity of Item Account
	UPDATE t WITH (ROWLOCK, NOWAIT) SET
		rowstatus = -1
		, errormessage = 'Item Account not available in US, retry'
		, sysmodified = CURRENT_TIMESTAMP    
	FROM dbo._AB_tb_TransfersOrders t 
		INNER JOIN dbo._AB_sy_US_cicmpy c WITH (NOLOCK)
			ON c.crdnr = t.crdnr COLLATE DATABASE_DEFAULT
	WHERE 1 = 1
		AND t.runid = @runid
		AND t.seqno = 30
		AND t.rowstatus = 1
		-- Not yet available in US
		AND NOT EXISTS ( SELECT 1 FROM dbo._AB_sy_US_ItemAccounts AS iusa WITH (nolock) 
			WHERE iusa.ItemCode = t.Itemcode COLLATE DATABASE_DEFAULT
				AND iusa.AccountCode = c.cmp_wwn )

	-- Check availability of Item Number
	UPDATE t WITH (ROWLOCK, NOWAIT) SET
		rowstatus = -1
		, errormessage = 'Item Number not available in US, retry'
		, sysmodified = CURRENT_TIMESTAMP    
	FROM dbo._AB_tb_TransfersOrders t 
		INNER JOIN dbo._AB_sy_US_cicmpy c WITH (NOLOCK)
			ON c.crdnr = t.crdnr COLLATE DATABASE_DEFAULT
	WHERE 1 = 1 
		AND t.isSerialNumberItem = 1
		AND t.runid = @runid
		AND t.seqno = 30
		AND t.rowstatus = 1
		-- Not yet available in US
		AND NOT EXISTS ( SELECT 1 FROM dbo._AB_sy_US_ItemNumbers AS iusa WITH (nolock) 
			WHERE iusa.ItemCode = t.Itemcode COLLATE DATABASE_DEFAULT
				AND iusa.number = t.ItemNumber COLLATE DATABASE_DEFAULT)

	-- Only set next status when all checks passed for pallet
	UPDATE t WITH (ROWLOCK, NOWAIT) SET
		seqno = @seqno
		, errormessage = '' -- remove error
		, sysmodified = CURRENT_TIMESTAMP
	FROM dbo._AB_tb_TransfersOrders t 
	WHERE 1=1
		AND t.runid = @runid
		AND t.seqno = 30
		AND NOT EXISTS (SELECT 1 FROM dbo._AB_tb_TransfersOrders t1 WITH (NOLOCK) WHERE t1.runid = t.runid AND t1.absenceid = t.absenceid AND t1.seqno = t.seqno AND t1.rowstatus = -1)

END

GO
