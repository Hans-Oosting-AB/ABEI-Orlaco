/****** Object:  View [dbo].[_ST_VW_CRDCODECHECK]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[_ST_VW_CRDCODECHECK]
AS
select  LTRIM(RTRIM(cmp_code)) AS CMP_C, LTRIM(RTRIM(crdcode)) AS crdcode, LTRIM(RTRIM(crdnr)) AS crdnr, cmp_name  from [400]..Cicmpy (nolock) 
where LTRIM(RTRIM(cmp_code)) != LTRIM(RTRIM(crdcode)) OR LTRIM(RTRIM(crdcode)) != LTRIM(RTRIM(crdnr)) OR  LTRIM(RTRIM(cmp_code))  != LTRIM(RTRIM(crdnr))

GO
