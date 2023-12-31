/****** Object:  Table [dbo].[_ST_SS_WO_Attachments]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SS_WO_Attachments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WOSurveyId] [int] NULL,
	[WOID] [int] NOT NULL,
	[HID] [int] NOT NULL,
	[File] [varbinary](max) NOT NULL,
	[syscreated] [datetime] NOT NULL,
	[ABEI_status] [int] NOT NULL,
	[SynergyID] [uniqueidentifier] NULL,
 CONSTRAINT [PK__ST_SS_WO_Attachments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_SS_WO_Attachments] ADD  CONSTRAINT [DF__ST_SS_WO_Attachments_ABEI_status]  DEFAULT ((0)) FOR [ABEI_status]
GO
