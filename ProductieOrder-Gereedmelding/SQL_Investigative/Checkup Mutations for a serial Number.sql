
--SELECT top 1000 * 
--FROM [400].[dbo].[gbkmut] as gbk WITH (NOLOCK)
--WHERE facode in ('CPG64C2', 'CPG5FCB', 'CPG6515', 'CPG6518', 'CPG65ED', 'CPG6730', 'CPG66BC', 'CPG7896', 'CPG78A9', 'CPH0893', 'CPH08A4', 'CNH5B9C')
--AND transtype = 'N'
--AND transsubtype = 'A'

--INNER JOIN
--(SELECT facode, COUNT(ID)
--	FROM [400].[dbo].[gbkmut] WITH (NOLOCK)
--	WHERE facode IS NOT NULL
--	GROUP BY facode
--	HAVING COUNT(ID) > 1
--	) as dup
--ON dup.facode = gbk.facode
--ORDER BY gbk.sysmodified DESC

SELECT top 100 * 
FROM [400].dbo.ItemNumbers WITH (NOLOCK)
WHERE Number IS NOT NULL
AND Quantity > 1
ORDER BY sysmodified DESC

SELECT h.fullname, h.mail, g.project, g.* 
FROM [400]..gbkmut g WITH (NOLOCK)
--INNER JOIN [400]..[orsrg] as OL WITH (NOLOCK)
--ON OL.sysguid = g.LinkedLine
--INNER JOIN [400]..[orkrg] OH WITH (NOLOCK)
--ON OH.ordernr = OL.ordernr
INNER JOIN [400]..[humres] h with (NOLOCK)
ON h.res_id = g.sysmodifier
WHERE facode = 'CPH0897'
					AND g.transtype  NOT IN ('B', 'V')-- 'N'
					--AND g.transsubtype = 'A'
					AND reknr = 3300
ORDER BY g.datum DESC
