/****** Object:  Table [dbo].[_ST_SRI_Forecast_Year]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SRI_Forecast_Year](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppId] [int] NULL,
	[Year] [int] NULL,
	[syscreated] [datetime] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_SRI_Forecast_Year] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_Year] ADD  CONSTRAINT [DF__ST_SRI_Forecast_Year_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_Year] ADD  CONSTRAINT [DF__ST_SRI_Forecast_Year_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
