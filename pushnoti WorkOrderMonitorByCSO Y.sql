---pushnoti WorkOrderMonitorByCSO Y
---this is from c# IF condition

SELECT TOP 100 PERCENT W.Work_ID, W.Work_Date, W.Work_Priority, W.Work_Type, W.Problem_Description, W.Fault_Location, W.Requestor_Name, W.Personnel_SMS, W.Personnel_Email
, WP.Personnel_ID, P.UserID, P.Name  , _Recipient = 'PUSH|' + P.UserID, W.Work_Date as _OrderBy  , 'WOPUSH|' + Cast(W.Work_ID as nvarchar) + '|' + Cast(WP.Item_No as nvarchar) 
as _RecordID, W.Work_ID as _RecordTitle  , _Email_Address = '', _Mobile_No = P.Mobile_No  , _Sending_Priority = ISNULL(L.LookupValue2,'0')  , P.Name as _Recipient_Name
, 'WOPUSH|' + W.Work_ID as _Alert_Record_ID,W.Property_ID, WP.Item_No as _Item_No  , _CoID = W.CoID, _PropertyID = W.Property_ID  FROM tblWork_Order W  
INNER JOIN tblWork_Order_Personnel WP ON W.CoID = WP.CoID AND W.Work_ID = WP.Work_ID  INNER JOIN tblPersonnel P ON P.CoID = WP.CoID AND P.Personnel_ID = WP.Personnel_ID  
INNER JOIN KFPAM_Property.dbo.tblProperty  PR ON W.CoID = PR.CoID AND W.Property_ID = PR.Property_ID  
LEFT JOIN tblProperty_WorkPriority E ON W.CoID = E.CoID AND W.Property_ID = E.Property_ID AND ISNULL(CASE WHEN W.Work_Priority = '' THEN NULL ELSE W.Work_Priority END
,'N' ) = E.Work_Priority  
INNER JOIN dbo._tblLookup AS L ON L.CoID = W.CoID AND L.LookupID = 'WorkPriority' AND L.LookupValue1 = W.Work_Priority  
LEFT JOIN ( SELECT CoID, RecordID FROM KFPAM_System.dbo._tblAlert_Generated  
WHERE Alert_Name= 'Work Order Personnel Push Notification' AND datediff(hh,Alert_Date,GETDATE()) <= 12  AND LEFT(UserID,4)='PUSH') G ON W.CoID=G.CoID AND 'WOPUSH|' + 
Cast(W.Work_ID as nvarchar) + '|' + Cast(WP.Item_No as nvarchar)=G.RecordID  WHERE CONVERT(NVARCHAR,W.CoID)= '62' 
AND (W.Status=1 OR W.Status=2 

) AND W.Personnel_SMS=1 AND WP.Is_Personnel=1  AND datediff(hh,W.Log_Date,GETDATE()) <= 12 AND ISNULL(G.RecordID,'')=''  
AND W.Work_ID = 'SLA/CID/16050084' AND P.Start_Date <= W.Log_Date AND (W.Log_Date <= P.End_Date OR P.End_Date IS NULL)  AND GETDATE() > = ISNULL 
((SELECT DATEADD(n,ISNULL(E.Escalation_Interval,30),Max(Alert_Date))  FROM [FAMS_System].dbo._tblAlert_Generated G2   
WHERE W.CoID=G2.CoID AND G2.Alert_Name= 'Work Order Personnel Push Notification'  
AND datediff(hh,G2.Alert_Date,GETDATE()) <= 12  AND G2.RecordID LIKE 'WOPUSH|' + Cast(W.Work_ID as nvarchar) + '|%'    ),GETDATE())  
AND (W.Supplier_SMS = 1 OR W.Supplier_Email = 1)  AND P.Supplier = 0  
AND GETDATE() > = DATEADD(n,ISNULL(E.Escalation_Interval,30) * (WP.Personnel_Rank - 1), W.Log_Date) 


