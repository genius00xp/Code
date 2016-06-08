---pushnoti(fixed)
----from c# translate
--Should work (fixed)--
---This part has missing the REPLACE STRING format

SELECT DISTINCT P.*, _Recipient = 'PUSH|' + P.UserID, _Recipient_Name = P.Name, _RecordID = 'WOPUSH|' + 'SLA/CID/16050083'
,  PP.Personnel_Level, _PropertyID = PP.Property_ID FROM tblPersonnel P 
 	LEFT JOIN tblPersonnel_Properties PP ON P.CoID = PP.CoID AND P.Personnel_ID = PP.Personnel_ID  
 	LEFT JOIN (SELECT DISTINCT CoID,UserID FROM kfpam_System..tblDevice_Registry ) D ON P.CoID = D.CoID AND P.UserID = D.UserID  
	 LEFT JOIN ( SELECT CoID, RecordID, UserID FROM [KFPAM_System].[dbo].[_tblAlert_Generated] WHERE Alert_Name='Work Order Personnel Push Notification' 
	 AND datediff(hh,Alert_Date,GETDATE()) <= 12  AND LEFT(UserID,4)='PUSH'  
	 ) G ON PP.CoID=G.CoID AND 'WOPUSH|' + 'SLA/CID/16050083' = LEFT(G.RecordID,LEN('WOPUSH|' + 'SLA/CID/16050083')) AND 'PUSH|' 
	 + P.UserID = G.UserID  
 LEFT JOIN 
 (SELECT DISTINCT CoID, Personnel_ID FROM tblPersonnel_OnLeave  WHERE CoID = '62' AND '2016-05-25 10:03:54 AM'  BETWEEN StartDate And EndDate) L  
 ON L.CoID = P.CoID AND L.Personnel_ID = P.Personnel_ID  WHERE CONVERT(NVARCHAR,P.CoID)='62' 
 AND ISNULL(L.Personnel_ID,'') = ''  
 AND (PP.Property_ID = 'SLA_P1_0001' OR PP.Property_Level IN (SELECT ISNULL(M.Property_Level,'SLA_P1_0001' ) as Parent_Level_Name 
		 FROM tblProperty_Level M  
		 LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level        
		WHERE  PP.Property_ID ='SLA_P1_0001' AND M.CoID = '62'        		
		UNION        
		SELECT ISNULL(P.Property_Level,'SLA_P1_0001') as Parent_Level_Name FROM tblProperty_Level M        
		LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID AND M.ParentID=P.ID        
		LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level        
		WHERE  PP.Property_ID ='SLA_P1_0001' AND M.CoID = '62'        
		UNION        
		SELECT ISNULL(PPP.Property_Level,'SLA_P1_0001') as Parent_Level_Name FROM tblProperty_Level M        
		LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID AND M.ParentID=P.ID        
		LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level        
		LEFT JOIN tblProperty_Level PPP ON P.CoID=PPP.CoID AND P.ParentID=PPP.ID        
		WHERE  PP.Property_ID ='SLA_P1_0001' AND M.CoID = '62'  )) 
	 AND ISNULL(G.RecordID,'')='' AND ISNULL(D.UserID,'') <> ''  
	AND ((('True' = 'True')
	 AND P.Supplier = 1) 
	 OR P.Supplier = 0) 
	 AND P.Start_Date <= '25 May 2016' AND 
	 ('25 May 2016' <= P.End_Date OR P.End_Date IS NULL)  
	 --<<Escalation>> <<TypeOfService>> <<Supplier>> <<Staff>>