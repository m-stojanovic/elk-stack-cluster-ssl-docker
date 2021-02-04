#!/bin/bash
export schema=l$(date '+%Y%m%d')
export 'PGPASSWORD={{ db_devlog_password }}'

/usr/bin/psql -h some.dns.rds.amazonaws.com -U devops -p 5432 devopsdevlog -c "SELECT * FROM $schema.message_log where ts >= NOW() - INTERVAL '5 minutes'" --csv -o /etc/logstash/files/database_data.csv
