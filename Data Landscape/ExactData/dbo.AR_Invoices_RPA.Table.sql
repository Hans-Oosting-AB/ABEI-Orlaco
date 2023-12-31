/****** Object:  Table [dbo].[AR_Invoices_RPA]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AR_Invoices_RPA](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Invoice_code] [int] NULL,
	[OrderNr] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Deliverydate] [date] NULL,
	[Status] [int] NOT NULL,
	[Syscreated] [datetime] NOT NULL,
	[Sysmodified] [datetime] NOT NULL,
	[Attachment] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Result] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[AR_Invoices_RPA] ADD  CONSTRAINT [DF_AR_Invoices_RPA_Status_3]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[AR_Invoices_RPA] ADD  CONSTRAINT [DF_AR_Invoices_RPA_Syscreated_3]  DEFAULT (getdate()) FOR [Syscreated]
GO
ALTER TABLE [dbo].[AR_Invoices_RPA] ADD  CONSTRAINT [DF_AR_Invoices_RPA_Sysmodified_3]  DEFAULT (getdate()) FOR [Sysmodified]
GO
