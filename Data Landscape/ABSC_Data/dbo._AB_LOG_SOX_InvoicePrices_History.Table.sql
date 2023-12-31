/****** Object:  Table [dbo].[_AB_LOG_SOX_InvoicePrices_History]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_LOG_SOX_InvoicePrices_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InvMonth] [varchar](27) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[frhsrgid] [int] NOT NULL,
	[ordernr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[faknr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[fak_soort] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[fakdebnr] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[inv_debtor_name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[refer] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[docnumber] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[fakdat] [datetime] NULL,
	[regel] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[artcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[esr_aantal] [float] NOT NULL,
	[magcode] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[ar_soort] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[GPrice_Order] [float] NOT NULL,
	[GPrice_OrderList] [float] NULL,
	[GPrice_DebtorList] [float] NULL,
	[GPrice_SalesList] [float] NULL,
	[GPrice_Exact] [float] NULL,
	[NPrice_Order] [float] NOT NULL,
	[NPrice_OrderList] [float] NULL,
	[NPrice_DebtorList] [float] NULL,
	[NPrice_SalesList] [float] NULL,
	[NPrice_Exact] [float] NULL,
	[Discount] [float] NOT NULL,
	[PriceList_Order] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[PriceList_Debtor] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[sysmodified] [datetime] NOT NULL,
	[check_mssg] [varchar](91) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[check_status] [int] NOT NULL,
	[LogDate] [datetime] NOT NULL,
 CONSTRAINT [PK__AB_LOG_SOX_InvoicePrices_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
