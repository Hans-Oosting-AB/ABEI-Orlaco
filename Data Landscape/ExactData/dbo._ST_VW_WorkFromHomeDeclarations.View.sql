/****** Object:  View [dbo].[_ST_VW_WorkFromHomeDeclarations]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  VIEW [dbo].[_ST_VW_WorkFromHomeDeclarations] AS
SELECT TOP 100 PERCENT 
b.HID, b.EmpID, h.fullname, b.freetextfield_01 as Reason, 
b.freetextfield_03 as FWeekNr, LEFT(b.freetextfield_03,4) AS YearNr, SUBSTRING(freetextfield_03,6,2) AS WeekNr, 
b.Approved, b.Approver,b.Processed, 
a.DeclDay, DATEADD(DAY, a.DeclDay,DATEADD(WEEK,(CONVERT(int,SUBSTRING(freetextfield_03,6,2))-1),y.FirstWeekStart))  AS DeclDate,
DATENAME(WEEKDAY,DATEADD(DAY, a.DeclDay,DATEADD(WEEK,(CONVERT(int,SUBSTRING(freetextfield_03,6,2))-1),y.FirstWeekStart))) AS DeclDayName
FROM (
	SELECT a.HID, CASE WHEN  a.Freeboolfield_01 = 1 THEN 1 ELSE NULL END AS DeclDay FROM [orlaco]..Absences a WITH (NOLOCK) WHERE type = 6044 UNION
	SELECT a.HID, CASE WHEN  a.Freeboolfield_02 = 1 THEN 2 ELSE NULL END AS DeclDay FROM [orlaco]..Absences a WITH (NOLOCK) WHERE type = 6044 UNION
	SELECT a.HID, CASE WHEN  a.Freeboolfield_03 = 1 THEN 3 ELSE NULL END AS DeclDay FROM [orlaco]..Absences a WITH (NOLOCK) WHERE type = 6044 UNION
	SELECT a.HID, CASE WHEN  a.Freeboolfield_04 = 1 THEN 4 ELSE NULL END AS DeclDay FROM [orlaco]..Absences a WITH (NOLOCK) WHERE type = 6044 UNION
	SELECT a.HID, CASE WHEN  a.Freeboolfield_05 = 1 THEN 5 ELSE NULL END AS DeclDay FROM [orlaco]..Absences a WITH (NOLOCK) WHERE type = 6044 UNION
	SELECT a.HID, CASE WHEN  a.EarlyInvoicing   = 1 THEN 6 ELSE NULL END AS DeclDay FROM [orlaco]..Absences a WITH (NOLOCK) WHERE type = 6044  ) a
INNER JOIN [orlaco]..Absences b WITH (NOLOCK) ON a.HID = b.HID
INNER JOIN [orlaco]..humres h WITH (NOLOCK) ON h.res_id = b.empid 
INNER JOIN [ExactData].._ST_VW_YearDates y ON y.YearNr = LEFT(b.freetextfield_03,4)
WHERE DeclDay IS NOT NULL
ORDER BY EmpID,HID,DeclDate
GO
