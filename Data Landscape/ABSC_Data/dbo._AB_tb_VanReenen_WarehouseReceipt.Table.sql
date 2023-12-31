/****** Object:  Table [dbo].[_AB_tb_VanReenen_WarehouseReceipt]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_VanReenen_WarehouseReceipt](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FileFolderListID] [int] NULL,
	[company] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sourcefilename] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_mutationtype] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_customer_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_branch_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_warehouse_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_ordernr] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_orderdate] [datetime] NULL,
	[order_reference] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_pickupdate] [datetime] NULL,
	[orderline_article_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[orderline_unitamount] [float] NULL,
	[orderline_unitid] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[orderline_inbounddate] [datetime] NULL,
	[orderline_lot] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[abei_receiptdate] [datetime] NULL,
	[abei_itemcode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[abei_serial] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[abei_warehouse] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[abei_stock] [float] NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[seqno] [int] NULL,
	[sysmessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_VanReenen_WarehouseReceipt] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_VanReenen_WarehouseReceipt] ADD  CONSTRAINT [DF__AB_tb_VanReenen_WarehouseReceipt_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_VanReenen_WarehouseReceipt] ADD  CONSTRAINT [DF__AB_tb_VanReenen_WarehouseReceipt_seqno]  DEFAULT ((0)) FOR [seqno]
GO
ALTER TABLE [dbo].[_AB_tb_VanReenen_WarehouseReceipt] ADD  CONSTRAINT [DF__AB_tb_VanReenen_WarehouseReceipt_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_VanReenen_WarehouseReceipt] ADD  CONSTRAINT [DF__AB_tb_VanReenen_WarehouseReceipt_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
