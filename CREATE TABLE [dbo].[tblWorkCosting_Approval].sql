---CREATE TABLE [dbo].[tblWorkCosting_Approval]

USE eFAMS_Maint_20160427
GO

/****** Object:  Table [dbo].[tblPurchase_Approval]    Script Date: 27/5/2016 3:25:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblWorkCosting_Approval](
	[CoID] [int] NOT NULL  DEFAULT (0),
	[Form_Name] [nvarchar](300) NOT NULL,
	[Min_Amount] [money] NOT NULL,
	[Max_Amount] [money] NOT NULL,
	[Last_Updated_By] [nvarchar](300) NOT NULL,
	[Last_Updated_On] [datetime] NOT NULL
) ON [PRIMARY]

GO


