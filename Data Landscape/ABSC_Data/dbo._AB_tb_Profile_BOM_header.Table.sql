/****** Object:  Table [dbo].[_AB_tb_Profile_BOM_header]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_Profile_BOM_header](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[partid] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[itemcode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[action] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HeaderID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[itemprod] [char](30) COLLATE Latin1_General_CI_AS NULL,
	[description] [char](30) COLLATE Latin1_General_CI_AS NULL,
	[MainVersion] [bit] NULL,
	[version] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[eff_date] [datetime] NULL,
	[quantity] [float] NULL,
	[drawingno] [char](25) COLLATE Latin1_General_CI_AS NULL,
	[pos_no] [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[seqno] [int] NULL,
	[retrycount] [int] NULL,
	[sysmessage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
	[isUpdate] [bit] NULL,
 CONSTRAINT [PK__AB_tb_Profile_BOM_header] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_header] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_header_quantity]  DEFAULT ((0.0)) FOR [quantity]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_header] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_header_pos_no]  DEFAULT ((1)) FOR [pos_no]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_header] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_header_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_header] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_header_seqno]  DEFAULT ((0)) FOR [seqno]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_header] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_header_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_header] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_header_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
ALTER TABLE [dbo].[_AB_tb_Profile_BOM_header] ADD  CONSTRAINT [DF__AB_tb_Profile_BOM_header_isUpdate]  DEFAULT ((1)) FOR [isUpdate]
GO
