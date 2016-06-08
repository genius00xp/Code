INSERT INTO [eFAMS_System].[dbo].[_tblNumberSetup]
           ([FormatID]
           ,[Description]
           ,[ModuleSection]
           ,[LastUpdateBy]
           ,[LastUpdateOn]
           ,[Table_Name]
           ,[Field_Name])
     VALUES
           ('Work_Instruction_No'
           ,'Work Instruction No'
           ,'Maintenance'
           ,'Support'
           ,GetDate()
           ,'tblWork_Order_InstructionNo'
           ,'InstructionNo'
           )
GO

