/****** Object:  Table [dbo].[_ST_IC_BCAs]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_IC_BCAs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CID] [int] NOT NULL,
	[Email] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CDate] [datetime] NOT NULL,
	[CompanyName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyCountry] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyPhone] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyAddress] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyCity] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyState] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyZipCode] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyWebsite] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyVATNo] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyCRNo] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyBusinessType] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyTradeRegister] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyDUNSNo] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyLegalForm] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[APContactName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[APContactPhone] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[APContactEmail] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[APContactDepartment] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingAddress] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingCity] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingEmail] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingState] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingZipCode] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryAddress] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryCity] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryTermsNote] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryTransport] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingEmail] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingState] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingCountry] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingZipCode] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BuyersName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BuyersFirstName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BuyersTitle] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BuyersPhone] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BuyersMobilePhone] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BuyersEmail] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignatureName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignatureTitle] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignatureDate] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrlacoContactPerson] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Updated] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateChanged] [datetime] NOT NULL,
	[RunId] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HID] [int] NULL,
	[Attachment] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK__ST_IC_BCAs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_IC_BCAs] ADD  CONSTRAINT [DF__ST_IC_BCAs_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[_ST_IC_BCAs] ADD  CONSTRAINT [DF__ST_IC_BCAs_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[_ST_IC_BCAs] ADD  CONSTRAINT [DF__ST_IC_BCAs_DateChanged]  DEFAULT (getdate()) FOR [DateChanged]
GO
ALTER TABLE [dbo].[_ST_IC_BCAs] ADD  CONSTRAINT [DF__ST_IC_BCAs_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
