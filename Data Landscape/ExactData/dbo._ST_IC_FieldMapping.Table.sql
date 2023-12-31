/****** Object:  Table [dbo].[_ST_IC_FieldMapping]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_IC_FieldMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IConnectListId] [int] NULL,
	[IConneqtListName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AdditionalField] [bit] NULL,
	[IConneqtFieldId] [int] NULL,
	[IConneqtFieldName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrlacoDBTable] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrlacoDBField] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrlacoDataType] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SynergyTable] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SynergyRequestType] [int] NULL,
	[SynergyField] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK__ST_IC_FieldMapping] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
