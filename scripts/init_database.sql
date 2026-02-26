/*
Running this script will drop the entire 'DataWarehouse' database if it exists. 
*/

USE master;
GO
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

/*
This script creates a new database named 'DataWarehouse' Additionally, the script sets up three schemas within the database: 'bronze', 'silver', and 'gold'.
*/

CREATE DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
