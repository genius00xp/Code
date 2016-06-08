---INSERT INTO [dbo].[_tblLookup] ApprovalSetup

USE [eFAMS_System_20160427]
GO

INSERT INTO [dbo].[_tblLookup]
           ([CoID]
           ,[LookupID]
           ,[LookupValue1]
           ,[LookupValue2]
           ,[LookupValue3]
           ,[LookupValue4]
           ,[LookupValue5]
           ,[LookupValue6]
           ,[LookupValue7]
           ,[LookupValue8]
           ,[LookupValue9]
           ,[LookupValue10]
           ,[LastUpdateBy]
           ,[LastUpdateOn]
           ,[Property_ID])
     VALUES
           (''
           ,'ApprovalSetup'
           ,'Work Costing'
           ,'_Applications/iMaintain/_Forms/work_order.asp'
           ,'9'
           ,'Maintenance'
           ,'MAINTConnectionStr'
           ,''
           ,''
           ,''
           ,''
           ,''
           ,'support'
           ,GETDATE()
           ,''
		   )
GO


