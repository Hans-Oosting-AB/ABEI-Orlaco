/****** Object:  StoredProcedure [dbo].[_AB_sp_ReplaceFileOrDirNames]    Script Date: 8/17/2023 9:09:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[_AB_sp_ReplaceFileOrDirNames] 
  (@oldpathToObject varchar(200),
   @oldName 	varchar(50),
   @newpathToObject varchar(200))
as
begin
	declare @winCmd  varchar(400)
  	declare @isFileThere     bit
	declare @isDirectory	 bit
	declare @parentDirExists bit
	declare @oldfullNamewithPath varchar(250)
	declare @newfullNamewithPath varchar(250)
	declare @newname varchar (50)

	set nocount on 

	set @newname = cast(CONVERT(CHAR(8), CURRENT_TIMESTAMP, 112)as varchar) + '_' + cast(replace(convert(varchar, getdate(), 114),':','')as varchar)
	 + '_' + @oldName
	print @newname
	set @oldfullNamewithPath = @oldpathToObject+'\'+@oldName 	
	set @newfullNamewithPath = @newpathToObject+'\'+@newName 	

        Create table #temp (isFileThere 	bit,
			    isDirectory 	bit,
			    parentDirExists	bit)

	Insert #temp exec master..xp_fileExist @oldfullNamewithPath

	select @isFileThere = isFileThere,
	       @isDirectory = isDirectory 
        FROM #temp

	if (@isFileThere = 1)
        begin 
         set @winCmd = 'move /Y "' + @oldfullNamewithPath + '" "' + @newfullNamewithPath +'"'
	     
	   --set @winCmd = 'rename ' + 
	   --@pathToObject+'\'+@oldName + ' ' + @newName
        end 
	else 
        begin 
		if (@isDirectory = 1)
		begin 
		   set @winCmd = 'move /Y ' + @oldpathToObject+'\'+
				@oldName + ' '+ @oldpathToObject+'\'+@newName
		end
	end
	print @winCmd
	exec master..xp_cmdShell @winCmd

	drop table #temp
	set nocount off
   
end

GO
