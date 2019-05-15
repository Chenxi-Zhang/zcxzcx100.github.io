#Lock

## Syntax
```MySQL
LOCK TABLES
    tbl_name [AS alias] {READ [LOCAL] | [LOW_PRIORITY] WRITE}
    [, tbl_name [AS alias] {READ [LOCAL] | [LOW_PRIORITY] WRITE}] ...
UNLOCK TABLES
```

e.g.

|session_1|session_2|
| ---- | ---- |
|`LOCK TABLE user READ;`| |
|`SELECT * FROM user;`|`SELECT * FROM user;`|
| |`UPDATE user SET AGE = 18 WHERE id = 2;`|
|`UNLOCK TABLES`|Wait|
| | Query OK |

---
#Transaction
## Syntax
```MySQL
START TRANSACTION | BEGIN [WORK]
COMMIT [WORK] [AND [NO] CHAIN] [[NO] RELEASE]
ROLLBACK [WORK] [AND [NO] CHAIN] [[NO] RELEASE]
SET AUTOCOMMIT = {0 | 1}
```

e.g. 

|session_1|session_2|
| ---- | ---- |
|`START TRANSACTION;`| |
|`INSERT INTO user (person_id, last_name, first_name, age, permission_group) VALUES (5110, 'D', 'ZZ', 35, 'user');`||
| |`SELECT * FROM user WHERE person_id = 5110;`|
|COMMIT;|Wait|
| |`SELECT * FROM user WHERE person_id = 5110;`|

# Distributed transaction
## Syntax
```MySQL
XA {START|BEGIN} xid [JOIN|RESUME]
    
    xid: gtrid [, bqual [, formatID]]

XA END xid [SUSPEND [FOR MIGRATE]]
XA PREPARE xid
XA COMMIT xid [ONE PHASE]
XA ROLLBACK xid
XA RECOVER
```

e.g.
|session_1|session_2|
| ---- | ---- |
|`XA START 'test1', 'my_db_utf8';`|`XA START 'test1', 'my_db';`|
|`UPDATE user SET age=18 WHERE id=2;`|`UPDATE user SET age=16 WHERE id=2;`|
|`XA END 'test1', 'my_db_utf8';`|`XA END 'test1', 'my_db';`|
|`XA PREPARE 'test1', 'my_db_utf8';`|`XA PREPARE 'test1', 'my_db';`|
|`XA COMMIT 'test1', 'my_db_utf8';`|`XA COMMIT 'test1', 'my_db';`|




