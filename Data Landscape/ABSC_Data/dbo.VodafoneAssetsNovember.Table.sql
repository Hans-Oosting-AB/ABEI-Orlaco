/****** Object:  Table [dbo].[VodafoneAssetsNovember]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VodafoneAssetsNovember](
	[Asset] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Persoon] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Rekening referentie] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Rekening nr#] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Bedrag in €] [money] NULL,
	[Bedrag] [money] NULL,
	[Bedrag1] [money] NULL,
	[F9] [float] NULL
) ON [PRIMARY]
GO
