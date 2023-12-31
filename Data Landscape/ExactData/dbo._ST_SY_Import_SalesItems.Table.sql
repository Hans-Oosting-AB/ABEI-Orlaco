/****** Object:  Table [dbo].[_ST_SY_Import_SalesItems]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SY_Import_SalesItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Itemcode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Salesdescription] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Category1] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Category2] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PMC] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LeadTime] [int] NULL,
	[LeadTimeUSA] [int] NULL,
	[Notes] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Pricelist] [bit] NOT NULL,
	[Syscreated] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_SY_Import_SalesItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_SY_Import_SalesItems] ADD  CONSTRAINT [DF__ST_SY_Import_SalesItems_Pricelist]  DEFAULT ((1)) FOR [Pricelist]
GO
ALTER TABLE [dbo].[_ST_SY_Import_SalesItems] ADD  CONSTRAINT [DF__ST_SY_Import_SalesItems_Syscreated]  DEFAULT (getdate()) FOR [Syscreated]
GO
