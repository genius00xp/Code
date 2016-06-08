---Property User_DefinedFieldName

SELECT * FROM (SELECT ISNULL(Table1.Text, LookupValue1) as [Form_Name], LookupValue2 as [Field_Name_(Unique)], LookupValue3 as [Field_Description], LookupValue4 as [Category]
, LookupValue5 as [Field_Order], ISNULL(Table6.Text, LookupValue6) as [Field_Type], LookupValue7 as [Field_Table], LookupValue8 as [Is_Optional(Y/N)]
, ISNULL(Table9.Text, LookupValue9) as [Default_Function], LookupValue10 as [Tab_Index], L.ID 
FROM _tblLookup L 
LEFT JOIN (SELECT DISTINCT [LookupValue1] as Value
, [LookupValue1] + ' - ' + [LookupValue2] as Text 
FROM [eFAMS_Property].dbo.[_tblLookup] 
WHERE CONVERT(NVARCHAR,CoID) IN ('','62.SLA_P1_001','62') 
AND LookupID=N'UserField_Property_FormName') Table1 ON Table1.Value=L.LookupValue1 
LEFT JOIN (SELECT DISTINCT [LookupValue1] as Value, [LookupValue1] + ' - ' + [LookupValue2] as Text FROM [eFAMS_Property].dbo.[_tblLookup]
 WHERE CONVERT(NVARCHAR,CoID) IN ('','62.SLA_P1_001','62') AND LookupID=N'FieldType') Table6 ON Table6.Value=L.LookupValue6 
 LEFT JOIN (SELECT DISTINCT [LookupValue1] as Value, [LookupValue1] + ' - ' + [LookupValue2] as Text FROM [eFAMS_Property].dbo.[_tblLookup] 
 WHERE CONVERT(NVARCHAR,CoID) IN ('','62.SLA_P1_001','62') AND LookupID=N'UserField_DefaultFunction') Table9 ON Table9.Value=L.LookupValue9
  WHERE L.LookupID=N'UserField_Property_FieldName' AND L.CoID='62') TBL ORDER BY [Form_Name] ASC
  , [Field_Name_(Unique)], [Field_Description], [Category], [Field_Order], [Field_Type], [Field_Table], [Is_Optional(Y/N)], [Default_Function], [Tab_Index] 