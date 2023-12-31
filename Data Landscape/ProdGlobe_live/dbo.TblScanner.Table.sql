/****** Object:  Table [dbo].[TblScanner]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblScanner](
	[ScanId] [int] IDENTITY(1,1) NOT NULL,
	[ScanCode] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Direction] [int] NULL,
	[ScanDate] [datetime] NULL,
 CONSTRAINT [PK_TblScanner] PRIMARY KEY CLUSTERED 
(
	[ScanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
