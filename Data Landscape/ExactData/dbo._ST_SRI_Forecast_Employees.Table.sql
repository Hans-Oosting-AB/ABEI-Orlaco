/****** Object:  Table [dbo].[_ST_SRI_Forecast_Employees]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SRI_Forecast_Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppId] [int] NULL,
	[res_id] [int] NULL,
	[FullName] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UserName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ManagerResId] [int] NULL,
	[ManagerAppId] [int] NULL,
	[StatusId] [int] NULL,
	[Division] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_SRI_Forecast_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_Employees] ADD  CONSTRAINT [DF__ST_SRI_Forecast_Employees_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_Employees] ADD  CONSTRAINT [DF__ST_SRI_Forecast_Employees_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
