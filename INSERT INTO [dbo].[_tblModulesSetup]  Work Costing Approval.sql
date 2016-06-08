---INSERT INTO [dbo].[_tblModulesSetup]  Work Costing Approval

USE [eFAMS_System_20160427]
GO

INSERT INTO [dbo].[_tblModulesSetup]
           ([ModuleSection]
           ,[ModuleID]
           ,[SortOrder]
           ,[ParentModuleID]
           ,[ModuleName]
           ,[ModuleLevel]
           ,[ASPFile]
           ,[Form_ASPFile]
           ,[ASPXFile]
           ,[Target]
           ,[ModuleImage]
           ,[Release]
           ,[ProfileName])
     VALUES
           ('Maintenance'
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
           ,'0'
           ,'Module - Maintenance'
		   )
GO


