/****** Object:  Table [dbo].[_ST_EG_Import_SORequestedDate]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_EG_Import_SORequestedDate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderNr] [int] NOT NULL,
	[DebtorNr] [varchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Name] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SODescription] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SODate] [datetime] NULL,
	[RowNr] [int] NULL,
	[OldRequestedDate] [datetime] NULL,
	[DeliveryWeekNr] [int] NULL,
	[NewRequestedDate] [datetime] NULL,
	[Itemcode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ItemDescription] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity] [int] NOT NULL,
	[SelectionCode] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SelectionDescription] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailAddress] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailSent] [bit] NOT NULL,
	[Syscreated] [datetime] NOT NULL,
	[Sysmodified] [datetime] NOT NULL,
	[State] [int] NOT NULL,
	[RunId] [uniqueidentifier] NULL,
	[Delivered] [int] NULL,
	[EGPlannedDate] [datetime] NULL,
	[Message] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK__ST_EG_Import_SORequestedDate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_EG_Import_SORequestedDate] ADD  CONSTRAINT [DF__ST_EG_Import_SORequestedDate_EmailSent]  DEFAULT ((0)) FOR [EmailSent]
GO
ALTER TABLE [dbo].[_ST_EG_Import_SORequestedDate] ADD  CONSTRAINT [DF__ST_EG_Import_SORequestedDate_Syscreated]  DEFAULT (getdate()) FOR [Syscreated]
GO
ALTER TABLE [dbo].[_ST_EG_Import_SORequestedDate] ADD  CONSTRAINT [DF__ST_EG_Import_SORequestedDate_Sysmodified]  DEFAULT (getdate()) FOR [Sysmodified]
GO
ALTER TABLE [dbo].[_ST_EG_Import_SORequestedDate] ADD  CONSTRAINT [DF__ST_EG_Import_SORequestedDate_State]  DEFAULT ((0)) FOR [State]
GO
