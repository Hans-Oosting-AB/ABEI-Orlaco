/****** Object:  Table [dbo].[_AB_tb_TransfersOrders]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_TransfersOrders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[absenceid] [uniqueidentifier] NULL,
	[HID] [int] NULL,
	[ItemCode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemNumber] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[quantity] [float] NULL,
	[original_quantity] [float] NULL,
	[statisticalnumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[origin] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[packagedescription] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[isSerialNumberItem] [bit] NULL,
	[usercode] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NetWeight] [float] NULL,
	[crdnr] [char](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[purchase_ordernr] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sales_ordernr] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[orderreferenceid] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[linereferenceid] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[seqno] [int] NULL,
	[errormessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[retrycounter] [int] NULL,
	[runid1] [uniqueidentifier] NULL,
	[rowstatus1] [int] NULL,
	[errormessage1] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[retrycounter1] [int] NULL,
	[runid2] [uniqueidentifier] NULL,
	[rowstatus2] [int] NULL,
	[errormessage2] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[retrycounter2] [int] NULL,
	[sysmodified] [datetime] NULL,
	[syscreated] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_TransfersOrders] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersOrders] ADD  CONSTRAINT [DF__AB_tb_TransfersOrders_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersOrders] ADD  CONSTRAINT [DF__AB_tb_TransfersOrders_seqno]  DEFAULT ((0)) FOR [seqno]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersOrders] ADD  CONSTRAINT [DF__AB_tb_TransfersOrders_retrycounter]  DEFAULT ((0)) FOR [retrycounter]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersOrders] ADD  CONSTRAINT [DF__AB_tb_TransfersOrders_rowstatus1]  DEFAULT ((0)) FOR [rowstatus1]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersOrders] ADD  CONSTRAINT [DF__AB_tb_TransfersOrders_retrycounter1]  DEFAULT ((0)) FOR [retrycounter1]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersOrders] ADD  CONSTRAINT [DF__AB_tb_TransfersOrders_rowstatus2]  DEFAULT ((0)) FOR [rowstatus2]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersOrders] ADD  CONSTRAINT [DF__AB_tb_TransfersOrders_retrycounter2]  DEFAULT ((0)) FOR [retrycounter2]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersOrders] ADD  CONSTRAINT [DF__AB_tb_TransfersOrders_sysmodified1]  DEFAULT (getdate()) FOR [sysmodified]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersOrders] ADD  CONSTRAINT [DF__AB_tb_TransfersOrders_syscreated1]  DEFAULT (getdate()) FOR [syscreated]
GO
