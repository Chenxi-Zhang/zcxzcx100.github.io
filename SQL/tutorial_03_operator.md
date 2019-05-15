# Arithmetic / algebraic operation
## They are: + - * /,DIV %,MOD
```MySQL
SELECT 0.1+0.3333, 0.1-0.3333, 0.1*0.3333, 1/2, 1%2, MOD(1,2);
SELECT 1/0, 1%0;
```
# Comparison operators:
## = <> <=> > < >= <= (BETWEEN min AND max) IN (IS NULL, IS NOT NULL)
## LIKE REGEXP
```MySQL
SELECT 3=7, 3=3, NULL=NULL;
SELECT 3<>7, 3<>3, NULL<>NULL;
SELECT 3<=>7, 3<=>3, NULL<=>NULL;
SELECT 3<7, 'a'>'a', 'a'<='c', 'bcd'>='b';
SELECT 10 BETWEEN 10 AND 20, 20 BETWEEN 10 AND 20, 9 BETWEEN 10 AND 20;
SELECT 1 IN (1,2,3), 't' IN ('a','b');
SELECT 0 IS NULL, null IS NULL, null IS NOT NULL;
SELECT 123456 LIKE '123%', 123456 LIKE '%123%', 123456 LIKE '%123';
SELECT 123456 LIKE '123___';
```
# Logical operators:
## (NOT !) (AND &&) (OR ||) XOR
```MySQL
SELECT NOT 0, !1, NOT NULL;
SELECT 0 && 1, 1 || 0, 3 || 1, 1 AND NULL, 1 OR NULL;
SELECT 1 XOR 1, 1 XOR 0, 0 XOR 1, 0 XOR 0, NULL XOR 1;
```
# Bit operators:
## & | ^ ~ >> <<
```MySQL
SELECT 1&1, 1&2, 2&3;

SELECT 18446744073709551614=-2, 18446744073709551614>>1 = -2>>1;
```




