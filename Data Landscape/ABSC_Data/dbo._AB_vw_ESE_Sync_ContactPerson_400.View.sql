/****** Object:  View [dbo].[_AB_vw_ESE_Sync_ContactPerson_400]    Script Date: 8/17/2023 9:06:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[_AB_vw_ESE_Sync_ContactPerson_400] AS
SELECT
	c.cmp_code AS ESE_cmp_code

	, ct.cnt_id AS ESE_cnt_id
	, ISNULL(cnt_f_name,'') AS cnt_f_name, ISNULL(cnt_l_name,'') AS cnt_l_name, ISNULL(cnt_m_name,'') AS cnt_m_name, ISNULL(FullName,'') AS FullName
	, ISNULL(Initials,'') AS Initials, ISNULL(Gender,'') AS Gender, ISNULL(predcode,'') AS predcode, ISNULL(cnt_job_desc,'') AS cnt_job_desc
	, ISNULL(cnt_dept,'') AS cnt_dept, ISNULL(taalcode,'') AS taalcode, ISNULL(cnt_f_ext,'') AS cnt_f_ext
	, ISNULL(cnt_f_fax,'') AS cnt_f_fax, ISNULL(cnt_f_tel,'') AS cnt_f_tel, ISNULL(cnt_f_mobile,'') AS cnt_f_mobile
	, ISNULL(cnt_email,'') AS cnt_email
	-- Convert old numbers to new account manager numbers, please check if the ID is available in the target database
	, CASE ct.cnt_acc_man
			WHEN 11580 THEN 7940
			ELSE ct.cnt_acc_man END AS ESE_cnt_acc_man
	, cnt_note, active_y AS ESE_active
	, WebAccess
	--, ct.syscreated
	, ct.sysmodified AS ESE_sysmodified--, ct.sysguid
	, ct.datefield1, ct.datefield2, ct.datefield3, ct.datefield4, ct.datefield5
	, ct.numberfield1, ct.numberfield2, ct.numberfield3, ct.numberfield4, ct.numberfield5
	, ct.YesNoField1, ct.YesNoField2, ct.YesNoField3, ct.YesNoField4, ct.YesNoField5
	, ISNULL(ct.textfield1,'') AS textfield1, ISNULL(ct.textfield2,'') AS textfield2, ISNULL(ct.textfield3,'') AS textfield3
	, ISNULL(ct.textfield4,'') AS textfield4
	, ISNULL(ct.textfield5,'') AS ESE_textfield5 -- this is used as ESE_cnt_id now
	, ISNULL(cntp_Directory,'') AS cntp_Directory, ContactChange
	, CASE WHEN c.cnt_id = ct.cnt_id THEN 1 ELSE 0 END AS Check_isMain
FROM dbo._AB_sy_cicntp ct WITH (NOLOCK)
	INNER JOIN dbo._AB_sy_cicmpy c WITH (NOLOCK)
		ON c.cmp_wwn = ct.cmp_wwn
WHERE 1=1
	AND c.cmp_type = 'C' -- Debtors only
	AND c.cmp_status = 'A' -- Active only






GO
