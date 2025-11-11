/*
-----------------------------------------------------------------------
Create Database and Schemas
-----------------------------------------------------------------------

Script Purpose:
	This script will create a new database called 'DataWarehouse' after checking if it already exists.
	If the database does already exist it will be dropped and recreated. Also the script will set up 3 schemas
	within the database: 'bronze', 'silver', and 'gold'
*/
--The code in the block below will drop the entire DataWarehouse if it exists, Execute with caution. Ensure proper backups if running this code

USE master;

--DROP and RECREATE the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;

GO

--Creating Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

--Creating Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
