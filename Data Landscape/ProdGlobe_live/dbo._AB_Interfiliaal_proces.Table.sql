/****** Object:  Table [dbo].[_AB_Interfiliaal_proces]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_Interfiliaal_proces](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Productieorder] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[Mag] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[Artikel] [varchar](60) COLLATE Latin1_General_CI_AS NULL,
	[Serienummer] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[Aantal] [numeric](18, 3) NULL,
	[Proddatum] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[Vrrdrek] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[CostPriceStandard] [float] NULL,
	[Status_Interfiliaal] [int] NULL,
	[Eenheid] [varchar](5) COLLATE Latin1_General_CI_AS NULL,
	[SentMail] [bit] NULL,
	[Uitgegeven] [bit] NULL,
	[Imp_attempts] [int] NULL,
	[Timestamp] [timestamp] NULL
) ON [PRIMARY]
GO
