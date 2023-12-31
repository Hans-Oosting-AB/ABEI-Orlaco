/****** Object:  Table [dbo].[PriceUpdate_DAF_20220706]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceUpdate_DAF_20220706](
	[id] [int] NOT NULL,
	[ordernr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[ord_soort] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[debnr] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[ord_debtor_name] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[regel] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[artcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[ar_soort] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[oms45] [varchar](60) COLLATE Latin1_General_CI_AS NULL,
	[esr_aantal] [float] NOT NULL,
	[prijslijst] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[afldat] [datetime] NULL,
	[Gross_RowPrice] [float] NOT NULL,
	[Net_RowPrice] [float] NOT NULL,
	[RowDiscount] [float] NOT NULL,
	[New_GrossPrice] [float] NULL,
	[New_NetPrice] [float] NULL,
	[PriceAgreement_ID] [int] NULL,
	[PriceAgreement_GrossPrice] [float] NULL,
	[PriceAgreement_Discount] [float] NULL,
	[PriceAgreement_DiscountType] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[PriceAgreement_Account] [uniqueidentifier] NULL,
	[Pricelist_ID] [int] NULL,
	[Pricelist_GrossPrice] [float] NULL,
	[Pricelist_Discount] [float] NULL,
	[Pricelist_DiscountType] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[Source] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
