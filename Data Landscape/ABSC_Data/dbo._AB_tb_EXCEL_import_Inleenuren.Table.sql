/****** Object:  Table [dbo].[_AB_tb_EXCEL_import_Inleenuren]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_EXCEL_import_Inleenuren](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RegDate] [datetime] NULL,
	[Name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Amount] [float] NULL,
	[Costcenter] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Reknr] [varchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SaveGuid] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[runid] [uniqueidentifier] NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_EXCEL_import_Inleenuren] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_EXCEL_import_Inleenuren] ADD  CONSTRAINT [DF__AB_tb_EXCEL_import_Inleenuren_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_EXCEL_import_Inleenuren] ADD  CONSTRAINT [DF__AB_tb_EXCEL_import_Inleenuren_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
