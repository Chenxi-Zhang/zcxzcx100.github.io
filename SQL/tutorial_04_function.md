# String functions:
## CONCAT(S1, S2,...,Sn)
```MySQL
SELECT CONCAT('ab', 'cd', 'ef'), CONCAT('A', null);
```
## INSERT(str, x, y, in_str)
```MySQL
SELECT INSERT('abcdefg', 1, 0, 'zzz');
SELECT INSERT('abcdefg', 1, 2, 'zzz');
SELECT INSERT('abcdefg', 2, 2, 'zzz');
```
## LOWER(str) UPPER(str);
```MySQL
SELECT LOWER('ABCdef'), UPPER('ABCdef');
```
## LEFT(str, x) RIGHT(str, x)
```MySQL
SELECT LEFT('ABCdef', 3), RIGHT('ABCdef', 3), LEFT('ASDF', NULL);
```
## LPAD(str, n, pad) RPAD(str, n, pad)
```MySQL
SELECT LPAD('ABCdef', 3, '*'), RPAD('ABCdef', 3, '*');
SELECT LPAD('ABCdef', 10, '*'), RPAD('ABCdef', 10, '*');
```
## TRIM(str) LTRIM(str) RTRIM(str)
```MySQL
SELECT 
'   dsf   ' Original, 
TRIM('   dsf   ') T, 
LTRIM('   dsf   ') LT, 
RTRIM('   dsf   ') RT;
```
## REPEAT(str, x)
```MySQL
SELECT REPEAT('ABC', 3);
```
## REPLACE(str, a, b)
```MySQL
SELECT REPLACE('ABCAdef', 'A', '*');
```
## STRCMP(s1, s2)
```MySQL
SELECT STRCMP('ABC', 'DEF'), STRCMP('B', 'A'), STRCMP('A', 'A');
```
## SUBSTRING(str, x, y)
```MySQL
SELECT SUBSTRING('ABCdef', 1, 2);
```

# Numerical functions:

## ABS(x)
```MySQL
SELECT ABS(0.5), ABS(-0.5);
```
## CEIL(x)
```MySQL
SELECT CEIL(1.2), CEIL(-1.2);
```
## FLOOR(x)
```MySQL
SELECT FLOOR(1.2), FLOOR(-1.2);
```
## MOD(x, y)
## RAND()
```MySQL
SELECT RAND(), RAND();
SELECT CEIL(100*RAND());
```
## ROUND(x, y) TRUNCATE(x, y)
```MySQL
SELECT ROUND(1.46), ROUND(1.46, 1), ROUND(1.46, 4);
SELECT ROUND(1.46, 1), TRUNCATE(1.46, 1);
```

# Date and time functions:

## CURDATE() CURTIME() NOW()
```MySQL
SELECT CURDATE(), CURTIME(), NOW();
```
## UNIX_TIMESTAMP(date) FROM_UNIXTIME(unix_time)
```MySQL
SELECT UNIX_TIMESTAMP(CURDATE()), UNIX_TIMESTAMP(NOW());
SELECT FROM_UNIXTIME(UNIX_TIMESTAMP(NOW()));
```
## WEEK(date) YEAR(date) MONTHNAME(date)
```MySQL
SELECT WEEK(NOW()), YEAR(NOW()), MONTHNAME(NOW());
```
## HOUR(time) MINUTE(time)
```MySQL
SELECT NOW(), HOUR(NOW()), MINUTE(NOW());
```
## DATE_FORMAT(date, fmt)
```MySQL
SELECT DATE_FORMAT(NOW(), '%M,%D,%Y');
```
## DATE_ADD(date, INTERVAL expr type)
```MySQL
SELECT 
NOW(), 
DATE_ADD(NOW(), INTERVAL 10 DAY) '10 days later', 
DATE_ADD(NOW(), INTERVAL 3 MONTH) '3 month later';
```
## DATEDIFF(expr, expr2)
```MySQL
SELECT DATEDIFF('2019-8-4', NOW());
```

# Conditional function

## IF(value, t, f)
```MySQL
SELECT first_name, last_name, age, IF(age>25, 'old', 'young') FROM user;
```
## IFNULL(value1, value2)
## CASE WHEN [condition1] THEN [result1] ... ELSE [DEFAULT] END
```MySQL
SELECT age, CASE WHEN age>25 THEN 'old' ELSE 'young' END FROM user;
```
## CASE [expr] WHEN [value1] THEN [result1] ... ELSE [DEFAULT] END
```MySQL
SELECT age, CASE age WHEN 26 THEN 'young' WHEN 27 THEN 'mid' ELSE 'old' END FROM user;
```
# Other functions

## DATABASE() VERSION() USER()
```MySQL
SELECT DATABASE(), VERSION(), USER();
```
## INET_ATON(IP) INET_NTOA(NUM)
```MySQL
SELECT INET_ATON('172.17.0.1'), INET_NTOA(2886795265);
```
## PASSWORD(str) MD5(str)
```MySQL
SELECT PASSWORD('hello'), MD5('hello');
```

