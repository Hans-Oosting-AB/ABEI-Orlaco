/****** Object:  Table [dbo].[_ST_LOGTransfer2022]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_LOGTransfer2022](
	[HeaderID] [varchar](7) COLLATE Latin1_General_CI_AS NOT NULL,
	[TransSubType] [varchar](1) COLLATE Latin1_General_CI_AS NOT NULL,
	[Regelcode] [varchar](1) COLLATE Latin1_General_CI_AS NOT NULL,
	[TransactionType] [varchar](3) COLLATE Latin1_General_CI_AS NOT NULL,
	[Datum] [datetime] NOT NULL,
	[reknr] [char](9) COLLATE Latin1_General_CI_AS NULL,
	[oms25] [varchar](21) COLLATE Latin1_General_CI_AS NOT NULL,
	[kstplcode] [varchar](3) COLLATE Latin1_General_CI_AS NOT NULL,
	[artcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[facode] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[warehouse] [varchar](1) COLLATE Latin1_General_CI_AS NOT NULL,
	[aantal] [int] NOT NULL,
	[bdr_hfl] [numeric](18, 3) NULL,
	[docdate] [datetime] NOT NULL
) ON [PRIMARY]
GO
