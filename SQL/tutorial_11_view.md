# View
SQL syntax: create view:
```MySQL
CREATE [OR REPLACE] [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    VIEW view_name [(column_list)]
    AS select_statement
    [WITH [CASCADED|LOCAL] CHECK OPTION]
```
Alter view:
```MySQL
ALTER [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    VIEW view_name [(column_list)]
    AS select_statement
    [WITH [CASCADED|LOCAL] CHECK OPTION]
```
e.g.
```MySQL
CREATE OR REPLACE VIEW user_permission_view
AS SELECT user.id, user.first_name, user.last_name, p.publish
FROM user, permission_group p WHERE user.permission_group=p.name;
```

Delete view:
```MySQL
DROP VIEW [IF EXISTS] view_name [,view_name2 ...] [RESTRICT|CASCADE]