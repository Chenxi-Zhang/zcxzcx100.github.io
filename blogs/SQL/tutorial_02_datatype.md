# Create table with diff data types

## Number types:
```MySQL
DROP TABLE IF EXISTS table_int;
CREATE TABLE table_int
(
t_tiny_int TINYINT,
t_small_int SMALLINT,
t_int int(11) zerofill,
t_big_int BIGINT
);

DROP TABLE IF EXISTS table_float;
CREATE TABLE table_float
(
t_float FLOAT,
t_double DOUBLE,
t_decimal DECIMAL(8, 2)
);

DROP TABLE IF EXISTS table_bit;
CREATE TABLE table_bit
(
t_bit1 BIT(1),
t_bit8 BIT(8)
);

### Insert record
INSERT INTO table_int
(t_tiny_int, t_small_int, t_int, t_big_int)
VALUES
(1,1,1,1),
(1, 1111, 1111111, 1111111111111);
SELECT * FROM table_int;

INSERT INTO table_float
(t_float, t_double, t_decimal)
VALUES
(1.0, 1.0, 1.00),
(1.111, 1.1111111111, 1111.11),
(1.111111111111, 1.0, 11.1111);
SELECT * FROM table_float;

INSERT INTO table_bit
(t_bit1, t_bit8)
VALUES
(0, 0),
(1, 1),
(1, 25);
SELECT bin(t_bit1), bin(t_bit8) FROM table_bit;
```

## Date and time types
```MySQL
DROP TABLE IF EXISTS table_datetime;
CREATE TABLE table_datetime
(
t_date DATE,
t_datetime DATETIME,
t_timestamp TIMESTAMP,
t_time TIME,
t_year YEAR
);
```

### Insert record
```MySQL
INSERT INTO table_datetime
(t_date, t_datetime, t_timestamp, t_time, t_year)
VALUES
(now(), now(), now(), now(), now()),
(CURRENT_DATE, CURRENT_DATE, CURRENT_DATE, CURRENT_DATE, CURRENT_DATE),
(null, null, null, null, null);
SELECT * FROM table_datetime;
/*
YYYY-MM-DD HH:MM:SS / YY-MM-DD HH:MM:SS 
YYYYMMDDHHMMSS / YYMMDDHHMMSS / YYYYMMDD/ YYMMDD
 */
```

## String types
```MySQL
DROP TABLE IF EXISTS table_char;
CREATE TABLE table_char
(
t_char CHAR(10),
t_varchar VARCHAR(10)
);

DROP TABLE IF EXISTS table_blob;
CREATE TABLE table_blob
(
t_tinyblob TINYBLOB,
t_blob BLOB,
t_mediumblob MEDIUMBLOB,
t_longblob LONGBLOB
);

DROP TABLE IF EXISTS table_text;
CREATE TABLE table_text
(
t_tinytext TINYTEXT,
t_text TEXT,
t_mediumtext MEDIUMTEXT,
t_longtext LONGTEXT
);

DROP TABLE IF EXISTS table_binary;
CREATE TABLE table_binary
(
t_binary BINARY(10),
t_varbinary VARBINARY(10)
);
```

### Insert record
```MySQL
INSERT INTO table_char
(t_char, t_varchar)
VALUES
('ab  ', 'ab  ');
SELECT * FROM table_char;
SELECT LENGTH(t_char), LENGTH(t_varchar) FROM table_char;
SELECT CONCAT(t_char, '+'), CONCAT(t_varchar, '+') FROM table_char;


INSERT INTO table_binary
(t_binary, t_varbinary)
VALUES
('a', 'a'),
('0', '0'),
('a\0', 'a\0'),
('1\01', '1\01');
SELECT *, HEX(t_binary), HEX(t_varbinary) FROM table_binary;
```

## Enum type
```MySQL
DROP TABLE IF EXISTS table_enum;
CREATE TABLE table_enum
(
gender enum('M', 'F')
);
```
### Insert record
```MySQL
INSERT INTO table_enum
(gender)
VALUES
('M'),
('1'),
('2'),
('f'),
(null);
SELECT * FROM table_enum;
```

## Set type
```MySQL
DROP TABLE IF EXISTS table_set;
CREATE TABLE table_set
(
t_set SET('a', 'bb', 'ccc', 'dddd')
);
```
### Insert record
```MySQL
INSERT INTO table_set
(t_set)
VALUES
('a'),
('a,bb'),
#('a, bb') Wrong, no space between two elements.
#('a,b'),
('a,ccc,dddd'),
('a,a');
SELECT * FROM table_set;
```





