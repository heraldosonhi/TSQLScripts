--Restoring Full backup with norecovery.

RESTORE DATABASE [dbname]
    FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Backup\dbname.bak'
WITH

    MOVE 'DB' TO 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Backup\dbname.mdf',
	MOVE 'DB_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Backup\dbname.ldf',

    REPLACE, NORECOVERY, NOUNLOAD;

    GO

--Restore Log backup with STOPBEFOREMARK option to recover exact LSN.

RESTORE LOG [dbname]
FROM
    DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Backup\dbname.trn'
WITH
    STOPBEFOREMARK = 'lsn:0x000008da:0000038e:0002'
	--STOPATMARK ='lsn:0x000008da:0000036c:0002'
	--STOPAT = '2023-10-13 01:36'

	--RESTORE DATABASE [dbname] WITH RECOVERY
    --GO

	--ALTER DATABASE [dbname] SET RECOVERY FULL

