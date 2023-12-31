/****** Object:  Table [dbo].[_ST_ItemPricelistLog]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_ItemPricelistLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Itemcode] [nvarchar](30) COLLATE Latin1_General_CI_AS NOT NULL,
	[Field] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OldValue] [nvarchar](255) COLLATE Latin1_General_CI_AI NULL,
	[NewValue] [nvarchar](255) COLLATE Latin1_General_CI_AI NULL,
	[Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Version] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemModified] [datetime] NULL,
	[ItemModifier] [int] NULL,
	[Syscreated] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_ItemPricelistLogFields] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_ItemPricelistLog] ADD  CONSTRAINT [DF__ST_ItemPricelistLogFields_Syscreated]  DEFAULT (getdate()) FOR [Syscreated]
GO
