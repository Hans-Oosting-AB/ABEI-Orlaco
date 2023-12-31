/****** Object:  Table [dbo].[_ST_Synergy_Contact_Import]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_Synergy_Contact_Import](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ECMPGuid] [uniqueidentifier] NULL,
	[ECMPCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ECMPName] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EContactId] [uniqueidentifier] NULL,
	[EContactName] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EContactLastname] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EContactEmail] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NOT NULL,
	[Created] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_Synergy_Contact_Import] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_Synergy_Contact_Import] ADD  CONSTRAINT [DF__ST_Synergy_Contact_Import_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[_ST_Synergy_Contact_Import] ADD  CONSTRAINT [DF__ST_Synergy_Contact_Import_Created]  DEFAULT (getdate()) FOR [Created]
GO
