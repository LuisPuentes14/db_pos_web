@echo off
set PGPASSWORD=12345
set "sql_folder=./data"
set "sql_folder_trigger=./triggers"

psql -U postgres -d pos -f ./tables/tables.sql

SET PGCLIENTENCODING=utf8

REM DATA
SET PGCLIENTENCODING=utf8
for %%f in ("%sql_folder%\*.sql") do (
   psql -U postgres -d pos -f "%%f"
)


REM CONSTRAINTS
psql -U postgres -d pos -f ./constraints/pk.sql
psql -U postgres -d pos -f ./constraints/uk.sql
psql -U postgres -d pos -f ./constraints/fk.sql
psql -U postgres -d pos -f ./constraints/ck.sql


REM TRIGGERS
SET PGCLIENTENCODING=utf8
for %%f in ("%sql_folder_trigger%\*.sql") do (
   psql -U postgres -d pos -f "%%f"
)

REM FUNCIONES


REM actualiza las secuencias
psql -U postgres -d pos -f ./update_sequences.sql


