--lists multiple columns which are present insame table
select * from sysibm.syscolumns c1
where name in ('COL1','COL2')
and tbname = (select name from sysibm.syscolumns c2
                where c1.tbname = c2.tbname and c1.name = c2.name)