# DBVS

## (MacOS) Lokalaus serverio paleidimas

<https://dataschool.com/learn-sql/how-to-start-a-postgresql-server-on-mac-os-x/>

```bash
$ brew install postgresql
$ mkdir <pav>
# Create server
$ initdb <pav>
# Start server
$ pg_ctl -D ./<pav> start
# SQL REPL
$ psql (-h localhost) postgres
# execute SQL
$ psql (-h localhost) postgres -f <failo_pav>
# Stop server
$ pg_ctl -D ./<pav> stop
```