---work order testing
SELECT * FROM [tblWork_Order] WHERE CoID=62 AND Property_ID='SLA_P1_0001' 
AND Work_ID='SLA/CID/16050072' AND 
Status IN (SELECT Status FROM
 (SELECT LookupValue1 AS [Status], LookupValue2 AS [Work Order Status], LookupValue3 AS [Active(Y/N)], LookupValue4 AS [Order Column], LookupValue5 AS [Color]
 , LookupValue6 AS [Allow Status Update], LookupValue7 AS [Approval Status] FROM [KFPAM_MAINT].dbo._tblLookup 
 WHERE LookupID=N'WorkOrderStatus') S
  WHERE S.[Allow Status Update]='Y')