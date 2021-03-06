﻿USE [SnackMachineDDD]
GO
/****** Object:  Table [dbo].[SnackMachine]     ******/
DROP TABLE IF EXISTS [dbo].[SnackMachine]
GO
/****** Object:  Table [dbo].[Snack]     ******/
DROP TABLE IF EXISTS [dbo].[Snack]
GO
/****** Object:  Table [dbo].[Slot]     ******/
DROP TABLE IF EXISTS [dbo].[Slot]
GO
/****** Object:  Table [dbo].[Ids]     ******/
DROP TABLE IF EXISTS [dbo].[Ids]
GO
/****** Object:  Table [dbo].[HeadOffice]     ******/
DROP TABLE IF EXISTS [dbo].[HeadOffice]
GO
/****** Object:  Table [dbo].[Atm]     ******/
DROP TABLE IF EXISTS [dbo].[Atm]
GO
/****** Object:  Table [dbo].[Atm]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Atm](
	[AtmID] [bigint] NOT NULL,
	[MoneyCharged] [decimal](18, 2) NOT NULL,
	[OneCentCount] [int] NOT NULL,
	[TenCentCount] [int] NOT NULL,
	[QuarterCount] [int] NOT NULL,
	[OneDollarCount] [int] NOT NULL,
	[FiveDollarCount] [int] NOT NULL,
	[TwentyDollarCount] [int] NOT NULL,
 CONSTRAINT [PK_Atm] PRIMARY KEY CLUSTERED 
(
	[AtmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeadOffice]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeadOffice](
	[HeadOfficeID] [bigint] NOT NULL,
	[Balance] [decimal](18, 2) NOT NULL,
	[OneCentCount] [int] NOT NULL,
	[TenCentCount] [int] NOT NULL,
	[QuarterCount] [int] NOT NULL,
	[OneDollarCount] [int] NOT NULL,
	[FiveDollarCount] [int] NOT NULL,
	[TwentyDollarCount] [int] NOT NULL,
 CONSTRAINT [PK_HeadOffice] PRIMARY KEY CLUSTERED 
(
	[HeadOfficeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ids]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ids](
	[EntityName] [nvarchar](100) NOT NULL,
	[NextHigh] [int] NOT NULL,
 CONSTRAINT [PK_Ids] PRIMARY KEY CLUSTERED 
(
	[EntityName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slot]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slot](
	[SlotID] [bigint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[SnackID] [bigint] NOT NULL,
	[SnackMachineID] [bigint] NOT NULL,
	[Position] [int] NOT NULL,
 CONSTRAINT [PK_Slot] PRIMARY KEY CLUSTERED 
(
	[SlotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Snack]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Snack](
	[SnackID] [bigint] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Snack] PRIMARY KEY CLUSTERED 
(
	[SnackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SnackMachine]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SnackMachine](
	[SnackMachineID] [bigint] IDENTITY(1,1) NOT NULL,
	[OneCentCount] [int] NOT NULL,
	[TenCentCount] [int] NOT NULL,
	[QuarterCount] [int] NOT NULL,
	[OneDollarCount] [int] NOT NULL,
	[FiveDollarCount] [int] NOT NULL,
	[TwentyDollarCount] [int] NOT NULL,
 CONSTRAINT [PK_SnackMachine] PRIMARY KEY CLUSTERED 
(
	[SnackMachineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Atm] ([AtmID], [MoneyCharged], [OneCentCount], [TenCentCount], [QuarterCount], [OneDollarCount], [FiveDollarCount], [TwentyDollarCount]) VALUES (1, CAST(0.00 AS Decimal(18, 2)), 20, 20, 20, 20, 20, 20)
INSERT [dbo].[HeadOffice] ([HeadOfficeID], [Balance], [OneCentCount], [TenCentCount], [QuarterCount], [OneDollarCount], [FiveDollarCount], [TwentyDollarCount]) VALUES (1, CAST(0.00 AS Decimal(18, 2)), 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Ids] ([EntityName], [NextHigh]) VALUES (N'Atm', 1)
INSERT [dbo].[Ids] ([EntityName], [NextHigh]) VALUES (N'HeadOffice', 1)
INSERT [dbo].[Ids] ([EntityName], [NextHigh]) VALUES (N'Slot', 1)
INSERT [dbo].[Ids] ([EntityName], [NextHigh]) VALUES (N'Snack', 1)
INSERT [dbo].[Ids] ([EntityName], [NextHigh]) VALUES (N'SnackMachine', 1)
INSERT [dbo].[Slot] ([SlotID], [Quantity], [Price], [SnackID], [SnackMachineID], [Position]) VALUES (1, 100, CAST(3.00 AS Decimal(18, 2)), 1, 1, 1)
INSERT [dbo].[Slot] ([SlotID], [Quantity], [Price], [SnackID], [SnackMachineID], [Position]) VALUES (2, 100, CAST(2.00 AS Decimal(18, 2)), 2, 1, 2)
INSERT [dbo].[Slot] ([SlotID], [Quantity], [Price], [SnackID], [SnackMachineID], [Position]) VALUES (3, 100, CAST(1.00 AS Decimal(18, 2)), 3, 1, 3)
INSERT [dbo].[Snack] ([SnackID], [Name]) VALUES (1, N'Chocolate')
INSERT [dbo].[Snack] ([SnackID], [Name]) VALUES (2, N'Soda')
INSERT [dbo].[Snack] ([SnackID], [Name]) VALUES (3, N'Gum')
SET IDENTITY_INSERT [dbo].[SnackMachine] ON 

INSERT [dbo].[SnackMachine] ([SnackMachineID], [OneCentCount], [TenCentCount], [QuarterCount], [OneDollarCount], [FiveDollarCount], [TwentyDollarCount]) VALUES (1, 1, 5, 3, 3, 3, 3)
SET IDENTITY_INSERT [dbo].[SnackMachine] OFF
