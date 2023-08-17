/****** Object:  Table [dbo].[_AB_Entity_trigger_table]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_Entity_trigger_table](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[jobid] [int] NOT NULL,
	[params] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
