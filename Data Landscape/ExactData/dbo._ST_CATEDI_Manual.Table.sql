/****** Object:  Table [dbo].[_ST_CATEDI_Manual]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_CATEDI_Manual](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NOT NULL,
	[Invoice] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InvoiceDate] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Currency] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingNote] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipmentDate] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderNr] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sender] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Receiver] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FacilityCode] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipToName] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipToCode] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipToAddress] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipToCity] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipToZipcode] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipToCountry] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipFromName] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipFromCode] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipFromAddress] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipFromCity] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipFromZipcode] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipFromCountry] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PONumber] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[POCallId] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OurItemCode] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerItemCode] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ECLevel] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemDescription] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemPieces] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CountryOfOrigin] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemPrice] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TotalPrice] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Colli] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ColloType] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ColloPieces] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderReference] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderDescription] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderDebtor] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InvoiceDebtor] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryDebtor] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TotalWeight] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FileData] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FileName] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TimeStamp] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Syscreator] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Syscreated] [datetime] NOT NULL,
 CONSTRAINT [PK__ST_CATEDI_Manual] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_CATEDI_Manual] ADD  CONSTRAINT [DF__ST_CATEDI_Manual_Syscreated]  DEFAULT (getdate()) FOR [Syscreated]
GO
