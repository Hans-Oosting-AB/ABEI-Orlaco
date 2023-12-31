/****** Object:  Table [dbo].[_PriceUpdate_974048_05042022]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_PriceUpdate_974048_05042022](
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
	[R_Prijs83] [float] NOT NULL,
	[prijs_n] [float] NOT NULL,
	[NewPrice] [float] NULL,
	[korting] [float] NOT NULL
) ON [PRIMARY]
GO
