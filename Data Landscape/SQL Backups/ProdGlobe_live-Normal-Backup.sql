BACKUP DATABASE [ProdGlobe_live] TO  DISK = N'\\bar-nas-optical\sqlbackup\ProdGlobe_live\ProdGlobe_live_backup_2023_08_10_013015_7122927.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'ProdGlobe_live-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
