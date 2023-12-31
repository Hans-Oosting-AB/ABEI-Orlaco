/****** Object:  Table [dbo].[_AB_tb_IFR_History]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_IFR_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[aID] [uniqueidentifier] NULL,
	[HID] [int] NULL,
	[syscreated] [datetime] NULL,
	[Waiting] [tinyint] NULL,
	[WaitingReason] [nvarchar](60) COLLATE Latin1_General_CI_AS NULL,
	[bkstknr] [int] NULL,
	[RequestComments] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[WorkflowComments] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[Approved] [datetime] NULL,
	[Status] [int] NULL,
	[prev_HID] [int] NULL,
	[prev_syscreated] [datetime] NULL,
	[prev_Waiting] [tinyint] NULL,
	[prev_WaitingReason] [nvarchar](60) COLLATE Latin1_General_CI_AS NULL,
	[prev_bkstknr] [int] NULL,
	[prev_RequestComments] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[prev_WorkflowComments] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[prev_Approved] [datetime] NULL,
	[prev_Status] [int] NULL,
	[first_created] [datetime] NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[errormessage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[p_syscreated] [datetime] NULL,
	[p_sysmodified] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_IFR_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_IFR_History] ADD  CONSTRAINT [DF__AB_tb_IFR_History_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_IFR_History] ADD  CONSTRAINT [DF__AB_tb_IFR_History_p_syscreated]  DEFAULT (getdate()) FOR [p_syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_IFR_History] ADD  CONSTRAINT [DF__AB_tb_IFR_History_p_sysmodified]  DEFAULT (getdate()) FOR [p_sysmodified]
GO
