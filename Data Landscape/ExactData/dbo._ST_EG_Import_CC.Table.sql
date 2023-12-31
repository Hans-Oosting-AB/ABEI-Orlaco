/****** Object:  Table [dbo].[_ST_EG_Import_CC]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_EG_Import_CC](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Itemcode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Category] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CountingCycle] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[runid] [uniqueidentifier] NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
 CONSTRAINT [PK__ST_EG_Import_CC] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_EG_Import_CC] ADD  CONSTRAINT [DF__ST_EG_Import_CC_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[_ST_EG_Import_CC] ADD  CONSTRAINT [DF__ST_EG_Import_CC_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_ST_EG_Import_CC] ADD  CONSTRAINT [DF__ST_EG_Import_CC_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
