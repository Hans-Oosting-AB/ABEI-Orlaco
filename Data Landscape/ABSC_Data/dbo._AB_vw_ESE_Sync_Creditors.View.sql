/****** Object:  View [dbo].[_AB_vw_ESE_Sync_Creditors]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[_AB_vw_ESE_Sync_Creditors] AS
SELECT  
	c.cmp_wwn AS ESE_cmp_wwn, c.cmp_code AS ESE_cmp_code, c.cmp_parent AS ESE_cmp_wwn_parent, cp.cmp_code AS ESE_cmp_code_parent
	, ISNULL(c.cmp_name,'') AS cmp_name
	, ISNULL(c.cmp_fadd1,'') AS cmp_fadd1, ISNULL(c.cmp_fadd2,'') AS cmp_fadd2, ISNULL(c.cmp_fadd3,'') AS cmp_fadd3
	, ISNULL(c.cmp_fpc,'') AS cmp_fpc, ISNULL(c.cmp_fcity,'') AS cmp_fcity, ISNULL(c.cmp_fcounty,'') AS cmp_fcounty, ISNULL(c.StateCode,'') AS StateCode, ISNULL(c.cmp_fctry,'') AS cmp_fctry
	, ISNULL(c.cmp_e_mail,'') AS cmp_e_mail, ISNULL(c.cmp_web,'') AS cmp_web, ISNULL(c.cmp_fax,'') AS cmp_fax, ISNULL(c.cmp_tel,'') AS cmp_tel
	, ISNULL(c.sct_code,'') AS sct_code, ISNULL(c.SubSector,'') AS SubSector, ISNULL(c.siz_code,'') AS siz_code
	, c.cmp_date_cust
	, ISNULL(c.cmp_note,'') AS cmp_note
	-- Convert old numbers to new account manager numbers, please check if the ID is available in the target database
	, CASE c.cmp_acc_man 
		WHEN 11580 THEN 7940 -- Thomas Bösinger
		WHEN 50003 THEN 99009  -- Jan van Beek
		ELSE c.cmp_acc_man END AS cmp_acc_man 
	, c.cmp_reseller
	, ISNULL(c.cmp_type,'') AS cmp_type, ISNULL(c.cmp_status,'') AS cmp_status
	, ISNULL(c.cmp_origin,'') AS cmp_origin
	, ISNULL(c.ClassificationId,'') AS ClassificationId
	, c.type_since, c.status_since, c.WebAccessSince, c.ProcessedByBackgroundJob 
	, ISNULL(c.debnr,'') AS debnr, ISNULL(c.crdnr,'') AS crdnr, ISNULL(c.debcode,'') AS debcode, ISNULL(c.crdcode,'') AS crdcode
	, ISNULL(c.ASPServer,'') AS ASPServer, ISNULL(c.ASPDatabase,'') AS ASPDatabase, ISNULL(c.ASPWebServer,'') AS ASPWebServer, ISNULL(c.ASPWebSite,'') AS ASPWebSite
	, ISNULL(c.SearchCode,'') AS SearchCode, ISNULL(c.Telex,'') AS Telex
	, c.NoteID, c.Blocked, c.LayoutCode
	, c.Factoring, ISNULL(c.ISOCountry,'') AS ISOCountry, c.LiableToPayVAT
	, c.BackOrders
	, ISNULL(c.AddressNumber,'') AS AddressNumber, ISNULL(c.DeliveryAddress,'') AS DeliveryAddress, ISNULL(c.RouteCode,'') AS RouteCode
	, c.InvoiceDiscount, ISNULL(c.PaymentConditionSearchCode,'') AS PaymentConditionSearchCode, ISNULL(c.SearchCodeGoods,'') AS SearchCodeGoods, ISNULL(c.ExpenseCode,'') AS ExpenseCode
	, ISNULL(c.Area,'') AS Area, ISNULL(c.InvoiceLayout,'') AS InvoiceLayout, ISNULL(c.Status,'') AS Status
	, c.InvoiceThreshold, ISNULL(c.Location,'') AS Location, ISNULL(c.VATSource,'') AS VATSource, c.CalculatePenaltyInterest
	, c.SendPenaltyInvoices
	, ISNULL(c.PaymentMethod,'') AS PaymentMethod
	, ISNULL(c.InvoiceDebtor,'') AS InvoiceDebtor, c.CreditLine
	, ISNULL(c.VatNumber,'') AS VatNumber, ISNULL(c.PurchaseReceipt,'') AS PurchaseReceipt
	, ISNULL(c.JournalCode,'') AS JournalCode
	, ISNULL(c.PaymentCondition,'') AS PaymentCondition
	, c.CheckDate 
	, CASE WHEN c.debnr IN (180045, 220536) THEN 1 ELSE 0 END AS ChangeVatCode -- DF: only set RDS open
	, ISNULL(c.IntrastatSystem,'') AS IntrastatSystem, c.ChangeIntraStatSystem
	, ISNULL(c.TransActionA,'') AS TransActionA, c.ChangeTransActionA, ISNULL(c.TransActionB,'') AS TransActionB, c.ChangeTransActionB
	, ISNULL(c.DestinationCountry,'') AS DestinationCountry, c.ChangeDestinationCountry
	, ISNULL(c.Transport,'') AS Transport, c.ChangeTransport
	, ISNULL(c.CityOfLoadUnload,'') AS CityOfLoadUnload, c.ChangeCityOfLoadUnload
	, ISNULL(c.DeliveryTerms,'') AS DeliveryTerms, c.ChangeDeliveryTerms
	, ISNULL(c.TransShipment,'') AS TransShipment, c.ChangeTransShipment
	, ISNULL(c.TriangularCountry,'') AS TriangularCountry, c.ChangeTriangularCountry
	, ISNULL(c.IntRegion,'') AS IntRegion, c.ChangeIntRegion
	, ISNULL(c.Collect,'') AS Collect
	, c.PaymentDay1, c.PaymentDay2, c.PaymentDay3, c.PaymentDay4, c.PaymentDay5
	, ISNULL(c.FiscalCode,'') AS FiscalCode
	, ISNULL(c.CreditCard,'') AS CreditCard, c.ExpiryDate	
	, ISNULL(c.VatLiability,'') AS VatLiability, c.Attention, ISNULL(c.Category,'') AS Category, ISNULL(c.StatementAddress,'') AS StatementAddress
	, ISNULL(c.DefaultSelCode,'') AS DefaultSelCode, ISNULL(c.GroupPayments,'') AS GroupPayments
	, c.BOELimitAmount, c.BOEMaxAmount
	, ISNULL(c.ChamberOfCommerce,'') AS ChamberOfCommerce, ISNULL(c.DunsNumber,'') AS DunsNumber

	--, ISNULL(c.textfield1,'') AS textfield1 -- NCM file / coface reference
	----ISNULL(c.textfield2,'') AS textfield2, old debnr maritime -- not set in Synergy
	----ISNULL(c.textfield3,'') as textfield3, shipment documentation -- 2020-05-27 LS: 05.131.983 dont update shipment documentation 
	--, ISNULL(c.textfield4,'') AS textfield4 -- account no carrier
	--, ISNULL(c.TextField6,'') AS TextField6 -- General info 1
	--, ISNULL(c.TextField7,'') AS TextField7 -- General info 2
	--, ISNULL(c.TextField8,'') AS TextField8 -- General info 3
	----, ISNULL(c.TextField9,'') AS TextField9 - Globe: Extra mailproperties/Synergy:Discount pricelist
	----, ISNULL(c.TextField10,'') AS TextField10 Globe: Old rep code, syn: Brands
	----, ISNULL(c.TextField11,'') as TextField11 EAN Code
	--, ISNULL(c.TextField12,'') AS TextField12 -- Coface EASY number
	--, ISNULL(c.TextField13,'') AS TextField13 -- Incoterms
	--, ISNULL(c.TextField14,'') AS TextField14 -- EUR 1 statement
	----, ISNULL(c.TextField15,'') as TextField15 -- EDI facility code
	--, ISNULL(c.TextField16,'') AS TextField16  -- Alt douane code
	--, ISNULL(c.TextField17,'') AS TextField17  -- supplier rating
	----, ISNULL(c.TextField18,'') AS TextField18  -- specific invoice text (Not set in Synergy)
	--, ISNULL(c.TextField19,'') AS TextField19  -- Trade shows
	--, ISNULL(c.TextField20,'') AS TextField20  -- IMDS register
	--, ISNULL(c.TextField21,'') AS TextField21  -- Store
	--, ISNULL(c.TextField22,'') AS TextField22  -- Dealercode
	--, ISNULL(c.TextField23,'') AS TextField23  -- Dealername
	--, ISNULL(c.TextField24,'') AS TextField24  -- Subdealercode
	--, ISNULL(c.TextField25,'') AS TextField25  -- Legal entity code
	--, ISNULL(c.TextField26,'') AS TextField26  -- Legal entity name
	--, ISNULL(c.TextField27,'') AS TextField27  -- EORI nr
	----, ISNULL(c.TextField28,'') AS TextField28  -- N/A
	----, ISNULL(c.TextField29,'') AS TextField29  -- ISS - (Not set in Globe)
	----, ISNULL(c.TextField30,'') AS TextField30  -- Sales Funnel status - (Not set in Globe)
	--, c.datefield1	 -- Coface date
	--, c.datefield2	 -- Coface conditions date
	--, c.datefield3	 -- VAT number check
	--, c.datefield4	 -- 
	--, c.datefield5	 -- 
	--, c.numberfield1 -- Pricelist (discount)
	--, c.numberfield2 -- CNH Dealer discount
	--, c.numberfield3 -- 
	--, c.numberfield4 -- 
	--, c.numberfield5 -- 
	----, c.YesNofield1	 -- Synergy: BCA form present, Globe: invitation
	--, c.YesNofield2	 -- Mailing
	----, c.YesNofield3	 -- Synergy: IS TS approach, Globe Schedule supplier
	--, c.YesNofield4	 -- CAT relation
	--, c.YesNofield5	 -- EDI Customer
	, c.cnt_id AS ESE_cnt_id
	, ISNULL(c.cmp_rating,'') AS cmp_rating
	, c.sysmodified AS ESE_sysmodified
	, CURRENT_TIMESTAMP AS datemodified -- update modified date
FROM dbo._AB_sy_ESE_cicmpy c WITH (NOLOCK)
	-- Parent
	LEFT JOIN dbo._AB_sy_ESE_cicmpy cp WITH (NOLOCK)
		ON cp.cmp_wwn = c.cmp_parent
WHERE 1=1
	AND c.cmp_type = 'S' -- Debtors only
	--AND c.cmp_status = 'A' -- Active only








GO
