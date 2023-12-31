/****** Object:  Table [dbo].[_ST_Restore_ITRequests]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_Restore_ITRequests](
	[ID] [uniqueidentifier] NOT NULL,
	[HID] [int] IDENTITY(1,1) NOT NULL,
	[EmpID] [int] NOT NULL,
	[StartDate] [datetime] NULL,
	[Enddate] [datetime] NULL,
	[CustomerId] [uniqueidentifier] NULL,
	[Description] [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
	[RequestComments] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[WorkflowComments] [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
	[Status] [int] NOT NULL,
	[StatusChanged] [datetime] NULL,
	[Approver] [int] NOT NULL,
	[Approved] [datetime] NULL,
	[Processor] [int] NULL,
	[Processed] [datetime] NULL,
	[Realizer] [int] NULL,
	[Realized] [datetime] NULL,
	[RejectedBy] [int] NULL,
	[Rejected] [datetime] NULL,
	[syscreated] [datetime] NOT NULL,
	[syscreator] [int] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
	[sysmodifier] [int] NOT NULL,
	[ParentRequest] [uniqueidentifier] NULL,
	[RelatedRequestID] [uniqueidentifier] NULL,
	[FreeTextField_01] [nvarchar](60) COLLATE Latin1_General_CI_AS NULL,
	[FreeTextField_02] [nvarchar](60) COLLATE Latin1_General_CI_AS NULL,
	[FreeTextField_03] [nvarchar](60) COLLATE Latin1_General_CI_AS NULL,
	[FreeTextField_04] [nvarchar](60) COLLATE Latin1_General_CI_AS NULL,
	[FreeTextField_05] [nvarchar](60) COLLATE Latin1_General_CI_AS NULL,
	[FreeBoolField_01] [tinyint] NULL,
	[StatusDescription] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NewId] [uniqueidentifier] NULL,
	[RunId] [uniqueidentifier] NULL,
	[RestoredOn] [datetime] NULL,
	[Type] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
