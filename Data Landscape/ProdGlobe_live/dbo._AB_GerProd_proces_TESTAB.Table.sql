/****** Object:  Table [dbo].[_AB_GerProd_proces_TESTAB]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_GerProd_proces_TESTAB](
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
	[Rowstatus] [int] NULL,
	[Runid] [varchar](255) COLLATE Latin1_General_CI_AS NULL,
	[Sysmodified] [datetime] NULL,
	[Errormessage] [varchar](max) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK__AB_GerProd_proces_TESTAB] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_GerProd_proces_TESTAB] ADD  CONSTRAINT [DF__AB_GerProd_proces_TESTAB_Rowstatus]  DEFAULT ((0)) FOR [Rowstatus]
GO
ALTER TABLE [dbo].[_AB_GerProd_proces_TESTAB] ADD  CONSTRAINT [DF__AB_GerProd_proces_TESTAB_Sysmodified]  DEFAULT (getdate()) FOR [Sysmodified]
GO
