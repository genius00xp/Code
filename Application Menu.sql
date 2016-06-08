---Application Menu

SELECT *
FROM
  (SELECT SortOrder AS Menu_Order,
          ModuleName AS Menu_Name,
          ModuleID AS Menu_ID,
          ASPFile AS Primary_File_Path,
          ModuleLevel AS LEVEL,
          Release AS R,
          ProfileName AS Profile,
          ParentModuleID,
          ModuleSection,
          ID,
          ModuleID + '-' + ModuleName AS ModuleTitle,
                           ModuleLevel
   FROM _tblModulesSetup
   WHERE 1=1) TBL