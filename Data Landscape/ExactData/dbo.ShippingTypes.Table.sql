/****** Object:  Table [dbo].[ShippingTypes]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[levwijze] [char](5) COLLATE Latin1_General_CI_AS NULL,
	[oms40_0] [varchar](40) COLLATE Latin1_General_CI_AS NULL,
	[oms40_1] [varchar](40) COLLATE Latin1_General_CI_AS NULL,
	[oms40_2] [varchar](40) COLLATE Latin1_General_CI_AS NULL,
	[oms40_3] [varchar](40) COLLATE Latin1_General_CI_AS NULL,
	[oms40_4] [varchar](40) COLLATE Latin1_General_CI_AS NULL,
	[shipping] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[direct_shipping] [tinyint] NOT NULL,
	[syscreated] [datetime] NOT NULL,
	[syscreator] [int] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
	[sysmodifier] [int] NOT NULL,
	[sysguid] [uniqueidentifier] NOT NULL,
	[timestamp] [timestamp] NOT NULL,
	[Division] [smallint] NULL,
	[UseShippingManifest] [tinyint] NOT NULL,
	[DeliveryOnSaturday] [bit] NOT NULL,
	[DeliveryOnSunday] [bit] NOT NULL,
	[DeliveryOnPublicHolidays] [bit] NOT NULL,
	[IsUPSShipment] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ShippingTypes] ADD  CONSTRAINT [DF_ShippingTypes_IsUPSShipment]  DEFAULT ((0)) FOR [IsUPSShipment]
GO
