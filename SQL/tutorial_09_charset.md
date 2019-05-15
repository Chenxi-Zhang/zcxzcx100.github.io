## Charset / Collation
## 4 level charset/collation:
    * Server level
    * Database level
    * Table level
    * Column level
# Alter charset to a used database/table
## mysqldump -uroot -p -d <database_name> > createtab.sql;

1. Dump table structure.
```bash
# mysqldump 8 need --column-statistics=0
mysqldump --column-statistics=0 \
-h 0.0.0.0 -P 32834 -u root -p \
--default-character-set=utf8 -d my_db > createtab.sql
```
2. Modify charset in createtab.sql.

3. Dump all records
```bash
# --quick 
mysqldump -h 0.0.0.0 -P 32834 -u root -p \
--column-statistics=0 \
--extended-insert \
--no-create-info \
--default-character-set=latin1 \
my_db > data.sql
```
4. Maybe modify SET NAMES utf8
5. Create new database with new default charset
```MySQL
CREATE DATABASE <database_name> DEFAULT CHARSET utf8;
```
6. Import table structure information
```bash
mysql -h 0.0.0.0 -P 32834 -u root -p \
my_db_utf8 < createtab.sql
```
7. Import data
```bash
mysql -h 0.0.0.0 -P 32834 -u root -p \
my_db_utf8 < data.sql
```

# Summary of modify charset of used database/table:
1. dump table structure and record.
2. Modify the structure and record manually.
3. Create new database with required charset.
4. Import table and data.

