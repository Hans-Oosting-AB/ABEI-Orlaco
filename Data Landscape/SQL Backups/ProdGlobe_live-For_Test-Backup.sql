BACKUP DATABASE [ProdGlobe_live] TO  DISK = N'F:\ProdGlobe_live_backup_2023_08_10.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'ProdGlobe_live-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
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
Processed 109584 pages for database 'ProdGlobe_live', file 'ProdGlobe_live' on file 1.
100 percent processed.
Processed 3 pages for database 'ProdGlobe_live', file 'ProdGlobe_live_log' on file 1.
BACKUP DATABASE successfully processed 109587 pages in 4.531 seconds (188.952 MB/sec).
*/

--   3 Gb in 4.5s ProdGlobe
--  22 Gb in 27s ExactData
-- 1.3 Tb		400