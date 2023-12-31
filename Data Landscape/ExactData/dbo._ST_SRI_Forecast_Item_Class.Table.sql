/****** Object:  Table [dbo].[_ST_SRI_Forecast_Item_Class]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SRI_Forecast_Item_Class](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppId] [int] NULL,
	[ProfileID] [int] NULL,
	[Itemcode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Itemnumber] [int] NULL,
	[Description] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StatusId] [int] NULL,
	[Price] [float] NULL,
	[Portfolio] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Productgroup] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LineFamily] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Variant] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ClassId1] [int] NULL,
	[ClassId2] [int] NULL,
	[ClassId3] [int] NULL,
	[ClassId4] [int] NULL,
	[ClassId5] [int] NULL,
	[syscreated] [datetime] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_SRI_Forecast_Item_Class_copy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_Item_Class] ADD  CONSTRAINT [DF__ST_SRI_Forecast_Item_Class_copy_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_ST_SRI_Forecast_Item_Class] ADD  CONSTRAINT [DF__ST_SRI_Forecast_Item_Class_copy_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
