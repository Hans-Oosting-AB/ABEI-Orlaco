/****** Object:  Table [dbo].[_ST_PRD_Process_Cummulative]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_PRD_Process_Cummulative](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductionOrder] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[Itemcode] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[SerialNr] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[QtyPlanned] [int] NOT NULL,
	[QtyReceived] [int] NOT NULL,
	[QtyReady] [int] NOT NULL,
	[QtyReject] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Warehouse] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[OrderStatus] [int] NOT NULL,
	[syscreated] [datetime] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[RunId] [uniqueidentifier] NULL,
 CONSTRAINT [PK__ST_PRD_Process] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_PRD_Process_Cummulative] ADD  CONSTRAINT [DF__ST_PRD_Process_Warehouse]  DEFAULT ((1)) FOR [Warehouse]
GO
ALTER TABLE [dbo].[_ST_PRD_Process_Cummulative] ADD  CONSTRAINT [DF__ST_PRD_Process_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_ST_PRD_Process_Cummulative] ADD  CONSTRAINT [DF__ST_PRD_Process_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
ALTER TABLE [dbo].[_ST_PRD_Process_Cummulative] ADD  CONSTRAINT [DF__ST_PRD_Process_Cummulative_Status]  DEFAULT ((0)) FOR [Status]
GO
