/*************   When did Job ID 330 & 469 run in the same minute ??? ******/

SELECT DISTINCT FORMAT( AEl_330.syscreated, 'yyyy-MM-dd HH:mm')
FROM [ABEI].[dbo].[_AB_Entity_Log] AEl_330 WITH (NOLOCK)

LEFT JOIN [ABEI].[dbo].[_AB_Entity_Log] AEl_469 WITH (NOLOCK)
	ON  --AEl_469.runid = AEl_330.runid
	FORMAT( AEl_469.syscreated, 'yyyy-MM-dd HH:mm') = FORMAT( AEl_330.syscreated, 'yyyy-MM-dd HH:mm')
	--AND AEl_469.jobid = 469
WHERE AEl_330.jobid = 330
AND AEl_469.jobid = 469
AND AEl_469.Id IS NOT NULL
--ORDER BY syscreated DESC
--AND FORMAT( AEl_469.syscreated, 'yyyy-MM-dd') = '2023-08-09'

--SELECT FORMAT( AEl.syscreated, 'HH:mm')
--, * 
--FROM [ABEI].[dbo].[_AB_Entity_Log] AEl WITH (NOLOCK)
--WHERE AEl.jobid IN (330,469)
--AND  FORMAT( AEl.syscreated, 'HH:mm')  < '05:45'
