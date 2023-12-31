/****** Object:  Table [dbo].[_ST_ICLPriceUpdate]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_ICLPriceUpdate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemCode] [varchar](30) COLLATE Latin1_General_CI_AS NOT NULL,
	[PriceListCode] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PriceListType] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PriceListDescription] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CurrencyCode] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AccountType] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AccountStatus] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Value] [numeric](18, 3) NOT NULL,
	[Unit] [varchar](8) COLLATE Latin1_General_CI_AS NOT NULL,
	[Factor] [int] NOT NULL,
	[LineType] [int] NOT NULL,
	[DateStart] [date] NOT NULL,
	[DateEnd] [date] NULL,
	[DiscountType] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DiscountNumber] [int] NOT NULL,
	[DiscountQuantity] [int] NOT NULL,
	[DiscountValue] [numeric](18, 3) NOT NULL,
	[UpdateReason] [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OldSalesPrice] [numeric](18, 3) NULL,
	[OldDiscount] [numeric](18, 3) NULL,
	[CreationDate] [datetime] NOT NULL,
	[SourceDB] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RunId] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK__ST_ICLPriceUpdate] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
