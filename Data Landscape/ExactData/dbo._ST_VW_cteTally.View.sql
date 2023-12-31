/****** Object:  View [dbo].[_ST_VW_cteTally]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create View [dbo].[_ST_VW_cteTally] as

WITH
    E1(N) AS (select 1 from (values (1),(1),(1),(1),(1),(1),(1),(1),(1),(1))dt(n)),
    E2(N) AS (SELECT 1 FROM E1 a, E1 b), --10E+2 or 100 rows
    E4(N) AS (SELECT 1 FROM E2 a, E2 b), --10E+4 or 10,000 rows max
    cteTally(N) AS 
    (
        SELECT  ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM E4
    )
select N from cteTally
GO
