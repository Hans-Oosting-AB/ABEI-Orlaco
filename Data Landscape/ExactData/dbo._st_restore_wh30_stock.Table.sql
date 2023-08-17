/****** Object:  Table [dbo].[_st_restore_wh30_stock]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_st_restore_wh30_stock](
	[bkstnr] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[artcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[warehouse] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[facode] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[aantal] [float] NULL
) ON [PRIMARY]
GO
