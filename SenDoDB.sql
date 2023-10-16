USE [master]
GO
/****** Object:  Database [SenDoDB]    Script Date: 16/10/2023 12:04:48 PM ******/
CREATE DATABASE [SenDoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SenDoDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SenDoDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SenDoDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SenDoDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SenDoDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SenDoDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SenDoDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SenDoDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SenDoDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SenDoDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SenDoDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SenDoDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SenDoDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SenDoDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SenDoDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SenDoDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SenDoDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SenDoDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SenDoDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SenDoDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SenDoDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SenDoDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SenDoDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SenDoDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SenDoDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SenDoDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SenDoDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [SenDoDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SenDoDB] SET RECOVERY FULL 
GO
ALTER DATABASE [SenDoDB] SET  MULTI_USER 
GO
ALTER DATABASE [SenDoDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SenDoDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SenDoDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SenDoDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SenDoDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SenDoDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SenDoDB', N'ON'
GO
ALTER DATABASE [SenDoDB] SET QUERY_STORE = OFF
GO
USE [SenDoDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 16/10/2023 12:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 16/10/2023 12:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 16/10/2023 12:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PriceTotal] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 16/10/2023 12:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrginalPrice] [float] NOT NULL,
	[ActualPrice] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 16/10/2023 12:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[ProductImageId] [int] IDENTITY(1,1) NOT NULL,
	[ProductImageName] [nvarchar](max) NOT NULL,
	[ProductImageLink] [nvarchar](max) NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED 
(
	[ProductImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductReviews]    Script Date: 16/10/2023 12:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductReviews](
	[ProductReviewId] [int] IDENTITY(1,1) NOT NULL,
	[ContentReview] [nvarchar](max) NOT NULL,
	[PointEvaluation] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_ProductReviews] PRIMARY KEY CLUSTERED 
(
	[ProductReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 16/10/2023 12:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductTypeId] [int] NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[Price] [float] NOT NULL,
	[Discount] [int] NULL,
	[Quantity] [int] NOT NULL,
	[AvartarImage] [nvarchar](max) NOT NULL,
	[Brand] [nvarchar](max) NOT NULL,
	[ShopId] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTypes]    Script Date: 16/10/2023 12:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTypes](
	[ProductTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ProductTypeName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ProductTypes] PRIMARY KEY CLUSTERED 
(
	[ProductTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Properties]    Script Date: 16/10/2023 12:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Properties](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyName] [nvarchar](max) NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_Properties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shops]    Script Date: 16/10/2023 12:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shops](
	[ShopId] [int] IDENTITY(1,1) NOT NULL,
	[ShopName] [nvarchar](max) NOT NULL,
	[ShopImage] [nvarchar](max) NOT NULL,
	[ShopAddress] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Shops] PRIMARY KEY CLUSTERED 
(
	[ShopId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231012031312_data', N'7.0.11')
GO
SET IDENTITY_INSERT [dbo].[Carts] ON 
GO
INSERT [dbo].[Carts] ([CartId], [Quantity], [ProductId]) VALUES (1, 7, 1)
GO
INSERT [dbo].[Carts] ([CartId], [Quantity], [ProductId]) VALUES (12, 1, 2)
GO
SET IDENTITY_INSERT [dbo].[Carts] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (1, 1, N'Áo thun long tea tay dài lai bầu tay xỏ nam nữ - ATLTTDLBTXNN', 95000, 25, 100, N'https://media3.scdn.vn/img4/2020/08_26/WcuSFoYMIgEor8inepcr_simg_de2fe0_250x250_maxb.jpg', N'
OEM', 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (2, 1, N'Áo Sweater tay dài nam nữ chất da cá cotton - ÁWTTDNNCDC', 155000, 44, 100, N'https://media3.scdn.vn/img4/2020/08_26/CCtaDm7USrZvZH4Laa8u_simg_de2fe0_250x250_maxb.jpg', N'OEM', 1)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (3, 1, N'áo nỉ hoodie nam - AP385B', 101000, 0, 100, N'https://media3.scdn.vn/img3/2019/11_27/pSUboz_simg_de2fe0_250x250_maxb.jpg', N'OEM', 2)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (4, 1, N'Áo hoodie nam nữ in hình chất nỉ ấm áp - DB230', 132000, 71, 100, N'https://media3.scdn.vn/img4/2023/09_27/kFSqpcZVUlsdgvbIQjzP_simg_de2fe0_250x250_maxb.jpg', N'OEM', 2)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (5, 1, N'Áo hoodie nam nữ in chữ chữ Hàn - AHDNNICH', 160000, 0, 100, N'https://media3.scdn.vn/img4/2020/01_04/lEUSLZvkRUFQmLmxhMW3_simg_de2fe0_250x250_maxb.jpg', N'OEM', 3)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (6, 1, N'ÁO SƠ MI CARO NAM NỮ MẶC - SMKN289', 119000, 0, 100, N'https://media3.scdn.vn/img3/2019/7_30/egmqRf_simg_b5529c_250x250_maxb.jpg', N'OEM', 3)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (7, 1, N'ÁO SƠ MI TRƠN NAM LỤA NẾN - TTFS1204', 150000, 0, 100, N'https://media3.scdn.vn/img3/2019/7_28/VGZTtn_simg_de2fe0_500x500_maxb.png', N'OEM', 4)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (8, 1, N'Áo sơ mi nam dài tay cao cấp - MH 068', 150000, 0, 100, N' https://media3.scdn.vn/img3/2019/11_1/QwWUFB_simg_de2fe0_500x500_maxb.png', N'OEM', 4)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (9, 1, N'Áo phông nam cao cấp tay ngắn được kiểm hàng - aonam02', 139000, 0, 100, N'https://media3.scdn.vn/img4/2023/09_19/Tqm1DA6830FKm11VS7uu_simg_de2fe0_250x250_maxb.jpg', N'OEM', 4)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (10, 1, N'Áo khoác bomber nam xịn đẹp - HB1414', 109000, 0, 100, N'https://media3.scdn.vn/img4/2020/08_27/40pfudqSCALqYajVtM66_simg_de2fe0_500x500_maxb.png', N'OEM', 5)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (11, 1, N'
Cà vạt bản 7cm FITTOP CAVAT-170 - CAVAT-170', 160000, 0, 100, N'https://media3.scdn.vn/img4/2020/11_23/bLZ9o88gmxAaXv2A9k1I_simg_b5529c_250x250_maxb.jpg', N'OEM', 5)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (12, 1, N'Cà vạt hoa văn FITTOP CAVAT-025 - CAVAT-025', 160000, 0, 100, N'https://media3.scdn.vn/img3/2019/1_2/0E5n0k_simg_de2fe0_500x500_maxb.jpg', N'OEM', 5)
GO
INSERT [dbo].[Products] ([ProductId], [ProductTypeId], [ProductName], [Price], [Discount], [Quantity], [AvartarImage], [Brand], [ShopId]) VALUES (13, 4, N'Nồi áp suất Elmich PCE-1802 (5L) - 4021802', 2250000, 0, 100, N'https://media3.scdn.vn/img4/2022/05_31/I1qbSQQnpTMmWOTG68Rq_simg_de2fe0_500x500_maxb.png', N'Elmich', 6)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductTypes] ON 
GO
INSERT [dbo].[ProductTypes] ([ProductTypeId], [ProductTypeName]) VALUES (1, N'Thời Trang Nam')
GO
INSERT [dbo].[ProductTypes] ([ProductTypeId], [ProductTypeName]) VALUES (2, N'Thời Trang Nữ')
GO
INSERT [dbo].[ProductTypes] ([ProductTypeId], [ProductTypeName]) VALUES (3, N'Sức Khỏe-Làm Đẹp')
GO
INSERT [dbo].[ProductTypes] ([ProductTypeId], [ProductTypeName]) VALUES (4, N'Điện gia dụng-Điện máy')
GO
INSERT [dbo].[ProductTypes] ([ProductTypeId], [ProductTypeName]) VALUES (5, N'Trang Sức')
GO
INSERT [dbo].[ProductTypes] ([ProductTypeId], [ProductTypeName]) VALUES (6, N'Điện thoại-Laptop')
GO
SET IDENTITY_INSERT [dbo].[ProductTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Shops] ON 
GO
INSERT [dbo].[Shops] ([ShopId], [ShopName], [ShopImage], [ShopAddress]) VALUES (1, N'MSK Chính Hãng', N'https://media3.scdn.vn/img4/2020/03_27/oBO7J7ZWFjbuz2FME28e.png', N'Hà Nội')
GO
INSERT [dbo].[Shops] ([ShopId], [ShopName], [ShopImage], [ShopAddress]) VALUES (2, N'TCC Group', N'https://media3.scdn.vn/img4/2021/07_23/m1uaK1m6UpYnTIopHu5M.jpg', N'TP Hồ Chí Minh')
GO
INSERT [dbo].[Shops] ([ShopId], [ShopName], [ShopImage], [ShopAddress]) VALUES (3, N'Xưởng jean MiA
', N'https://media3.scdn.vn/img4/2020/04_11/KmUb5v4wmITVqoIkQepa.jpg', N'TP Hồ Chí Minh')
GO
INSERT [dbo].[Shops] ([ShopId], [ShopName], [ShopImage], [ShopAddress]) VALUES (4, N'
Basic Bro', N'https://media3.scdn.vn/img4/2021/07_08/uLTwQEtytbAilohYgu1l.jpg', N'Hà Nội')
GO
INSERT [dbo].[Shops] ([ShopId], [ShopName], [ShopImage], [ShopAddress]) VALUES (5, N'Fittop', N'https://media3.scdn.vn/img2/2018/5_19/3pvEKU.jpg', N'TP Hồ Chí Minh')
GO
INSERT [dbo].[Shops] ([ShopId], [ShopName], [ShopImage], [ShopAddress]) VALUES (6, N'NiKa Food', N'https://media3.scdn.vn/img4/2021/01_06/mgPqrvzTiOmE0hFNXs32.png', N'Hải Phòng')
GO
INSERT [dbo].[Shops] ([ShopId], [ShopName], [ShopImage], [ShopAddress]) VALUES (7, N'Shop Thu Anh', N'https://media3.scdn.vn/img4/2020/04_12/lBmH9UKoOEegFp65PoWC.jpg', N'Đồng Nai')
GO
INSERT [dbo].[Shops] ([ShopId], [ShopName], [ShopImage], [ShopAddress]) VALUES (8, N'Tổng sỉ lẻ Sài Gòn', N'https://media3.scdn.vn/img4/2021/03_20/erDXXue46sUNnUJ4HXAG.jpg', N'TP Hồ Chí Minh')
GO
SET IDENTITY_INSERT [dbo].[Shops] OFF
GO
/****** Object:  Index [IX_Carts_ProductId]    Script Date: 16/10/2023 12:04:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Carts_ProductId] ON [dbo].[Carts]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_OrderId]    Script Date: 16/10/2023 12:04:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_OrderId] ON [dbo].[OrderDetails]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_ProductId]    Script Date: 16/10/2023 12:04:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_ProductId] ON [dbo].[OrderDetails]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductImages_ProductId]    Script Date: 16/10/2023 12:04:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductImages_ProductId] ON [dbo].[ProductImages]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductReviews_ProductId]    Script Date: 16/10/2023 12:04:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductReviews_ProductId] ON [dbo].[ProductReviews]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_ProductTypeId]    Script Date: 16/10/2023 12:04:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_ProductTypeId] ON [dbo].[Products]
(
	[ProductTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_ShopId]    Script Date: 16/10/2023 12:04:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_ShopId] ON [dbo].[Products]
(
	[ShopId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Properties_ProductId]    Script Date: 16/10/2023 12:04:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Properties_ProductId] ON [dbo].[Properties]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Products_ProductId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders_OrderId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products_ProductId]
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD  CONSTRAINT [FK_ProductImages_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductImages] CHECK CONSTRAINT [FK_ProductImages_Products_ProductId]
GO
ALTER TABLE [dbo].[ProductReviews]  WITH CHECK ADD  CONSTRAINT [FK_ProductReviews_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReviews] CHECK CONSTRAINT [FK_ProductReviews_Products_ProductId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_ProductTypes_ProductTypeId] FOREIGN KEY([ProductTypeId])
REFERENCES [dbo].[ProductTypes] ([ProductTypeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_ProductTypes_ProductTypeId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Shops_ShopId] FOREIGN KEY([ShopId])
REFERENCES [dbo].[Shops] ([ShopId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Shops_ShopId]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Properties_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Properties_Products_ProductId]
GO
USE [master]
GO
ALTER DATABASE [SenDoDB] SET  READ_WRITE 
GO
