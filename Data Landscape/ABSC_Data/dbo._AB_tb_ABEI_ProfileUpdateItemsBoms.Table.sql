/****** Object:  Table [dbo].[_AB_tb_ABEI_ProfileUpdateItemsBoms]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_ABEI_ProfileUpdateItemsBoms](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[partid] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[itemcode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[rowmessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[retrycounter] [int] NULL,
	[sysmodified] [datetime] NULL,
	[syscreated] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_ABEI_ProfileUpdateItemsBoms] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_ProfileUpdateItemsBoms] ADD  CONSTRAINT [DF__AB_tb_ABEI_ProfileUpdateItemsBoms_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_ProfileUpdateItemsBoms] ADD  CONSTRAINT [DF__AB_tb_ABEI_ProfileUpdateItemsBoms_retrycounter]  DEFAULT ((0)) FOR [retrycounter]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_ProfileUpdateItemsBoms] ADD  CONSTRAINT [DF__AB_tb_ABEI_ProfileUpdateItemsBoms_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_ProfileUpdateItemsBoms] ADD  CONSTRAINT [DF__AB_tb_ABEI_ProfileUpdateItemsBoms_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
