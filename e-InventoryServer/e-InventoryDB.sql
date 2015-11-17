USE [master]
GO
/****** Object:  Database [e-Inventory]    Script Date: 03/11/2015 10:21:23 a.m. ******/
CREATE DATABASE [e-Inventory]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'e-Inventory', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\e-Inventory.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'e-Inventory_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\e-Inventory_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [branch]    Script Date: 03/11/2015 10:21:23 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [branch](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_branch] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [category]    Script Date: 03/11/2015 10:21:23 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [inventory]    Script Date: 03/11/2015 10:21:23 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [inventory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](100) NULL,
	[branchID] [int] NOT NULL,
 CONSTRAINT [PK_catalog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [manufacturer]    Script Date: 03/11/2015 10:21:23 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [manufacturer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_manufacturer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [product]    Script Date: 03/11/2015 10:21:23 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [product](
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
/****** Object:  Table [product_inventory]    Script Date: 03/11/2015 10:21:23 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [product_inventory](
	[inventoryID] [int] NOT NULL,
	[productID] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [int] NOT NULL,
	[expirationDate] [datetime] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_product_inventory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [provider]    Script Date: 03/11/2015 10:21:23 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [provider](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_provider] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [user]    Script Date: 03/11/2015 10:21:23 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [user](
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
SET IDENTITY_INSERT [branch] ON 

INSERT [branch] ([id], [description]) VALUES (1, N'Main Office')
INSERT [branch] ([id], [description]) VALUES (2, N'Casa 1')
INSERT [branch] ([id], [description]) VALUES (3, N'Casa 2')
INSERT [branch] ([id], [description]) VALUES (4, N'Restaurante 1')
SET IDENTITY_INSERT [branch] OFF
SET IDENTITY_INSERT [category] ON 

INSERT [category] ([id], [description]) VALUES (1, N'Salsas preparadas')
INSERT [category] ([id], [description]) VALUES (2, N'Hortalizas')
INSERT [category] ([id], [description]) VALUES (3, N'Pastas')
INSERT [category] ([id], [description]) VALUES (4, N'Frutas')
INSERT [category] ([id], [description]) VALUES (5, N'Harinas')
INSERT [category] ([id], [description]) VALUES (6, N'Especies')
SET IDENTITY_INSERT [category] OFF
SET IDENTITY_INSERT [inventory] ON 

INSERT [inventory] ([id], [description], [branchID]) VALUES (1, N'Navidad', 1)
INSERT [inventory] ([id], [description], [branchID]) VALUES (3, N'Semana Santa', 2)
INSERT [inventory] ([id], [description], [branchID]) VALUES (5, N'Inventario Mensual', 3)
SET IDENTITY_INSERT [inventory] OFF
SET IDENTITY_INSERT [manufacturer] ON 

INSERT [manufacturer] ([id], [name]) VALUES (1, N'El Angel')
INSERT [manufacturer] ([id], [name]) VALUES (2, N'Lizano')
INSERT [manufacturer] ([id], [name]) VALUES (3, N'Procter & Gamble')
INSERT [manufacturer] ([id], [name]) VALUES (4, N'Unilever')
INSERT [manufacturer] ([id], [name]) VALUES (5, N'Colgate Palmolive')
INSERT [manufacturer] ([id], [name]) VALUES (6, N'Feria del agricultor')
SET IDENTITY_INSERT [manufacturer] OFF
INSERT [product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [providerID], [size], [sizeUnit]) VALUES (1000, N'Salsa Lizano', 2, N'Lizano baja en sal', 1, 1, 200, N'ml')
INSERT [product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [providerID], [size], [sizeUnit]) VALUES (1001, N'Zanahorias', 6, N'', 2, 4, 1, N'kg')
INSERT [product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [providerID], [size], [sizeUnit]) VALUES (1002, N'Fetuccine', 1, N'Tallarin integral', 3, 2, 250, N'g')
INSERT [product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [providerID], [size], [sizeUnit]) VALUES (1003, N'Curry', 4, N'Curry en polvo', 6, 3, 150, N'g')
SET IDENTITY_INSERT [product_inventory] ON 

INSERT [product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate], [id]) VALUES (1, 1000, 15, 850, CAST(0x0000A55B00000000 AS DateTime), 1)
INSERT [product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate], [id]) VALUES (1, 1001, 3, 600, CAST(0x0000A54C00000000 AS DateTime), 2)
INSERT [product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate], [id]) VALUES (1, 1003, 3, 760, CAST(0x0000A5C500000000 AS DateTime), 3)
INSERT [product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate], [id]) VALUES (2, 1001, 1, 500, CAST(0x0000A54C00000000 AS DateTime), 4)
INSERT [product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate], [id]) VALUES (2, 1002, 2, 1050, CAST(0x0000A1D500000000 AS DateTime), 5)
SET IDENTITY_INSERT [product_inventory] OFF
SET IDENTITY_INSERT [provider] ON 

INSERT [provider] ([id], [name]) VALUES (1, N'Walmart')
INSERT [provider] ([id], [name]) VALUES (2, N'Auto Mercado')
INSERT [provider] ([id], [name]) VALUES (3, N'Peri')
INSERT [provider] ([id], [name]) VALUES (4, N'Feria del agricultor')
SET IDENTITY_INSERT [provider] OFF
SET IDENTITY_INSERT [user] ON 

INSERT [user] ([username], [useremail], [userpasswd], [useralias], [userrole], [userID], [branchID]) VALUES (N'administrator', N'admin@enterprise.com', N'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342', N'Administrador de la herramienta', 0, 1, NULL)
INSERT [user] ([username], [useremail], [userpasswd], [useralias], [userrole], [userID], [branchID]) VALUES (N'user1', N'user1@enterprise.com', N'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342', N'Usuario de Pruebas 1', 1, 2, 1)
INSERT [user] ([username], [useremail], [userpasswd], [useralias], [userrole], [userID], [branchID]) VALUES (N'user2', N'user2@enterprise.com', N'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342', N'Usuario de Pruebas 2', 1, 3, 2)
SET IDENTITY_INSERT [user] OFF
ALTER TABLE [inventory]  WITH CHECK ADD  CONSTRAINT [FK_inventory_branch] FOREIGN KEY([branchID])
REFERENCES [branch] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [inventory] CHECK CONSTRAINT [FK_inventory_branch]
GO
ALTER TABLE [product]  WITH NOCHECK ADD  CONSTRAINT [FK_product_category] FOREIGN KEY([categoryID])
REFERENCES [category] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [product] CHECK CONSTRAINT [FK_product_category]
GO
ALTER TABLE [product]  WITH CHECK ADD  CONSTRAINT [FK_product_manufacturer] FOREIGN KEY([manufacturerID])
REFERENCES [manufacturer] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [product] CHECK CONSTRAINT [FK_product_manufacturer]
GO
ALTER TABLE [product]  WITH CHECK ADD  CONSTRAINT [FK_product_provider] FOREIGN KEY([providerID])
REFERENCES [provider] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [product] CHECK CONSTRAINT [FK_product_provider]
GO
ALTER TABLE [product_inventory]  WITH NOCHECK ADD  CONSTRAINT [FK_product_inventory_inventory] FOREIGN KEY([inventoryID])
REFERENCES [inventory] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [product_inventory] CHECK CONSTRAINT [FK_product_inventory_inventory]
GO
ALTER TABLE [product_inventory]  WITH CHECK ADD  CONSTRAINT [FK_product_inventory_product] FOREIGN KEY([productID])
REFERENCES [product] ([gtinNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [product_inventory] CHECK CONSTRAINT [FK_product_inventory_product]
GO
ALTER TABLE [user]  WITH CHECK ADD  CONSTRAINT [FK_user_branch] FOREIGN KEY([branchID])
REFERENCES [branch] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [user] CHECK CONSTRAINT [FK_user_branch]
GO
USE [master]
GO
ALTER DATABASE [e-Inventory] SET  READ_WRITE 
GO
