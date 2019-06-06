# 1. Enter MySQL shell
```bash
mysql -h 0.0.0.0 -P 32834 -u root -p
```

# 2. Create database
```MySQL
DROP DATABASE IF EXISTS my_db;
CREATE DATABASE my_db;
USE my_db;
```
# 3. Create table
```MySQL
DROP TABLE IF EXISTS permission_group;
CREATE TABLE permission_group
(
name varchar(255) NOT NULL,
PRIMARY KEY (name),
visit bool,
publish bool,
reply bool
);

DROP TABLE IF EXISTS user;
CREATE TABLE user
(
id int AUTO_INCREMENT,
PRIMARY KEY (id)
person_id int,
last_name varchar(255),
first_name varchar(255),
age int,
permission_group varchar(255),
FOREIGN KEY fk_permission_group(permission_group) REFERENCES permission_group(name) ON DELETE CASCADE;
);

DROP TABLE IF EXISTS car;
CREATE TABLE car
(
id int AUTO_INCREMENT,
user_id int,
FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE ON UPDATE CASCADE,
mile int,
PRIMARY KEY (id)
);

DROP TABLE IF EXISTS test1;
CREATE TABLE test1
(
num_int int
);

#4. Change table column
ALTER TABLE user MODIFY last_name varchar(20);
ALTER TABLE user MODIFY first_name varchar(20);
/*
ALTER TABLE user MODIFY last_name varchar(20);
ALTER TABLE user CHANGE last_name_new last_name varchar(20);
ALTER TABLE user ADD birthday date AFTER age;
ALTER TABLE user DROP COLUMN birthday;
ALTER TABLE user RENAME user_new;
ALTER TABLE user_new RENAME user;
 */
```
# 5. Insert record
```MySQL
INSERT INTO permission_group
(name, visit, publish, reply)
VALUES
('admin', true, true, true),
('user', true, false, true),
('anonymous', true, false, false);
SELECT * FROM permission_group;

INSERT INTO user 
(person_id, last_name, first_name, age, permission_group) 
VALUES
(5101, 'Zhang', 'Chenxi', 27, 'admin'),
(5102, 'A', 'QQ', 20, 'user'),
(5103, 'B', 'DD', 18, 'user'),
(5105, 'C', 'X', 33, 'user');
SELECT * FROM user;

/* Add permission group column at user table.
ALTER TABLE permission_group MODIFY name varchar(255) NOT NULL PRIMARY KEY;
ALTER TABLE user ADD permission_group varchar(255);
ALTER TABLE user 
ADD FOREIGN KEY fk_permission_group(permission_group)
REFERENCES permission_group(name)
ON DELETE CASCADE;
UPDATE user SET permission_group='user';
 */

INSERT INTO car
(user_id, mile)
VALUES
(1, 10),
(1, 1),
(2, 1),
(3, 25);
SELECT * FROM car;
```

# 6. Update record
```MySQL
SELECT * FROM user;
UPDATE user SET age=26 WHERE person_id=5103;
SELECT * FROM user;
```

# 7. Delete record
```MySQL
SELECT * FROM car;
DELETE FROM car WHERE mile>20;
SELECT * FROM car;
```
# 8. Retrive record
```MySQL
SELECT * FROM user;
SELECT id, first_name, age FROM user;

SELECT DISTINCT user_id FROM car;

SELECT * FROM user WHERE age>30;
```
## Limit
```MySQL
SELECT * FROM user ORDER BY age;
SELECT * FROM user ORDER BY age LIMIT 3;
SELECT * FROM user ORDER BY age LIMIT 1,2;
```
## Group by
```MySQL
SELECT COUNT(1) FROM user;
SELECT permission_group, COUNT(1) FROM user GROUP BY permission_group;
SELECT permission_group, COUNT(1) FROM user GROUP BY permission_group WITH ROLLUP;
SELECT permission_group, COUNT(1) FROM user GROUP BY permission_group HAVING COUNT(1)>2;
SELECT SUM(age), AVG(age), MAX(age), MIN(age) FROM user;
```
## Join
```MySQL
SELECT id, first_name, last_name, publish FROM user, permission_group WHERE user.permission_group=permission_group.name;
SELECT id, publish FROM user LEFT JOIN permission_group ON user.permission_group=permission_group.name;
```
## Subquery
```MySQL
SELECT * FROM user WHERE permission_group IN (SELECT name FROM permission_group WHERE publish=true);
SELECT * FROM user WHERE permission_group IN (SELECT name FROM permission_group WHERE visit=true);
```
## Union / union all
```MySQL
SELECT * FROM user
UNION ALL
SELECT * FROM user;
```

