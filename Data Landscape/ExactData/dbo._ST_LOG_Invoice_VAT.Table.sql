/****** Object:  Table [dbo].[_ST_LOG_Invoice_VAT]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_LOG_Invoice_VAT](
	[faknr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[VATNumber_new] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VATNumber_old] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[runtime] [datetime] NOT NULL
) ON [PRIMARY]
GO
