/****** Object:  Table [dbo].[_AB_tb_ExtendedWarranty_ItemNumbers_backup]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_ExtendedWarranty_ItemNumbers_backup](
	[tID] [int] IDENTITY(1,1) NOT NULL,
	[ordernr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[debnr] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[regel] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[artcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[oms45] [varchar](60) COLLATE Latin1_General_CI_AS NULL,
	[sysguid] [uniqueidentifier] NULL,
	[afldat] [datetime] NULL,
	[warranty_artcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[warranty_order_description] [varchar](max) COLLATE Latin1_General_CI_AS NULL,
	[mo_default] [float] NULL,
	[mo_customer] [float] NULL,
	[mo_item] [float] NULL,
	[mo_item_after] [float] NULL,
	[mo_longest] [float] NULL,
	[EW] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ID] [uniqueidentifier] NULL,
	[number] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[DateEnd] [datetime] NULL,
	[LotNumber] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateEnd_old] [datetime] NULL,
	[Classification] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
	[abei_runid] [uniqueidentifier] NULL,
	[abei_rowstatus] [int] NULL,
	[abei_message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[abei_checkmessage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[abei_retrycount] [int] NULL,
	[administration] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[isAfterSales] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
