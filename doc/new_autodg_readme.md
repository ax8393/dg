# 2024.05.15 draft.
- use bats to test lib function.
- seperate one shell file into small functions.
- when source datafile has > 1 levels, such as /u02/ordata/orcl/,/u02/oradata/orcl/data2/, 
the datafiles can be converted to target directory without to pre-create the directory: data2. 
- tested on single -> signle, rac-> rac.
- when rac -> rac done, while the node1 instance is still running, run dg_adddb_01.sh ~ 03.sh to 
add the database service to cluster.
- tested datafile convert: 1) create tablespace test1 datafile '+data' size 10m, '+data/orcl/test1.dbf'. 
the dg rac can convert this file successfully.
- how to use
-- 1) unzip , 2) edit para.cfg according to environment.  3) run autodg.sh .
-- tools, dgcheck, for check dg sync error, dgmonitor, to monitor dg sync.
