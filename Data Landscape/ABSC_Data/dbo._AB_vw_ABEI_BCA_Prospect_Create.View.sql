/****** Object:  View [dbo].[_AB_vw_ABEI_BCA_Prospect_Create]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[_AB_vw_ABEI_BCA_Prospect_Create] AS
SELECT	
	p.ID as referencekey
	, p.runid
	, 'P' as cmp_type -- Prospect
	, 'A' as cmp_status -- Active
	, a.HID as NumberField5 -- BCA form number
	, 1 as YesNoField1 -- BCA Form Present
	,'' AS ClassificationId
	, b.email as cmp_e_mail
	, a.FreeTextField_01 as cmp_name
	, a.FreeTextField_05 as cmp_fctry 
	, a.FreeTextField_06 as cmp_tel
	, a.FreeTextField_07 as cmp_fadd1
	, a.FreeTextField_08 as cmp_fcity
	, a.FreeTextField_09 as cmp_fcounty -- county or state?
	, a.FreeTextField_10 as cmp_fpc
	, a.FreeTextField_11 as cmp_web
	, a.FreeTextField_12 as VatNumber
	--, FreeTextField_13 as .CompanyCRNo as ?? -- TODO
	--, FreeTextField_14 as b.CompanyBusinessType as ?? -- Where should this go?
	--, FreeTextField_02 as CompanyTradeRegister
	, a.ordernumber as DunsNumber
	-- , FreeTextField_15 - b.CompanyLegalForm as ?? -- Where should this go?
	, a.empid as cmp_acc_man 

	-- Contact
	, a.FreeTextField_04 as cnt_l_name
	, a.FreeTextField_03 as cnt_email
	, a.ReferenceNumber as cnt_f_tel
    --, a.ProcessNumber as cnt_dept --b.APContactDepartment 

	-- Delivery
	, b.DeliveryAddress as DelAddress
	, b.DeliveryCity as DelCity
	, a.FreeTextField_05 as DelCountry  
	--, b.DeliveryTermsNote as DeliveryTerms -- todo: test, this probably does not work
      --,[DeliveryName]
	  --, b.DeliveryTransport

	-- Invoice
	, b.BillingAddress as InvAddress
	, b.BillingCity as InvCity
	, b.BillingState as InvCounty
	, b.BillingZipCode as InvPostCode
	, a.FreeTextField_05 as InvCountry 
	
      --,[BillingName]
	--, b.BillingEmail 

      --,[ShippingName]
      --,[ShippingEmail]
      --,[ShippingState]
     -- ,[ShippingCountry]
     -- ,[ShippingZipCode]

     -- ,[BuyersName]
      --,[BuyersFirstName]
     -- ,[BuyersTitle]
     -- ,[BuyersPhone]
     -- ,[BuyersMobilePhone]
     -- ,[BuyersEmail]
    --  ,[SignatureName]
    --  ,[SignatureTitle]
	--  ,[Email]
      --,[SignatureDate]
     

FROM dbo._AB_tb_ABEI_BCA_Prospects p WITH (NOLOCK)
	INNER JOIN [ExactData].[dbo].[_ST_IC_BCAs] b WITH (NOLOCK) ON b.ID = p.BCAID
	INNER JOIN dbo._AB_sy_absences a WITH (NOLOCK) ON a.hid = p.hid
WHERE 1=1
	AND p.rowstatus = 1
	AND p.seqno = 10




GO
