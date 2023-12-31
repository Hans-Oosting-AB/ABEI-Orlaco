/****** Object:  View [dbo].[_AB_vw_ABEI_BCA_Request_Create]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[_AB_vw_ABEI_BCA_Request_Create] AS
SELECT 
	b.ID as referencekey
	, b.runid
	, 6043 as [Type]
	, CONCAT('BCA - ', REPLACE(b.CompanyName, 'Company name:', '')) as Description
	, b.ID as FreeIntField_01
	, b.CDate as Startdate

	-- Company
	, REPLACE(b.CompanyName, 'Company name:', '') as FreeTextField_01
	, b.CompanyTradeRegister as FreeTextField_02
	--, b.CompanyCountry as FreeTextField_05
	, l.landcode as FreeTextField_05 
	, b.CompanyPhone as FreeTextField_06
	, b.CompanyAddress as FreeTextField_07
	, b.CompanyCity as FreeTextField_08
	, b.CompanyState as FreeTextField_09
	, b.CompanyZipCode as FreeTextField_10
	, b.CompanyWebsite as FreeTextField_11
	, b.CompanyVATNo as FreeTextField_12
	, b.CompanyCRNo as FreeTextField_13
	, b.CompanyBusinessType as FreeTextField_14
	, b.CompanyDUNSNo as ordernumber
	, b.CompanyLegalForm as FreeTextField_15
	-- details
	, CONCAT('Company', '
'	,'------------------------------','
 Name: '		, REPLACE(b.CompanyName, 'Company name:', ''),'
 Country: '		, b.CompanyCountry,'
 Phone: '		, b.CompanyPhone,'
 Address: '		, b.CompanyAddress,'
 City: '		, b.CompanyCity,'
 State: '		, b.CompanyState,'
 ZipCode: '		, b.CompanyZipCode,'
 Website: '		, b.CompanyWebsite,'
 VATNo: '		, b.CompanyVATNo,'
 CRNo: '		, b.CompanyCRNo,'
 BusinessType: '	, b.CompanyBusinessType,'
 TradeRegister: '	, b.CompanyTradeRegister,'
 DUNSNo: '		, b.CompanyDUNSNo,'
 LegalForm: '	, b.CompanyLegalForm, '
 
 Orlaco Contact Person: ', b.OrlacoContactPerson) as RequestComments

	-- Contact
	, LTRIM( REPLACE(b.APContactName, 'Name Financial contact:', '')) as FreeTextField_04
	,  b.APContactEmail as FreeTextField_03
	,  b.APContactPhone as ReferenceNumber
	,  b.APContactDepartment as ProcessNumber

	, CONCAT('Financial Contact', '
'	,'------------------------------','
 Name: '		, REPLACE(b.APContactName, 'Name Financial contact:', ''),'
 Phone: '		, b.APContactPhone,'
 Email: '		, b.APContactEmail,'
 Department: '	, b.APContactDepartment,'

'	, 'Billing', '
'	,'------------------------------','
 Name: '		, REPLACE(b.BillingName, 'Company name:', ''),'
 Address: '		, b.BillingAddress,'
 City: '		, b.BillingCity,'
 State: '		, b.BillingState,'
 ZipCode: '		, b.BillingZipCode,'
 Email: '		, b.BillingEmail,'

'	, 'Delivery', '
'	,'------------------------------','
 Name: '		, REPLACE(b.DeliveryName, 'Company name:', ''),'
 Address: '		, b.DeliveryAddress,'
 City: '		, b.DeliveryCity,'
 State: '		, b.DeliveryTermsNote,'
 ZipCode: '		, b.DeliveryTransport,'

'	, 'Shipping', '
'	,'------------------------------','
 Name: '		, REPLACE(b.ShippingName, 'Shipping account number:', ''),'
 Email: '		, b.ShippingEmail,'
 Country: '		, b.ShippingCountry,'
 State: '		, b.ShippingState,'
 ZipCode: '		, b.ShippingZipCode,'

'	, 'Buyer', '
'	,'------------------------------','
 Name: '		, REPLACE(b.BuyersName, 'Last name:', ''),'
 First Name: '	, b.BuyersFirstName,'
 Title: '		, b.BuyersTitle,'
 Phone: '		, b.BuyersPhone,'
 Mobile Phone: ', b.BuyersMobilePhone,'
 Email: '		, b.BuyersEmail,'

'	, 'Signature', '
'	,'------------------------------','
 Name: '		, REPLACE(b.SignatureName, 'Name:', ''),'
 Title: '		, b.SignatureTitle, '
 Email: '		, b.Email, '
 Date: '		, b.SignatureDate
  
	) as WorkflowComments

	, ISNULL(h.res_id, 11990) as EmpID

FROM [ExactData].[dbo].[_ST_IC_BCAs] b WITH (NOLOCK)
	LEFT JOIN dbo._AB_sy_ESE_humres h WITH (NOLOCK) ON h.fullname = b.OrlacoContactPerson COLLATE DATABASE_DEFAULT and ISNULL(h.ldatuitdienst, '2099-01-01') > GETDATE()
	LEFT JOIN dbo._AB_sy_ESE_Land l WITH (NOLOCK) ON l.oms60_0 = b.CompanyCountry COLLATE DATABASE_DEFAULT OR l.landcode = b.CompanyCountry COLLATE DATABASE_DEFAULT 
WHERE 1=1
	AND b.HID IS NULL -- No HID yet




GO
