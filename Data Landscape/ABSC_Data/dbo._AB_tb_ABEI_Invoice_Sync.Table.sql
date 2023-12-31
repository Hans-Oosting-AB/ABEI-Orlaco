/****** Object:  Table [dbo].[_AB_tb_ABEI_Invoice_Sync]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_ABEI_Invoice_Sync](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AOS_id] [int] NULL,
	[purchase_ordernr] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sales_ordernr] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sales_faknr] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sales_docnumber] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[invoicedate] [datetime] NULL,
	[orderreferenceid] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[linereferenceid] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[runid1] [uniqueidentifier] NULL,
	[rowstatus1] [int] NULL,
	[rowmessage1] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[retrycounter1] [int] NULL,
	[runid2] [uniqueidentifier] NULL,
	[rowstatus2] [int] NULL,
	[rowmessage2] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[retrycounter2] [int] NULL,
	[sysmodified] [datetime] NULL,
	[syscreated] [datetime] NULL,
	[baid] [uniqueidentifier] NULL,
 CONSTRAINT [PK__AB_tb_ABEI_Invoice_Sync] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_Invoice_Sync] ADD  CONSTRAINT [DF__AB_tb_ABEI_Invoice_Sync_rowstatus1]  DEFAULT ((0)) FOR [rowstatus1]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_Invoice_Sync] ADD  CONSTRAINT [DF__AB_tb_ABEI_Invoice_Sync_retrycounter1]  DEFAULT ((0)) FOR [retrycounter1]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_Invoice_Sync] ADD  CONSTRAINT [DF__AB_tb_ABEI_Invoice_Sync_rowstatus2]  DEFAULT ((0)) FOR [rowstatus2]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_Invoice_Sync] ADD  CONSTRAINT [DF__AB_tb_ABEI_Invoice_Sync_retrycounter2]  DEFAULT ((0)) FOR [retrycounter2]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_Invoice_Sync] ADD  CONSTRAINT [DF__AB_tb_ABEI_Invoice_Sync_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
