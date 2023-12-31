/****** Object:  Table [dbo].[_AB_tb_VRTransferInterBranchGroupRows]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_AB_tb_VRTransferInterBranchGroupRows](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[bkstnr] [int] NULL,
	[ibtdeliverynr] [int] NULL,
	[oms25] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[syscreated] [datetime] NOT NULL,
	[runid] [uniqueidentifier] NULL,
 CONSTRAINT [PK__AB_tb_VRTransferInterBranchGroupRow] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_AB_tb_VRTransferInterBranchGroupRows] ADD  CONSTRAINT [DF__AB_tb_VRTransferInterBranchGroupRow_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
