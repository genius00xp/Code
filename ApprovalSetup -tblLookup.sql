--ApprovalSetup -tblLookup
 --SELECT *
--FROM _tblLookupSetup
--WHERE LookupID = 'ApprovalSetup'

--SELECT *
--FROM _tblLookup
--WHERE LookupID = 'ApprovalSetup' --ApprovalSetup

--  SELECT *
--  FROM
--    (SELECT LookupValue1 AS [Form_Name], LookupValue2 as [Module_ASPFile], LookupValue3 as [Order], LookupValue4 as [Module] ,
--            LookupValue5 AS [Connection_String], LookupValue6 as [Record_URL],
--            L.ID
--     FROM _tblLookup L
--     WHERE L.LookupID=N'ApprovalSetup') TBL ---Purchasing Approval

