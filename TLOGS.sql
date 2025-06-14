/* MICROSOFT SQL SERVER [T-LOGS] */

SELECT
  [Transaction ID], [Current LSN], [Transaction Name], [Operation],  [Context],[AllocUnitName],[Begin Time],[End Time], [Transaction SID],
  [Num Elements] ,
  [RowLog Contents 0],
  [RowLog Contents 1],
  [RowLog Contents 2],
  [RowLog Contents 3],
  [RowLog Contents 4],
	Description
  FROM fn_dblog (NULL, NULL)
  WHERE [Transaction ID] in (Select [Transaction ID] FROM fn_dblog (null,null) WHERE
  [Transaction Name] = 'user_transaction')
  and [AllocUnitName] like '%dbo.%'


-- The following command can be executed to see how many virtual log files there are, 
-- how many has been used and what their sizes are. This will be used to determine what the 
-- correct size and increment should be.
DBCC LOGINFO

/*--check port number*/
USE master
GO
xp_readerrorlog 0, 1, N'Server is listening on' 
GO

/*--verify update statements*/
SELECT TOP(10) [Transaction Name] 
from  fn_dblog (NULL, NULL) where [Transaction Name] not in('INSERT','user_transaction','UPDATE')