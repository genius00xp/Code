---DON"T USE--WRONG

SELECT DISTINCT P.*, _Recipient = 'PUSH|' + P.UserID, _Recipient_Name = P.Name, _RecordID = 'WOPUSH|' + 'SLA/CID/16040029'
,  PP.Personnel_Level
, _PropertyID = PP.Property_ID 
FROM tblPersonnel P 
 	LEFT JOIN tblPersonnel_Properties PP ON P.CoID = PP.CoID AND P.Personnel_ID = PP.Personnel_ID  
 	LEFT JOIN 
 	(
 	SELECT DISTINCT CoID,UserID FROM kfpam_System..tblDevice_Registry 
 	) D ON P.CoID = D.CoID AND P.UserID = D.UserID  
	 LEFT JOIN 
	 ( 
	 SELECT CoID, RecordID, UserID FROM [KFPAM_System].[dbo].[_tblAlert_Generated] WHERE Alert_Name='Work Order Personnel Push Notification' AND datediff(hh,Alert_Date,GETDATE()) <= 12  AND LEFT(UserID,4)='PUSH'  
	 ) G ON PP.CoID=G.CoID AND 'WOPUSH|' + 'SLA/CID/16040029' = LEFT(G.RecordID,LEN('WOPUSH|' + 'SLA/CID/16040029')) AND 'PUSH|' + P.UserID = G.UserID  
 LEFT JOIN 
 (
 SELECT DISTINCT CoID, Personnel_ID FROM tblPersonnel_OnLeave  WHERE CoID = '62' AND '2016-04-13 11:09:05'  BETWEEN StartDate And EndDate
 ) L  ON L.CoID = P.CoID AND L.Personnel_ID = P.Personnel_ID  
 WHERE CONVERT(NVARCHAR,P.CoID)='62' AND ISNULL(L.Personnel_ID,'') = ''  
 AND 
 (	
 	PP.Property_ID = 'SLA_P2_0002'  
 --	OR PP.Property_Level IN 
	-- (
 --		SELECT ISNULL
 --		(M.Property_Level,'SLA_P2_0002' ) as Parent_Level_Name 
	--	 FROM tblProperty_Level M        
	--	LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level        
	--	WHERE  PP.Property_ID ='SLA_P2_0002' AND M.CoID = '62'        
	--	UNION        
	--	SELECT ISNULL(P.Property_Level,'SLA_P2_0002') as Parent_Level_Name FROM tblProperty_Level M        
	--	LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID AND M.ParentID=P.ID        
	--	LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level        
	--	WHERE  PP.Property_ID ='SLA_P2_0002' AND M.CoID = '62'        
	--	UNION        
	--	SELECT ISNULL(PPP.Property_Level,'SLA_P2_0002') as Parent_Level_Name FROM tblProperty_Level M        
	--	LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID AND M.ParentID=P.ID        
	--	LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level        
	--	LEFT JOIN tblProperty_Level PPP ON P.CoID=PPP.CoID AND P.ParentID=PPP.ID        
	--	WHERE  PP.Property_ID ='SLA_P2_0002' AND M.CoID = '62'  
	--)
) 
	-- AND ISNULL(G.RecordID,'')='' AND ISNULL(D.UserID,'') <> ''  
	AND 
	--(
	--(
	('False' = 'True')
	-- AND P.Supplier = 1) 
	 --OR P.Supplier = 0) 
	 AND P.Start_Date <= '2016-04-13 11:09:05.783' AND ('2016-04-13 11:09:05.783') <= P.End_Date 
	OR P.End_Date IS NULL  --<<Escalation>> <<TypeOfService>> <<Supplier>> <<Staff>>

-- UNION  
 
-- SELECT DISTINCT P.*, _Recipient = 'PUSH|' + P.UserID, _Recipient_Name = P.Name, _RecordID = 'WOPUSH|' + 'SLA/CID/16040029',  PP.Personnel_Level, _PropertyID = PP.Property_ID 
-- FROM tblPersonnel P  
--LEFT JOIN tblPersonnel_Properties PP ON P.CoID = PP.CoID AND P.Personnel_ID = PP.Personnel_ID  
--LEFT JOIN 
--(
--SELECT DISTINCT CoID,UserID 
--FROM kfpam_System..tblDevice_Registry
--) D 
--ON P.CoID = D.CoID AND P.UserID = D.UserID  
--LEFT JOIN 
--( 
--SELECT CoID, RecordID, UserID 
--FROM [KFPAM_System].[dbo].[_tblAlert_Generated]
--WHERE Alert_Name='Work Order Personnel Push Notification' AND datediff(hh,Alert_Date,GETDATE()) <= 12  AND LEFT(UserID,4)='PUSH'  
--) G 
--ON PP.CoID=G.CoID AND 'WOPUSH|' + 'SLA/CID/16040029' = LEFT(G.RecordID,LEN('WOPUSH|' + 'SLA/CID/16040029')) AND 'PUSH|' + P.UserID = G.UserID  
--INNER JOIN 
--(
--SELECT DISTINCT CoID, Personnel_ID,Assign_To_Personnel_ID 
--FROM tblPersonnel_OnLeave            
--WHERE CoID = '62' AND '2016-04-13 11:09:05' BETWEEN StartDate And EndDate
--) L  
--ON L.CoID = P.CoID AND L.Assign_To_Personnel_ID = P.Personnel_ID  
--WHERE CONVERT(NVARCHAR,P.CoID)='62' AND ISNULL(L.Personnel_ID,'') <> ''  
--AND 
--(PP.Property_ID = 'SLA_P2_0002'   
--OR PP.Property_Level IN 
--(
--SELECT ISNULL(M.Property_Level,'SLA_P2_0002') as Parent_Level_Name 
--FROM tblProperty_Level M        
--LEFT JOIN tblProperty_Level_Properties PP ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level        
--WHERE  PP.Property_ID ='SLA_P2_0002' AND M.CoID = '62'       

-- UNION     
    
-- SELECT ISNULL(P.Property_Level,'SLA_P2_0002') as Parent_Level_Name 
-- FROM tblProperty_Level M        
-- LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID AND M.ParentID=P.ID        
-- LEFT JOIN tblProperty_Level_Properties PP 
-- ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level        
-- WHERE  PP.Property_ID ='SLA_P2_0002' AND M.CoID = '62'        
-- UNION        
-- SELECT ISNULL(PPP.Property_Level,'SLA_P2_0002') as Parent_Level_Name 
-- FROM tblProperty_Level M        
-- LEFT JOIN tblProperty_Level P ON M.CoID=P.CoID AND M.ParentID=P.ID       
-- LEFT JOIN tblProperty_Level_Properties PP 
-- ON M.CoID=PP.CoID AND M.Property_Level=PP.Property_Level        
-- LEFT JOIN tblProperty_Level PPP ON P.CoID=PPP.CoID AND P.ParentID=PPP.ID       
-- WHERE  PP.Property_ID ='SLA_P2_0002' AND M.CoID = '62'  
-- ))  
-- AND ISNULL(G.RecordID,'')='' AND ISNULL(D.UserID,'') <> ''  
-- AND ((('False' = 'True') AND P.Supplier = 1) OR P.Supplier = 0)  
-- AND P.Start_Date <= '2016-04-13 11:09:05.783' AND ('2016-04-13 11:09:05.783') <= P.End_Date 
--  OR P.End_Date IS NULL 
  -- <<Escalation>> <<TypeOfService>> <<Supplier>> <<Staff>> "	string



    --,'62'=N'62',@DefaultWorkPriority=N'N','Work Order Personnel Push Notification'=N'Work Order Personnel Push Notification','SLA/CID/16040029'=N'SLA/CID/16040029','SLA_P2_0002'=N'SLA_P2_0002'
    --,'False'=N'False',@Work_Type=N'Ext Pipe burst/leak','2016-04-13 11:09:05.783'='2016-04-13 11:09:05.783',@Escalation_Interval=120,@AcknowledgeStatus=N''