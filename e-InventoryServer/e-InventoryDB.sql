USE [master]
GO
/****** Object:  Database [e-Inventory]    Script Date: 10/28/2015 9:14:53 PM ******/
CREATE DATABASE [e-Inventory]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'e-Inventory', FILENAME = N'F:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\e-Inventory.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'e-Inventory_log', FILENAME = N'F:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\e-Inventory_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [e-Inventory] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [e-Inventory].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [e-Inventory] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [e-Inventory] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [e-Inventory] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [e-Inventory] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [e-Inventory] SET ARITHABORT OFF 
GO
ALTER DATABASE [e-Inventory] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [e-Inventory] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [e-Inventory] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [e-Inventory] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [e-Inventory] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [e-Inventory] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [e-Inventory] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [e-Inventory] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [e-Inventory] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [e-Inventory] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [e-Inventory] SET  DISABLE_BROKER 
GO
ALTER DATABASE [e-Inventory] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [e-Inventory] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [e-Inventory] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [e-Inventory] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [e-Inventory] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [e-Inventory] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [e-Inventory] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [e-Inventory] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [e-Inventory] SET  MULTI_USER 
GO
ALTER DATABASE [e-Inventory] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [e-Inventory] SET DB_CHAINING OFF 
GO
ALTER DATABASE [e-Inventory] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [e-Inventory] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [e-Inventory]
GO
/****** Object:  Table [dbo].[branch]    Script Date: 10/28/2015 9:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[branch](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_branch] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[category]    Script Date: 10/28/2015 9:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[inventory]    Script Date: 10/28/2015 9:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inventory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](100) NULL,
	[branchID] [int] NOT NULL,
 CONSTRAINT [PK_catalog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[manufacturer]    Script Date: 10/28/2015 9:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[manufacturer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_manufacturer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product]    Script Date: 10/28/2015 9:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[gtinNumber] [int] NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[manufacturerID] [int] NOT NULL,
	[additionalChar] [nvarchar](100) NULL,
	[categoryID] [int] NULL,
	[providerID] [int] NULL,
	[size] [int] NULL,
	[sizeUnit] [nvarchar](50) NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[gtinNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_inventory]    Script Date: 10/28/2015 9:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_inventory](
	[inventoryID] [int] NOT NULL,
	[productID] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [int] NOT NULL,
	[expirationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_product_inventory_1] PRIMARY KEY CLUSTERED 
(
	[inventoryID] ASC,
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[provider]    Script Date: 10/28/2015 9:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[provider](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_provider] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[user]    Script Date: 10/28/2015 9:14:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[username] [nvarchar](50) NOT NULL,
	[useremail] [nvarchar](100) NOT NULL,
	[userpasswd] [nvarchar](250) NOT NULL,
	[useralias] [nvarchar](max) NOT NULL,
	[userrole] [int] NOT NULL,
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[branchID] [int] NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[branch] ON 

INSERT [dbo].[branch] ([id], [description]) VALUES (1, N'Restaurante 1')
INSERT [dbo].[branch] ([id], [description]) VALUES (2, N'Casa 1')
INSERT [dbo].[branch] ([id], [description]) VALUES (3, N'Casa 2')
SET IDENTITY_INSERT [dbo].[branch] OFF
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([id], [description]) VALUES (1, N'Salsas preparadas')
INSERT [dbo].[category] ([id], [description]) VALUES (2, N'Hortalizas')
INSERT [dbo].[category] ([id], [description]) VALUES (3, N'Pastas')
INSERT [dbo].[category] ([id], [description]) VALUES (4, N'Frutas')
INSERT [dbo].[category] ([id], [description]) VALUES (5, N'Harinas')
INSERT [dbo].[category] ([id], [description]) VALUES (6, N'Especies')
SET IDENTITY_INSERT [dbo].[category] OFF
SET IDENTITY_INSERT [dbo].[inventory] ON 

INSERT [dbo].[inventory] ([id], [description], [branchID]) VALUES (1, N'Navidad', 1)
INSERT [dbo].[inventory] ([id], [description], [branchID]) VALUES (3, N'Semana Santa', 2)
INSERT [dbo].[inventory] ([id], [description], [branchID]) VALUES (5, N'Inventario Mensual', 3)
SET IDENTITY_INSERT [dbo].[inventory] OFF
SET IDENTITY_INSERT [dbo].[manufacturer] ON 

INSERT [dbo].[manufacturer] ([id], [name]) VALUES (1, N'El Angel')
INSERT [dbo].[manufacturer] ([id], [name]) VALUES (2, N'Lizano')
INSERT [dbo].[manufacturer] ([id], [name]) VALUES (3, N'Procter & Gamble')
INSERT [dbo].[manufacturer] ([id], [name]) VALUES (4, N'Unilever')
INSERT [dbo].[manufacturer] ([id], [name]) VALUES (5, N'Colgate Palmolive')
INSERT [dbo].[manufacturer] ([id], [name]) VALUES (6, N'Feria del agricultor')
SET IDENTITY_INSERT [dbo].[manufacturer] OFF
INSERT [dbo].[product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [providerID], [size], [sizeUnit]) VALUES (1000, N'Salsa Lizano', 2, N'Lizano baja en sal', 1, 1, 200, N'ml')
INSERT [dbo].[product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [providerID], [size], [sizeUnit]) VALUES (1001, N'Zanahorias', 6, N'', 2, 4, 1, N'kg')
INSERT [dbo].[product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [providerID], [size], [sizeUnit]) VALUES (1002, N'Fetuccine', 1, N'Tallarin integral', 3, 2, 250, N'g')
INSERT [dbo].[product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [providerID], [size], [sizeUnit]) VALUES (1003, N'Curry', 4, N'Curry en polvo', 6, 3, 150, N'g')
INSERT [dbo].[product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate]) VALUES (1, 1000, 15, 850, CAST(0x0000A55B00000000 AS DateTime))
INSERT [dbo].[product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate]) VALUES (1, 1001, 3, 600, CAST(0x0000A54C00000000 AS DateTime))
INSERT [dbo].[product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate]) VALUES (1, 1003, 3, 760, CAST(0x0000A5C500000000 AS DateTime))
INSERT [dbo].[product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate]) VALUES (2, 1001, 1, 500, CAST(0x0000A54C00000000 AS DateTime))
INSERT [dbo].[product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate]) VALUES (2, 1002, 2, 1050, CAST(0x0000A1D500000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[provider] ON 

INSERT [dbo].[provider] ([id], [name]) VALUES (1, N'Walmart')
INSERT [dbo].[provider] ([id], [name]) VALUES (2, N'Auto Mercado')
INSERT [dbo].[provider] ([id], [name]) VALUES (3, N'Peri')
INSERT [dbo].[provider] ([id], [name]) VALUES (4, N'Feria del agricultor')
SET IDENTITY_INSERT [dbo].[provider] OFF
SET IDENTITY_INSERT [dbo].[user] ON 

INSERT [dbo].[user] ([username], [useremail], [userpasswd], [useralias], [userrole], [userID], [branchID]) VALUES (N'administrator', N'admin@enterprise.com', N'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342', N'Administrador de la herramienta', 0, 1, NULL)
INSERT [dbo].[user] ([username], [useremail], [userpasswd], [useralias], [userrole], [userID], [branchID]) VALUES (N'user1', N'user1@enterprise.com', N'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342', N'Usuario de Pruebas 1', 1, 2, 1)
INSERT [dbo].[user] ([username], [useremail], [userpasswd], [useralias], [userrole], [userID], [branchID]) VALUES (N'user2', N'user2@enterprise.com', N'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342', N'Usuario de Pruebas 2', 1, 3, 2)
SET IDENTITY_INSERT [dbo].[user] OFF
USE [master]
GO
ALTER DATABASE [e-Inventory] SET  READ_WRITE 
GO
