/****** Object:  StoredProcedure [dbo].[_AB_Create_Interfiliaal_XML]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sander van der Loo
-- Create date: 14-12-2011
-- Description:	Aanmaken interfiliaal XML
-- =============================================
CREATE PROCEDURE [dbo].[_AB_Create_Interfiliaal_XML] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @FileName varchar(60)
DECLARE @bcpCommand varchar(8000)
DECLARE @x XML
DECLARE @v varchar(max)  
Declare @Productieorder varchar (50)
Declare @Artikel varchar(50)
Declare @Serienummer varchar(50)
Declare @New_records varchar(50)

set @New_records = (select top 1 Productieorder from _AB_Interfiliaal_proces 
				  --where (Productieorder is not null and productieorder <>'' and Status_Interfiliaal = '0')
				where ((Productieorder is not null and productieorder <>'' and Status_Interfiliaal = '0') 
				  or (Productieorder is not null and Productieorder <>'' and Status_Interfiliaal = '4' and Imp_attempts <3 )
				   ))
if @New_records is null goto Geen_records

EXECUTE ('CREATE TABLE [ProdGlobe_live].._AB_XML_Interfiliaal (x xml)' )

SET @v = (
  SELECT(
-- de orderkop
   SELECT
    ' 70' AS 'Journal/@code',

     -- de Creditregel (regel 1)
     (SELECT 
			 'N' as '@type',
			 'G' as '@subtype',
			 'B' as '@linecode',
			 '100' as '@transactiontype',
             proddatum As 'Date',
             vrrdrek As 'GLAccount/@code',
             'Productieorder: '+ productieorder As 'Description',
             '600' As 'Costcenter/@code',
             Artikel AS 'Item/@code',
             
             Serienummer AS 'Asset/@code',
             'A' As 'Asset/@status',
             Serienummer As 'Asset/Description',
             'B' As 'Asset/Classification',
             Proddatum AS 'Asset/DateStart',
             '' As 'Asset/DateEnd',
             
             mag As 'Warehouse/@code',
             'REWORK' As 'Project/@code',
             --aanpassing SVL aantal variabel; origineel was:  -1 as 'Quantity'
             ISNULL(-Aantal,-1) as 'Quantity',
             cast(CostPriceStandard as numeric (18,3)) as 'Amount/Credit',
             proddatum As 'DocumentDate',
             proddatum As 'ReportDate', 
             rtrim(Eenheid) As 'Unit/@unit'
      FROM (select  * from [ProdGlobe_live].dbo._AB_Interfiliaal_proces with(nolock) 
      where  ((Status_Interfiliaal = '0'and Productieorder is not null and productieorder <>'' 
      and kop.Artikel = Artikel and isnull(kop.Serienummer,1) = isnull(Serienummer,1) and kop.Productieorder=Productieorder)
      or (kop.Artikel = Artikel and isnull(kop.Serienummer,1) = isnull(Serienummer,1) and kop.Productieorder=Productieorder and Productieorder is not null and Productieorder <>'' and Status_Interfiliaal = '4' and Imp_attempts <3 )))As regel1  
      FOR XML PATH ('FinEntryLine'), TYPE ),

     -- de Debitregel (regel 2)
            (SELECT 
 			 'N' as '@type',
			 'G' as '@subtype',
			 'B' as '@linecode',
			 '100' as '@transactiontype',
             proddatum As 'Date',
             vrrdrek As 'GLAccount/@code',
             'Productieorder: '+ productieorder As 'Description',
             '600' As 'Costcenter/@code',
             Artikel AS 'Item/@code',
             
             Serienummer AS 'Asset/@code',
             'A' As 'Asset/@status',
             Serienummer As 'Asset/Description',
             'B' As 'Asset/Classification',
             Proddatum AS 'Asset/DateStart',
             '' As 'Asset/DateEnd',
             
             '95' As 'Warehouse/@code',
             'REWORK' As 'Project/@code',
              --aanpassing SVL aantal variabel; origineel was:  1 as 'Quantity'
             ISNULL(Aantal,1) as 'Quantity',
             cast(CostPriceStandard as numeric (18,3)) as 'Amount/Debit',
             proddatum As 'DocumentDate',
             proddatum As 'ReportDate',
             rtrim(Eenheid) As 'Unit/@unit'
      FROM (select  * from [ProdGlobe_live].dbo._AB_Interfiliaal_proces with(nolock)
      where  ((Status_Interfiliaal = '0'and Productieorder is not null and productieorder <>'' 
      and kop.Artikel = Artikel and isnull(kop.Serienummer,1) = isnull(Serienummer,1) and kop.Productieorder=Productieorder)
      or (Productieorder is not null and Productieorder <>'' and Status_Interfiliaal = '4' and Imp_attempts <3
      and kop.Artikel = Artikel and isnull(kop.Serienummer,1) = isnull(Serienummer,1) and kop.Productieorder=Productieorder)))as regel2
      FOR XML PATH ('FinEntryLine'), TYPE )
     
   FROM (select * from [ProdGlobe_live].dbo._AB_Interfiliaal_proces with(nolock)
   where ((Status_Interfiliaal = '0' and Productieorder is not null and productieorder <>'') or 
           (Productieorder is not null and Productieorder <>'' and Status_Interfiliaal = '4' and Imp_attempts <3)))  AS kop

--Sluit XML Financiele boekingen
  FOR XML   PATH ('GLEntry'), TYPE) 

--sluit XML
 FOR XML PATH ('GLEntries'),ROOT('eExact'), ELEMENTS  XSINIL 
  )

--Schrijf resultaat (XML) weg in tabel _AB_XML
INSERT INTO [ProdGlobe_live].._AB_XML_Interfiliaal  (x) VALUES ( @v)
Select * from  [ProdGlobe_live].._AB_XML_Interfiliaal

--Maak een bestand aan met de XML
SET @FileName =  'F:\XML_import_export\InterFiliaal\Current\interfiliaal.xml'
SET @bcpCommand = 'bcp "SELECT x  FROM [ProdGlobe_live].._AB_XML_Interfiliaal" queryout "' 
SET @bcpCommand = @bcpCommand + @FileName + '" -T -c -S SQL'
PRINT @bcpCommand
EXEC [master]..xp_cmdshell @bcpCommand

DROP TABLE [ProdGlobe_live].._AB_XML_Interfiliaal

update dbo._AB_Interfiliaal_proces with(rowlock,nowait) set Status_Interfiliaal = '1' where Status_Interfiliaal = '0' or (Status_Interfiliaal = '4' and Imp_attempts <3)

Geen_records:

END

GO
