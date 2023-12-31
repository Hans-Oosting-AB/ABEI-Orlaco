/****** Object:  Table [dbo].[_ST_Synergy_Import]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_Synergy_Import](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EId] [int] NOT NULL,
	[EGUID] [uniqueidentifier] NOT NULL,
	[ECode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EStatus] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Accountmanager] [int] NULL,
	[ParentCode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NOT NULL,
	[Syscreated] [datetime] NOT NULL,
	[ParentGuid] [uniqueidentifier] NULL,
	[OldParentGuid] [uniqueidentifier] NULL,
	[OldAccountmanager] [int] NULL,
 CONSTRAINT [PK__ST_Synergy_Import] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_Synergy_Import] ADD  CONSTRAINT [DF__ST_Synergy_Import_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[_ST_Synergy_Import] ADD  CONSTRAINT [DF__ST_Synergy_Import_Syscreated]  DEFAULT (getdate()) FOR [Syscreated]
GO
