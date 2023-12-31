/****** Object:  Table [dbo].[_AB_tb_EXCEL_import_Mobile]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_EXCEL_import_Mobile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[bkstnr] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[Asset] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Persoon] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RekeningReferentie] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RekeningNr] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Bedrag] [float] NULL,
	[ProjectNr] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[kstplcode] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SaveGuid] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[runid] [uniqueidentifier] NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_EXCEL_import_Mobile] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_EXCEL_import_Mobile] ADD  CONSTRAINT [DF__AB_tb_EXCEL_import_Mobile_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_EXCEL_import_Mobile] ADD  CONSTRAINT [DF__AB_tb_EXCEL_import_Mobile_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
