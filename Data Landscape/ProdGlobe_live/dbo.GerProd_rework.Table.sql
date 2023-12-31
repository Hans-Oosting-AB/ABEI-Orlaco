/****** Object:  Table [dbo].[GerProd_rework]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GerProd_rework](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Productieorder] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[Artikel] [varchar](60) COLLATE Latin1_General_CI_AS NULL,
	[Serienummer] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[Aantal] [numeric](18, 3) NULL,
	[Proddatum] [datetime] NULL,
	[Geimp_Globe] [bit] NULL,
	[XML_gegenereerd] [bit] NULL,
	[XML_prod] [bit] NULL,
	[Uitgegeven] [bit] NULL,
	[Timestamp] [timestamp] NULL,
 CONSTRAINT [PK_GerProd_rework] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Productieorder]    Script Date: 8/17/2023 9:09:20 AM ******/
CREATE NONCLUSTERED INDEX [IX_Productieorder] ON [dbo].[GerProd_rework]
(
	[Productieorder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
