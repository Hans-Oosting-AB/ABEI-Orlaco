/****** Object:  Table [dbo].[_AB_tb_VRSalesOrders]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_VRSalesOrders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RowId] [int] NOT NULL,
	[ordernr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[refer] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[docnumber] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[selcode] [char](2) COLLATE Latin1_General_CI_AS NULL,
	[debnr] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[ord_debtor_name] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[del_debnr] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[del_debtor_name] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[del_AddressLine1] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[del_PostCode] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[del_City] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[del_landcode] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[del_contactperson] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[del_phone] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Rownr] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[Itemcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[Description] [varchar](60) COLLATE Latin1_General_CI_AS NULL,
	[CustomerItemcode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[isSerialNumberItem] [int] NULL,
	[DeliveryDate] [datetime] NULL,
	[Quantity] [float] NOT NULL,
	[PcsWeight] [float] NOT NULL,
	[NetWeight] [float] NOT NULL,
	[syscreated] [datetime] NOT NULL,
	[runid] [uniqueidentifier] NULL,
 CONSTRAINT [PK__AB_tb_VRSalesOrders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_VRSalesOrders] ADD  CONSTRAINT [DF__AB_tb_VRSalesOrders_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
