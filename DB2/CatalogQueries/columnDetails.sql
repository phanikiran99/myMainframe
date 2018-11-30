select c.name,c.tbname,t.creator,t.owner
from sysibm.syscolumns c, sysibm.systables t
where t.name = c.tbname;

