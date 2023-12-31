/****** Object:  Table [dbo].[_AB_GerProd_proces_backup]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_GerProd_proces_backup](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Productieorder] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[Artikel] [varchar](60) COLLATE Latin1_General_CI_AS NULL,
	[Serienummer] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[Aantal] [numeric](18, 3) NULL,
	[Proddatum] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[Status_ProdGer] [int] NULL,
	[SentMail] [bit] NULL,
	[Uitgegeven] [bit] NULL,
	[Imp_attempts] [int] NULL,
	[Timestamp] [timestamp] NULL,
	[SysCreated] [datetime] NULL
) ON [PRIMARY]
GO
