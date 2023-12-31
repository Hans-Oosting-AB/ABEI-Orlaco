/****** Object:  Table [dbo].[400_stfoms_backup_20211020]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[400_stfoms_backup_20211020](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[prijslijst] [char](15) COLLATE Latin1_General_CI_AS NULL,
	[oms30_0] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[oms30_1] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[oms30_2] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[oms30_3] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[oms30_4] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[valcode] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[country] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[type] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[AccountType] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[AccountStatus] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[AccountClassificationId] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[main_pricelist] [tinyint] NOT NULL,
	[syscreated] [datetime] NOT NULL,
	[syscreator] [int] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
	[sysmodifier] [int] NOT NULL,
	[sysguid] [uniqueidentifier] NOT NULL,
	[timestamp] [timestamp] NOT NULL,
	[Division] [smallint] NULL
) ON [PRIMARY]
GO
