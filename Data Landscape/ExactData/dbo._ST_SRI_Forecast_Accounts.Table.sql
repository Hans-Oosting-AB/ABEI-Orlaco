/****** Object:  Table [dbo].[_ST_SRI_Forecast_Accounts]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SRI_Forecast_Accounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppId] [int] NULL,
	[Accountcode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AccountNr] [int] NULL,
	[AccountName] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PMC] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Country] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Pricelist] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PricelistAppId] [int] NULL,
	[Status] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StatusId] [int] NULL,
	[EmployeeResId] [int] NULL,
	[EmployeeAppId] [int] NULL,
	[Division] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_SRI_Forecast_Accounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_Accounts] ADD  CONSTRAINT [DF__ST_SRI_Forecast_Accounts_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_Accounts] ADD  CONSTRAINT [DF__ST_SRI_Forecast_Accounts_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
