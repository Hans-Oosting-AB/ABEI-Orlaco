/****** Object:  Table [dbo].[_ST_PricelistUpdate211230]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_PricelistUpdate211230](
	[Division] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ID] [int] NOT NULL,
	[prijslijst] [char](15) COLLATE Latin1_General_CI_AS NULL,
	[artcode] [char](30) COLLATE Latin1_General_CI_AS NULL,
	[kort_pbn] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[prijs83] [float] NOT NULL,
	[bedr1] [float] NOT NULL,
	[bedr2] [float] NOT NULL,
	[bedr3] [float] NOT NULL,
	[bedr4] [float] NOT NULL,
	[bedrag5] [float] NOT NULL,
	[price6] [float] NOT NULL,
	[price7] [float] NOT NULL,
	[price8] [float] NOT NULL,
	[price9] [float] NOT NULL,
	[price10] [float] NOT NULL,
	[new_prijs83] [float] NULL,
	[new_bedr1] [float] NULL,
	[new_bedr2] [float] NULL,
	[new_bedr3] [float] NULL,
	[new_bedr4] [float] NULL,
	[new_bedr5] [float] NULL,
	[new_price6] [float] NULL,
	[new_price7] [float] NULL,
	[new_price8] [float] NULL,
	[new_price9] [float] NULL,
	[new_price10] [float] NULL,
	[AccountID] [uniqueidentifier] NULL,
	[validfrom] [datetime] NULL,
	[validto] [datetime] NULL,
	[syscreated] [datetime] NOT NULL,
	[syscreator] [int] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
	[sysmodifier] [int] NOT NULL,
	[updated] [datetime] NOT NULL,
	[reverted] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_PricelistUpdate211230] ADD  CONSTRAINT [DF__ST_PricelistUpdate211230_reverted]  DEFAULT ((0)) FOR [reverted]
GO
