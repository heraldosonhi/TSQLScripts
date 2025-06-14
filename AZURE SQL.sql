-- CREATE USER IN MASTER DATABASE
CREATE LOGIN [loginname]
WITH PASSWORD ='xxxxx..';

-- CREATE USER IN SELECTED DATABASE
CREATE USER [loginname] FROM LOGIN [loginname] WITH DEFAULT_SCHEMA=dbo

-- ADD DBOWNER
ALTER ROLE db_owner ADD MEMBER [loginname];

-- ADD OTHERS
EXEC sp_addrolemember 'db_datareader', 'loginname'
EXEC sp_addrolemember 'db_datawriter', 'loginname'


USE [master]
GO

CREATE LOGIN [loginname] WITH PASSWORD=N'xxxxx..', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

USE [dbname]
GO

CREATE USER [loginname] FOR LOGIN [loginname] WITH DEFAULT_SCHEMA=[mySchema]
GO

GRANT CONNECT TO [loginname]
GO

-- the role membership below will allow you to run a test "select" query against the tables in your database
ALTER ROLE db_owner ADD MEMBER [loginname];
GO