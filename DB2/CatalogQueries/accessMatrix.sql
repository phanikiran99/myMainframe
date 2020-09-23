    SELECT distinct GRANTEE,  STNAME AS TABEL_VIEW,
    CASE SELECTAUTH WHEN 'Y' THEN 'SEL' ELSE '...' END AS SEL,
    CASE INSERTAUTH WHEN 'Y' THEN 'INS' ELSE '...' END AS INS,
    CASE UPDATEAUTH WHEN 'Y' THEN 'UPD' ELSE '...' END AS UPD,
    CASE DELETEAUTH WHEN 'Y' THEN 'DEL' ELSE '...' END AS DEL
    FROM SYSIBM.SYSCOLUMNS a, SYSIBM.SYSTABAUTH ac
    where 1=1
    and a.TBCREATOR = '<>'   --Schema
    and a.TBNAME = '<>'    -- Table Name
    --and grantee like '%<>%' -- Package name
    and a.tbname = ac.stname
    --and (INSERTAUTH = 'Y' or UPDATEAUTH = 'Y')
    order by 1, 2, 3, 4
    FETCH FIRST 200 ROWS ONLY ;
