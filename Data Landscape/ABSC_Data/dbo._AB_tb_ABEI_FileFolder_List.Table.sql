/****** Object:  Table [dbo].[_AB_tb_ABEI_FileFolder_List]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_ABEI_FileFolder_List](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[runid] [uniqueidentifier] NULL,
	[jobid] [int] NULL,
	[seqno] [int] NULL,
	[jobstepid] [int] NULL,
	[name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[filepath] [varchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fullname] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[isfolder] [bit] NULL,
	[ishidden] [bit] NULL,
	[creationtime] [datetime] NULL,
	[creationtimeutc] [datetime] NULL,
	[lastaccesstime] [datetime] NULL,
	[lastaccesstimeutc] [datetime] NULL,
	[lastwritetime] [datetime] NULL,
	[lastwritetimeutc] [datetime] NULL,
	[rowstatus] [int] NULL,
	[sysmessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_ABEI_FileFolder_List] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_FileFolder_List] ADD  CONSTRAINT [DF__AB_tb_ABEI_FileFolder_List_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_FileFolder_List] ADD  CONSTRAINT [DF__AB_tb_ABEI_FileFolder_List_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_FileFolder_List] ADD  CONSTRAINT [DF__AB_tb_ABEI_FileFolder_List_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
