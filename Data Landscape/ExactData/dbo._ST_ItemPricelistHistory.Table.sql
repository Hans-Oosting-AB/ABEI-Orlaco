/****** Object:  Table [dbo].[_ST_ItemPricelistHistory]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_ItemPricelistHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Itemcode] [nvarchar](30) COLLATE Latin1_General_CI_AS NOT NULL,
	[PMC] [nvarchar](255) COLLATE Latin1_General_CI_AI NULL,
	[Category1] [nvarchar](255) COLLATE Latin1_General_CI_AI NULL,
	[Category2] [nvarchar](255) COLLATE Latin1_General_CI_AI NULL,
	[OrdCat1] [int] NULL,
	[OrdCat2] [int] NULL,
	[SalesDescription] [nvarchar](255) COLLATE Latin1_General_CI_AI NULL,
	[NL_EUR] [float] NULL,
	[USA_USD] [float] NULL,
	[USA_EUR] [float] NULL,
	[NL_Leadtime] [float] NOT NULL,
	[USA_Leadtime] [float] NOT NULL,
	[DiscountCode] [nvarchar](30) COLLATE Latin1_General_CI_AS NULL,
	[Discount] [nvarchar](60) COLLATE Latin1_General_CI_AS NULL,
	[Number] [int] NOT NULL,
	[Version] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Active] [bit] NOT NULL,
	[ItemModified] [datetime] NULL,
	[ItemModifier] [int] NULL,
	[Syscreated] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_ItemPricelistLogALL] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_ItemPricelistHistory] ADD  CONSTRAINT [DF__ST_ItemPricelistLogALL_Number]  DEFAULT ((0)) FOR [Number]
GO
ALTER TABLE [dbo].[_ST_ItemPricelistHistory] ADD  CONSTRAINT [DF__ST_ItemPricelistHistory_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[_ST_ItemPricelistHistory] ADD  CONSTRAINT [DF__ST_ItemPricelistLogALL_Syscreated]  DEFAULT (getdate()) FOR [Syscreated]
GO
