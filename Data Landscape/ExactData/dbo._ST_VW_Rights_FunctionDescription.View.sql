/****** Object:  View [dbo].[_ST_VW_Rights_FunctionDescription]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE view [dbo].[_ST_VW_Rights_FunctionDescription] as
  select top 100 percent m.mnu_id, m.prnt_id, m.seq_no, m.m_type, m.fnc_id, m.root_id,
  case when mpp.descr64 is null or mpp.descr64 = '@DEFAULTROLE@' then '' else RTRIM(mpp.descr64) + ' / ' end +
  case when mp.descr64 is null or mp.descr64 = '@DEFAULTROLE@' then '' else RTRIM(mp.descr64) + ' / ' end +
  case when m.descr64 is null then '' else RTRIM(m.descr64) end as description
  from [400]..sysmnu (nolock) m
  left join [400]..sysmnu (nolock) mp on m.prnt_id = mp.mnu_id
  left join [400]..sysmnu (nolock) mpp on mp.prnt_id = mpp.mnu_id
  --where not m.fnc_id is null AND LTRIM(RTRIM(m.fnc_id)) != ''
  order by fnc_id
GO
