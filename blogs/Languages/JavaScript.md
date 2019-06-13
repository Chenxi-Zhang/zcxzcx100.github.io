# JavaScript 

### Variables Decleration

```JavaScript
var a = 1; // stored to local context.
b = 1;  // stored to global context.
```

### `typeof`

```JavaScript
// 5 results:
typeof "" === "string" // true
typeof 1 === "number" // true
typeof true === "boolean" // true
typeof {} === "object" // true
typeof x => x === "function" //true
var a;
typeof a === "undefined" // true

// Special cases:
typeof null === "object" // true
```

### Boolean Operator
1. Not (!)
```JavaScript
!{} === false;
!"asd" === false;
!"" === true;
!123 === false;
!0 === true;
!null === true;
!NaN === true;
```
2. And (&&)
```JavaScript
var a = {};
a && b; // === b
true && a; // === a
false && a; // === false
"" && a; // === ""
null && a; // === null;
a && null; // === null;
// undefined and NaN are the same as null;
null && NaN; // === null;
NaN && null; // === NaN;
```
3. Or (||)
```JavaScript
var a = {};
a || b; // === a
false || b; // === b
null || NaN; === NaN
```

### Compare Operator
```JavaScript
11 < 103;
11 < "103"; // convert String to Number
"11" > "103";

var a = {};
a > 1 // false
a <= 1 // false, a convert to NaN.

0.5 > false; // convert false to 0
0.5 < true;  // convert true to 1

5 == "5";  // true. Convert "5" to 5 first. 
5 === "5"; // false
```

### Function
1. arguments
```JavaScript
function add(v1, v2) {
    return v1 + v2;
}
add.length === 2;
//
function add2 () {
    return arguments[0] + arguments[1];
}
add2.length === 0;

arguments.callee;  // when call a function recursively, use it to decouple the function name from the function itself. It's better to use anonmyous function. 
```
2. call and apply
3. execution context and scope chain
4. this
```JavaScript
function fx() {
    var that = this;
    return function () {
        return that;
    };
};
// declare a new variable to store 'this' in closure, just in case the context change. 
```
5. closure
```JavaScript
function outer(v1) {
    return function () {
        return v1;
    };
};
var fx = outer(5);
fx();  // === 5;
// Inner function can use the outer function variable because of the scope chain. The activation object of outer function is added to the scope chain of inner class. When the outer function returns, its context and its scope chain are destroyed but its activation object still has at least one referer: scope chain of inner function. 
```
6. 

### Object-oriented
```JavaScript
function Animal () {};  // Animal is a function.
var animal = new Animal();   // Animal is used as a constructor.
Animal.prototype;   // Animal.prototype can be regarded as its class.
function Dog() {};
Dog.prototype = new Animal();   // Dog is inherited from Animal class.
Animal.prototype.run = function () { return "Animal run."};
var dog = new Dog();
dog.run()  // === "Animal run"
```
