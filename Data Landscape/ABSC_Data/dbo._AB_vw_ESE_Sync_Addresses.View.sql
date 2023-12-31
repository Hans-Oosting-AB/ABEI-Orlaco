/****** Object:  View [dbo].[_AB_vw_ESE_Sync_Addresses]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[_AB_vw_ESE_Sync_Addresses] AS
SELECT 
	a.ID as ESE_address_id
	, c.cmp_code as ESE_cmp_code
	, ct.cnt_id as ESE_cnt_id
	, a.Type
	
	, ISNULL(a.AddressLine1,'') as AddressLine1
	, ISNULL(a.AddressLine2,'') as AddressLine2
	, ISNULL(a.AddressLine3,'') as AddressLine3
	, ISNULL(a.PostCode,'') as PostCode
	, ISNULL(a.City,'') as City
	, ISNULL(a.StateCode,'') as StateCode
	, ISNULL(a.County,'') as County
	, ISNULL(a.Country,'') as Country
	, ISNULL(a.Phone, '') as Phone
	, ISNULL(a.Fax,'') as Fax
	, ISNULL(a.Notes,'') as Notes
	, a.KeepSameAsVisit
	, a.datefield1, a.datefield2, a.datefield3, a.datefield4, a.datefield5
	, a.numberfield1, a.numberfield2, a.numberfield3, a.numberfield4, a.numberfield5
	, a.YesNofield1, a.YesNofield2, a.YesNofield3, a.YesNofield4, a.YesNofield5
	, ISNULL(a.textfield1,'') as textfield1
	, ISNULL(a.textfield2,'') as textfield2
	, ISNULL(a.textfield3,'') textfield3
	, ISNULL(a.textfield4,'') as textfield4
	, ISNULL(a.textfield5,'') as textfield5
	, a.CustomerReq
	, ISNULL(a.PoNumber,'') as PoNumber
	, a.InvoiceType
	, a.DamageWaiver
	, a.InvoiceFrequency
	, a.Main
	, ISNULL(a.AddressCode,'') as AddressCode
	, a.SalesPersonNumber
	, ISNULL(a.ShipVia,'') as ShipVia
	, ISNULL(a.UPSZone,'') as UPSZone
	, a.warehouse
	, a.IsTaxable
	, a.sysmodified as ESE_sysmodified
	, CURRENT_TIMESTAMP as datemodified -- update modified date
FROM dbo._AB_sy_ESE_Addresses a WITH (NOLOCK)
	INNER JOIN dbo._AB_sy_ESE_cicntp ct WITH (NOLOCK)
		ON ct.cnt_id = a.ContactPerson
	INNER JOIN dbo._AB_sy_ESE_cicmpy c WITH (NOLOCK)
		ON c.cmp_wwn = ct.cmp_wwn
WHERE 1=1
	AND c.cmp_type = 'C' -- Debtors only
	AND c.cmp_status = 'A' -- Active only
	--AND a.Type != 'VIS' -- Don't sync visiting addresses










GO
