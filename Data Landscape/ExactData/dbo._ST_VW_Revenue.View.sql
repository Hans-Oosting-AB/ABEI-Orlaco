/****** Object:  View [dbo].[_ST_VW_Revenue]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[_ST_VW_Revenue] AS
      SELECT fakdebnr, YEAR(orddat) AS OrdYear, SUM(o.bdr_val) OrdBdr, 400 as Adm FROM [400]..orkrg o WITH (NOLOCK) WHERE o.ord_soort = 'V' AND orddat > '2018-01-01' GROUP BY fakdebnr, YEAR(orddat) 
UNION SELECT fakdebnr, YEAR(orddat) AS OrdYear, SUM(o.bdr_val) OrdBdr, 483 as Adm FROM [483]..orkrg o WITH (NOLOCK) WHERE o.ord_soort = 'V' AND orddat > '2018-01-01' GROUP BY fakdebnr, YEAR(orddat) 
UNION SELECT fakdebnr, YEAR(orddat) AS OrdYear, SUM(o.bdr_val) OrdBdr, 484 as Adm FROM [484]..orkrg o WITH (NOLOCK) WHERE o.ord_soort = 'V' AND orddat > '2018-01-01' GROUP BY fakdebnr, YEAR(orddat) 


GO
