----Work Order Listing

SELECT * FROM ( 
SELECT R.Work_Date,R.Reference_No as Ref_No,U.LookupValue2 as Status,Problem_Description,R.Remedy as Action_Taken, R.Fault_Location,WP.Description AS Work_Priority
,R.Requestor_Name,R.Email_Address AS Requestor_Email,R.Mobile_No AS Requestor_Mobile_No,R.Work_Type as Problem_Code,R.Work_ID,R.Unit_ID,R.Request_ID
, Work_Order_Type = CASE WHEN Work_Order_Type='S' THEN 'Schedule' WHEN Work_Order_Type='P' THEN 'Project' ELSE 'Request' END, WT.Work_Type,WT.Type_Of_Service
, P.Property_Name,R.Property_ID,R.Property_ID + ' ' + P.Property_Name as Property, R.Work_Priority as _Work_Priority, R.Status As Work_Status, R.Primary_Work_Id 
FROM tblWork_Order R 
LEFT JOIN vWorkType WT ON R.CoID = WT.CoID AND R.Work_Type = WT.All_Work_Type 
LEFT JOIN [eFAMS_Property].dbo.tblProperty P ON P.CoID=R.CoID AND P.Property_ID=R.Property_ID 
LEFT JOIN 
( 
SELECT M.Property_Level as Name, ISNULL(P.Property_Level,'') as Parent_Level_Name, ISNULL(L.LookupValue2,'') as Level_Type, M.Last_Updated_By, M.Last_Updated_Date
, M.Active, M.ID, M.HierDepth, M.HierLevel, 'Level' as Item_Type, '' as Property_ID, '' as Unit_Category, '' as Unit_ID, '' as Property_Name, '' as Unit_Category_Name
, '' as Unit_Number, M.HierOrder, M.HierLineage 
FROM tblProperty_Level M 
LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID AND M.ParentID=P.ID 
LEFT JOIN _tblLookup L ON L.CoID=M.CoID AND L.LookupId='PropertyLevelType' AND L.LookupValue1=M.HierDepth 
WHERE M.CoID='62' 
UNION ALL 
SELECT P.Property_Name as Name, ISNULL(L.Property_Level,'') as Parent_Level_Name, 'Property' as Level_Type, P.Last_Updated_By, P.Last_Updated_Date, P.Active, P.ID
, ISNULL(L.HierDepth+1,1) as HierDepth, ISNULL(L.HierLevel + '_1' + P.Property_ID,'_'+P.Property_ID) as HierLevel,'Property' as Item_Type, P.Property_ID, '' as Unit_Category
, '' as Unit_ID, P.Property_Name as Property_Name, '' as Unit_Category_Name, '' as Unit_Number, L.HierOrder, L.HierLineage 
FROM [eFAMS_Property].dbo.tblProperty P 
LEFT JOIN tblProperty_Level_Properties T ON T.CoID=P.CoID AND T.Property_ID=P.Property_ID 
LEFT JOIN tblProperty_Level L ON L.CoID=T.CoID AND L.Property_Level=T.Property_Level WHERE P.CoID='62' 
) L ON L.Level_Type='Property' AND L.ID=P.ID 
LEFT JOIN _tblLookup U ON R.Status=U.LookupValue1 AND U.LookupID='WorkOrderStatus' 
LEFT JOIN 
(
SELECT LookupValue1 AS [Work Priority], LookupValue2 AS [Work Priority Level], LookupValue3 AS [Description],ID,LastUpdateBy,LastUpdateOn,Property_ID 
FROM [eFAMS_MAINT].dbo._tblLookup WHERE LookupID=N'WorkPriority' AND CoID='62') WP ON WP.[Work Priority]=R.Work_Priority 
WHERE R.CoID='62' AND R.Property_ID=N'SLA_P1_001'
) TBL 
ORDER BY [Property],[Work_Date] DESC
,[Work_ID] DESC 