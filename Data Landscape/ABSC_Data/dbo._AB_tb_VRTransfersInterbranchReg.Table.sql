/****** Object:  Table [dbo].[_AB_tb_VRTransfersInterbranchReg]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_VRTransfersInterbranchReg](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IBTDeliveryNr] [int] NOT NULL,
	[Bkstnr] [int] NOT NULL,
	[Itemcode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Itemnumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity] [float] NOT NULL,
	[Description] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TotalPallets] [float] NULL,
	[RegistrationDate] [datetime] NOT NULL,
	[Origin] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Destination] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NOT NULL,
	[errormessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sysmodified] [datetime] NOT NULL,
	[syscreated] [datetime] NOT NULL,
 CONSTRAINT [PK__AB_tb_VRTransfersInterbranchReg] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_VRTransfersInterbranchReg] ADD  CONSTRAINT [DF__AB_tb_VRTransfersInterbranchReg_TotalPallets]  DEFAULT ((1)) FOR [TotalPallets]
GO
ALTER TABLE [dbo].[_AB_tb_VRTransfersInterbranchReg] ADD  CONSTRAINT [DF__AB_tb_VRTransfersInterbranchReg_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_VRTransfersInterbranchReg] ADD  CONSTRAINT [DF__AB_tb_VRTransfersInterbranchReg_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
ALTER TABLE [dbo].[_AB_tb_VRTransfersInterbranchReg] ADD  CONSTRAINT [DF__AB_tb_VRTransfersInterbranchReg_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
