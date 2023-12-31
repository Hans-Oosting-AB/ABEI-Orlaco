/****** Object:  Table [dbo].[_ST_SS_WO_Planning]    Script Date: 8/17/2023 8:59:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ST_SS_WO_Planning](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PlanningId] [int] NOT NULL,
	[WorkOrderId] [int] NULL,
	[HID] [int] NOT NULL,
	[PlannedStart] [datetime] NOT NULL,
	[PlannedEnd] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[SysCreated] [datetime] NOT NULL,
	[ABEI_Updated] [bit] NOT NULL,
	[UserID] [int] NOT NULL,
	[EmployeeID] [int] NULL,
	[ABEI_status] [int] NOT NULL,
 CONSTRAINT [PK__ST_SS_WO_Planning] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_ST_SS_WO_Planning] ADD  CONSTRAINT [DF__ST_SS_WO_Planning_ABEI_status]  DEFAULT ((0)) FOR [ABEI_status]
GO
