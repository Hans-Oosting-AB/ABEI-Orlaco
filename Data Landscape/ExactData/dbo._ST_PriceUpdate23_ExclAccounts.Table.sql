/****** Object:  Table [dbo].[_ST_PriceUpdate23_ExclAccounts]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_PriceUpdate23_ExclAccounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[debnr] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[cmp_wwn] [uniqueidentifier] NULL,
	[cmp_name] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[cmp_status] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[cmp_type] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[pricelist] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[division] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[source] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_PriceUpdate23_ExclAccounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_PriceUpdate23_ExclAccounts] ADD  CONSTRAINT [DF__ST_PriceUpdate23_ExclAccounts_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
