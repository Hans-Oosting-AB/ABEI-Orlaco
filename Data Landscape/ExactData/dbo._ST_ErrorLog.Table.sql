/****** Object:  Table [dbo].[_ST_ErrorLog]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_ErrorLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Application] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StackTrace] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Message] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LogMessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_ErrorLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_ErrorLog] ADD  CONSTRAINT [DF__ST_ErrorLog_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
