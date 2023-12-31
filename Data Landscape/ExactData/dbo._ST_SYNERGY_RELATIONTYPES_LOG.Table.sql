/****** Object:  Table [dbo].[_ST_SYNERGY_RELATIONTYPES_LOG]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SYNERGY_RELATIONTYPES_LOG](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[cmp_wwn] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) COLLATE Latin1_General_CI_AS NOT NULL,
	[Relatienaam] [nvarchar](50) COLLATE Latin1_General_CI_AI NULL,
	[Debiteurcode] [nvarchar](20) COLLATE Latin1_General_CI_AS NULL,
	[Status] [varchar](1) COLLATE Latin1_General_CI_AS NOT NULL,
	[TypeCode] [varchar](1) COLLATE Latin1_General_CI_AS NOT NULL,
	[TypeDescription] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NewTypeCode] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NewTypeDescription] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ClassificationId] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaxOrdDat] [datetime] NULL,
	[MaxContactDat] [datetime] NULL,
	[MaxQuotDat] [datetime] NULL,
	[Updated] [datetime] NOT NULL,
	[runid] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK__ST_SYNERGY_RELATIONTYPES_LOG] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
