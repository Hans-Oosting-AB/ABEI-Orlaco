/****** Object:  Table [dbo].[_AB_tb_AIBLPP_backup_20200128]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_AIBLPP_backup_20200128](
	[items_itemcode] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[items_description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[cicmpy_cmp_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[cicmpy_cmp_code] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[itemaccounts_purchaseprice] [float] NULL,
	[rowstatus] [int] NULL
) ON [PRIMARY]
GO
