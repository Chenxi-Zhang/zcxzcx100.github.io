# Stored procedure
    No return required.
## Syntax
```MySQL
CREATE PROCEDURE sp_name ([proc_parameter[,...]])
    [characteristic ...] routine_body

CREATE FUNCTION sp_name ([func_parameter[,...]])
    RETURNS type
    [characteristic ...] routine_body

    proc_parameter:
        [IN|OUT|INOUT] param_name type
    func_parameter:
        param_name type
    type:
        Any valid MySQL data type
    characteristic:
        LANGUAGE SQL
        | [NOT] DETERMINISTIC
        | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA } 
        | SQL SECURITY { DEFINER | INVOKER }
        | COMMENT 'string'
    routine_body:
        Valid SQL procedure statement or statements

ALTER {PROCEDURE|FUNCTION} sp_name [characteristic]

    characteristic:
        { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
        | SQL SECURITY { DEFINER | INVOKER } 
        | COMMENT 'string'

CALL sp_name ([parameter[,...]])

DROP {PROCEDURE|FUNCTION} [IF EXISTS] sp_name;
```

e.g.
```MySQL

DROP PROCEDURE IF EXISTS user_older_than;
DELIMITER $$

CREATE PROCEDURE user_older_than(IN in_age INT, OUT out_user_count INT)
READS SQL DATA
BEGIN
    SELECT first_name, last_name, age FROM user
    WHERE age > in_age;
    
    SELECT FOUND_ROWS() INTO out_user_count;
END $$

DELIMITER ;

CALL user_older_than(25, @a);
SELECT @a;

```

---
# Check procedure|function status
```MySQL
SHOW {PROCEDURE | FUNCTION} STATUS [LIKE 'pattern']
SHOW CREATE {PROCEDURE | FUNCTION} sp_name


SELECT * FROM information_schema.routines WHERE ROUTINE_NAME='user_older_than'\G
```

---
# Variable
## Declaration
A declared variable only works in BEGIN END block and nested block.

Syntax
```MySQL
DECLARE var_name[,...] type [DEFAULT value]

e.g.
DECLARE last_month_start DATE;
```

## Set value
```MySQL
SET var_name = expr [, var_name = expr] ...
SELECT col_name[,...] INTO var_name[,...] table_expr

e.g.
SET last_month_start = DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);
SET IFNULL(AVG(age),0) INTO avg_age FROM user;
```

## Condition and handler
```MySQL
DECLARE condition_name CONDITION FOR condition_value

    condition_value:
        SQLSTATE [VALUE] sqlstate_value
        | mysql_error_code

DECLARE handler_type HANDLER FOR condition_value[,...] sp_statement

    handler_type:
        CONTINUE
        | EXIT 
        | UNDO
    condition_value:
        SQLSTATE [VALUE] sqlstate_value 
        | condition_name
        | SQLWARNING
        | NOT FOUND
        | SQLEXCEPTION
        | mysql_error_code
```

---
# Cursor
## Syntax
```MySQL
DECLARE cursor_name CURSOR FOR select_statement
OPEN cursor_name
FETCH cursor_name INTO var_name [, var_name] ...
CLOSE cursor_name
```

e.g.
```MySQL


DROP PROCEDURE IF EXISTS user_age_sum;
DELIMITER $$
CREATE PROCEDURE user_age_sum()
BEGIN
    DECLARE u_age INT;
    DECLARE cur_user CURSOR FOR SELECT age FROM user;
    DECLARE EXIT HANDLER FOR NOT FOUND CLOSE cur_user;

    SET @x1 = 0;
    OPEN cur_user;
    REPEAT
        FETCH cur_user INTO u_age;
            SET @x1 = @x1 + u_age;
    UNTIL 0 
    END REPEAT;

    CLOSE cur_user;

END;
$$
DELIMITER ;

CALL user_age_sum();
SELECT @x1, SUM(age) FROM user;
```

---
# Conditional statements
## IF
```MySQL
IF search_condition THEN statement_list
[ELSEIF search_condition THEN statement_list] ... 
[ELSE statement_list]
END IF
```

## CASE
```MySQL
CASE case_value
WHEN when_value THEN statement_list
[WHEN when_value THEN statement_list] ... [ELSE statement_list]
END CASE

Or:
CASE
WHEN search_condition THEN statement_list
[WHEN search_condition THEN statement_list] ...
[ELSE statement list]
END CASE
```

## LOOP
```MySQL
[begin_label:] LOOP
    statement_list
END LOOP [end_label]
```

## LEAVE [label] ~= (Java) break

## ITERATE [label] ~= (Java) continue

## REPEAT
```MySQL
[begin_label:] REPEAT statement_list
UNTIL search_condition 
END REPEAT [end_label]
```

## WHILE
```MySQL
[begin_label:] WHILE search_condition DO
    statement_list
END WHILE [end_label]
```

---
# MySQL performance test

## Turn on Query Profile
```MySQL
SET PROFILING = 1;

#Turn off
SET PROFILING = 0;

```

## Create tables and procedures
```MySQL
DROP TABLE IF EXISTS performance_test;
CREATE TABLE performance_test
(
test_name VARCHAR(255),
time_diff TIMESTAMP()
);

DROP TABLE IF EXISTS tbl_int_test;
CREATE TABLE tbl_int_test 
(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
col_int INT
);

DROP PROCEDURE IF EXISTS int_test;
DELIMITER $$
CREATE PROCEDURE int_test(IN test_num INT, OUT time_diff)
BEGIN
    SET @x1 = 1;
    SET @old_t = CURRENT_TIMESTAMP(3);
    WHILE @x1 < test_num DO
        INSERT INTO tbl_int_test
        (col_int) VALUES
        (@x1);
        SET @x1 = @x1 + 1;
    END WHILE;

END;
$$
DELIMITER ;

CALL int_test(1000);

```
