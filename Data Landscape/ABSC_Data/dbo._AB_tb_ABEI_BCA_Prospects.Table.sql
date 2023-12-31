/****** Object:  Table [dbo].[_AB_tb_ABEI_BCA_Prospects]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_ABEI_BCA_Prospects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReqId] [uniqueidentifier] NOT NULL,
	[HID] [int] NOT NULL,
	[BCAID] [int] NULL,
	[cmp_wwn] [uniqueidentifier] NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[seqno] [int] NULL,
	[sysmessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_ABEI_BCA_Prospects] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_BCA_Prospects] ADD  CONSTRAINT [DF__AB_tb_ABEI_BCA_Prospects_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_BCA_Prospects] ADD  CONSTRAINT [DF__AB_tb_ABEI_BCA_Prospects_seqno]  DEFAULT ((0)) FOR [seqno]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_BCA_Prospects] ADD  CONSTRAINT [DF__AB_tb_ABEI_BCA_Prospects_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_BCA_Prospects] ADD  CONSTRAINT [DF__AB_tb_ABEI_BCA_Prospects_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
