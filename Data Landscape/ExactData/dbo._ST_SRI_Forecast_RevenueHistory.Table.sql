/****** Object:  Table [dbo].[_ST_SRI_Forecast_RevenueHistory]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SRI_Forecast_RevenueHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppId] [int] NULL,
	[Debnr] [nchar](6) COLLATE Latin1_General_CI_AS NULL,
	[AccountAppId] [int] NULL,
	[FcYear] [int] NULL,
	[YearAppId] [int] NULL,
	[Quantity] [float] NULL,
	[Price] [float] NULL,
	[Amount] [float] NULL,
	[EmployeeResId] [int] NULL,
	[EmployeeAppId] [int] NULL,
	[Itemcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[ItemAppId] [int] NULL,
	[Division] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_SRI_Forecast_RevenueHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_RevenueHistory] ADD  CONSTRAINT [DF__ST_SRI_Forecast_RevenueHistory_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_RevenueHistory] ADD  CONSTRAINT [DF__ST_SRI_Forecast_RevenueHistory_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
