# What's it for
It's for deploy Oracle dataguard with scripts.
just edit the config file para.cfg according to your env, the script will deply dataguard .
# How to use it 
git clone https://github.com/liyuefu/autodg.git
cd src
vi para.cfg
./autodg.sh

# example
## single instance to single instance
oracle_sid=ctp
oracle_dg_sid=ctpdg
#如果已经有配置了dg,比如配置了2个dg,把db_unique_name写这里,没有就保持no
#exist_dg_unique_name_list=testdg1,testdg2
exist_dg_unique_name_list=no

#指定主库使用哪个dest
pri_log_archive_dest=3
#指定备库使用哪个dest
dg_log_archive_dest=3
dg_unique_name=ctpdg
oracle_base_pr=/u01/app/oracle
oracle_home_pr=/u01/app/oracle/product/11.2.0/dbhome_1
oracle_base_dg=/u01/app/oracle
oracle_home_dg=/u01/app/oracle/product/11.2.0/dbhome_1
dgpath=/u02/oradata/ctpdg
dgarch=/u02/arch
#从rac到单机时,rac使用搭建使用节点的public ip.
ippr=192.168.56.91
ipdg=192.168.56.92
stagepr=/stage
stagedg=/stage
duplicate_active=yes
fix_datafile_same_name=no
rman_backup_dir=/u02/rmanbackup
syspwd=oracle
setupssh=no
#fix_datafile_same_name=yes, 用%U统一命名./u03/oradata/ctp/data_D-CTP_TS-SYSTEM_FNO-1; no: 用原来的名字
#如果文件有重名的,设置为yes
#duplicate_active: yes(直接用duplicate from active命令从主库duplicate), no(用现有的rman备份也用duplicate命令, rman必须已经复制到备库),
p

## rac -> rac

oracle_sid=ctp1
oracle_dg_sid=ctp1
#如果已经有配置了dg,比如配置了2个dg,把db_unique_name写这里,没有就保持no
exist_dg_unique_name_list=ctpdg
#exist_dg_unique_name_list=no

#指定主库使用哪个dest
pri_log_archive_dest=2
#指定备库使用哪个dest
dg_log_archive_dest=2
dg_unique_name=ctpdgrac
oracle_base_pr=/u01/app/oracle
oracle_home_pr=/u01/app/oracle/product/11.2.0/dbhome_1
oracle_base_dg=/u01/app/oracle
oracle_home_dg=/u01/app/oracle/product/11.2.0/dbhome_1
dgpath=+datadg
dgarch=+datadg
#源端和目标端都是rac时,搭建时使用public ip. 搭建顺利完成后可以考虑改为scan ip
ippr=192.168.56.191
ipdg=192.168.56.201
stagepr=/stage
stagedg=/stage
duplicate_active=yes
fix_datafile_same_name=no
rman_backup_dir=/u02/rmanbackup
syspwd=oracle
setupssh=no
#fix_datafile_same_name=yes, 用%U统一命名./u03/oradata/ctp/data_D-CTP_TS-SYSTEM_FNO-1; no: 用原来的名字
#如果文件有重名的,设置为yes
#duplicate_active: yes(直接用duplicate from active命令从主库duplicate), no(用现有的rman备份也用duplicate命令, rman必须已经复制到备库),
#rman(新建一个rman备份并复制到备库,用rman restore, recover命令)
