/****** Object:  Table [dbo].[_ST_SRI_Forecast_PricelistRow]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SRI_Forecast_PricelistRow](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppId] [int] NULL,
	[PricelistName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PricelistAppId] [int] NULL,
	[Itemcode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemAppId] [int] NULL,
	[GrossPrice] [float] NULL,
	[DiscountType] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[Discount] [float] NULL,
	[Price] [float] NULL,
	[Division] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_SRI_Forecast_PricelistRow] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_PricelistRow] ADD  CONSTRAINT [DF__ST_SRI_Forecast_PricelistRow_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_PricelistRow] ADD  CONSTRAINT [DF__ST_SRI_Forecast_PricelistRow_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
