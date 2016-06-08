USE [eFAMS_MAINT]
GO

/****** Object:  Table [dbo].[tblWork_Order_InstructionNo]    Script Date: 05/09/2016 17:15:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblWork_Order_InstructionNo](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CoID] [int] NOT NULL,
	[Work_ID] [nvarchar](20) NOT NULL,
	[InstructionNo] [nvarchar](20) NOT NULL,
	[Property_ID] [nvarchar](20) NOT NULL,
	[Year] [nvarchar](4) NOT NULL,
	[Month] [nvarchar](2) NOT NULL,
	[Number] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Reason] [nvarchar](300) NOT NULL Default(''),
	[Last_Updated_By] [nvarchar](300) NOT NULL,
	[Last_Updated_Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tblWork_Order_InstructionNo] PRIMARY KEY CLUSTERED 
(
	[CoID] ASC,
	[Work_ID] ASC,
	[InstructionNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


