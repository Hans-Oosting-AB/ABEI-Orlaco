/****** Object:  Table [dbo].[_ST_ExcludeFromPricelist22]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_ExcludeFromPricelist22](
	[Division] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[cmp_code] [char](20) COLLATE Latin1_General_CI_AS NULL,
	[debnr] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[cmp_wwn] [uniqueidentifier] NOT NULL,
	[cmp_name] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[cmp_type] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[cmp_status] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[pricelist] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[basedon] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
