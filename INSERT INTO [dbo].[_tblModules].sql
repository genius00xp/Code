----INSERT INTO [dbo].[_tblModules]

USE [eFAMS_System_20160427]
GO

INSERT INTO [dbo].[_tblModules]
           ([CoID]
           ,[ModuleSection]
           ,[ModuleID]
           ,[SortOrder]
           ,[ParentModuleID]
           ,[ModuleName]
           ,[ModuleLevel]
           ,[ASPFile]
           ,[Form_ASPFile]
           ,[ASPXFile]
           ,[Target]
           ,[ModuleImage])
     VALUES
           ('62'
           ,'Maintenance'
           ,'1650'
           ,'1650'
           ,'1600'
           ,'Work Costing Approval'
           ,'2'
           ,'_Applications/iMaintain/_Print/workcosting_approval.asp'
           ,''
           ,''
           ,'main'
           ,'_Images/listicon.gif'
		   )
GO


