/****** Object:  Table [dbo].[_st_undo_vanreenen_receipt]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_st_undo_vanreenen_receipt](
	[ID] [int] NOT NULL,
	[reknr] [char](9) COLLATE Latin1_General_CI_AS NULL,
	[datum] [datetime] NULL,
	[bkstnr] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[dagbknr] [char](10) COLLATE Latin1_General_CI_AS NULL,
	[oms25] [varchar](60) COLLATE Latin1_General_CI_AS NULL,
	[aantal] [float] NOT NULL,
	[dbk_verwnr] [int] NOT NULL,
	[verwerknrl] [int] NOT NULL,
	[artcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[facode] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[faktuurnr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[warehouse] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[type] [smallint] NULL,
	[transtype] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[transsubtype] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[syscreator] [int] NOT NULL,
	[syscreated] [datetime] NOT NULL
) ON [PRIMARY]
GO
