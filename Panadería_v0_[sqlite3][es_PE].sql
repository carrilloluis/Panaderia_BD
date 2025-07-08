/*
@description Gestión para una Panadería (venta directa)
@author Luis Carrillo Gutiérrez
@date Abril, 2022
@version 0.0.1
*/

DROP TABLE IF EXISTS [Categoría];
CREATE TABLE IF NOT EXISTS [Categoría]
(
	[id] INTEGER UNSIGNED NOT NULL,
	[denominación] VARCHAR(64) NOT NULL, -- { bread, cupCake, pie, cake }
	PRIMARY KEY(id)
) WITHOUT RowId;

-- [Category] -- 1 --- 1:n -- [BakedProduct]
DROP TABLE IF EXISTS [Inventario de Horneado];
CREATE TABLE IF NOT EXISTS [Inventario de Horneado]
(
	[id] INTEGER UNSIGNED NOT NULL, -- product/ItemID
	[id de categoría] INTEGER UNSIGNED NOT NULL REFERENCES [Categoría](id),
	[denominación] VARCHAR(40) NOT NULL,
	[unidad de venta] CHAR(3) NOT NULL, -- { pkg, unt, kg, onz }
	[cantidad] NUMERIC(12, 3) NOT NULL CHECK([cantidad] > 0.0), -- UNSIGNED
	[fecha de horneado] DATE NOT NULL,
	PRIMARY KEY(id)
) WITHOUT RowId;


DROP TABLE IF EXISTS [Venta];
CREATE TABLE IF NOT EXISTS [Venta]
(
	[id] CHAR(36) NOT NULL,
	[id del cliente] INTEGER UNSIGNED NOT NULL DEFAULT 0,
	[id del empleado] INTEGER UNSIGNED NOT NULL DEFAULT 0,
	[total] NUMERIC(12, 3) NOT NULL CHECK([total] > 0.0),
	[estado] INTEGER UNSIGNED NOT NULL, -- { 0 active, 1 cancel, 2 donation, etc }
	PRIMARY KEY(id)
) WITHOUT RowId;


-- [Product] -- 1 --- 0:n -- [SaleDetail]
DROP TABLE IF EXISTS [Detalle de Venta];
CREATE TABLE IF NOT EXISTS [Detalle de Venta]
(
	[id] INTEGER UNSIGNED NOT NULL,
	[id de producto] INTEGER UNSIGNED NOT NULL REFERENCES [Inventario de Horneado](id),
	[cantidad] NUMERIC(8, 3) NOT NULL CHECK([cantidad] > 0.0),
	[precio unitario] NUMERIC(12, 3) NOT NULL CHECK([precio unitario] > 0.0),
	[descuento] NUMERIC(12, 3) NOT NULL CHECK([descuento] > 0.0),
	PRIMARY KEY(id)
) WITHOUT RowId;