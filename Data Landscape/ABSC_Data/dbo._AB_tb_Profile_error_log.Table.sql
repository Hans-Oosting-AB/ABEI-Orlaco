/****** Object:  Table [dbo].[_AB_tb_Profile_error_log]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_Profile_error_log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[partid] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[itemcode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Entity] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Action] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HeaderID] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReferenceValue] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Keyvalue] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NewKeyvalue] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[runid] [uniqueidentifier] NULL,
	[sysmessage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_Profile_error_log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_error_log] ADD  CONSTRAINT [DF__AB_tb_Profile_error_log_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_error_log] ADD  CONSTRAINT [DF__AB_tb_Profile_error_log_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
