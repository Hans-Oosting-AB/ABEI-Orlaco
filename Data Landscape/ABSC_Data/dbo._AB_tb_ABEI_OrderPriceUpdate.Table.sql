/****** Object:  Table [dbo].[_AB_tb_ABEI_OrderPriceUpdate]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_ABEI_OrderPriceUpdate](
	[tID] [int] IDENTITY(1,1) NOT NULL,
	[db] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ord_soort] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[ordernr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[ID] [int] NOT NULL,
	[regel] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[artcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[oms45] [varchar](60) COLLATE Latin1_General_CI_AS NULL,
	[esr_aantal] [float] NULL,
	[prijslijst] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[prijs_n_old] [float] NULL,
	[prijs83_old] [float] NULL,
	[korting_old] [float] NULL,
	[bdr_ev_ed_val] [float] NULL,
	[bdr_d_ev_val] [float] NULL,
	[bdr_vat_val] [float] NULL,
	[bdr_inv_d_val] [float] NULL,
	[bdr_val] [float] NULL,
	[prijs83] [float] NULL,
	[prijs_n] [float] NULL,
	[fiattering] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[ordbv_afdr] [bit] NULL,
	[ordbv_afgd] [bit] NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[seqno] [int] NULL,
	[sysmessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
	[reverted] [bit] NULL,
	[debnr] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fakdebnr] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ord_contactemail] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[inv_contactemail] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[emailsent] [int] NOT NULL,
	[accmanmail] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[old_represent_id] [int] NULL,
	[represent_id] [int] NULL,
	[tcreated] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_ABEI_OrderPriceUpdate] PRIMARY KEY CLUSTERED 
(
	[tID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_OrderPriceUpdate] ADD  CONSTRAINT [DF__AB_tb_ABEI_OrderPriceUpdate_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_OrderPriceUpdate] ADD  CONSTRAINT [DF__AB_tb_ABEI_OrderPriceUpdate_seqno]  DEFAULT ((0)) FOR [seqno]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_OrderPriceUpdate] ADD  CONSTRAINT [DF__AB_tb_ABEI_OrderPriceUpdate_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_OrderPriceUpdate] ADD  CONSTRAINT [DF__AB_tb_ABEI_OrderPriceUpdate_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_OrderPriceUpdate] ADD  CONSTRAINT [DF__AB_tb_ABEI_OrderPriceUpdate_reverted]  DEFAULT ((0)) FOR [reverted]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_OrderPriceUpdate] ADD  CONSTRAINT [DF__AB_tb_ABEI_OrderPriceUpdate_emailsent]  DEFAULT ((0)) FOR [emailsent]
GO
ALTER TABLE [dbo].[_AB_tb_ABEI_OrderPriceUpdate] ADD  CONSTRAINT [DF__AB_tb_ABEI_OrderPriceUpdate_tcreated]  DEFAULT (getdate()) FOR [tcreated]
GO
