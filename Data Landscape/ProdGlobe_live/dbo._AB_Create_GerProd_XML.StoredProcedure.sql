/****** Object:  StoredProcedure [dbo].[_AB_Create_GerProd_XML]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sander van der Loo
-- Create date: 14-12-2011
-- Description:	Aanmaken Ontvangst productie XML
-- =============================================
CREATE PROCEDURE [dbo].[_AB_Create_GerProd_XML] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @FileName varchar(50)
DECLARE @bcpCommand varchar(8000)
DECLARE @x XML
DECLARE @v varchar(max) 
Declare @Productieorder varchar (50)
Declare @Artikel varchar(50)
Declare @Serienummer varchar(50)
Declare @New_records varchar(50)

set @New_records = (select top 1 Productieorder from _AB_GerProd_proces 
				  where ((Productieorder is not null and productieorder <>'' and Status_ProdGer = '0') 
				  or (Productieorder is not null and Productieorder <>'' and Status_ProdGer = '4' and Imp_attempts <1 )
				  ))

if @New_records is null goto Geen_records

EXECUTE ('CREATE TABLE [ProdGlobe_live].._AB_XML_GerProd (x xml)' )

SET @v = '<?xml version="1.0" encoding="iso-8859-1" ?>' + CONVERT(varchar(max),
  ( SELECT
      -- de orderkop
      'R' AS '@type',
 
      
      (-- de orderregels 
       SELECT
         Productieorder AS 'OrderNumber', 
        Proddatum as 'Date', 
        'Receipt by XML' as 'YourRef',
        (select
        Artikel as 'Code'
        from [ProdGlobe_live].dbo._AB_GerProd_proces as Item WITH (NOLOCK)
        where (item.artikel = prodline.artikel and isnull(item.serienummer,1) = isnull(prodline.serienummer,1) 
        and Status_ProdGer = '0' and Productieorder is not null and productieorder <>'')
        or (item.artikel = prodline.artikel and isnull(item.serienummer,1) = isnull(prodline.serienummer,1) and 
        Productieorder is not null and Productieorder <>'' and Status_ProdGer = '4' and Imp_attempts <1 )
			
        For XML PATH ('Item'), TYPE),
        --aanpassing SVL aantal variabel; origineel was:  1 as 'Quantity',
        ISNULL(aantal,1) as 'Quantity',
        Serienummer as 'Serialnumber'
        --aanpassing SVL warehouse uit XML om magazijn variabel (magazijn uit productieorder) te maken
        --'1' as 'Warehouse/@code'
        
       FROM 
        [ProdGlobe_live].dbo._AB_GerProd_proces as Prodline WITH (NOLOCK)
        where (Status_ProdGer = '0' and Productieorder is not null and productieorder <>'')
        or (Productieorder is not null and Productieorder <>'' and Status_ProdGer = '4' and Imp_attempts <1 )

		FOR XML PATH ('Line'), TYPE )
		
		FOR XML PATH ('Manufacturing'), Root('XML'),ELEMENTS  XSINIL))
		 
--Schrijf resultaat (XML) weg in tabel _AB_XML
INSERT INTO [ProdGlobe_live].._AB_XML_GerProd  (x) VALUES ( @v)
Select * from  [ProdGlobe_live].._AB_XML_GerProd

--Maak een bestand aan met de XML
SET @FileName =  'F:\XML_import_export\ProdGer\Current\Gerprod.xml'
SET @bcpCommand = 'bcp "SELECT x  FROM [ProdGlobe_live].._AB_XML_GerProd" queryout "' 
SET @bcpCommand = @bcpCommand + @FileName + '" -T -c -S SQL'
PRINT @bcpCommand
EXEC [master]..xp_cmdshell @bcpCommand

DROP TABLE [ProdGlobe_live].._AB_XML_GerProd

update dbo._AB_GerProd_proces with(rowlock,nowait) set Status_ProdGer = '1' where Status_prodger = '0' or (Status_ProdGer = '4' and Imp_attempts <1)

Geen_records:

END
GO
