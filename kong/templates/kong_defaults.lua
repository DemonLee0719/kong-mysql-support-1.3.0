return [[
prefix = /usr/local/kong/
log_level = notice
proxy_access_log = logs/access.log
proxy_error_log = logs/error.log
admin_access_log = logs/admin_access.log
admin_error_log = logs/error.log
plugins = bundled
anonymous_reports = on

proxy_listen = 0.0.0.0:8000, 0.0.0.0:8443 ssl
stream_listen = off
admin_listen = 127.0.0.1:8001, 127.0.0.1:8444 ssl
origins = NONE
nginx_user = nobody nobody
nginx_worker_processes = auto
nginx_optimizations = on
nginx_daemon = on
mem_cache_size = 128m
ssl_cert = NONE
ssl_cert_key = NONE
client_ssl = off
client_ssl_cert = NONE
client_ssl_cert_key = NONE
ssl_cipher_suite = modern
ssl_ciphers = ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256
admin_ssl_cert = NONE
admin_ssl_cert_key = NONE
upstream_keepalive = 60
headers = server_tokens, latency_tokens
trusted_ips = NONE
real_ip_header = X-Real-IP
real_ip_recursive = off
client_max_body_size = 0
client_body_buffer_size = 8k
error_default_type = text/plain

nginx_http_ssl_protocols = TLSv1.1 TLSv1.2 TLSv1.3
nginx_http_upstream_keepalive = 60
nginx_http_upstream_keepalive_requests = 100
nginx_http_upstream_keepalive_timeout = 60s

database = postgres
pg_host = 127.0.0.1
pg_port = 5432
pg_database = kong
pg_schema = NONE
pg_timeout = 5000
pg_user = kong
pg_password = NONE
pg_ssl = off
pg_ssl_verify = off
pg_max_concurrent_queries = 0
pg_semaphore_timeout = 60000

mysql_host = 127.0.0.1
mysql_port = 3306
mysql_database = kong
mysql_schema = NONE
mysql_timeout = 5000
mysql_user = kong
mysql_password = NONE
mysql_ssl = off
mysql_ssl_verify = off
mysql_max_concurrent_queries = 0
mysql_semaphore_timeout = 60000

cassandra_contact_points = 127.0.0.1
cassandra_port = 9042
cassandra_keyspace = kong
cassandra_timeout = 5000
cassandra_ssl = off
cassandra_ssl_verify = off
cassandra_username = kong
cassandra_password = NONE
cassandra_consistency = ONE
cassandra_lb_policy = RequestRoundRobin
cassandra_local_datacenter = NONE
cassandra_repl_strategy = SimpleStrategy
cassandra_repl_factor = 1
cassandra_data_centers = dc1:2,dc2:3
cassandra_schema_consensus_timeout = 10000
declarative_config = NONE

db_update_frequency = 5
db_update_propagation = 0
db_cache_ttl = 0
db_resurrect_ttl = 30
db_cache_warmup_entities = services, plugins

dns_resolver = NONE
dns_hostsfile = /etc/hosts
dns_order = LAST,SRV,A,CNAME
dns_valid_ttl = NONE
dns_stale_ttl = 4
dns_not_found_ttl = 30
dns_error_ttl = 1
dns_no_sync = off

router_consistency = strict

lua_socket_pool_size = 30
lua_ssl_trusted_certificate = NONE
lua_ssl_verify_depth = 1
lua_package_path = ./?.lua;./?/init.lua;
lua_package_cpath = NONE
]]
