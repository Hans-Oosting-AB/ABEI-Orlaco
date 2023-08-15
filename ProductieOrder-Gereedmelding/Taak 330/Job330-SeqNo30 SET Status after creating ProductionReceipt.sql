update [ProdGlobe_live].dbo._AB_GerProd_proces with(rowlock,nowait) set Status_ProdGer = '1' where Status_prodger = '0' or (Status_ProdGer = '4' and Imp_attempts <5)

update [ProdGlobe_live].[dbo].[_ST_PRD_Process_Cummulative]
Set Status = 2 WHERE runid = '%runid%'

exec [ProdGlobe_live].dbo._AB_sp_Report_Status_Prod