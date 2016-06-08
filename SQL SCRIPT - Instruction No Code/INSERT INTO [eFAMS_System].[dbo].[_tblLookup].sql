INSERT INTO [eFAMS_System].[dbo].[_tblLookup]
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
          ( ''
           ,'SystemOption'
           ,'Maintenance Settings'
           ,'Show Work Order Instruction No'
           ,'0|Disable'
           + char(13) + char(10) + 
            '1|Enable'
           ,'_InstructionNo'
           ,'To allow generation of Instruction No on Work Order'
           ,''
           ,''
           ,''
           ,''
           ,''
           ,'support'
           ,GetDate()
           ,''
           )
GO


