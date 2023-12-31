/****** Object:  Table [dbo].[_AB_tb_LockInfo]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_LockInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SPID] [smallint] NOT NULL,
	[HostName] [nchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LoginName] [nchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Blocked] [smallint] NOT NULL,
	[database] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TableName] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Program_Name] [nchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CMD] [nchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Open_Tran] [smallint] NOT NULL,
	[WaitTime] [bigint] NOT NULL,
	[cpu] [int] NOT NULL,
	[status] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Last_Batch] [datetime] NOT NULL,
	[Blocked_Query] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Causing_Query] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NOT NULL,
 CONSTRAINT [PK__AB_tb_LockInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
