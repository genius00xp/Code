--exra field show


---sqlstr	"
SELECT [Field Name (Unique)] AS FieldName, [Field Description] as FieldDesc,[Field Type] as FieldType,[Is Optional(Y/N)] as Optional 
FROM (SELECT LookupValue1 AS [Form Name], LookupValue2 AS [Field Name (Unique)], LookupValue3 AS [Field Description], LookupValue4 AS [Category], LookupValue5 AS [Field Order]
, LookupValue6 AS [Field Type], LookupValue7 AS [Field Table], LookupValue8 AS [Is Optional(Y/N)], LookupValue9 AS [Default Function], LookupValue10 AS [Tab Index]
,ID,LastUpdateBy,LastUpdateOn,Property_ID FROM [eFAMS_Property].dbo._tblLookup WHERE LookupID=N'UserField_Property_FieldName' AND CoID='62') TBL 
WHERE [Form Name]='Property Unit' AND [Field Table] IN ('','none') ORDER BY [Field Order]


SELECT [Field Name (Unique)] AS FieldName, [Field Description] as FieldDesc,[Field Type] as FieldType,[Is Optional(Y/N)] as Optional 
FROM (SELECT LookupValue1 AS [Form Name], LookupValue2 AS [Field Name (Unique)], LookupValue3 AS [Field Description], LookupValue4 AS [Category], LookupValue5 AS [Field Order]
, LookupValue6 AS [Field Type], LookupValue7 AS [Field Table], LookupValue8 AS [Is Optional(Y/N)], LookupValue9 AS [Default Function], LookupValue10 AS [Tab Index]
,ID,LastUpdateBy,LastUpdateOn,Property_ID FROM [eFAMS_Property].dbo._tblLookup WHERE LookupID=N'UserField_Tenant_FieldName' AND CoID='62') TBL 
WHERE [Form Name]='Tenancy Contract' AND [Field Table] IN ('','none') ORDER BY [Field Order]
