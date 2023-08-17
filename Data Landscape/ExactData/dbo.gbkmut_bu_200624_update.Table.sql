/****** Object:  Table [dbo].[gbkmut_bu_200624_update]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gbkmut_bu_200624_update](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[bkjrcode] [smallint] NULL,
	[reknr] [char](9) COLLATE Latin1_General_CI_AS NULL,
	[datum] [datetime] NULL,
	[periode] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[bkstnr] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[dagbknr] [char](10) COLLATE Latin1_General_CI_AS NULL,
	[oms25] [varchar](60) COLLATE Latin1_General_CI_AS NULL,
	[bdr_hfl] [float] NOT NULL,
	[btw_code] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[btw_bdr_3] [float] NOT NULL,
	[btw_grond] [float] NOT NULL,
	[tegreknr] [char](9) COLLATE Latin1_General_CI_AS NULL,
	[debnr] [char](12) COLLATE Latin1_General_CI_AS NULL,
	[crdnr] [char](12) COLLATE Latin1_General_CI_AS NULL,
	[kstplcode] [char](10) COLLATE Latin1_General_CI_AS NULL,
	[kstdrcode] [char](10) COLLATE Latin1_General_CI_AS NULL,
	[aantal] [float] NOT NULL,
	[valcode] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[exvalcode] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[koers] [float] NOT NULL,
	[wisselkrs] [float] NOT NULL,
	[koers3] [float] NOT NULL,
	[bdr_val] [float] NOT NULL,
	[dbk_verwnr] [int] NOT NULL,
	[verwerknrl] [int] NOT NULL,
	[volgnr5] [char](5) COLLATE Latin1_General_CI_AS NULL,
	[regel] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[regelcode] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[storno] [tinyint] NOT NULL,
	[bkstnr_sub] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[betcond] [char](2) COLLATE Latin1_General_CI_AS NULL,
	[btwper] [float] NOT NULL,
	[oorsprong] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[vlgn_gbk2] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[btw_grval] [float] NOT NULL,
	[afldat] [datetime] NULL,
	[docnumber] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[docdate] [datetime] NULL,
	[exvalbdr] [float] NOT NULL,
	[entryorigin] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[vervdatkrd] [datetime] NULL,
	[vervdtkrd2] [datetime] NULL,
	[vervdatfak] [datetime] NULL,
	[kredbep] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[bdrkredbep] [float] NOT NULL,
	[bdrkredbp2] [float] NOT NULL,
	[betaalref] [varchar](35) COLLATE Latin1_General_CI_AS NULL,
	[stat_nr] [smallint] NOT NULL,
	[btw_nummer] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[rapnr] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[raplist] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[artcode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[faktuurnr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[bud_vers] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[syscreated] [datetime] NOT NULL,
	[syscreator] [int] NOT NULL,
	[ReminderCount] [int] NOT NULL,
	[sysmodified] [datetime] NOT NULL,
	[ReminderLayout] [int] NOT NULL,
	[LastReminderDate] [datetime] NULL,
	[sysmodifier] [int] NOT NULL,
	[sysguid] [uniqueidentifier] NOT NULL,
	[BlockItem] [tinyint] NOT NULL,
	[timestamp] [timestamp] NOT NULL,
	[CompanyCode] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[res_id] [int] NOT NULL,
	[TransactionType] [int] NOT NULL,
	[CurrencyCode] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[Rate] [float] NOT NULL,
	[bankacc] [varchar](34) COLLATE Latin1_General_CI_AS NULL,
	[AmountCentral] [float] NOT NULL,
	[VatBaseAmountCentral] [float] NOT NULL,
	[PaymentMethod] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[VatAmountCentral] [float] NOT NULL,
	[CurrencyAliasAc] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[DocumentID] [uniqueidentifier] NULL,
	[facode] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[transtype] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[transsubtype] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[freefield1] [varchar](75) COLLATE Latin1_General_CI_AS NULL,
	[freefield2] [varchar](75) COLLATE Latin1_General_CI_AS NULL,
	[freefield3] [varchar](75) COLLATE Latin1_General_CI_AS NULL,
	[freefield4] [float] NULL,
	[freefield5] [float] NULL,
	[project] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[DocAttachmentID] [uniqueidentifier] NULL,
	[cmp_wwn] [uniqueidentifier] NULL,
	[warehouse] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[orderdebtor] [uniqueidentifier] NULL,
	[PayrollSubtype] [char](4) COLLATE Latin1_General_CI_AS NULL,
	[ReconcileNumber] [int] NULL,
	[warehouse_location] [char](10) COLLATE Latin1_General_CI_AS NULL,
	[EntryGuid] [uniqueidentifier] NULL,
	[TransactionGuid] [uniqueidentifier] NULL,
	[TransactionGuid2] [uniqueidentifier] NULL,
	[Checked] [tinyint] NOT NULL,
	[Reviewed] [tinyint] NOT NULL,
	[BankTransactionGUID] [uniqueidentifier] NULL,
	[StockTrackingNumber] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[ReportingDate] [datetime] NULL,
	[CashRegisterAccount] [varchar](34) COLLATE Latin1_General_CI_AS NULL,
	[Original_Quantity] [float] NULL,
	[comp_code] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[Selcode] [char](2) COLLATE Latin1_General_CI_AS NULL,
	[Unitcode] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[Pricelist] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[Discount] [float] NULL,
	[Shipment] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[IntTransportMethod] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[IntPort] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[IntSystem] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[IntTransA] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[IntStatNr] [varchar](9) COLLATE Latin1_General_CI_AS NULL,
	[IntStandardCode] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[IntTransShipment] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[IntTransB] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[IntArea] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[IntLandISO] [varchar](3) COLLATE Latin1_General_CI_AS NULL,
	[IntLandDestOrig] [varchar](3) COLLATE Latin1_General_CI_AS NULL,
	[IntDeliveryMethod] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[IntStatUnit] [float] NULL,
	[IntWeight] [float] NULL,
	[IntComplete] [tinyint] NULL,
	[LinkedLine] [uniqueidentifier] NULL,
	[PayrollCosts] [tinyint] NULL,
	[TaxCode2] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[TaxCode3] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[TaxCode4] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[TaxCode5] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[TaxBasis2] [float] NOT NULL,
	[TaxBasis3] [float] NOT NULL,
	[TaxBasis4] [float] NOT NULL,
	[TaxBasis5] [float] NOT NULL,
	[TaxAmount2] [float] NOT NULL,
	[TaxAmount3] [float] NOT NULL,
	[TaxAmount4] [float] NOT NULL,
	[TaxAmount5] [float] NOT NULL,
	[StatisticalFactor] [float] NULL,
	[IntLandAssembly] [varchar](3) COLLATE Latin1_General_CI_AS NULL,
	[backflush] [tinyint] NULL,
	[LastReminderLayout] [varchar](8) COLLATE Latin1_General_CI_AS NULL,
	[Correction] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[IBTDeliveryNr] [varchar](8) COLLATE Latin1_General_CI_AS NULL,
	[Routing] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[Step] [int] NULL,
	[Reasoncode] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[TransactionNumber] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[Division] [smallint] NULL,
	[Type] [smallint] NULL,
	[Status] [tinyint] NULL,
	[UniqueSeqNo] [int] NULL,
	[CompleteOperation] [tinyint] NULL,
	[ImSerialNr] [varchar](22) COLLATE Latin1_General_CI_AS NULL,
	[ImportationNr] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[RevaluationCurrency] [char](3) COLLATE Latin1_General_CI_AS NULL,
	[LineType] [smallint] NULL,
	[Operation] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[ExternalNumber] [varchar](30) COLLATE Latin1_General_CI_AS NULL,
	[ExternalNumberRecordID] [bigint] NULL,
	[RevaluationRate] [float] NULL,
	[PositionNumber] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[StatementDate] [datetime] NULL,
	[StatementNumber] [char](10) COLLATE Latin1_General_CI_AS NULL,
	[IntrastatEnabled] [bit] NULL,
	[AllocationType] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[OfficialExchangeRate] [float] NULL,
	[OfficialAmountDC] [float] NULL,
	[OfficialBasisDC] [float] NULL,
	[csFakregRegister] [char](10) COLLATE Latin1_General_CI_AS NULL,
	[csFakregEntry] [tinyint] NOT NULL,
	[CSReqCreated] [tinyint] NOT NULL,
	[CSPickITCWDeliveryNoteCWDB] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[CSPickITCWOrsrgIDCWDB] [int] NOT NULL,
	[CSPickITHandTerminalID] [char](15) COLLATE Latin1_General_CI_AS NULL,
	[CSPickITModifyQuantity] [tinyint] NOT NULL,
	[CSPickITOrderPicker] [int] NULL,
	[CSPickITState] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[CSPickITQuantityPicked] [float] NULL,
	[CSPickITCWInvoiceNumberCWDB] [char](8) COLLATE Latin1_General_CI_AS NULL,
	[CSPickITQtyOrdered] [float] NULL,
	[CSPickITTransactionGUID] [uniqueidentifier] NULL,
	[CSPickITTransferLineID] [int] NULL,
	[ScheduledResources] [int] NULL,
	[ManualStartLock] [bit] NULL,
	[ManualStopLock] [bit] NULL,
	[FirmZoneLock] [bit] NULL,
	[OperationQuantityComplete] [float] NULL,
	[TaxDate] [datetime] NULL,
	[CSPickITLockTime] [datetime] NULL,
	[CSPickITLockResource] [int] NULL,
	[CSPickITLockProcessID] [char](2) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
