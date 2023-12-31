/****** Object:  Table [dbo].[_ST_Update_DAFPrices_230202]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_Update_DAFPrices_230202](
	[ordernr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[id] [int] NOT NULL,
	[regel] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[artcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[esr_aantal] [float] NOT NULL,
	[prijs83_old] [float] NOT NULL,
	[prijs_n_old] [float] NOT NULL,
	[korting_old] [float] NOT NULL,
	[prijs83] [float] NULL,
	[prijs_n] [float] NULL
) ON [PRIMARY]
GO
