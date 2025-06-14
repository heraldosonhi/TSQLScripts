  SELECT * from sys.servers
  SELECT m.FUNCIONARIO_ID,m.data from [WEB-DEV-AO1].[PiagetSGAVerLocal1.0].dbo.RH_TIMETRACK_MOVIMENTOS  m

--ADD LINKED SERVER
--EXEC sp_addlinkedserver @server='WEB-DEV-AO1'
--EXEC sp_addlinkedsrvlogin 'WEB-DEV-AO1', 'false', NULL, 'timetracksrv', 'timetracksrv#.,.12'

--REMOVE LINKED SERVER
--EXEC sp_dropserver 'WEB-DEV-AO1', 'droplogins';

--GRANT PERMISSIONS
--GRANT SELECT ON dbo.RH_TIMETRACK_MOVIMENTOS to timetracksrv;
--GRANT INSERT ON dbo.RH_TIMETRACK_MOVIMENTOS to timetracksrv;