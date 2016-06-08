---ALTER TABLE tblProperty,tblProperty_Unit,tblProperty_Zone
--APPLIES to eFAMS_PROPERTY

ALTER TABLE [tblProperty] ADD Land_Area  [decimal](18, 2) NOT NULL ;


ALTER TABLE [tblProperty_Unit] ADD Land_Area  [decimal](18, 2) NOT NULL ;


ALTER TABLE [tblProperty_Zone] ADD Land_Area  [decimal](18, 2) NOT NULL ;



