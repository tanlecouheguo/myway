
# ES6，7，7语法和Babel插件对应关系

## 常量类型检查
输入
    
    const a = 1;
    a = 2;

输出

    repl: "a" is read-only
      1 | const a = 1;
    > 2 | a = 2;
        | ^


对应`babel-plugin-check-es2015-constants`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["check-es2015-constants"]
    }

## 箭头函数
输入
    
    var a = () => {};
    var a = (b) => b;

    const double = [1,2,3].map((num) => num * 2);
    console.log(double); // [2,4,6]

    var bob = {
        _name: "Bob",
        _friends: ["Sally", "Tom"],
        printFriends() {
            this._friends.forEach(f =>
            console.log(this._name + " knows " + f));
        }
    };
    console.log(bob.printFriends());

输出

    var a = function () {};
    var a = function (b) {
    return b;
    };

    const double = [1, 2, 3].map(function (num) {
    return num * 2;
    });
    console.log(double); // [2,4,6]

    var bob = {
    _name: "Bob",
    _friends: ["Sally", "Tom"],
    printFriends() {
        var _this = this;

        this._friends.forEach(function (f) {
        return console.log(_this._name + " knows " + f);
        });
    }
    };
    console.log(bob.printFriends());

对应`babel-plugin-transform-es2015-arrow-functions`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-arrow-functions"]
    }

## 块级作用域
    function f() {
        {
            let x;
            {
            // this is ok since it's a block scoped name
            const x = "sneaky";
            // error, was just defined with `const` above
            x = "foo";
            }
            // this is ok since it was declared with `let`
            x = "bar";
            // error, already declared above in this block
            let x = "inner";
        }
    }

对应`babel-plugin-transform-es2015-block-scoped-functions`和`babel-plugin-transform-es2015-block-scoping`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": [
            "transform-es2015-block-scoped-functions",
            "transform-es2015-block-scoping"
        ]
    }

## 类
    class SkinnedMesh extends THREE.Mesh {
        constructor(geometry, materials) {
            super(geometry, materials);

            this.idMatrix = SkinnedMesh.defaultMatrix();
            this.bones = [];
            this.boneMatrices = [];
            //...
        }
        update(camera) {
            //...
            super.update();
        }
        static defaultMatrix() {
            return new THREE.Matrix4();
        }
    }

对应`babel-plugin-transform-es2015-classes`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": [
            "babel-plugin-transform-es2015-classes"
        ]
    }

## 计算属性
输入
    
    var obj = {
        ["x" + foo]: "heh",
        ["y" + bar]: "noo",
        foo: "foo",
        bar: "bar"
    };

输出

    var _obj;

    function _defineProperty(obj, key, value) {
        if (key in obj) {
            Object.defineProperty(obj, key, {
            value: value,
            enumerable: true,
            configurable: true,
            writable: true
            });
        } else {
            obj[key] = value;
        }

        return obj;
    }

    var obj = (
        _obj = {},
        _defineProperty(_obj, "x" + foo, "heh"),
        _defineProperty(_obj, "y" + bar, "noo"),
        _defineProperty(_obj, "foo", "foo"),
        _defineProperty(_obj, "bar", "bar"),
        _obj
    );


对应`babel-plugin-transform-es2015-computed-properties`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-computed-properties"]
    }


## 解构赋值

    // list matching
    var [a, ,b] = [1,2,3];
    a === 1;
    b === 3;

    // object matching
    var { op: a, lhs: { op: b }, rhs: c }
        = getASTNode()

    // object matching shorthand
    // binds `op`, `lhs` and `rhs` in scope
    var {op, lhs, rhs} = getASTNode()

    // Can be used in parameter position
    function g({name: x}) {
        console.log(x);
    }
    g({name: 5})

    // Fail-soft destructuring
    var [a] = [];
    a === undefined;

    // Fail-soft destructuring with defaults
    var [a = 1] = [];
    a === 1;

    // Destructuring + defaults arguments
    function r({x, y, w = 10, h = 10}) {
        return x + y + w + h;
    }
    r({x:1, y:2}) === 23

对应`babel-plugin-transform-es2015-destructuring`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-destructuring"]
    }

## 重复的key
输入
    
    var obj = {
        ["x" + foo]: "heh",
        ["y" + bar]: "noo",
        foo: "foo",
        bar: "bar"
    };

输出

    var x = { a: 5, a: 6 };
    var y = {
        get a() {},
        set a(x) {},
        a: 3
    };

    var x = { a: 5, ["a"]: 6 };
    var y = {
        get a() {},
        set a(x) {},
        ["a"]: 3
    };


对应`babel-plugin-transform-es2015-duplicate-keys`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-duplicate-keys"]
    }


## for...of语法
输入
    
    for (var i of foo) {}

输出

    var _iteratorNormalCompletion = true;
    var _didIteratorError = false;
    var _iteratorError = undefined;

    try {
        for (var _iterator = foo[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
            var i = _step.value;
        }
    } catch (err) {
        _didIteratorError = true;
        _iteratorError = err;
    } finally {
        try {
            if (!_iteratorNormalCompletion && _iterator.return) {
                _iterator.return();
            }
        } finally {
            if (_didIteratorError) {
                throw _iteratorError;
            }
        }
    }

对应`babel-plugin-transform-es2015-for-of`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-for-of"]
    }

## 函数name属性

对应`babel-plugin-transform-es2015-function-name`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-function-name"]
    }

## Unicode
输入
    
    var b = 0b11; // binary integer literal
    var o = 0o7; // octal integer literal
    const u = 'Hello\u{000A}\u{0009}!'; // unicode string literals, newline and tab

输出

    var b = 3; // binary integer literal
    var o = 7; // octal integer literal
    const u = 'Hello\n\t!'; // unicode string literals, newline and tab

对应`babel-plugin-transform-es2015-literals`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-literals"]
    }


## 对象super语法
对应`babel-plugin-transform-es2015-object-super`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-object-super"]
    }

## 函数参数

    function f(x, y=12) {
        // y is 12 if not passed (or passed as undefined)
        return x + y;
    }
    f(3) == 15

    function f(x, ...y) {
        // y is an Array
        return x * y.length;
    }
    f(3, "hello", true) == 6

    function f(x, y, z) {
        return x + y + z;
    }
    // Pass each elem of array as argument
    f(...[1,2,3]) == 6

## 简写属性

输入
    
   var o = { a, b, c };

输出

    var o = { a: a, b: b, c: c };

输入
    
   var cat = {
        getName() {
            return name;
        }
    };

输出

    var cat = {
        getName: function () {
            return name;
        }
    };

对应`babel-plugin-transform-es2015-shorthand-properties`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-shorthand-properties"]
    }

## 展开语法
输入

    var a = ['a', 'b', 'c'];
    var b = [...a, 'foo'];

输出

    var a = [ 'a', 'b', 'c' ];
    var b = [].concat(a, [ 'foo' ]);

对应`babel-plugin-transform-es2015-spread`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-spread"]
    }

## sticky-regex

对应`babel-plugin-transform-es2015-sticky-regex`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-sticky-regex"]
    }

## 模板字符

输入

    `foo${bar}`;

输出

    "foo" + bar;

对应`babel-plugin-transform-es2015-template-literals`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-template-literals"]
    }

## typeof的symol扩展

输入

    typeof Symbol() === "symbol";

输出

    var _typeof = function (obj) {
        return obj && obj.constructor === Symbol ? "symbol" : typeof obj;
    };

    _typeof(Symbol()) === "symbol";

对应`babel-plugin-transform-es2015-typeof-symbol`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-typeof-symbol"]
    }

## unicode正则

输入

    var string = "foo💩bar";
    var match = string.match(/foo(.)bar/u);

输出

    var string = "foo💩bar";
    var match = string.match(/foo((?:[\0-\t\x0B\f\x0E-\u2027\u202A-\uD7FF\uE000-\uFFFF]|[\uD800-\uDBFF][\uDC00-\uDFFF]|[\uD800-\uDBFF](?![\uDC00-\uDFFF])|(?:[^\uD800-\uDBFF]|^)[\uDC00-\uDFFF]))bar/);

对应`babel-plugin-transform-es2015-unicode-regex`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-es2015-unicode-regex"]
    }

## 求幂操作

    // x ** y

    let squared = 2 ** 2;
    // same as: 2 * 2

    let cubed = 2 ** 3;
    // same as: 2 * 2 * 2


    // x **= y

    let a = 2;
    a **= 2;
    // same as: a = a * a;

    let b = 3;
    b **= 3;
    // same as: b = b * b * b;

对应`babel-plugin-transform-exponentiation-operator`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-exponentiation-operator"]
    }

## Async to generator
输入

    async function foo() {
        await bar();
    }

输出

    var _asyncToGenerator = function (fn) {
        ...
    };
    var foo = _asyncToGenerator(function* () {
        yield bar();
    });

对应`babel-plugin-transform-async-to-generator`插件，通过`.babelrc`文件集成此插件

    {
        "plugins": ["transform-async-to-generator"]
    }

## babel-preset-env
上述特性所使用到的插件都被包含到了`babel-preset-env`里面，我们只要在`.babelrc`文件里面加上下面的配置，就可以轻松集成以上所有特性

    {
        "presets": ["env"]
    }

