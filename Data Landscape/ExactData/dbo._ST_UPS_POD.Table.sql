/****** Object:  Table [dbo].[_ST_UPS_POD]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_UPS_POD](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EOrhkrgId] [int] NOT NULL,
	[EOrderNumber] [int] NOT NULL,
	[EShippingNumber] [int] NOT NULL,
	[EShipmentDate] [datetime] NOT NULL,
	[EDebtor] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EShippingDebtor] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EShippingType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EShippingDescription] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UTracking] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UReference] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UWeight] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UService] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[USendOn] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UDeliverdOn] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[USenderAddress] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UDeliveryAddress] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UNPackages] [int] NULL,
	[UReceivedBy] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ULeftAt] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UNDocuments] [int] NULL,
	[UMessage] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UPSStatus] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UPSChecked] [int] NOT NULL,
	[UPODReady] [int] NOT NULL,
	[UPSPODChecked] [int] NOT NULL,
	[URetry] [int] NOT NULL,
	[syscreated] [datetime] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
	[abei_runid] [uniqueidentifier] NULL,
	[abei_rowstatus] [int] NULL,
	[abei_PODstatus] [int] NOT NULL,
	[abei_PODID] [uniqueidentifier] NULL,
 CONSTRAINT [PK__ST_UPS_POD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_UPS_POD] ADD  CONSTRAINT [DF__ST_UPS_POD_UPSChecked]  DEFAULT ((0)) FOR [UPSChecked]
GO
ALTER TABLE [dbo].[_ST_UPS_POD] ADD  CONSTRAINT [DF__ST_UPS_POD_UPODReady]  DEFAULT ((0)) FOR [UPODReady]
GO
ALTER TABLE [dbo].[_ST_UPS_POD] ADD  CONSTRAINT [DF__ST_UPS_POD_UPSPODChecked]  DEFAULT ((0)) FOR [UPSPODChecked]
GO
ALTER TABLE [dbo].[_ST_UPS_POD] ADD  CONSTRAINT [DF__ST_UPS_POD_URetry]  DEFAULT ((0)) FOR [URetry]
GO
ALTER TABLE [dbo].[_ST_UPS_POD] ADD  CONSTRAINT [DF__ST_UPS_POD_syscreated]  DEFAULT (getdate()) FOR [syscreated]
GO
ALTER TABLE [dbo].[_ST_UPS_POD] ADD  CONSTRAINT [DF__ST_UPS_POD_sysmodified]  DEFAULT (getdate()) FOR [sysmodified]
GO
ALTER TABLE [dbo].[_ST_UPS_POD] ADD  CONSTRAINT [DF__ST_UPS_POD_abei_rowstatus]  DEFAULT ((0)) FOR [abei_rowstatus]
GO
ALTER TABLE [dbo].[_ST_UPS_POD] ADD  CONSTRAINT [DF__ST_UPS_POD_abei_PODstatus]  DEFAULT ((-1)) FOR [abei_PODstatus]
GO
