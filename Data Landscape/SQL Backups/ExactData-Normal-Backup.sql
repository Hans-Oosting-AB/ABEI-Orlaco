BACKUP DATABASE [ExactData] 
TO  DISK = N'\\bar-nas-optical\sqlbackup\ExactData\ExactData_backup_2023_08_10_013014_2982927.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'ExactData-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
