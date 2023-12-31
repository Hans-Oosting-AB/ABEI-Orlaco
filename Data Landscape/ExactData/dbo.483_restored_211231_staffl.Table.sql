/****** Object:  Table [dbo].[483_restored_211231_staffl]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[483_restored_211231_staffl](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[prijslijst] [char](15) COLLATE Latin1_General_CI_AS NULL,
	[artcode] [char](30) COLLATE Latin1_General_CI_AS NULL,
	[kort_pbn] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[prijs83] [float] NOT NULL,
	[aantal1] [float] NOT NULL,
	[bedr1] [float] NOT NULL,
	[aantal2] [float] NOT NULL,
	[bedr2] [float] NOT NULL,
	[aantal3] [float] NOT NULL,
	[bedr3] [float] NOT NULL,
	[aantal4] [float] NOT NULL,
	[bedr4] [float] NOT NULL,
	[aantal5] [float] NOT NULL,
	[bedrag5] [float] NOT NULL,
	[quantity6] [float] NOT NULL,
	[price6] [float] NOT NULL,
	[quantity7] [float] NOT NULL,
	[price7] [float] NOT NULL,
	[quantity8] [float] NOT NULL,
	[price8] [float] NOT NULL,
	[quantity9] [float] NOT NULL,
	[price9] [float] NOT NULL,
	[quantity10] [float] NOT NULL,
	[price10] [float] NOT NULL,
	[AccountID] [uniqueidentifier] NULL,
	[unitcode] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[unitfactor] [float] NOT NULL,
	[validfrom] [datetime] NULL,
	[validto] [datetime] NULL,
	[Project] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[LineType] [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
	[Division] [smallint] NULL,
	[syscreated] [datetime] NOT NULL,
	[syscreator] [int] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
	[sysmodifier] [int] NOT NULL,
	[sysguid] [uniqueidentifier] NOT NULL,
	[timestamp] [timestamp] NOT NULL
) ON [PRIMARY]
GO
