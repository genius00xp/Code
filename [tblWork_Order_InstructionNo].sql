/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [eFAMS_Maint_20160427].[dbo].[tblWork_Order_InstructionNo]
  
  --drop table [eFAMS_Maint_20160427].[dbo].[tblWork_Order_InstructionNo]
  
SELECT  InstructionNo AS [Instruction_No], Reason, Property_ID, Last_Updated_By, Last_Updated_Date, Active  
FROM tblWork_Order_InstructionNo WHERE CoID='62'  AND Work_ID = 'SLA/CID/16050001' AND Property_ID = 'SLA_P1_0001' 
ORDER BY Last_Updated_Date,InstructionNo DESC