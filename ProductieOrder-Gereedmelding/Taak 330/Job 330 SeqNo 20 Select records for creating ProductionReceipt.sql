--Optimized query:
SELECT DISTINCT * FROM (
SELECT TOP 999
    CONCAT(FORMAT(GETDATE(), 'yyyyMMddHHmm'), FORMAT(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), '000')) AS UniqueID,
    CASE WHEN gbk.BlockItem = 1 THEN 0 ELSE gbk.ID END as ID,
    ob.Productieorder as HeaderID,
    ob.artikel as artcode,
    ob.Productieorder as Project,
    ob.Serienummer as facode,
    'Receipt by ABEI' as YourRef,
    ISNULL(SUM(ob.aantal), 1) as actualquantity,
    10152 as res_id,
    gbk.magcode as warehouse
    FROM [ProdGlobe_live].dbo._AB_GerProd_proces as ob with (nolock) 
CROSS APPLY (
    SELECT TOP 1 g.id, g.blockitem, pr.magcode
    FROM [400].dbo.PRProject as pr with (nolock) 
    INNER JOIN [400].dbo.gbkmut as g with (nolock)  ON g.project = pr.ProjectNr
    INNER JOIN [400].dbo.Items as i with (nolock)  ON i.itemcode = g.artcode AND i.GLAccountDistribution = g.reknr
    WHERE pr.type = 'P'
        AND pr.status = 'A'
        AND g.transsubtype = 'A'
        AND g.transtype = 'B'
        AND g.freefield1 = 'P'
        AND i.IsBatchItem = 0
        AND g.artcode = ob.Artikel COLLATE DATABASE_DEFAULT
        AND pr.projectnr = ob.Productieorder COLLATE DATABASE_DEFAULT
    ORDER BY g.blockitem, g.ID ASC, pr.projectnr, i.itemcode
) as gbk
WHERE ISNULL(ob.productieorder, '') <> ''
    AND (ob.Status_ProdGer = 0 OR (ob.Status_ProdGer = 4 AND ob.Imp_attempts < 5))
GROUP BY gbk.BlockItem, gbk.ID, ob.Productieorder, ob.artikel, ob.Serienummer, gbk.magcode
ORDER BY ob.Productieorder, ob.Serienummer, gbk.BlockItem, gbk.ID, ob.artikel, gbk.magcode
) SUB



--Original Query Below:


--SELECT DISTINCT TOP 1000
-- CASE WHEN gbk.BlockItem = 1 THEN 0 ELSE gbk.ID END as ID
-- , ob.Productieorder as HeaderID
-- , ob.Productieorder as Project
--
-- , 'Receipt by ABEI' as YourRef 
-- , ob.artikel as artcode
-- , isnull(SUM(ob.aantal), 1) as actualquantity
-- , ob.Serienummer as facode
-- , 10152 as res_id
-- , gbk.magcode as warehouse
--  
--
--FROM    [ProdGlobe_live].dbo._AB_GerProd_proces as ob with (nolock) 
--        CROSS APPLY (SELECT TOP 1 g.id, g.blockitem, pr.magcode
--                     FROM   [400].dbo.PRProject as pr with (nolock)
--                            INNER JOIN [400].dbo.gbkmut as g with (NOLOCK) on g.project = pr.ProjectNr
--                            INNER JOIN [400].dbo.Items as i WITH (NOLOCK) on i.itemcode = g.artcode and i.GLAccountDistribution = g.reknr
--
--                     WHERE 1=1
--                     and pr.type = 'P'
--                     AND pr.status = 'A'
--                     AND g.transsubtype = 'A'
--                     AND g.transtype = 'B'
--                     AND g.freefield1 = 'P'
--                     AND i.IsBatchItem = 0
--                     AND g.artcode = ob.Artikel COLLATE DATABASE_DEFAULT
--                     AND pr.projectnr = ob.Productieorder COLLATE DATABASE_DEFAULT
--                      
--                     ORDER BY g.blockitem, g.ID ASC
--                     ) as gbk
--where 
---- (ob.Serienummer IS NULL OR ob.Serienummer not in (select top 100 percent number FROM [400].[dbo].[ItemNumbers] WITH (NOLOCK) )) LS 2020-2-26 05.048.511
-- isnull(ob.productieorder,'') <> ''
--and (ob.Status_ProdGer = 0 OR (ob.Status_ProdGer = 4 and ob.Imp_attempts < 5))
----and ob.proddatum = CONVERT(DATE, GETDATE())
--
--GROUP BY gbk.BlockItem , gbk.ID 
-- , ob.Productieorder
-- , ob.Productieorder 
-- , ob.artikel
-- , ob.Serienummer 
-- , gbk.magcode 