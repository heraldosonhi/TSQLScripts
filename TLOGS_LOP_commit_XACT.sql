 Select 
        b.Description,
        d.AllocUnitName,
		b.[Current LSN], 
        b.[Transaction ID],
        d.name,
        d.Operation,
        b.[Transaction Name],
        b.[Begin Time],
        c.[End Time],
		b.account
    from (
        Select 
            Description,
			[Current LSN], 
            [Transaction Name],
            Operation,
            [Transaction ID],
            [Begin Time],
			SUSER_SNAME ([Transaction SID]) AS account
        FROM sys.fn_dblog(NULL,NULL) 
        where Operation like 'LOP_begin_XACT'
    ) as b
    inner join (
        Select 
            Operation,
            [Transaction ID],
            [End Time]
        FROM sys.fn_dblog(NULL,NULL)
        where Operation like 'LOP_commit_XACT'
    ) as c
    on c.[Transaction ID] = b.[Transaction ID]
    inner join (
        select 
            x.AllocUnitName,
            x.Operation,
            x.[Transaction ID],
            z.name
        FROM sys.fn_dblog(NULL,NULL) x
        inner join sys.partitions y
        on x.PartitionId = y.partition_id
        inner join sys.objects z
        on z.object_id = y.object_id
        where z.type != 'S'
    )as d
    on d.[Transaction ID] = b.[Transaction ID]
	where name='tablename'
	AND d.operation='LOP_MODIFY_COLUMNS'
	--and convert(date, b.[Begin Time])  between '2023-09-29' and '2023-09-29'
    order by b.[Begin Time] ASC

	SELECT [Current LSN], [Operation],AllocUnitName, [Transaction ID], 
    [Transaction SID], [Begin Time], [End Time],
    [Num Elements], [RowLog Contents 0], [RowLog Contents 1], [RowLog Contents 2],
    [RowLog Contents 3], [RowLog Contents 4],[Lock Information],
	[Page ID],[Slot ID] --The Page ID and Slot ID columns will tell exactly what record, on what page, was modified 
    from fn_dblog(null, null)
    where  [Transaction ID]='0000:0004d93c' and [Lock Information] like '%(4b10dbdccf5c)%'