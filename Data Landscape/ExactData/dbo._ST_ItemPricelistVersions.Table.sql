/****** Object:  Table [dbo].[_ST_ItemPricelistVersions]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_ItemPricelistVersions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Version] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Syscreated] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_ItemPricelistVersions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_ItemPricelistVersions] ADD  CONSTRAINT [DF__ST_ItemPricelistVersions_Syscreated]  DEFAULT (getdate()) FOR [Syscreated]
GO
