SELECT MAX(CASE WHEN r.id IS NULL THEN 0 ELSE 1 END) as doQuit
FROM (VALUES (0)) l(v)
    LEFT JOIN dbo._AB_Entity_Log r WITH (NOLOCK)
        ON r.jobid = 469
        AND r.runid <> '%runid%'
        AND r.syscreated > DATEADD(HOUR, -2, CURRENT_TIMESTAMP) -- check for max 2 hours back
        AND NOT EXISTS (SELECT 1 FROM dbo._AB_Entity_Log r1 WITH (NOLOCK) WHERE r1.runid = r.runid AND r1.seqno = -10) -- -10 is 'Finished Running Job'

SELECT MAX(CASE WHEN r.id IS NULL THEN 0 ELSE 1 END) as doQuit
FROM (VALUES (0)) l(v) -- 2023-08-10 HOO:Ensure at least one row result
LEFT JOIN dbo._AB_Entity_Log r WITH (NOLOCK)
    ON r.jobid = 469
    --AND r.runid <> '%runid%' -- 2023-08-10 HOO: Also quit when runid's are the same
      AND r.syscreated > DATEADD(HOUR, -2, CURRENT_TIMESTAMP) -- check for max 2 hours back
      AND NOT EXISTS (
        SELECT 1 
        FROM dbo._AB_Entity_Log r1 WITH (NOLOCK) 
        WHERE r1.runid = r.runid 
        AND r1.jobid = r.jobid    -- 2023-08-10 HOO: Check specifically whetehr given job is finished (not just any job in run id)
        AND r1.seqno = -10) -- -10 is 'Finished Running Job'