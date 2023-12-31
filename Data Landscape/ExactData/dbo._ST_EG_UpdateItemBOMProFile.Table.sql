/****** Object:  Table [dbo].[_ST_EG_UpdateItemBOMProFile]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_EG_UpdateItemBOMProFile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Partid] [int] NOT NULL,
	[Itemcode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[State] [int] NOT NULL,
	[RunID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_EG_UpdateItemBOMProFile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_EG_UpdateItemBOMProFile] ADD  CONSTRAINT [DF__ST_EG_UpdateItemBOMProFile_State]  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[_ST_EG_UpdateItemBOMProFile] ADD  CONSTRAINT [DF__ST_EG_UpdateItemBOMProFile_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[_ST_EG_UpdateItemBOMProFile] ADD  CONSTRAINT [DF__ST_EG_UpdateItemBOMProFile_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
