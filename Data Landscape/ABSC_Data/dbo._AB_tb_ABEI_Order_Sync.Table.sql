/****** Object:  Table [dbo].[_AB_tb_ABEI_Order_Sync]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_ABEI_Order_Sync](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[purchase_ordernr] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sales_ordernr] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[orderreferenceid] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[linereferenceid] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[rowmessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[retrycounter] [int] NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_ABEI_Order_Sync] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [_AB_tb_ABEI_Order_Sync_purchase_ordernr]    Script Date: 8/17/2023 9:06:05 AM ******/
CREATE NONCLUSTERED INDEX [_AB_tb_ABEI_Order_Sync_purchase_ordernr] ON [dbo].[_AB_tb_ABEI_Order_Sync]
(
	[purchase_ordernr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_Order_Sync] ADD  CONSTRAINT [DF__AB_tb_ABEI_Order_Sync_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_Order_Sync] ADD  CONSTRAINT [DF__AB_tb_ABEI_Order_Sync_retrycounter]  DEFAULT ((0)) FOR [retrycounter]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_Order_Sync] ADD  CONSTRAINT [DF__AB_tb_ABEI_Order_Sync_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_Order_Sync] ADD  CONSTRAINT [DF__AB_tb_ABEI_Order_Sync_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
