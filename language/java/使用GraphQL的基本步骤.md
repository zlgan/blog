---
title: 使用GraphQL的基本步骤
date: 2021-05-15 10:48:30
tags: 
categories: Java
---
### 使用GraphQL的基本步骤

1. 使用GraphQL语法构建一个Schema，Schema描述了服务器端能够给客户端提供的数据类型集合

   同时对客户端的查询参数进行校验，并执行查询

   ```javascript
   //Query是一个特殊的对象类型，
   //1.所有的查询必须定义在Query中，是查询的入口
   //2.有且只能有一个Query类型
   const schema=buildSchema(`
       type Query{
           foo:String
           count:Int
           bar:String
       }
   `)
   ```

   2. 定义Schema对应的resolver解析器，也就是Schema里面定义的每个字段如何取值

   ```javascript
   const rootValue= { 
       foo(){return 'bar'},
       count(){return 123},
       bar(){return "bar2"}
   }
   ```

   3. 客户端提供查询语句

   ```javascript
   {
       foo //查询foo的值
   }
   ```

   

### 标量类型

- string
- Int
- Float
- Boolean
- ID

### 自定义对象类型

``` javascript
//自定义User类型
type User ｛
    name:String
    age:Int
｝
Type Query{
    user1:User //定义一个类型为User的字段user1
}
//返回值
const rootValue= { 
    user1(){
        return{
             name:"leo"
        	age:30
        }
    }
}

//客户端查询
{
	user1{
    name,age
  }
}

//查询结果
{
  "data": {
    "user1": {
      "name": "leo",
      "age": 40
    }
  }
}

```

### 对象的嵌套

~~~javascript
//服务端	
	type User{
        name:String
        age:Int
        hobbies:[String] //定义数组
    }
    
    type Article{
        title:String
        content:String
        author:User
    }
    type Query{
        foo:String
        count:Int
        bar:String
        user1:User
        article1:Article
    }

 	article1(){
        return{
            title:"title1",
            content:"content1",
            author:{
                name:"leo",
                age:30，
                hobbies:["a","b","c"]
            }
        }
    }
//客户端
//查询
{
	article1{
    title,
    author{
      name
    }
  }
}
//查询结果
{
  "data": {
    "article1": {
      "title": "title1",
      "author": {
        "name": "leo"
      }
    }
  }
}
~~~

### 类型约束

- 默认情况下每个字段都可以为空，如果要求非空使用！

```javascript
type User{
	name:Int! //非空
    hobbies:[String!]//数组元素不能为null
    hobbies:[String]!//数组本身不能为null
    hobbies:[String!]!//二者都不能为空        
}
```

### 查询参数

```javascript
type Query {
    articles:[Article] //查询所有文章
    articleEntity(title:String!):Article //按title查询，title不能为null，返回值为Article类型
}
//resolver
{
    //通过args接受传递过来的参数
    article({id}){
        ///实现
    }
}

//客户端查询
{
  articleEntity(title:"title1"){
    title
    author{
      name
    }
  }
}
```





