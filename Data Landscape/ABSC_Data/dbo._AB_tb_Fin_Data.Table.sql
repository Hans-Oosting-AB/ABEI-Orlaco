/****** Object:  Table [dbo].[_AB_tb_Fin_Data]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_Fin_Data](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[targetDB] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[referencekey] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HeaderID] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fType] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fLinenr] [int] NULL,
	[gID] [int] NULL,
	[afldat] [datetime] NULL,
	[bedrag] [float] NULL,
	[bkstnr] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[crdnr] [char](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[dagbknr] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[debnr] [char](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[datum] [datetime] NULL,
	[docdate] [datetime] NULL,
	[docnumber] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[faktuurnr] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[freefield1] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[freefield2] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[freefield3] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[numberfield1] [float] NULL,
	[numberfield2] [float] NULL,
	[kstplcode] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[kstdrcode] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[oms25] [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[project] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[res_id] [int] NULL,
	[selcode] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[valcode] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[aantal] [float] NULL,
	[artcode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[btw_code] [char](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[facode] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[reknr] [char](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[transtype] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[transsubtype] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vatamount] [float] NULL,
	[unitcode] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[warehouse] [char](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[warehouse_location] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[seqno] [int] NULL,
	[retryCounter] [int] NULL,
	[targetoverride] [int] NULL,
	[mailto] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sysmessage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NULL,
	[sysmodified] [datetime] NULL,
	[HeaderDescription] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_dbo._AB_tb_Fin_Data] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_Fin_Data] ADD  CONSTRAINT [DF__AB_tb_Fin_Data_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_Fin_Data] ADD  CONSTRAINT [DF__AB_tb_Fin_Data_retryCounter]  DEFAULT ((0)) FOR [retryCounter]
GO
ALTER TABLE [dbo].[_AB_tb_Fin_Data] ADD  CONSTRAINT [DF__AB_tb_Fin_Data_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_AB_tb_Fin_Data] ADD  CONSTRAINT [DF__AB_tb_Fin_Data_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
