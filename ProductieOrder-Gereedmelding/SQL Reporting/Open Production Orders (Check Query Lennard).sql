SELECT  
    a.ProductionOrder,  
    a.ItemCode,  
    b.ExactPlanned,  
    c.ExactReceived,  
    a.LastModified, 
       d.[Quantity of double serialnumbers] 
FROM  
    [ExactData].dbo.[_ST_PRD_Prod_Process] a WITH (NOLOCK) 
INNER JOIN  
    ( 
        SELECT Productionorder, ExactPlanned 
        FROM [ExactData].dbo.[_ST_PRD_Exact_Planned_Open] WITH (NOLOCK) 
    ) b  
ON a.Productionorder = b.Productionorder 
LEFT JOIN  
    ( 
        SELECT Productionorder, ExactReceived 
        FROM [ExactData].dbo.[_ST_PRD_Exact_Received_Open] WITH (NOLOCK) 
    ) c  
ON a.Productionorder = c.Productionorder 
LEFT JOIN  
    ( 
        SELECT  
            sub_gbkmut.project AS ProductionOrder, 
            COUNT (*)  as [Quantity of double serialnumbers] 
        FROM  
            [400]..Items i 
        INNER JOIN 
            ( 
               SELECT  
                    MIN(g.ID) AS ID,  
                    g.artcode,  
                    SUM(g.aantal) AS quantity,  
                    g.faktuurnr,  
                    SUM(g.bdr_hfl) AS amount,  
                    g.bkstnr_sub,  
                    CASE WHEN IsSerialNumberItem = 1 OR IsBatchItem = 1 THEN facode ELSE '' END AS facode,  
                    g.kstplcode,  
                    g.kstdrcode,  
                    g.warehouse,  
                    CONVERT(VARCHAR, g.Step) + ' - ' + g.Operation AS operation, 
                    g.project,  
                    g.res_id,  
                    g.warehouse_location 
                FROM  
                    [400]..gbkmut g 
                INNER JOIN  
                    [400]..Items i ON i.ItemCode = g.artcode AND g.reknr = i.GLAccountDistribution 
                LEFT JOIN  
                    [400]..prproject pr ON pr.projectnr = g.project 
                WHERE  
                    pr.status IN ('P', 'A')  
                    AND (g.aantal > 0) 
                GROUP BY  
                    g.artcode,  
                    g.bkstnr_sub,  
                    g.kstplcode,  
                    g.warehouse,  
                    CONVERT(VARCHAR, g.Step) + ' - ' + g.Operation,  
                    g.faktuurnr, 
                    CASE WHEN IsSerialNumberItem = 1 OR IsBatchItem = 1 THEN facode ELSE '' END,  
                    g.res_id,  
                    g.warehouse_location,  
                    g.kstdrcode,  
                    g.project,  
                    i.IsSerialNumberItem,  
                    i.IsBatchItem 
                HAVING  
                    (SUM(g.aantal) > 0) 
            ) AS sub_gbkmut  
        ON i.ItemCode = sub_gbkmut.artcode  
        WHERE  
            sub_gbkmut.quantity = 2 
            AND sub_gbkmut.facode > '' 
        GROUP BY  
            sub_gbkmut.project 
    ) d  
ON a.ProductionOrder = d.ProductionOrder 

WHERE  
    a.ProductionOrder != 'PROD00198101.002' 
    and a.ProcessReady >= b.ExactPlanned 
    AND a.LastModified < DATEADD(DAY, -1, GETDATE()) 

ORDER BY  
    a.ItemCode,  
    a.ProductionOrder 