/****** Object:  Table [dbo].[_ST_IC_RMAs]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_IC_RMAs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CID] [int] NOT NULL,
	[Accountno] [int] NULL,
	[Company] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContactPerson] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CDate] [datetime] NULL,
	[Reason] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ArticleNo1] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SerialNo1] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity1] [int] NULL,
	[State1] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ArticleNo2] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SerialNo2] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity2] [int] NULL,
	[State2] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderNo] [int] NULL,
	[InvoiceNo] [int] NULL,
	[Description] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipmentDate] [datetime] NULL,
	[Failure] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FailureDescription] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OptionalText] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Updated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateChanged] [datetime] NOT NULL,
	[RunId] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HID] [int] NULL,
	[Attachment] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK__ST_IC_RMAs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_IC_RMAs] ADD  CONSTRAINT [DF__ST_IC_RMAs_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[_ST_IC_RMAs] ADD  CONSTRAINT [DF__ST_IC_RMAs_ModifiedDate]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[_ST_IC_RMAs] ADD  CONSTRAINT [DF__ST_IC_RMAs_DateChanged]  DEFAULT (getdate()) FOR [DateChanged]
GO
ALTER TABLE [dbo].[_ST_IC_RMAs] ADD  CONSTRAINT [DF__ST_IC_RMAs_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
