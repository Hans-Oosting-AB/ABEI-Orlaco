/****** Object:  Table [dbo].[_AB_tb_Backup_MainContact]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_Backup_MainContact](
	[cnt_id] [uniqueidentifier] NOT NULL,
	[cmp_wwn] [uniqueidentifier] NOT NULL,
	[MainContact] [int] NOT NULL,
	[datemodified] [datetime] NOT NULL
) ON [PRIMARY]
GO
