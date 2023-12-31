/****** Object:  Table [dbo].[_ST_IC_Subscribers]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_IC_Subscribers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CId] [int] NOT NULL,
	[Email] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CDate] [datetime] NOT NULL,
	[Confirmed] [bit] NOT NULL,
	[Unsubscribed] [bit] NOT NULL,
	[Bounced] [bit] NOT NULL,
	[FirstName] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Initials] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Suffix] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Gender] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BirthDate] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Mobile] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Currency] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Country] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Role] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Selection] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Subscriptions] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateChanged] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK__ST_IC_Subscribers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX__ST_IC_Subscribers_UQ_CID]    Script Date: 8/17/2023 8:59:03 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX__ST_IC_Subscribers_UQ_CID] ON [dbo].[_ST_IC_Subscribers]
(
	[CId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_IC_Subscribers] ADD  CONSTRAINT [DF__ST_IC_Subscribers_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[_ST_IC_Subscribers] ADD  CONSTRAINT [DF__ST_IC_Subscribers_DateChanged]  DEFAULT (getdate()) FOR [DateChanged]
GO
ALTER TABLE [dbo].[_ST_IC_Subscribers] ADD  CONSTRAINT [DF__ST_IC_Subscribers_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
