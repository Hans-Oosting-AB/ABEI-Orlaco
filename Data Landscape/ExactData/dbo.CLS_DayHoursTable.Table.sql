/****** Object:  Table [dbo].[CLS_DayHoursTable]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLS_DayHoursTable](
	[PKDate] [datetime] NOT NULL,
	[calendar_year] [smallint] NULL,
	[calendar_quarter] [tinyint] NULL,
	[calendar_quarter_desc] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[calendar_month] [tinyint] NULL,
	[calendar_month_name_long] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[calendar_month_name_short] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[calendar_week_in_year] [tinyint] NULL,
	[calendar_week_in_month] [tinyint] NULL,
	[calendar_day_in_year] [smallint] NULL,
	[calendar_day_in_week] [tinyint] NULL,
	[calendar_day_in_month] [tinyint] NULL,
	[mdy_name_long] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mdy_name_long_with_suffix] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[day_name_long] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[day_name_short] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[continuous_year] [tinyint] NULL,
	[continuous_quarter] [smallint] NULL,
	[continuous_month] [smallint] NULL,
	[continuous_week] [smallint] NULL,
	[continuous_day] [int] NULL,
	[description] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[is_weekend] [tinyint] NULL,
	[is_holiday] [tinyint] NULL,
	[is_workday] [tinyint] NULL,
	[is_event] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[PKDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
