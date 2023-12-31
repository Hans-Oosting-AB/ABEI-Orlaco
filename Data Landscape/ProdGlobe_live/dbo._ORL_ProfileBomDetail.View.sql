/****** Object:  View [dbo].[_ORL_ProfileBomDetail]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[_ORL_ProfileBomDetail]
AS
    /**********************************
	Author  : Henk van Achterberg
	Created : 04-03-2015
	SP Name : dbo._ORL_ProfileBomDetail
	RFP		: 150224-01-20704126 RFP koppeling Productie BOM Profile v2
	Purpose : Retrieves the contents of a BOM in the profile database
	        : with the supplied parent itemcode, revision- and versionnumber OR the BOMID (internal value).
	Inputs  : 
	Outputs : 
	Revision History
	-----------------
	Version No: Modified By: Modified Date: Comments:
	***************************************************
	1 : Henk van Achterberg : 04-03-2015 : Created
	2 : Henk van Achterberg : 05-03-2015 : Added Phantom status
	3 : Henk van Achterberg : 24-04-2015 : Change QTY to SQTY * UQTY
	***************************************************/
    SELECT  _ORL_ProfileBomDetail.ParentBomID ,
            _ORL_ProfileBomDetail.ParentItemCode ,
            _ORL_ProfileBomDetail.ParentRevision ,
            _ORL_ProfileBomDetail.ParentVersion ,
            _ORL_ProfileBomDetail.ParentStatus ,
            _ORL_ProfileBomDetail.ChildItemCode ,
            _ORL_ProfileBomDetail.ChildRevision ,
            _ORL_ProfileBomDetail.ChildVersion ,
            _ORL_ProfileBomDetail.POS ,
            _ORL_ProfileBomDetail.QTY ,
            _ORL_ProfileBomDetail.SQTY ,
            _ORL_ProfileBomDetail.UQTY ,
            _ORL_ProfileBomDetail.UNIT ,
            _ORL_ProfileBomDetail.CONDITION ,
            _ORL_ProfileBomDetail.ChildBomID
    FROM    profile.dbo._ORL_ProfileBomDetail;





GO
