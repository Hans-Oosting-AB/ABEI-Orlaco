/****** Object:  Table [dbo].[_AB_tb_TransfersAbsenceIdReg]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_TransfersAbsenceIdReg](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[absenceid] [uniqueidentifier] NULL,
	[HID] [int] NULL,
	[absencetype] [int] NULL,
	[usercode] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[registrationdate] [datetime] NULL,
	[prevregistrationdate] [datetime] NULL,
	[crdnr] [char](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[marked_for_delivery] [bit] NULL,
	[mfd_date] [datetime] NULL,
	[marked_for_receipt] [bit] NULL,
	[mfr_date] [datetime] NULL,
	[runid] [uniqueidentifier] NULL,
	[rowstatus] [int] NULL,
	[errormessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sysmodified] [datetime] NULL,
	[syscreated] [datetime] NULL,
 CONSTRAINT [PK__AB_tb_TransfersAbsenceIdReg] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersAbsenceIdReg] ADD  CONSTRAINT [DF__AB_tb_TransfersAbsenceIdReg_marked_for_delivery]  DEFAULT ((0)) FOR [marked_for_delivery]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersAbsenceIdReg] ADD  CONSTRAINT [DF__AB_tb_TransfersAbsenceIdReg_marked_for_receipt]  DEFAULT ((0)) FOR [marked_for_receipt]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersAbsenceIdReg] ADD  CONSTRAINT [DF__AB_tb_TransfersAbsenceIdReg_rowstatus]  DEFAULT ((0)) FOR [rowstatus]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersAbsenceIdReg] ADD  CONSTRAINT [DF__AB_tb_TransfersAbsenceIdReg_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
ALTER TABLE [dbo].[_AB_tb_TransfersAbsenceIdReg] ADD  CONSTRAINT [DF__AB_tb_TransfersAbsenceIdReg_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
