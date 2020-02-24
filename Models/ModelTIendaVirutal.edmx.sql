
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 02/20/2020 12:10:39
-- Generated from EDMX file: C:\Users\Steven\Documents\MIW - NET\EjemplosClase\TiendaVirutalHarlynPichardoO\Models\ModelTIendaVirutal.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_ClientesPedidos]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [FK_ClientesPedidos];
GO
IF OBJECT_ID(N'[dbo].[FK_ProductosPedidos_Pedidos]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductosPedidos] DROP CONSTRAINT [FK_ProductosPedidos_Pedidos];
GO
IF OBJECT_ID(N'[dbo].[FK_ProductosPedidos_Productos]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductosPedidos] DROP CONSTRAINT [FK_ProductosPedidos_Productos];
GO
IF OBJECT_ID(N'[dbo].[FK_StockProductos]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Productos] DROP CONSTRAINT [FK_StockProductos];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Clientes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Clientes];
GO
IF OBJECT_ID(N'[dbo].[Pedidos]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Pedidos];
GO
IF OBJECT_ID(N'[dbo].[Productos]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Productos];
GO
IF OBJECT_ID(N'[dbo].[ProductosPedidos]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductosPedidos];
GO
IF OBJECT_ID(N'[dbo].[Stock]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Stock];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Productos'
CREATE TABLE [dbo].[Productos] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Nombre] nvarchar(max)  NOT NULL,
    [Precio] float  NOT NULL,
    [Cantidad] int  NOT NULL,
    [Imagen] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Pedidos'
CREATE TABLE [dbo].[Pedidos] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Clientes_Id] int  NOT NULL
);
GO

-- Creating table 'Clientes'
CREATE TABLE [dbo].[Clientes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Nombre] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Direccion] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Stock'
CREATE TABLE [dbo].[Stock] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Nombre] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'ProductosPedidos'
CREATE TABLE [dbo].[ProductosPedidos] (
    [Productos_Id] int  NOT NULL,
    [Pedidos_Id] int  NOT NULL,
    [Cantidad] int NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Productos'
ALTER TABLE [dbo].[Productos]
ADD CONSTRAINT [PK_Productos]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Pedidos'
ALTER TABLE [dbo].[Pedidos]
ADD CONSTRAINT [PK_Pedidos]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Clientes'
ALTER TABLE [dbo].[Clientes]
ADD CONSTRAINT [PK_Clientes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Stock'
ALTER TABLE [dbo].[Stock]
ADD CONSTRAINT [PK_Stock]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Productos_Id], [Pedidos_Id] in table 'ProductosPedidos'
ALTER TABLE [dbo].[ProductosPedidos]
ADD CONSTRAINT [PK_ProductosPedidos]
    PRIMARY KEY CLUSTERED ([Productos_Id], [Pedidos_Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Productos_Id] in table 'ProductosPedidos'
ALTER TABLE [dbo].[ProductosPedidos]
ADD CONSTRAINT [FK_ProductosPedidos_Productos]
    FOREIGN KEY ([Productos_Id])
    REFERENCES [dbo].[Productos]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Pedidos_Id] in table 'ProductosPedidos'
ALTER TABLE [dbo].[ProductosPedidos]
ADD CONSTRAINT [FK_ProductosPedidos_Pedidos]
    FOREIGN KEY ([Pedidos_Id])
    REFERENCES [dbo].[Pedidos]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductosPedidos_Pedidos'
CREATE INDEX [IX_FK_ProductosPedidos_Pedidos]
ON [dbo].[ProductosPedidos]
    ([Pedidos_Id]);
GO

-- Creating foreign key on [Clientes_Id] in table 'Pedidos'
ALTER TABLE [dbo].[Pedidos]
ADD CONSTRAINT [FK_ClientesPedidos]
    FOREIGN KEY ([Clientes_Id])
    REFERENCES [dbo].[Clientes]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ClientesPedidos'
CREATE INDEX [IX_FK_ClientesPedidos]
ON [dbo].[Pedidos]
    ([Clientes_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------