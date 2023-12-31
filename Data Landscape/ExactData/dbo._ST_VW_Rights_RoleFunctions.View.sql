/****** Object:  View [dbo].[_ST_VW_Rights_RoleFunctions]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create view [dbo].[_ST_VW_Rights_RoleFunctions] as
SELECT rf.id, rf.syscreated, rf.syscreator, r.role_id, r.role_name, f.fnc_id, fd.description
  FROM [400].[dbo].[pwrprm] rf
  inner join [400]..pwrole r on r.role_id = rf.role_id
  inner join [400]..pwfunc f on f.fnc_id = rf.fnc_id
  left join [_ST_VW_Rights_FunctionDescription] fd on f.fnc_id = fd.fnc_id
GO
