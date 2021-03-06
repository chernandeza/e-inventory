USE [master]
GO
/****** Object:  Database [e-Inventory]    Script Date: 11/16/2015 10:33:05 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_AddNewUser]    Script Date: 11/16/2015 10:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernandez,Carlos>
-- Create date: <16/Nov/2015>
-- Description:	<Adds a user to the user's table>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AddNewUser] 
	-- Add the parameters for the stored procedure here
	@userName nvarchar(50) = '',
	@userEmail nvarchar(100) = '',
	@userPasswd nvarchar(250) = '',
	@userAlias nvarchar(MAX) = '',
	@userRole int = 1,
	@userCompany nvarchar(100) = 'Default Company',
	@inventoryName nvarchar(100) = 'Default Inventory'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @branchID int = 0
	
	INSERT INTO dbo.branch ([dbo].[branch].description)
	VALUES (@userCompany) -- Creación del branch

	SELECT @branchID = IDENT_CURRENT('branch') -- Selecciona el último identity generado para esta tabla

	INSERT INTO dbo.inventory (description, branchID)
	VALUES (@inventoryName, @branchID) -- Creación del inventario por defecto asociado al branch
		
	INSERT INTO [dbo].[user] (username, useremail, userpasswd, useralias, userrole, branchID, activated)
	VALUES (@userName, @userEmail, @userPasswd, @userAlias, @userRole, @branchID, 0) --Inserción del usuario	
END




GO
/****** Object:  StoredProcedure [dbo].[sp_AddProductToInventory]    Script Date: 11/16/2015 10:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernandez, Carlos>
-- Create date: <16/Nov/2015>
-- Description:	<Adds a product to a user's inventory>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AddProductToInventory] 
	-- Parameters
	@inventoryID int = 0,
	@productID int = 0,
	@prodQuantity int = 0,
	@productPrice int = 0,
	@providerID int = 1	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO product_inventory (inventoryID, productID, quantity, price, expirationDate, providerID)
	VALUES (@inventoryID, @productID, @prodQuantity, @productPrice, CURRENT_TIMESTAMP, @providerID)
	
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_InsertNewProduct]    Script Date: 11/16/2015 10:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernandez, Carlos>
-- Create date: <16/Nov/2015>
-- Description:	<Inserts a new product in the catalog>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertNewProduct]
	-- Add the parameters for the stored procedure here
	@gtinNum int = 0,
	@prodDesc nvarchar(100)='',
	
	-- The following parameters are optional
	@prodManuf nvarchar(150) = 'Default Manufacturer',
	@prodCateg nvarchar(100) = 'Default Category',
	@prodAddChar nvarchar(100) = 'Default Additional Description',
	--@prodProv nvarchar(100) = 'Default Provider',
	@prodSize int = 0,
	@prodSizeUnit nvarchar(50) = 'Default Unit'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @prodM int = 0
	Declare @prodC int = 0
	Declare @prodP int = 0
	
	SELECT @prodM = M1.id
	FROM manufacturer as M1
	WHERE M1.name = @prodManuf

	SELECT @prodC = C1.id
	FROM category as C1
	WHERE C1.description = @prodCateg

	--SELECT @prodP = P1.id
	--FROM provider as P1
	--WHERE P1.name = @prodProv

	INSERT INTO product (gtinNumber, description, manufacturerID, additionalChar, categoryID, size, sizeUnit)
	VALUES (@gtinNum, @prodDesc, @prodM, @prodAddChar, @prodC, @prodSize, @prodSizeUnit)
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ObtainUserSessionInfo]    Script Date: 11/16/2015 10:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernandez, Carlos>
-- Create date: <16/Nov/2015>
-- Description:	<Obtains the "session" information of a user>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ObtainUserSessionInfo] 
	-- Add the parameters for the stored procedure here
	@userEmail nvarchar(100) = ''

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @brID int = (SELECT branchID FROM [dbo].[user] AS U2 WHERE U2.useremail = @userEmail)

    -- Insert statements for procedure here
	SELECT U1.userID, U1.branchID, I1.id
	FROM [dbo].[user] U1 INNER JOIN inventory I1
		ON U1.branchID = I1.branchID 
	WHERE U1.useremail = @userEmail
END


GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateProductInventory]    Script Date: 11/16/2015 10:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernandez, Carlos>
-- Create date: <16/Nov/2015>
-- Description:	<Inserts a product into an inventory>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateProductInventory]

	-- Add the parameters for the stored procedure here
	@productID int = 0,
	--@providerID int = 1,
	@quantity int = 0,
	@prodInventory int = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE product_inventory
	SET quantity = @quantity
	WHERE productID = @productID and inventoryID = @prodInventory
    
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateProductExistence]    Script Date: 11/16/2015 10:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernandez, Carlos>
-- Create date: <16/Nov/2015>
-- Description:	<Validates if a product exists inside a catalog or inventory>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ValidateProductExistence] 
	-- Parameters
	@productID int = 0 ,
	@inventoryID int = 0,
	@result int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @prodInCatalog nvarchar(100) = ''
	Declare @prodInInventory int = ''

	SELECT @prodInCatalog = description
	FROM product
	WHERE gtinNumber = @productID

	IF @prodInCatalog = ''
	BEGIN
		SET @result = 2 -- El producto no se encuentra en el catálogo
	END
	ELSE
		BEGIN
			SELECT @prodInInventory = P1.id
			FROM product_inventory P1
			WHERE P1.inventoryID = @inventoryID and P1.productID = @productID
			
			IF (@@ROWCOUNT > 0) -- Product is in inventory
				BEGIN 
					SET @result = 0 -- El producto se encuentra en el catálogo y en el inventario
				END
			ELSE
				BEGIN
					SET @result = 1 -- El producto no se encuentra en el inventario
				END
		END   
END


GO
/****** Object:  StoredProcedure [dbo].[sp_validateUser]    Script Date: 11/16/2015 10:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hernandez,Carlos>
-- Create date: <16/Nov/2015>
-- Description:	<Validates user credentials and activation>
-- =============================================
CREATE PROCEDURE [dbo].[sp_validateUser]
	-- Add the parameters for the stored procedure here
	@userEmail nvarchar(100),
	@userPass nvarchar(MAX),
	@Result int OUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @UEmail nvarchar(100)
	Declare @UPass nvarchar (MAX)
	Declare @Ustate bit

	SELECT @UEmail = U1.useremail, @UPass = U1.userpasswd, @Ustate = U1.activated
	FROM [dbo].[user] AS U1 
	WHERE U1.useremail = @userEmail
	
    -- Insert statements for procedure here
	IF @UEmail = ''
	BEGIN
		SET @Result = 1 -- Usuario no existe
	END

	IF @Ustate = 'true'
	BEGIN
		IF (@UEmail <> '' and @UPass = @userPass) and @Ustate = 'true'
		BEGIN
			SET @Result = 0 -- Usuario y contraseña válidos
		END
		ELSE
			SET @Result = 2	-- Usuario existe y contraseña inválida
	END
	ELSE
		SET @Result = 3 --Usuario no ha sido activado
END


GO
/****** Object:  Table [dbo].[branch]    Script Date: 11/16/2015 10:33:05 PM ******/
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
/****** Object:  Table [dbo].[category]    Script Date: 11/16/2015 10:33:05 PM ******/
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
/****** Object:  Table [dbo].[inventory]    Script Date: 11/16/2015 10:33:05 PM ******/
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
/****** Object:  Table [dbo].[manufacturer]    Script Date: 11/16/2015 10:33:05 PM ******/
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
/****** Object:  Table [dbo].[product]    Script Date: 11/16/2015 10:33:05 PM ******/
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
	[size] [int] NULL,
	[sizeUnit] [nvarchar](50) NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[gtinNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_inventory]    Script Date: 11/16/2015 10:33:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_inventory](
	[inventoryID] [int] NOT NULL,
	[productID] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [int] NULL,
	[expirationDate] [datetime] NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[providerID] [int] NOT NULL,
 CONSTRAINT [PK_product_inventory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[provider]    Script Date: 11/16/2015 10:33:05 PM ******/
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
/****** Object:  Table [dbo].[user]    Script Date: 11/16/2015 10:33:05 PM ******/
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
	[activated] [bit] NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[branch] ON 

INSERT [dbo].[branch] ([id], [description]) VALUES (1, N'Main Office')
INSERT [dbo].[branch] ([id], [description]) VALUES (2, N'Casa 1')
INSERT [dbo].[branch] ([id], [description]) VALUES (3, N'Casa 2')
INSERT [dbo].[branch] ([id], [description]) VALUES (4, N'Restaurante 1')
SET IDENTITY_INSERT [dbo].[branch] OFF
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([id], [description]) VALUES (1, N'Default Category')
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

INSERT [dbo].[manufacturer] ([id], [name]) VALUES (1, N'Default Manufacturer')
INSERT [dbo].[manufacturer] ([id], [name]) VALUES (2, N'Lizano')
INSERT [dbo].[manufacturer] ([id], [name]) VALUES (3, N'Procter & Gamble')
INSERT [dbo].[manufacturer] ([id], [name]) VALUES (4, N'Unilever')
INSERT [dbo].[manufacturer] ([id], [name]) VALUES (5, N'Colgate Palmolive')
INSERT [dbo].[manufacturer] ([id], [name]) VALUES (6, N'Feria del agricultor')
SET IDENTITY_INSERT [dbo].[manufacturer] OFF
INSERT [dbo].[product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [size], [sizeUnit]) VALUES (1000, N'Salsa Lizano', 2, N'Lizano baja en sal', 1, 200, N'ml')
INSERT [dbo].[product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [size], [sizeUnit]) VALUES (1001, N'Zanahorias', 6, N'', 2, 1, N'kg')
INSERT [dbo].[product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [size], [sizeUnit]) VALUES (1002, N'Fetuccine', 1, N'Tallarin integral', 3, 250, N'g')
INSERT [dbo].[product] ([gtinNumber], [description], [manufacturerID], [additionalChar], [categoryID], [size], [sizeUnit]) VALUES (1003, N'Curry', 4, N'Curry en polvo', 6, 150, N'g')
SET IDENTITY_INSERT [dbo].[product_inventory] ON 

INSERT [dbo].[product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate], [id], [providerID]) VALUES (1, 1000, 15, 850, CAST(0x0000A55B00000000 AS DateTime), 1, 1)
INSERT [dbo].[product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate], [id], [providerID]) VALUES (1, 1001, 3, 600, CAST(0x0000A54C00000000 AS DateTime), 2, 1)
INSERT [dbo].[product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate], [id], [providerID]) VALUES (1, 1003, 3, 760, CAST(0x0000A5C500000000 AS DateTime), 3, 1)
INSERT [dbo].[product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate], [id], [providerID]) VALUES (2, 1001, 1, 500, CAST(0x0000A54C00000000 AS DateTime), 4, 1)
INSERT [dbo].[product_inventory] ([inventoryID], [productID], [quantity], [price], [expirationDate], [id], [providerID]) VALUES (2, 1002, 2, 1050, CAST(0x0000A1D500000000 AS DateTime), 5, 1)
SET IDENTITY_INSERT [dbo].[product_inventory] OFF
SET IDENTITY_INSERT [dbo].[provider] ON 

INSERT [dbo].[provider] ([id], [name]) VALUES (1, N'Default Provider')
INSERT [dbo].[provider] ([id], [name]) VALUES (2, N'Auto Mercado')
INSERT [dbo].[provider] ([id], [name]) VALUES (3, N'Peri')
INSERT [dbo].[provider] ([id], [name]) VALUES (4, N'Feria del agricultor')
INSERT [dbo].[provider] ([id], [name]) VALUES (5, N'Walmart')
SET IDENTITY_INSERT [dbo].[provider] OFF
SET IDENTITY_INSERT [dbo].[user] ON 

INSERT [dbo].[user] ([username], [useremail], [userpasswd], [useralias], [userrole], [userID], [branchID], [activated]) VALUES (N'administrator', N'admin@enterprise.com', N'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342', N'Administrador de la herramienta', 0, 1, NULL, 0)
INSERT [dbo].[user] ([username], [useremail], [userpasswd], [useralias], [userrole], [userID], [branchID], [activated]) VALUES (N'user1', N'user1@enterprise.com', N'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342', N'Usuario de Pruebas 1', 1, 2, 1, 0)
INSERT [dbo].[user] ([username], [useremail], [userpasswd], [useralias], [userrole], [userID], [branchID], [activated]) VALUES (N'user2', N'user2@enterprise.com', N'b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342', N'Usuario de Pruebas 2', 1, 3, 2, 0)
SET IDENTITY_INSERT [dbo].[user] OFF
ALTER TABLE [dbo].[product_inventory] ADD  CONSTRAINT [DF_product_inventory_expirationDate]  DEFAULT (getdate()) FOR [expirationDate]
GO
ALTER TABLE [dbo].[product_inventory] ADD  CONSTRAINT [DF_product_inventory_providerID]  DEFAULT ((1)) FOR [providerID]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF_user_activated]  DEFAULT ((0)) FOR [activated]
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD  CONSTRAINT [FK_inventory_branch] FOREIGN KEY([branchID])
REFERENCES [dbo].[branch] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[inventory] CHECK CONSTRAINT [FK_inventory_branch]
GO
ALTER TABLE [dbo].[product]  WITH NOCHECK ADD  CONSTRAINT [FK_product_category] FOREIGN KEY([categoryID])
REFERENCES [dbo].[category] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_category]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_manufacturer] FOREIGN KEY([manufacturerID])
REFERENCES [dbo].[manufacturer] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_manufacturer]
GO
ALTER TABLE [dbo].[product_inventory]  WITH NOCHECK ADD  CONSTRAINT [FK_product_inventory_inventory] FOREIGN KEY([inventoryID])
REFERENCES [dbo].[inventory] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[product_inventory] CHECK CONSTRAINT [FK_product_inventory_inventory]
GO
ALTER TABLE [dbo].[product_inventory]  WITH CHECK ADD  CONSTRAINT [FK_product_inventory_product] FOREIGN KEY([productID])
REFERENCES [dbo].[product] ([gtinNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[product_inventory] CHECK CONSTRAINT [FK_product_inventory_product]
GO
ALTER TABLE [dbo].[product_inventory]  WITH CHECK ADD  CONSTRAINT [FK_product_inventory_provider] FOREIGN KEY([providerID])
REFERENCES [dbo].[provider] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[product_inventory] CHECK CONSTRAINT [FK_product_inventory_provider]
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [FK_user_branch] FOREIGN KEY([branchID])
REFERENCES [dbo].[branch] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[user] CHECK CONSTRAINT [FK_user_branch]
GO
USE [master]
GO
ALTER DATABASE [e-Inventory] SET  READ_WRITE 
GO
