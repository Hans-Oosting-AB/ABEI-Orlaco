/****** Object:  Table [dbo].[_AB_tb_VRTransfersAbsenceIdReg]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_VRTransfersAbsenceIdReg](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[absenceid] [uniqueidentifier] NULL,
	[HID] [int] NULL,
	[absencetype] [int] NULL,
	[usercode] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[registrationdate] [datetime] NULL,
	[prevregistrationdate] [datetime] NULL,
	[TotalPallets] [float] NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[errormessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sysmodified] [datetime] NULL,
	[syscreated] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_VRTransfersAbsenceIdReg] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_VRTransfersAbsenceIdReg] ADD  CONSTRAINT [DF__AB_tb_VRTransfersAbsenceIdReg_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_VRTransfersAbsenceIdReg] ADD  CONSTRAINT [DF__AB_tb_VRTransfersAbsenceIdReg_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
ALTER TABLE [dbo].[_AB_tb_VRTransfersAbsenceIdReg] ADD  CONSTRAINT [DF__AB_tb_VRTransfersAbsenceIdReg_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
