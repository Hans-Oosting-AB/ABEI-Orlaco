/****** Object:  Table [dbo].[_AB_GerProd_proces]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_GerProd_proces](
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
	[ch_aantal] [numeric](18, 3) NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[seqno] [int] NULL,
	[sysmessage] [varchar](max) COLLATE Latin1_General_CI_AS NULL,
	[SysCreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
	[SourceId] [int] NULL,
	[SourceTable] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK__AB_GerProd_proces] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_GerProd_proces] ADD  CONSTRAINT [DF__AB_GerProd_proces_ch_aantal]  DEFAULT ((0)) FOR [ch_aantal]
GO
ALTER TABLE [dbo].[_AB_GerProd_proces] ADD  CONSTRAINT [DF__AB_GerProd_proces_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_GerProd_proces] ADD  CONSTRAINT [DF__AB_GerProd_proces_SysCreated]  DEFAULT (getdate()) FOR [SysCreated]
GO
ALTER TABLE [dbo].[_AB_GerProd_proces] ADD  CONSTRAINT [DF__AB_GerProd_proces_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
