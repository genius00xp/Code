 --01
--SELECT W.*,L.LookupValue4 Escalation FROM tblWork_Order W LEFT JOIN _tblLookup L ON L.CoID = W.CoID AND L.LookupID = 'WorkPriority' AND L.LookupValue1 = W.Work_Priority
--WHERE CONVERT(NVARCHAR,W.CoID)='62' AND W.Work_ID = 'SLA/CID/16050083'
 ----02
--Select * from tblPersonnel_TypeOfServices S  INNER JOIN vWorkType T ON T.CoID=S.CoID AND T.Type_Of_Service=S.Type_Of_Service AND T.HierDepth=3
--AND T.Problem_Code=N'Gate damaged' WHERE S.CoID='62'
 ----03
--Select * from tblProperty_WorkPriority E  WHERE E.CoID='62' AND E.Property_ID = 'SLA_P1_0001'  AND E.Work_Priority = 'N'
 --04 (long code) (else condition)

SELECT DISTINCT P.*, _Recipient = 'PUSH|' + P.UserID, _Recipient_Name = P.Name, _RecordID = 'WOPUSH|' + 'SLA/CID/16050087' , PP.Personnel_Level, _PropertyID = PP.Property_ID
FROM tblPersonnel P
LEFT JOIN tblPersonnel_Properties PP ON P.CoID = PP.CoID
AND P.Personnel_ID = PP.Personnel_ID
LEFT JOIN
  (SELECT DISTINCT CoID,
                   UserID
   FROM KFPAM_System.dbo.tblDevice_Registry) D ON P.CoID = D.CoID
AND P.UserID = D.UserID
LEFT JOIN
  (SELECT CoID,
          RecordID,
          UserID
   FROM KFPAM_System.dbo._tblAlert_Generated
   WHERE Alert_Name='Work Order Personnel Push Notification'
     AND datediff(hh,Alert_Date,GETDATE()) <= 12
     AND LEFT(UserID,4)='PUSH') G ON PP.CoID=G.CoID
AND 'WOPUSH|' + 'SLA/CID/16050087' = LEFT(G.RecordID,LEN('WOPUSH|' + 'SLA/CID/16050087'))
AND 'PUSH|' + P.UserID = G.UserID
LEFT JOIN
  (SELECT DISTINCT CoID,
                   Personnel_ID
   FROM tblPersonnel_OnLeave
   WHERE CoID = '62'
     AND '2016-5-25 10:00:54 AM' BETWEEN StartDate AND EndDate) L ON L.CoID = P.CoID
AND L.Personnel_ID = P.Personnel_ID
WHERE CONVERT(NVARCHAR,P.CoID)='62'
  AND ISNULL(L.Personnel_ID,'') = ''
  AND (PP.Property_ID = 'SLA_P1_0001'
       OR PP.Property_Level IN
         (SELECT ISNULL(M.Property_Level,'SLA_P1_0001') AS Parent_Level_Name
          FROM tblProperty_Level M
          LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID
          AND M.Property_Level=PP.Property_Level
          WHERE PP.Property_ID ='SLA_P1_0001'
            AND M.CoID = '62'
          UNION SELECT ISNULL(P.Property_Level,'SLA_P1_0001') AS Parent_Level_Name
          FROM tblProperty_Level M
          LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID
          AND M.ParentID=P.ID
          LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID
          AND M.Property_Level=PP.Property_Level
          WHERE PP.Property_ID ='SLA_P1_0001'
            AND M.CoID = '62'
          UNION SELECT ISNULL(PPP.Property_Level,'SLA_P1_0001') AS Parent_Level_Name
          FROM tblProperty_Level M
          LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID
          AND M.ParentID=P.ID
          LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID
          AND M.Property_Level=PP.Property_Level
          LEFT JOIN tblProperty_Level PPP ON P.CoID=PPP.CoID
          AND P.ParentID=PPP.ID
          WHERE PP.Property_ID ='SLA_P1_0001'
            AND M.CoID = '62'))
  AND ISNULL(G.RecordID,'')=''
  AND ISNULL(D.UserID,'') <> ''
  AND ((('True' = 'True')
        AND P.Supplier = 1)
       OR P.Supplier = 0)
  AND P.Start_Date <= '25 May 2016'
  AND ('25 May 2016' <= P.End_Date
       OR P.End_Date IS NULL) --<<Escalation>> <<TypeOfService>> <<Supplier>> <<Staff>>---
 --Below Script will Replace the string above----

  AND GETDATE() > = DATEADD(n,120 * (PP.Personnel_Level - 1), '2016-5-25 9:23:54 AM')
  AND P.Personnel_ID IN
    (SELECT Personnel_ID
     FROM tblPersonnel_TypeOfServices
     WHERE CoID = '62'
       AND Type_Of_Service =
         (SELECT Type_Of_Service
          FROM vWorkType
          WHERE Problem_Code = N'Gate damaged'
            AND CoID = '62')) --UNION
 --SELECT DISTINCT P.*, _Recipient = 'PUSH|' + P.UserID, _Recipient_Name = P.Name, _RecordID = 'WOPUSH|' + 'SLA/CID/16050083',  PP.Personnel_Level, _PropertyID = PP.Property_ID FROM tblPersonnel P
 --LEFT JOIN tblPersonnel_Properties PP ON P.CoID = PP.CoID AND P.Personnel_ID = PP.Personnel_ID
 --LEFT JOIN (SELECT DISTINCT CoID,UserID FROM KFPAM_System.dbo.tblDevice_Registry) D ON P.CoID = D.CoID AND P.UserID = D.UserID
 --LEFT JOIN ( SELECT CoID, RecordID, UserID FROM KFPAM_System.dbo._tblAlert_Generated WHERE Alert_Name='Work Order Personnel Push Notification'
 --AND datediff(hh,Alert_Date,GETDATE()) <= 12  AND LEFT(UserID,4)='PUSH'  ) G ON PP.CoID=G.CoID AND 'WOPUSH|' + 'SLA/CID/16050083' =
 --LEFT(G.RecordID,LEN('WOPUSH|' + 'SLA/CID/16050083')) AND 'PUSH|' + P.UserID = G.UserID
 --INNER JOIN (SELECT DISTINCT CoID, Personnel_ID,Assign_To_Personnel_ID FROM tblPersonnel_OnLeave WHERE CoID = '62' AND '2016-5-25 10:03:54 AM' BETWEEN StartDate And EndDate) L
 -- ON L.CoID = P.CoID AND L.Assign_To_Personnel_ID = P.Personnel_ID  WHERE CONVERT(NVARCHAR,P.CoID)='62' AND ISNULL(L.Personnel_ID,'') <> ''
 -- AND (PP.Property_ID = 'SLA_P1_0001'    OR PP.Property_Level IN SELECT ISNULL(M.Property_Level,'SLA_P1_0001') as Parent_Level_Name FROM tblProperty_Level M
 -- LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level
 --  WHERE  PP.Property_ID ='SLA_P1_0001' AND M.CoID = '62'
 --  UNION
 --  SELECT ISNULL(P.Property_Level,'SLA_P1_0001') as Parent_Level_Name FROM tblProperty_Level M
 --  LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID AND M.ParentID=P.ID
 --  LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level
 --  WHERE  PP.Property_ID ='SLA_P1_0001' AND M.CoID = '62'
 --  UNION
 --  SELECT ISNULL(PPP.Property_Level,'SLA_P1_0001') as Parent_Level_Name FROM tblProperty_Level M
 --  LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID AND M.ParentID=P.ID
 --  LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level
 --  LEFT JOIN tblProperty_Level PPP ON P.CoID=PPP.CoID AND P.ParentID=PPP.ID
 --  WHERE  PP.Property_ID ='SLA_P1_0001' AND M.CoID = '62'  ))
 --  AND ISNULL(G.RecordID,'')='' AND ISNULL(D.UserID,'') <> ''
 --  AND ((('True' = 'True') AND P.Supplier = 1) OR P.Supplier = 0)
 --  AND P.Start_Date <= '25 May 2016' AND ('25 May 2016' <= P.End_Date OR P.End_Date IS NULL)
 --05
--SELECT * FROM KFPAM_System.dbo.tblDevice_Registry D  WHERE CONVERT(NVARCHAR, D.CoID)='62'
--AND D.Application_Type = 'eFAMS'  AND D.UserID = '7'
 -------------------------------------------
--06 (if condition)
 --SELECT TOP 100 PERCENT W.Work_ID, W.Work_Date, W.Work_Priority, W.Work_Type, W.Problem_Description, W.Fault_Location, W.Requestor_Name, W.Personnel_SMS, W.Personnel_Email
--, WP.Personnel_ID, P.UserID, P.Name  , _Recipient = 'PUSH|'+ P.UserID, W.Work_Date as _OrderBy  , 'WOPUSH|' + Cast(W.Work_ID as nvarchar) +
-- '|' + Cast(WP.Item_No as nvarchar) as _RecordID, W.Work_ID as _RecordTitle  , _Email_Address = '', _Mobile_No = P.Mobile_No  , _Sending_Priority = ISNULL(L.LookupValue2,'0')  , P.Name as _Recipient_Name,
-- 'WOPUSH|'+ W.Work_ID as _Alert_Record_ID,W.Property_ID, WP.Item_No as _Item_No  , _CoID = W.CoID, _PropertyID = W.Property_ID  FROM tblWork_Order W
--   INNER JOIN tblWork_Order_Personnel WP ON W.CoID = WP.CoID AND W.Work_ID = WP.Work_ID
--   INNER JOIN tblPersonnel P ON P.CoID = WP.CoID AND P.Personnel_ID = WP.Personnel_ID
--   INNER JOIN KFPAM_Property.dbo.tblProperty PR ON W.CoID = PR.CoID AND W.Property_ID = PR.Property_ID
--   LEFT JOIN tblProperty_WorkPriority E ON W.CoID = E.CoID AND W.Property_ID = E.Property_ID AND ISNULL(CASE WHEN W.Work_Priority = '' THEN NULL ELSE W.Work_Priority END,
--   'N') = E.Work_Priority
--   INNER JOIN dbo._tblLookup AS L ON L.CoID = W.CoID AND L.LookupID = 'WorkPriority' AND L.LookupValue1 = W.Work_Priority
--   LEFT JOIN ( SELECT CoID, RecordID FROM KFPAM_System.dbo._tblAlert_Generated
--   WHERE Alert_Name='Work Order Personnel Push Notification' AND datediff(hh,Alert_Date,GETDATE()) <= 12  AND
--   LEFT(UserID,4)='PUSH'  ) G ON W.CoID=G.CoID AND 'WOPUSH|' + Cast(W.Work_ID as nvarchar) + '|' + Cast(WP.Item_No as nvarchar)=G.RecordID
--   WHERE CONVERT(NVARCHAR,W.CoID)='62' AND (W.Status=1 OR W.Status=2
--   --<<Status Critical>>
--   ) AND W.Personnel_SMS=1 AND WP.Is_Personnel=1  AND datediff(hh,W.Log_Date,GETDATE()) <= 12 AND ISNULL(G.RecordID,'')=''
--   AND W.Work_ID = 'SLA/CID/16050084' AND P.Start_Date <= W.Log_Date AND (W.Log_Date <= P.End_Date OR P.End_Date IS NULL)  AND GETDATE() > = ISNULL
--   ((SELECT DATEADD(n,ISNULL(E.Escalation_Interval,30),Max(Alert_Date))   FROM [FAMS_System].dbo._tblAlert_Generated G2
--   WHERE W.CoID=G2.CoID AND G2.Alert_Name='Work Order Personnel Push Notification'
--   AND datediff(hh,G2.Alert_Date,GETDATE()) <= 12  AND G2.RecordID LIKE 'WOPUSH|' + Cast(W.Work_ID as nvarchar) + '|%'    ),GETDATE())
--   AND (((W.Supplier_SMS = 1 OR W.Supplier_Email = 1) AND P.Supplier = 1) OR P.Supplier = 0)
--   AND GETDATE() > = DATEADD(n,ISNULL(E.Escalation_Interval,30) * (WP.Personnel_Rank - 1), W.Log_Date)
 -- )
