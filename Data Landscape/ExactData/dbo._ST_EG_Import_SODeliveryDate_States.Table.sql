/****** Object:  Table [dbo].[_ST_EG_Import_SODeliveryDate_States]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_EG_Import_SODeliveryDate_States](
	[Import_id] [int] NOT NULL,
	[new_state] [int] NOT NULL,
	[new_message] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[old_planneddate] [datetime] NULL,
	[syscreated] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
