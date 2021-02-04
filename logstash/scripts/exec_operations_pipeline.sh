#!/bin/bash

# generate schema name based on the current date
export schema=l$(date '+%Y%m%d')


# DevopsDev1
# production 0
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv
# production 1
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h  some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv


# DevopsDev2
# production 2
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv
# production 3
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv
# production 4
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv
# production 5
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv


# Devops01
# production 6
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv
# production 7
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv
# production 8
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv
# production 9
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv
# production 10
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv
# production 11
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopsuser -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv


# Devops02
# production 12
export 'PGPASSWORD={{ db_password }}'
/usr/bin/psql -h some.dns.rds.amazonaws.com -U devopssilverarts -p 5432 devops_log_db -c "SELECT * FROM $schema.operation where ts >= NOW() - INTERVAL '60 seconds'" -t --csv
