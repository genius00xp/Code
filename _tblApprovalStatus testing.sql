------_tblApprovalStatus testing

--test1

SELECT DISTINCT Form_Name FROM _tblApprovalSetup WHERE CoID= '63' 
AND (Form_Name LIKE 'Work Costing%') ORDER BY Form_Name


select * from eFAMS_Maint_20160427..tblWorkCosting_Approval



SELECT * FROM _tblApprovalStatus

SELECT  * FROM _tblApprovalSetup


---GetApprovalSetupRecord(byval FormName)
SELECT TOP 1 * FROM _tblApprovalSetup 
WHERE CoID=62 AND Form_Name='Work Costing' 
AND ID = dbo._fGetApprovalSetupID(62,'Work Costing','SLA_P1_0001') 
AND Number_Approver>0 
ORDER BY Property_ID DESC

SELECT TOP 1 * FROM _tblApprovalSetup WHERE CoID=62 AND Form_Name='Work Costing3' 
AND ID = dbo._fGetApprovalSetupID(62,'Work Costing3','SLA_P1_0001') AND Number_Approver>0 
ORDER BY Property_ID DESC


Select * from eFAMS_Maint_20160427..tblWorkCosting_Approval Where CoID='62' 
AND Form_Name LIKE 'Work Costing%' 
ORDER BY Min_Amount,Max_Amount

SELECT * FROM _tblApprovalStatus 
WHERE CoID=62 AND Form_Name='Work Costing' 
AND RecordID IN (N'')



SELECT  * FROM _tblApprovalSetup A
LEFT JOIN eFAMS_Maint_20160427..tblWorkCosting_Approval B
ON A.Form_Name = B.Form_Name AND A.CoID = B.CoID
WHERE A.Form_Name LIKE '%'
AND A.CoID = ''
ORDER BY B.Min_Amount,B.Max_Amount

Select * FROM _tblApprovalSetup A  LEFT JOIN tblWorkCosting_Approval B  ON A.Form_Name = B.Form_Name AND A.CoID = B.CoID 
  Where A.CoID='62'  AND A.Form_Name LIKE 'Work Costing%'  ORDER BY B.Min_Amount,B.Max_Amount



Select B.* FROM [eFAMS_System_20160427].dbo._tblApprovalSetup A  
LEFT JOIN tblWorkCosting_Approval B  ON A.Form_Name = B.Form_Name AND A.CoID = B.CoID  
 Where A.CoID='62'  AND B.Form_Name LIKE 'Work Costing%' 
  ORDER BY B.Min_Amount,B.Max_Amount



Select * from tblWorkCosting_Approval Where CoID='62'  AND Form_Name LIKE 'Work Costing%' 
 ORDER BY Min_Amount,Max_Amount

SELECT * FROM _tblApprovalStatus WHERE CoID=62 AND Form_Name='Work Costing' 
AND RecordID IN (N'')

select * from _tblApprovalStatus

select * from tblWork_Order where Work_ID = 'SLA/CID/16050013'


SELECT Requires_Action,Approval_Status FROM _tblApprovalStatus
where RecordID = 'SLA/CID/16050012'


SELECT Requires_Action,Approval_Status FROM _tblApprovalStatus M WHERE M.CoID=62 AND (M.Property_ID=N'SLA_P1_0001' OR M.Property_ID='')  
AND M.Requestor=N'1' AND M.Form_Name='Work Costing' AND M.RecordID='SLA/CID/16050013'

select * from tblWork_Order where Work_ID = 'SLA/CID/16050006'

update tblWork_Order
set Approved_Budget = 0
where Work_ID = 'SLA/CID/16050006'

select * from tblWork_Order_Details where Work_ID = 'SLA/CID/16050006'


SELECT * FROM _tblCodes WHERE CoID='62' AND CodeType='_InstructionNo'



SELECT A.[Module] FROM 
(
SELECT LookupValue1 AS [Form Name], LookupValue2 AS [Module ASPFile], LookupValue3 AS [Order], LookupValue4 AS [Module]
, LookupValue5 AS [Connection String], LookupValue6 AS [Record URL],ID,LastUpdateBy,LastUpdateOn,Property_ID 
FROM [eFAMS_System_20160427].dbo._tblLookup WHERE LookupID=N'ApprovalSetup'
) A  
WHERE A.[Form Name]='Work Costing1' 

SELECT A.[Module] FROM 
(
SELECT LookupValue1 AS [Form Name], LookupValue2 AS [Module ASPFile], LookupValue3 AS [Order], LookupValue4 AS [Module], LookupValue5 AS [Connection String]
, LookupValue6 AS [Record URL],ID,LastUpdateBy,LastUpdateOn,Property_ID FROM [eFAMS_System_20160427].dbo._tblLookup WHERE LookupID=N'ApprovalSetup'
) A  
WHERE A.[Form Name]='Work Costing1' 

SELECT * FROM _tblApprovalStatus  WHERE CoID='62' AND Form_Name='Work Costing1' AND RecordID IN ('SLA/CID/16050001')

SELECT   RecordID,  Action_Date as [Date], Action_By as User_Name, Action_Description as Description 
FROM         _tblApprovalHistory WHERE CoID='62' AND 
RecordID IN ('SLA/CID/16050001')  AND Form_Name='Work Costing1'



delete from _tblApprovalStatus

delete from _tblApprovalHistory

select * from _tblApprovalStatus

select * from _tblApprovalHistory

select * from tblWork_Order where work_ID = 'SLA/CID/16050006'

update tblWork_Order
set Approved_Budget = 0
where Work_ID = 'SLA/CID/16040025'