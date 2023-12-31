/****** Object:  Table [dbo].[ReworkProcess]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReworkProcess](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ordernr] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Itemcode] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Serialnr] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[Quantity] [int] NOT NULL,
	[Scrap] [bit] NOT NULL,
	[Warehouse] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Status] [int] NOT NULL,
	[RetryCnt] [int] NOT NULL,
	[RunId] [uniqueidentifier] NULL,
	[Syscreated] [datetime] NOT NULL,
	[Sysmodified] [datetime] NOT NULL,
 CONSTRAINT [PK_ReworkProcess] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReworkProcess] ADD  CONSTRAINT [DF_ReworkProcess_Quantity]  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[ReworkProcess] ADD  CONSTRAINT [DF_ReworkProcess_Scrap]  DEFAULT ((0)) FOR [Scrap]
GO
ALTER TABLE [dbo].[ReworkProcess] ADD  CONSTRAINT [DF_ReworkProcess_Warehouse]  DEFAULT ('1') FOR [Warehouse]
GO
ALTER TABLE [dbo].[ReworkProcess] ADD  CONSTRAINT [DF_ReworkProcess_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[ReworkProcess] ADD  CONSTRAINT [DF_ReworkProcess_RetryCnt]  DEFAULT ((0)) FOR [RetryCnt]
GO
ALTER TABLE [dbo].[ReworkProcess] ADD  CONSTRAINT [DF_ReworkProcess_Syscreated]  DEFAULT (getdate()) FOR [Syscreated]
GO
ALTER TABLE [dbo].[ReworkProcess] ADD  CONSTRAINT [DF_ReworkProcess_Sysmodified]  DEFAULT (getdate()) FOR [Sysmodified]
GO
