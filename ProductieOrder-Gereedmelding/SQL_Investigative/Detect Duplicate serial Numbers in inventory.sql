        --SELECT  
        --    sub_gbkmut.project AS ProductionOrder, 
        --    COUNT (*)  as [Quantity of double serialnumbers] 
        --FROM  
        --    ( 
               SELECT  
                    COUNT(g.ID) AS NumRecords,  
                    g.artcode,  
                    SUM(g.aantal) AS quantity,  
                    --g.faktuurnr,  
                    SUM(g.bdr_hfl) AS amount,  
                    --g.bkstnr_sub,  
                    --CASE WHEN IsSerialNumberItem = 1 OR IsBatchItem = 1 THEN facode ELSE '' END AS facode,
					g.facode  
                    --g.kstplcode,  
                    --g.kstdrcode,  
                    --g.warehouse,  
                    --CONVERT(VARCHAR, g.Step) + ' - ' + g.Operation AS operation, 
                    --g.project,  
                    --g.res_id,  
                    --g.warehouse_location 
                FROM  
                    [400]..gbkmut g WITH (NOLOCK)
                --INNER JOIN  
                --    [400]..Items i WITH (NOLOCK) ON i.ItemCode = g.artcode AND g.reknr = i.GLAccountDistribution 
                --LEFT JOIN  
                --    [400]..prproject pr WITH (NOLOCK) ON pr.projectnr = g.project 
                WHERE  1=1
                    --pr.status IN ('P', 'A')  
                    --AND (g.aantal > 0) 
					AND g.facode IS NOT NULL
					AND g.transtype  NOT IN ('B', 'V')-- 'N'
					--AND g.transsubtype = 'A'
					AND reknr = 3300
					--AND (IsSerialNumberItem = 1 OR IsBatchItem = 1)
					AND g.syscreated > '01-01-2023'
                GROUP BY  
                    --COUNT(g.ID) AS NumRecords,  
                    g.artcode,  
                    --SUM(g.aantal) AS quantity,  
                    --g.faktuurnr,  
                    --SUM(g.bdr_hfl) AS amount,  
                    --g.bkstnr_sub,  
                    --CASE WHEN IsSerialNumberItem = 1 OR IsBatchItem = 1 THEN facode ELSE '' END AS facode,
					g.facode  
                    --g.kstplcode,  
                    --g.kstdrcode,  
                    --g.warehouse,  
                    --CONVERT(VARCHAR, g.Step) + ' - ' + g.Operation AS operation, 
                    --g.project,  
                    --g.res_id,  
                    --g.warehouse_location 
                    --i.IsSerialNumberItem,  
                    --i.IsBatchItem 
                HAVING  
                    (SUM(g.aantal) > 1) 
        --    ) AS sub_gbkmut  
        --WHERE  
        --    sub_gbkmut.quantity = 2 
        --    AND sub_gbkmut.facode > '' 

