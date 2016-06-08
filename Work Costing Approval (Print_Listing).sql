----Work Costing Approval (Print_Listing)

SELECT P.Purchase_Category,P.Min_Amount,P.Max_Amount,P.Form_Name as Approval_Profile,ISNULL(A.Number_Approver,0) as Level,ISNULL(U1.DisplayName,A.Approver1_Group) as [Approver #1]
, ISNULL(U2.DisplayName,A.Approver2_Group) as [Approver #2],ISNULL(U3.DisplayName,A.Approver3_Group) as [Approver #3], CASE A.Property_ID WHEN '' THEN 'All Properties' ELSE ISNULL(A.Property_ID,'') END as Applicable_Property,P.Last_Updated_By,P.Last_Updated_On, P.Form_Name + '|' + CAST(ISNULL(A.ID,0) as varchar) as _RecordID, P.Form_Name as _RecordTitle
 FROM tblPurchase_Approval P 
LEFT JOIN [eFAMS_System_20160427].dbo._tblApprovalSetup A  ON A.Form_Name=P.Form_Name AND A.CoID=P.CoID
LEFT JOIN [eFAMS_System_20160427].dbo._tblUsers U1 ON U1.CoID=A.CoID AND U1.UserID=A.Approver1_UserID
 LEFT JOIN [eFAMS_System_20160427].dbo._tblUsers U2 ON U2.CoID=A.CoID AND U2.UserID=A.Approver2_UserID 
LEFT JOIN [eFAMS_System_20160427].dbo._tblUsers U3 ON U3.CoID=A.CoID AND U3.UserID=A.Approver3_UserID 
 WHERE P.CoID=57 ORDER BY P.Purchase_Category,P.Min_Amount,P.Max_Amount,ISNULL(A.Property_ID,'') 


 select * from [eFAMS_System_20160427].dbo._tblApprovalSetup A 
 select * from  [eFAMS_System_20160427].dbo._tblApprovalSetup
 select * from [eFAMS_System_20160427].dbo._tblUsers