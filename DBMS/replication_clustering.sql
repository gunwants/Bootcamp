
-- =====================================================================
-- 1. SETUP MASTER-SLAVE REPLICATION (Master side)
-- =====================================================================
 
-- my.cnf on master
-- [mysqld]
-- server-id=1
-- log-bin=mysql-bin
-- binlog-format=ROW
 
-- Create replication user
CREATE USER 'repl'@'%' IDENTIFIED BY 'strong_password';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
FLUSH PRIVILEGES;
 
-- Note binlog position (for older non-GTID setups)
SHOW MASTER STATUS;
 
 
-- =====================================================================
-- 2. CONFIGURE SLAVE SERVER
-- =====================================================================
 
-- my.cnf on slave
-- [mysqld]
-- server-id=2
-- relay-log=relay-bin
-- read_only=ON
 
-- Point slave to master
CHANGE MASTER TO
  MASTER_HOST='master_ip',
  MASTER_USER='repl',
  MASTER_PASSWORD='strong_password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=154;
 
START SLAVE;
SHOW SLAVE STATUS\G
 
-- MySQL 8.0.23+ syntax:
-- CHANGE REPLICATION SOURCE TO ...
-- START REPLICA;
-- SHOW REPLICA STATUS\G
 
 
-- =====================================================================
-- 3. PROMOTE SLAVE TO MASTER (FAILOVER)
-- =====================================================================
 
-- On the slave being promoted
STOP SLAVE;
RESET SLAVE ALL;
SET GLOBAL read_only = OFF;
SET GLOBAL super_read_only = OFF;
 
-- On other slaves, repoint to the new master
CHANGE MASTER TO
  MASTER_HOST='new_master_ip',
  MASTER_USER='repl',
  MASTER_PASSWORD='strong_password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=4;
START SLAVE;
 
 
-- =====================================================================
-- 4. CHECK REPLICATION LAG
-- =====================================================================
 
SHOW SLAVE STATUS\G
-- Key field: Seconds_Behind_Master
 
-- Newer performance_schema based checks
SELECT * FROM performance_schema.replication_connection_status;
SELECT * FROM performance_schema.replication_applier_status_by_worker;
 
 
-- =====================================================================
-- 5. MULTI-MASTER REPLICATION SETUP
-- =====================================================================
 
-- Server A (my.cnf)
-- server-id=1
-- log-bin=mysql-bin
-- auto-increment-increment=2
-- auto-increment-offset=1
 
-- Server B (my.cnf)
-- server-id=2
-- log-bin=mysql-bin
-- auto-increment-increment=2
-- auto-increment-offset=2
 
-- Server A points to Server B
CHANGE MASTER TO
  MASTER_HOST='server_b_ip',
  MASTER_USER='repl',
  MASTER_PASSWORD='strong_password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=4;
START SLAVE;
 
-- Server B points to Server A
CHANGE MASTER TO
  MASTER_HOST='server_a_ip',
  MASTER_USER='repl',
  MASTER_PASSWORD='strong_password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=4;
START SLAVE;
 
 
-- =====================================================================
-- 6. IMPLEMENT GALERA CLUSTER (Join a node)
-- =====================================================================
 
-- my.cnf on new node
-- [mysqld]
-- wsrep_on=ON
-- wsrep_provider=/usr/lib/galera/libgalera_smm.so
-- wsrep_cluster_address="gcomm://node1_ip,node2_ip,node3_ip"
-- wsrep_node_address="this_node_ip"
-- wsrep_node_name="node4"
-- wsrep_sst_method=rsync
-- binlog_format=ROW
-- default_storage_engine=InnoDB
-- innodb_autoinc_lock_mode=2
 
-- Then start mysql normally (do NOT use --wsrep-new-cluster; that's only for bootstrapping)
-- sudo systemctl start mysql
 
 
-- =====================================================================
-- 7. MONITOR GALERA CLUSTER HEALTH
-- =====================================================================
 
SHOW STATUS LIKE 'wsrep_cluster_size';
SHOW STATUS LIKE 'wsrep_cluster_status';
SHOW STATUS LIKE 'wsrep_local_state_comment';
SHOW STATUS LIKE 'wsrep_ready';
SHOW STATUS LIKE 'wsrep_connected';
SHOW STATUS LIKE 'wsrep_flow_control_paused';
 
 
-- =====================================================================
-- 8. FORCE A NODE TO LEAVE GALERA CLUSTER
-- =====================================================================
 
-- Graceful shutdown removes the node from the cluster automatically
-- sudo systemctl stop mysql
 
-- Verify remaining cluster size on another node
SHOW STATUS LIKE 'wsrep_cluster_size';
 
 
-- =====================================================================
-- 9. CONFIGURE SEMI-SYNCHRONOUS REPLICATION (Master)
-- =====================================================================
 
INSTALL PLUGIN rpl_semi_sync_source SONAME 'semisync_source.so';
SET GLOBAL rpl_semi_sync_source_enabled = 1;
SET GLOBAL rpl_semi_sync_source_timeout = 10000; -- ms
 
-- Pre-8.0.26 naming convention:
-- INSTALL PLUGIN rpl_semi_sync_master SONAME 'semisync_master.so';
-- SET GLOBAL rpl_semi_sync_master_enabled = 1;
 
-- On the replica:
INSTALL PLUGIN rpl_semi_sync_replica SONAME 'semisync_replica.so';
SET GLOBAL rpl_semi_sync_replica_enabled = 1;
STOP REPLICA IO_THREAD;
START REPLICA IO_THREAD;
 
 
-- =====================================================================
-- 10. CHECK SEMI-SYNC REPLICATION STATUS
-- =====================================================================
 
SHOW STATUS LIKE 'Rpl_semi_sync_source_status';
SHOW STATUS LIKE 'Rpl_semi_sync_source_clients';
SHOW VARIABLES LIKE 'rpl_semi_sync%';
 
 
-- =====================================================================
-- 11. CONVERT SEMI-SYNC TO (NEAR) FULLY SYNCHRONOUS
-- =====================================================================
 
-- MySQL has no native true synchronous replication; this is the closest
-- approximation using semi-sync with an effectively infinite timeout.
SET GLOBAL rpl_semi_sync_source_timeout = 999999999;
SET GLOBAL rpl_semi_sync_source_wait_no_slave = ON;
SET GLOBAL rpl_semi_sync_source_wait_point = 'AFTER_SYNC';
 
-- For true synchronous multi-primary behavior, use Galera Cluster
-- or Group Replication (single-primary mode) instead.
 
 
-- =====================================================================
-- 12. SETUP GROUP REPLICATION
-- =====================================================================
 
-- On each node
SET GLOBAL group_replication_bootstrap_group = OFF; -- ON only for the first node
INSTALL PLUGIN group_replication SONAME 'group_replication.so';
 
SET GLOBAL group_replication_group_name = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee";
SET GLOBAL group_replication_local_address = "this_node_ip:33061";
SET GLOBAL group_replication_group_seeds = "node1_ip:33061,node2_ip:33061,node3_ip:33061";
 
CHANGE REPLICATION SOURCE TO
  SOURCE_USER='repl',
  SOURCE_PASSWORD='strong_password'
  FOR CHANNEL 'group_replication_recovery';
 
-- On the first (bootstrap) node only:
SET GLOBAL group_replication_bootstrap_group = ON;
START GROUP_REPLICATION;
SET GLOBAL group_replication_bootstrap_group = OFF;
 
-- On subsequent nodes:
START GROUP_REPLICATION;
 
 
-- =====================================================================
-- 13. MONITOR GROUP REPLICATION STATUS
-- =====================================================================
 
SELECT * FROM performance_schema.replication_group_members;
SELECT * FROM performance_schema.replication_group_member_stats;
SHOW STATUS LIKE 'group_replication%';
 
 
-- =====================================================================
-- 14. ADD NEW MEMBER TO GROUP REPLICATION
-- =====================================================================
 
-- On the new node: configure the same group_name, seeds, and recovery
-- user as in section 12, then:
CHANGE REPLICATION SOURCE TO
  SOURCE_USER='repl',
  SOURCE_PASSWORD='strong_password'
  FOR CHANNEL 'group_replication_recovery';
 
START GROUP_REPLICATION;
 
-- Verify from an existing member
SELECT * FROM performance_schema.replication_group_members;
 
 
-- =====================================================================
-- 15. REMOVE MEMBER FROM GROUP REPLICATION
-- =====================================================================
 
-- On the node to remove
STOP GROUP_REPLICATION;
 
-- Confirm from remaining members
SELECT * FROM performance_schema.replication_group_members;
 
 
-- =====================================================================
-- 16. CHECK REPLICATION CONSISTENCY
-- =====================================================================
 
-- Common real-world approach: Percona Toolkit
-- pt-table-checksum --host=master_ip
 
-- Native MySQL approach: compare per-table checksums
CHECKSUM TABLE mydb.mytable;
-- Run on both master and each slave, then compare results
 
 
-- =====================================================================
-- 17. SET UP CIRCULAR REPLICATION (A -> B -> C -> A)
-- =====================================================================
 
-- Server A: server-id=1, log-bin enabled
CHANGE MASTER TO
  MASTER_HOST='C_ip',
  MASTER_USER='repl',
  MASTER_PASSWORD='strong_password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=4;
START SLAVE;
 
-- Server B: server-id=2
CHANGE MASTER TO
  MASTER_HOST='A_ip',
  MASTER_USER='repl',
  MASTER_PASSWORD='strong_password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=4;
START SLAVE;
 
-- Server C: server-id=3
CHANGE MASTER TO
  MASTER_HOST='B_ip',
  MASTER_USER='repl',
  MASTER_PASSWORD='strong_password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=4;
START SLAVE;
 
-- NOTE: Circular replication has no built-in conflict resolution or loop
-- prevention beyond server-id. Use with caution; largely superseded by
-- Group Replication / Galera Cluster.
 
 
-- =====================================================================
-- 18. HANDLE REPLICATION ERRORS
-- =====================================================================
 
SHOW SLAVE STATUS\G
-- Check Last_IO_Error and Last_SQL_Error
 
-- Skip a single problematic statement (use carefully - can cause data drift)
STOP SLAVE;
SET GLOBAL sql_slave_skip_counter = 1;
START SLAVE;
 
-- Better approach for GTID-based replication: inject an empty transaction
SET GTID_NEXT='master_uuid:transaction_id';
BEGIN;
COMMIT;
SET GTID_NEXT='AUTOMATIC';
START SLAVE;
 
 
-- =====================================================================
-- 19. IMPLEMENT READ-SCALE OUT WITH REPLICATION
-- =====================================================================
 
-- On each read replica
SET GLOBAL read_only = ON;
SET GLOBAL super_read_only = ON;
 
-- Application/proxy layer routes writes to the master and SELECTs across
-- replicas (e.g. via ProxySQL or MySQL Router).
-- Example ProxySQL-style routing rule concept:
--   Writes -> hostgroup 10 (master)
--   Reads  -> hostgroup 20 (replica pool, round-robin/least-connections)