/****** Object:  Table [dbo].[_AB_tb_Profile_BOM_lines]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_Profile_BOM_lines](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[partid] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[itemcode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[action] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HeaderID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[version] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sequenceno] [int] NULL,
	[position] [char](20) COLLATE Latin1_General_CI_AS NULL,
	[freefield7] [char](75) COLLATE Latin1_General_CI_AS NULL,
	[itemprod] [char](30) COLLATE Latin1_General_CI_AS NULL,
	[linetype] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[itemreq] [char](30) COLLATE Latin1_General_CI_AS NULL,
	[variant] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[backflush] [bit] NULL,
	[quantity] [float] NULL,
	[FromDay] [int] NULL,
	[ToDay] [int] NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[seqno] [int] NULL,
	[retrycount] [int] NULL,
	[sysmessage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
	[isUpdate] [bit] NULL,
	[possort] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK__AB_tb_Profile_BOM_lines] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_lines] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_lines_backflush]  DEFAULT ((0)) FOR [backflush]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_lines] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_lines_quantity]  DEFAULT ((0.0)) FOR [quantity]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_lines] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_lines_FromDay]  DEFAULT ((1)) FOR [FromDay]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_lines] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_lines_ToDay]  DEFAULT ((1)) FOR [ToDay]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_lines] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_lines_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_lines] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_lines_seqno]  DEFAULT ((0)) FOR [seqno]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_lines] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_lines_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_lines] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_lines_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_lines] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_lines_isUpdate]  DEFAULT ((1)) FOR [isUpdate]
GO
