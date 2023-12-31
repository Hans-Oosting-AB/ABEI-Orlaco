/****** Jobs that manipulate [ProdGlobe_live].[dbo].[_AB_GerProd_proces]   ******/
SELECT DISTINCT AEl.[jobid]
	, groupname
	,[jobname]
	--, PGP.*
	--, AEl.*
FROM [ABEI].[dbo].[_AB_Entity_Log] AEl WITH (NOLOCK)
INNER JOIN [ABEI].[dbo].[_AB_Entity_jobs] AEj WITH (NOLOCK)
	ON AEj.Id = AEl.jobid
INNER JOIN [ABEI].[dbo].[_AB_Entity_jobgroups] AEjg WITH (NOLOCK)
	ON AEj.[jobgroup] = AEjg.id
INNER JOIN (
	SELECT DISTINCT runid
	FROM [ProdGlobe_live].[dbo].[_AB_GerProd_proces]  WITH (NOLOCK)
	WHERE syscreated > '2023-08-03'
	) PGPr
	ON AEl.runid = PGPr.runid
--INNER JOIN [ProdGlobe_live].[dbo].[_AB_GerProd_proces]  PGP WITH (NOLOCK)
--	ON PGP.runid = PGPr.runid
--WHERE AEl.runid = 'DC7A42CC-D437-4CD4-B985-439A32C4EAA7'
--WHERE AEl.jobid = 292
ORDER BY groupname, AEl.jobid

/*
jobid	groupname			jobname
330		0. Default group	! EG: Productieorder gereedmelden en rework
469		0. Default group	00.1 - EG: Production order auto-complete

Arbitrary RUNIDS:
292		3. MRP jobs			! EG: HPP PROD aanmaken (400)
276		4. Quotations		! EG: Offerte inclusief voorwaarden mailen (400)
278		4. Quotations		! EG: Offerte inclusief voorwaarden mailen (484)
364		4. Quotations		! EG: Offerte inclusief voorwaarden mailen (483)
513		5. Synchronisatie	Order / Invoice : Order Sync (484 <> 400)
543		5. Synchronisatie	05.9.1 - EG: Start Sync Item From Pro.File
219		7. Requests			! ESE: PD Warehouse 90, 91, 92 ontvangsten
*/

