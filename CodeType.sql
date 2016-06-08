/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [CoID]
      ,[CodeType]
      ,[CodeValue]
      ,[CodeText]
      ,[CodeOrder]
      ,[CodeID]
      ,[Last_Updated_By]
      ,[Last_Updated_Date]
      ,[CodeGroup]
  FROM [eFAMS_System_20160427].[dbo].[_tblCodes]
  where CodeType = '_InstructionNo'
  
  --insert into [eFAMS_System_20160427].[dbo].[_tblCodes]
  --values ('','','','','','','','','')