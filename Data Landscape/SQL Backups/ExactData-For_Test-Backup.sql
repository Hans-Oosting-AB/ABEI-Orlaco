BACKUP DATABASE [ExactData] 
TO  DISK = N'F:\ExactData_backup_2023_08_10.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'ExactData-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


/*

10 percent processed.
20 percent processed.
30 percent processed.
40 percent processed.
50 percent processed.
60 percent processed.
70 percent processed.
80 percent processed.
90 percent processed.
Processed 817240 pages for database 'ExactData', file 'ExactData' on file 1.
100 percent processed.
Processed 7 pages for database 'ExactData', file 'ExactData_log' on file 1.
BACKUP DATABASE successfully processed 817247 pages in 27.323 seconds (233.676 MB/sec).


*/