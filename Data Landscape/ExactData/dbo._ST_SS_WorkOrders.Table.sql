/****** Object:  Table [dbo].[_ST_SS_WorkOrders]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SS_WorkOrders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ESID] [int] NOT NULL,
	[ESHID] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SSID] [int] NULL,
	[EGOrder] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SSStatus] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SyncStatus] [int] NOT NULL,
	[ESStatus] [int] NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NOT NULL,
	[Archived] [bit] NOT NULL,
	[ESType] [int] NULL,
 CONSTRAINT [PK__ST_SS_WorkOrders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_ST_SS_WorkOrders_ESID] UNIQUE NONCLUSTERED 
(
	[ESID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_SS_WorkOrders] ADD  CONSTRAINT [DF__ST_SS_WorkOrders_Archived]  DEFAULT ((0)) FOR [Archived]
GO
