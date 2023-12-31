/****** Object:  View [dbo].[_ORL_Serialnumbers]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[_ORL_Serialnumbers]
AS
    /**********************************
	Author  : Henk van Achterberg
	Created : 05-06-2015
	SP Name : dbo._ORL_Serialnumbers
	RFP		: -
	Purpose : Retrieves serialnumbers from the produced items
			: Sort by Shippingdate DESC to get the Globe rows first
	Inputs  : 
	Outputs : Serialnumber, Productiontime, ItemNumber, 
	        : ItemDesciption, Production order
	Revision History
	-----------------
	Version No: Modified By: Modified Date: Comments:
	***************************************************
	1 : Henk van Achterberg : 05-06-2015 : Created
	***************************************************/
   -- SELECT  s.SerialNumber ,
   --         s.ProductionDateTime ,
   --         s.ShippingDate ,
   --         s.ItemNumber ,
   --         COALESCE(s.ItemDescription, I.Description) AS ItemDescription ,
   --         s.ProductionOrder ,
			--s.DataSource
   -- FROM    ODP_PROD.Production.dbo.[_ORL_vw_Serialnumbers] s
   --         LEFT JOIN [400].dbo.Items I ON I.ItemCode = s.ItemNumber
   -- UNION ALL
    SELECT  serie_num as SerialNumber,
            NULL as ProductionDateTime,
            pakbon_dat as ShippingDate,
            artcode as ItemNumber,
            I.Description as ItemDescription,
            NULL as ProductionOrder,
			'Exact' as DataSource
    FROM    [400].dbo.[_AB_Leverdatum_Serienummers] s
            LEFT JOIN [400].dbo.Items I ON I.ItemCode = s.artcode;

GO
