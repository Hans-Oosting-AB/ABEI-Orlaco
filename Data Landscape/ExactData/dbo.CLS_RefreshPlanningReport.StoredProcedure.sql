/****** Object:  StoredProcedure [dbo].[CLS_RefreshPlanningReport]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--totale kalender tabel
--select * from dbo.CLS_DayHoursTable

CREATE proc [dbo].[CLS_RefreshPlanningReport] (@startdate datetime, @enddate datetime, @SynergyURL varchar(100)) as 

--declare @SynergyURL varchar(50) = 'http://exact.orlaco.nl/synergy'
--declare @startdate = '2018-12-17'
--declare @enddate = '2018-12-31'
--end date 1 dag oprekken ivm datumtijd issues
set @enddate = DATEADD(day, 1, @enddate)

IF OBJECT_ID('tempdb.dbo.##PlanningOutput', 'U') IS NOT NULL
drop table ##PlanningOutput

select h.res_id as MedewerkerID, h.fullname as Naam, d.pkdate as DatumTijd, null as Uren, convert(Varchar(50),null) as Color, 
null as HID, @SynergyURL + '/docs/WflRequestTypes.aspx?EntryType=0&Active=1&EndDate='+convert(varchar(10),d.pkdate,105)+'+00%3a00%3a00&NewReq=0&PageInitURL=WflRequestTypes.aspx%3fSource%3dCalendar%26NewReq%3d0%26Active%3d1%26MultipleEntry%3dFalse%26WeekEntry%3dFalse%26IsNew%3d1%26EndDate%3d'+convert(varchar(10),d.pkdate,105)+'%2b00%253a00%253a00%26EntryType%3d0%26Action%3d1%26EmployeeID%3d1000002%26SelectField%3d0%26ReturnToPage%3d0%26BTWRequestType%3d0%26StartDate%3d'+convert(varchar(10),d.pkdate,105)+'%2b00%253a00%253a00&MultipleEntry=False&SelectField=0&Source=Calendar&EmployeeID='+convert(varchar(20), h.res_id)+'&ReturnToPage=0&IsNew=1&Fav=1&IsReqParamExists=True&BTWRequestType=0&StartDate='+convert(varchar(10),d.pkdate,105)+'+00%3a00%3a00&WeekEntry=False&Action=1' as URL, 
 convert(varchar(255),null) as Description, null as Type, convert(varchar(255),null) as TypeDescription,
convert(varchar(8000),null) as Tooltip,
d.calendar_month_name_long as MaandJaar, d.is_weekend as Weekend, calendar_week_in_year as WeekNummer, D.day_name_short, d.calendar_day_in_month, d.calendar_month_name_short,
 D.day_name_short +  ' ' + convert(varchar(2),d.calendar_day_in_month) + ' ' + d.calendar_month_name_short as DateDayDescription
into ##PlanningOutput
from orlaco.dbo.humres h
inner join orlaco.dbo.hrjbtl j on h.job_title = j.job_title
cross join dbo.CLS_DayHoursTable d
where h.emp_stat = 'A' and h.emp_type = 'E' and h.res_id > 0 and j.job_grp IN ('VISBUIT')
and d.PKDate between @startdate and @enddate  and convert(varchar(2), d.PKDate, 108) between 8 and 17
order by h.res_id, d.pkdate


declare @HID int

DECLARE db_cursorHeader CURSOR FOR

		--Verzoeken ophalen
		select a.HID
		from orlaco.dbo.absences a
		inner join orlaco.dbo.absencetypes at on a.type = at.id and at.PlanHumanResource = 1
		left join orlaco.dbo.cicmpy c on a.customerid = c.cmp_wwn
		inner join orlaco.dbo.humres h on a.empid = h.res_id
		left join orlaco.dbo.hrjbtl j on h.job_title = j.job_title
		where a.type in (a.type)
		and j.job_grp in ('VISBUIT')
		and a.status <> 2  and (
							--verzoeken waarvan de startdatum binnen de periode valt
							(a.StartDate between @startdate and @enddate) 
							OR 
							--verzoeken waarvan de einddatum binnen de periode valt
							(a.EndDate between @startdate and @enddate)
							OR
							--verzoeken waarvan de startdatum voor de periode valt en de einddatum erna
							(a.Startdate< @startdate and a.EndDate > @enddate)
							)


OPEN db_cursorHeader   
FETCH NEXT FROM db_cursorHeader INTO @HID   

WHILE @@FETCH_STATUS = 0   
	BEGIN

			print @HID

			update ##PlanningOutput set 
					Color =			'#'
									+ CONVERT(varchar(6),
									CAST(ABS(at.graphcolor) as varbinary(1))
									+ CAST(ABS(at.graphcolor/256) as varbinary(1))
									+ CAST(ABS(at.graphcolor/256/256) as varbinary(1))
									, 2),
					
					 --case when a.status =  0 then 'Orange' else 'Green' end,
					Description = a.Description,
					URL = @SynergyURL + '/docs/WFLRequest.aspx?ID=' + convert(varchar(36), a.ID),
					Type = a.Type,
					TypeDescription = at.Description,
					Uren = a.Hours,
					HID = a.HID,
					Tooltip = 
at.Description + '
' + isnull(c.cmp_name  + '
', '') + a.Description + ' (' + case a.Status
	when 2 then 'Afgekeurd'
	when 0 then 'Open'
	when 1 then 'Goedgekeurd'
	when 4 then 'Gerealiseerd'
	when 3 then 'Verwerkt'
	when 5 then 'Concept'
end + ')
'+ isnull(a.RequestComments,'')

					from orlaco.dbo.absences a
					inner join ##PlanningOutput p on a.EmpID = p.MedewerkerID and p.DatumTijd between a.StartDate and a.enddate and p.DatumTijd < a.EndDate
					inner join orlaco.dbo.absencetypes at on a.type = at.id and at.PlanHumanResource = 1
					left join orlaco.dbo.cicmpy c on a.customerid = c.cmp_wwn
					inner join orlaco.dbo.humres h on a.empid = h.res_id
					left join orlaco.dbo.hrjbtl j on h.job_title = j.job_title
					where a.HID = @HID

	   FETCH NEXT FROM db_cursorHeader INTO  @HID
	END   

CLOSE db_cursorHeader   
DEALLOCATE db_cursorHeader

GO
