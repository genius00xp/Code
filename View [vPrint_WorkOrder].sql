----View [vPrint_WorkOrder]

SELECT H.Work_ID AS RecordID,
       H.Work_ID AS SMS_Record_ID,
       '' AS SMS_Status,
       H.CoID,
       H.Work_ID AS Work_Order_No,
       H.Property_ID AS Work_Order_Property_ID,
       H.Work_Date,
       H.Reference_No,
       L.LookupValue3 AS Work_Priority,
       H.Unit_Category,
       H.Unit_ID,
       H.Request_ID,
       H.Requestor_Code,
       H.Requestor_Name,
       CASE
           WHEN (CHARINDEX(' ', H.Fault_Location) - 1) > 0 THEN SUBSTRING(H.Fault_Location, 1, CHARINDEX(' ', H.Fault_Location) - 1)
           ELSE H.Fault_Location
       END AS Base,
       H.Fault_Location,
       H.Address,
       H.Office_Tel,
       H.Home_Tel,
       H.Mobile_No,
       H.Fax_No,
       H.Email_Address,
       H.Work_Type AS Problem_Code,
       H.Problem_Description,
       H.Remarks AS Internal_Remarks,
       H.Asset_Code,
       H.Supplier_Code,
       S.LookupValue2 AS Status,
       H.Work_Source,
       CASE
           WHEN S.LookupValue2 = 'Pending Verification  (Work Completed)'
                OR S.LookupValue2 = 'Work Completed' THEN 'Closed'
           ELSE S.LookupValue2
       END AS StatusClose,
       H.Progress,
       H.Diagnosis,
       H.Remedy,
       H.Cancel_Remarks,
       CONVERT(nvarchar(11), H.Work_Start, 106) AS Work_Start,
       H.Estimate_Start_Date,
       H.Estimate_End_Date,
       H.Personnel_Acknowledge,
       H.Supplier_Acknowledge,
       H.Personnel_Arrival,
       H.Supplier_Arrival,
       H.Actual_Start,
       H.Actual_End,
       H.Work_End,
       H.Retification_Start,
       CONVERT(Nvarchar(11), H.Retification_End, 106) AS Retification_End,
       CAST(ISNULL(D.Gross_Cost, 0) AS Money) AS Gross_Total_Cost,
       CAST(ISNULL(D.Tax_Amount_on_Cost, 0) AS Money) AS Tax_Amount_on_Cost,
       CAST(ISNULL(D.Cost_Disc, 0) AS Money) AS Disc_Amount_on_Cost,
       CAST(ISNULL(D.Net_Cost, 0) AS Money) AS Net_Total_Cost,
       D.Net_Cost_W_GST,
       CAST(ISNULL(D.Gross_Price, 0) AS Money) AS Gross_Total_Price,
       CAST(ISNULL(D.Tax_Amount_on_Price, 0) AS Money) AS Tax_Amount_on_Price,
       CAST(ISNULL(D.Price_Disc, 0) AS Money) AS Disc_Amount_on_Price,
       CAST(ISNULL(D.Net_Price, 0) AS Money) AS Net_Total_Price,
       D.Tax,
       SP.Contract_No,
       SP.Supplier_Name,
       SP.Supplier_Address,
       SP.Supplier_Phone,
       SP.Supplier_Email,
       SP.Contact_Name,
       PP.Name AS Personnel_Name,
       PP.Designation,
       PP.Mobile_No AS Personnel_Mobile,
       PP.Email_Address AS Personnel_Email,
       '[[RECIPIENT_NAME]]' AS RECIPIENT_NAME,
       '[[SENDER_NAME]]' AS SENDER_NAME,
       '[[SENDER_DESIGNATION]]' AS SENDER_DESIGNATION,
       '[[SENDER_TEL]]' AS SENDER_TEL,
       '[[MESSAGE_SUBJECT]]' AS MESSAGE_SUBJECT,
       D.Billable_Price,
       WI.Instruction_No,
       WI.Created_By,   ---Change 03
       WI.Created_Date	---Change 03
FROM dbo.tblWork_Order AS H
LEFT OUTER JOIN dbo.tblWork_Order_InstructionNo WI ON H.CoID = WI.CoID
AND H.Work_ID = WI.Work_ID
AND H.Property_ID = WI.Property_ID
LEFT OUTER JOIN
  (SELECT CoID,
          Work_ID,
          CAST(SUM(Gross_Cost) AS Money) AS Gross_Cost,
          MAX(Tax) AS Tax,
          CAST(SUM(Tax_Amount_on_Cost) AS Money) AS Tax_Amount_on_Cost,
          CAST(SUM(Cost_Disc) AS Money) AS Cost_Disc,
          CAST(SUM(Net_Cost) AS Money) AS Net_Cost,
          CAST(SUM(Net_Cost + Tax_Amount_on_Cost) AS Money) AS Net_Cost_W_GST,
          CAST(SUM(Gross_Price) AS Money) AS Gross_Price,
          CAST(SUM(Tax_Amount_on_Price) AS Money) AS Tax_Amount_on_Price,
          CAST(SUM(Price_Disc) AS Money) AS Price_Disc,
          CAST(SUM(Net_Price) AS Money) AS Net_Price,
          SUM(Bill_AMT) AS Billable_Price
   FROM
     (SELECT CoID,
             Work_ID,
             ISNULL(ROUND(SUM(Quantity * Unit_Cost), 2), 0) AS Gross_Cost,
             CASE WHEN GST_Chargable = '1' THEN CAST(GST_Percent AS nvarchar) ELSE '0' END AS Tax,
                                                                                              CASE WHEN To_Bill = 1 THEN SUM(Price_Total) ELSE 0 END AS Bill_AMT,
                                                                                                                                                        ROUND(SUM(CASE WHEN GST_Chargable = 1 THEN Cost_Total * (GST_PERCENT / 100) ELSE 0 END), 2) AS Tax_Amount_on_Cost,
                                                                                                                                                        ROUND(SUM(ROUND(ROUND(Quantity * Unit_Cost, 2) * (Cost_Disc / 100), 2)) * - 1, 2) AS Cost_Disc,
                                                                                                                                                        ROUND(SUM(Cost_Total), 2) AS Net_Cost,
                                                                                                                                                        SUM(Quantity * Unit_Price) AS Gross_Price,
                                                                                                                                                        ROUND(SUM(CASE WHEN GST_Chargable = 1 THEN Price_Total * (GST_PERCENT / 100) ELSE 0 END), 2) AS Tax_Amount_on_Price,
                                                                                                                                                        ROUND(SUM((Quantity * Unit_Price) * (Price_Disc / 100)) * - 1, 2) AS Price_Disc,
                                                                                                                                                        ROUND(SUM(Price_Total), 2) AS Net_Price
      FROM dbo.tblWork_Order_Details
      GROUP BY CoID,
               Work_ID,
               GST_Chargable,
               GST_Percent,
               To_Bill) AS D1
   GROUP BY CoID,
            Work_ID) AS D ON H.CoID = D.CoID
AND H.Work_ID = D.Work_ID
LEFT OUTER JOIN dbo._tblLookup AS L ON H.CoID = L.CoID
AND H.Work_Priority = L.LookupValue1
AND L.LookupID = 'WorkPriority'
LEFT OUTER JOIN dbo._tblLookup AS S ON H.CoID = L.CoID
AND H.Status = S.LookupValue1
AND S.LookupID = 'WorkOrderStatus'
LEFT OUTER JOIN
  (SELECT DISTINCT P.CoID,
                   P.Work_ID,
                   P.Contact_Name,
                   S.Contract_No,
                   S.Supplier_Name,
                   S.Supplier_Address,
                   S.Supplier_Phone,
                   S.Supplier_Email
   FROM dbo.tblWork_Order_Personnel AS P
   INNER JOIN dbo.tblSupplier_Contract AS S ON P.CoID = S.CoID
   AND P.Personnel_ID = S.Contract_No
   WHERE (P.Is_Personnel = 0)
     AND (P.Personnel_Rank = '1')) AS SP ON H.CoID = SP.CoID
AND H.Work_ID = SP.Work_ID
LEFT OUTER JOIN
  (SELECT P.CoID,
          P.Work_ID,
          P.Personnel_ID,
          P1.Name,
          P1.Designation,
          P1.Mobile_No,
          P1.Email_Address
   FROM dbo.tblWork_Order_Personnel AS P
   INNER JOIN dbo.tblPersonnel AS P1 ON P.CoID = P1.CoID
   AND P.Personnel_ID = P1.Personnel_ID
   WHERE (P.Is_Personnel = 1)
     AND (P.Personnel_Rank = '1')) AS PP ON H.CoID = PP.CoID
AND H.Work_ID = PP.Work_ID