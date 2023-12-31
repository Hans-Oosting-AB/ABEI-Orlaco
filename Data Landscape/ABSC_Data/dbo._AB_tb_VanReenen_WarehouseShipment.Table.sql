/****** Object:  Table [dbo].[_AB_tb_VanReenen_WarehouseShipment]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_VanReenen_WarehouseShipment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FileFolderListID] [int] NULL,
	[company] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ediprovider] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sourcefilename] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_mutationtype] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_customer_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_branch_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_warehouse_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_ordernr] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_orderdate] [datetime] NULL,
	[order_reference] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_deliverydate] [datetime] NULL,
	[order_addressname] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_addressstreet] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_addresszipcode] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_addresscity_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_addresscountry_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[orderline_article_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[orderline_unitamount] [float] NULL,
	[orderline_unitid] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[orderline_pickdate] [datetime] NULL,
	[orderline_lot] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[abei_deliverydate] [datetime] NULL,
	[abei_unitamount] [float] NULL,
	[abei_ordernr] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[abei_artcode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[abei_isserialitem] [bit] NULL,
	[abei_orsrgID] [int] NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[seqno] [int] NULL,
	[sysmessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_VanReenen_WarehouseShipment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_VanReenen_WarehouseShipment] ADD  CONSTRAINT [DF__AB_tb_VanReenen_WarehouseShipment_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_VanReenen_WarehouseShipment] ADD  CONSTRAINT [DF__AB_tb_VanReenen_WarehouseShipment_seqno]  DEFAULT ((0)) FOR [seqno]
GO
ALTER TABLE [dbo].[_AB_tb_VanReenen_WarehouseShipment] ADD  CONSTRAINT [DF__AB_tb_VanReenen_WarehouseShipment_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_VanReenen_WarehouseShipment] ADD  CONSTRAINT [DF__AB_tb_VanReenen_WarehouseShipment_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
