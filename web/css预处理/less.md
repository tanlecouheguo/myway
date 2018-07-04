
# Less

LESS是一种动态样式语言，LESS 将 CSS 赋予了动态语言的特性，如 变量， 继承， 运算， 函数. LESS 既可以在 客户端 上运行 (支持IE 6+, Webkit, Firefox)，也可以借助Node.js或者Rhino在服务端运行。
* 官网：http://lesscss.org/
* Github：https://github.com/less/less.js

## 安装
### 使用npm安装
npm install less -g
### 在浏览器中面使用
引入你的 .less 样式文件的时候要设置 rel 属性值为 “stylesheet/less”:
```html
<link rel="stylesheet/less" type="text/css" href="styles.less" />
```
然后点击页面顶部download按钮下载 less.js, 在<head> 中引入:
```html
<script src="less.js" type="text/javascript"></script>
```

> 注意你的less样式文件一定要在引入less.js前先引入。

## 语法
### 变量
变量允许我们单独定义一系列通用的样式，然后在需要的时候去调用。所以在做全局样式调整的时候我们可能只需要修改几行代码就可以了。

```less
// LESS
@width: 10px;
@height: @width + 10px;

#header {
  width: @width;
  height: @height;
}
```

```css
/* 生成的 CSS */
#header {
  width: 10px;
  height: 20px;
}
```

### 混合
混合可以将一个定义好的class A轻松的引入到另一个class B中，从而简单实现class B继承class A中的所有属性。我们还可以带参数地调用，就像使用函数一样。
```less
// LESS
.rounded-corners (@radius: 5px) {
  border-radius: @radius;
  -webkit-border-radius: @radius;
  -moz-border-radius: @radius;
}

#header {
  .rounded-corners;
}
#footer {
  .rounded-corners(10px);
}
```

```css
/* 生成的 CSS */
#header {
  border-radius: 5px;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
}
#footer {
  border-radius: 10px;
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
}
```

### 嵌套

我们可以在一个选择器中嵌套另一个选择器来实现继承，这样很大程度减少了代码量，并且代码看起来更加的清晰。
```less
// LESS

#header {
  color: black;
  .navigation {
    font-size: 12px;
  }
  .logo {
    width: 300px;
  }
}
```
```css
/* 生成的 CSS */
#header {
  color: black;
}
#header .navigation {
  font-size: 12px;
}
#header .logo {
  width: 300px;
}
```

### 嵌套的At-Rules和冒泡
如@media或者@supports之类的at-rule可以以选择器相同的方式嵌套。at-rule被放置在顶部，相对于同一规则集内的其他元素的相对顺序保持不变。这叫做冒泡。
```less
// LESS
.component {
  width: 300px;
  @media (min-width: 768px) {
    width: 600px;
    @media  (min-resolution: 192dpi) {
      background-image: url(/img/retina2x.png);
    }
  }
  @media (min-width: 1280px) {
    width: 800px;
  }
}
```
```css
/* 生成的 CSS */
.component {
  width: 300px;
}
@media (min-width: 768px) {
  .component {
    width: 600px;
  }
}
@media (min-width: 768px) and (min-resolution: 192dpi) {
  .component {
    background-image: url(/img/retina2x.png);
  }
}
@media (min-width: 1280px) {
  .component {
    width: 800px;
  }
}
```
### 函数 & 运算
运算提供了加，减，乘，除操作；我们可以做属性值和颜色的运算，这样就可以实现属性值之间的复杂关系。LESS中的函数一一映射了JavaScript代码，如果你愿意的话可以操作属性值。
```less
// LESS

@the-border: 1px;
@base-color: #111;
@red:        #842210;

#header {
  color: @base-color * 3;
  border-left: @the-border;
  border-right: @the-border * 2;
}
#footer { 
  color: @base-color + #003300;
  border-color: desaturate(@red, 10%);
}
```
```css
/* 生成的 CSS */

#header {
  color: #333;
  border-left: 1px;
  border-right: 2px;
}
#footer { 
  color: #114411;
  border-color: #7d2717;
}
```

### 命名空间和访问器
有时，为了组织的目的，您可能想要分组您的mixin，或者只是提供一些封装。用less可以更直观的做到。假设您想要将`#bundle`下的mixin和变量捆绑在一起，以便以后重用或分发：
```less
#bundle() {
  .button {
    display: block;
    border: 1px solid black;
    background-color: grey;
    &:hover {
      background-color: white;
    }
  }
  .tab { ... }
  .citation { ... }
}
```
现在如果我们想`#header a`中混合`.button`，我们可以这样做：
```less
#header a {
  color: orange;
  #bundle.button();  // can also be written as #bundle > .button
}
```

### Map
从Less 3.5开始，还可以使用mixins和rulesets作为值的映射。
```less
// LESS
#colors() {
  primary: blue;
  secondary: green;
}

.button {
  color: #colors[primary];
  border: 1px solid #colors[secondary];
}
```
```css
/* 生成的 CSS */
.button {
  color: blue;
  border: 1px solid green;
}
```
### 作用域
Less变量的作用域与CSS非常相似。变量和mixin首先在本地查找，如果找不到它们，它将继承自“父”范围。
```less
@var: red;

#page {
  @var: white;
  #header {
    color: @var; // white
  }
}
```
与CSS自定义属性一样，mixin和变量定义不必放在引用它们的行之前。因此，以下Less代码与前一个示例相同：
```less
@var: red;

#page {
  #header {
    color: @var; // white
  }
  @var: white;
}
```

### 注释
可以使用块样式和内联注释：
```less
/* One heck of a block
 * style comment! */
@var: red;

// Get in line!
@var: white;
```

### 导入
我们可以导入.less文件，其中的所有变量都可用。可以为.less文件指定扩展名。
```less
@import "library"; // library.less
@import "typo.css";
```
