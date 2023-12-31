/****** Object:  Table [dbo].[_ST_Restore_ITRequestAttachments]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_Restore_ITRequestAttachments](
	[ID] [uniqueidentifier] NOT NULL,
	[Entity] [uniqueidentifier] NOT NULL,
	[EntityType] [int] NOT NULL,
	[Attachment] [varbinary](max) NOT NULL,
	[AttachmentFileName] [nvarchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
	[AttachmentFileExtension] [nvarchar](20) COLLATE Latin1_General_CI_AS NULL,
	[AttachmentSize] [int] NULL,
	[AttachmentType] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
