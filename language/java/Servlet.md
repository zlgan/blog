---
title: Servlet
date: 2021-06-26 07:02:58
tags:
categories: Java
---

### Servlet 就是.net 中的一般处理程序

浏览器发出的HTTP请求总是由Web Server先接收，然后，根据Servlet配置的映射，不同的路径转发到不同的Servlet：

```ascii
               ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐

               │            /hello    ┌───────────────┐│
                          ┌──────────>│ HelloServlet  │
               │          │           └───────────────┘│
┌───────┐    ┌──────────┐ │ /signin   ┌───────────────┐
│Browser│───>│Dispatcher│─┼──────────>│ SignInServlet ││
└───────┘    └──────────┘ │           └───────────────┘
               │          │ /         ┌───────────────┐│
                          └──────────>│ IndexServlet  │
               │                      └───────────────┘│
                              Web Server
               └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘
```

![image-20211211073525156](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20211211073525156.png)

### MVC中的的简单实现

由Controller 直接实现一个Servlet，处理业务逻辑，然后将生成的业务实体传递给Jsp渲染。

```ascii
                   ┌───────────────────────┐
             ┌────>│Controller: UserServlet│
             │     └───────────────────────┘
             │                 │
┌───────┐    │           ┌─────┴─────┐
│Browser│────┘           │Model: User│
│       │<───┐           └─────┬─────┘
└───────┘    │                 │
             │                 ▼
             │     ┌───────────────────────┐
             └─────│    View: user.jsp     │
                   └───────────────────────┘
```

### 复杂的MVC

比较复杂的是我们需要在MVC框架中创建一个接收所有请求的`Servlet`，通常我们把它命名为`DispatcherServlet`，它总是映射到`/`，然后，根据不同的Controller的方法定义的`@Get`或`@Post`的Path决定调用哪个方法，最后，获得方法返回的`ModelAndView`后，渲染模板，写入`HttpServletResponse`，即完成了整个MVC的处理。

这个MVC的架构如下：

```ascii
   HTTP Request    ┌─────────────────┐
──────────────────>│DispatcherServlet│
                   └─────────────────┘
                            │
               ┌────────────┼────────────┐
               ▼            ▼            ▼
         ┌───────────┐┌───────────┐┌───────────┐
         │Controller1││Controller2││Controller3│
         └───────────┘└───────────┘└───────────┘
               │            │            │
               └────────────┼────────────┘
                            ▼
   HTTP Response ┌────────────────────┐
<────────────────│render(ModelAndView)│
                 └────────────────────┘
```

其中，`DispatcherServlet`以及如何渲染均由MVC框架实现，在MVC框架之上只需要编写每一个Controller

### DispatcherServlet

1. 继承链 

   DispatchServlet-->HttpServlet-->GenerateServlet-->Servlet

### Filter

为了把一些公用逻辑从各个Servlet中抽离出来，JavaEE的Servlet规范还提供了一种Filter组件，即过滤器，它的作用是，在HTTP请求到达Servlet之前，可以被一个或多个Filter预处理，类似打印日志、登录检查等逻辑，完全可以放到Filter中

![image-20211211113425454](https://zlgan-blog.oss-cn-shenzhen.aliyuncs.com/image-20211211113425454.png)

### Listener

一个Web服务器可以运行一个或多个WebApp，对于每个WebApp，Web服务器都会为其创建一个全局唯一的`ServletContext`实例，我们在`AppListener`里面编写的两个回调方法实际上对应的就是`ServletContext`实例的创建和销毁：

```java
public void contextInitialized(ServletContextEvent sce) {
    System.out.println("WebApp initialized: ServletContext = " + sce.getServletContext());
}
```

通过Listener我们可以监听Web应用程序的生命周期，获取`HttpSession`等创建和销毁的事件；

`ServletContext`是一个WebApp运行期的全局唯一实例，可用于设置和共享配置信息

### 部署结构

类似Tomcat这样的Web服务器，运行的Web应用程序通常都是业务系统，因此，这类服务器也被称为应用服务器。应用服务器并不擅长处理静态文件，也不适合直接暴露给用户。通常，我们在生产环境部署时，总是使用类似Nginx这样的服务器充当反向代理和静态服务器，只有动态请求才会放行给应用服务器，所以，部署架构如下：

```ascii
             ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐

             │  /static/*            │
┌───────┐      ┌──────────> file
│Browser├────┼─┤                     │    ┌ ─ ─ ─ ─ ─ ─ ┐
└───────┘      │/          proxy_pass
             │ └─────────────────────┼───>│  Web Server │
                       Nginx
             └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘    └ ─ ─ ─ ─ ─ ─ ┘
```

使用Nginx配合Tomcat服务器，可以充分发挥Nginx作为网关的优势，既可以高效处理静态文件，也可以把https、防火墙、限速、反爬虫等功能放到Nginx中，使得我们自己的WebApp能专注于业务逻辑











https://www.zhihu.com/question/21416727
