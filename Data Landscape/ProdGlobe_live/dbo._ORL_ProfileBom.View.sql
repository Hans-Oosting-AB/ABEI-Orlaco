/****** Object:  View [dbo].[_ORL_ProfileBom]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[_ORL_ProfileBom]
AS
    /**********************************
	Author  : Henk van Achterberg
	Created : 04-03-2015
	SP Name : dbo._ORL_ProfileBom
	RFP		: 150224-01-20704126 RFP koppeling Productie BOM Profile v2
	Purpose : Retrieves the BOM's present in the profile database
	        : with the revision and version.
	Inputs  : 
	Outputs : BOM ID (can be used in the detail view), ItemCode, Revision, Version and Status.
	Revision History
	-----------------
	Version No: Modified By: Modified Date: Comments:
	***************************************************
	1 : Henk van Achterberg : 04-03-2015 : Created
	***************************************************/
    SELECT  _ORL_ProfileBom.ID ,
            _ORL_ProfileBom.ItemCode ,
            _ORL_ProfileBom.Revision ,
            _ORL_ProfileBom.VERSION ,
            _ORL_ProfileBom.Status
    FROM    profile.dbo._ORL_ProfileBom;


GO
