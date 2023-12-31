/****** Object:  Table [dbo].[_AB_tb_VRExportDocuments]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_VRExportDocuments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[absenceid] [uniqueidentifier] NULL,
	[ordernr] [int] NULL,
	[FileName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FileContent] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FileType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Syscreated] [datetime] NULL,
	[Runid] [uniqueidentifier] NULL,
 CONSTRAINT [PK__AB_tb_VRExportDocuments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
