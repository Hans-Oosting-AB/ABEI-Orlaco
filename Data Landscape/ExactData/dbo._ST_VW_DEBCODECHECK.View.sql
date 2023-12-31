/****** Object:  View [dbo].[_ST_VW_DEBCODECHECK]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[_ST_VW_DEBCODECHECK]
AS
select  LTRIM(RTRIM(cmp_code)) AS CMP_C, LTRIM(RTRIM(debcode)) AS Debcode, LTRIM(RTRIM(debnr)) AS Debnr, cmp_name  from [400]..Cicmpy (nolock) 
where LTRIM(RTRIM(cmp_code)) != LTRIM(RTRIM(debcode)) OR LTRIM(RTRIM(debcode)) != LTRIM(RTRIM(Debnr)) OR  LTRIM(RTRIM(cmp_code))  != LTRIM(RTRIM(Debnr))

GO
