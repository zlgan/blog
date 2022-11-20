---
title: Spring开发
date: 2021-06-26 07:02:58
tags:
categories: Java
---

### 通过注解注入容器

```java
//这个@Component注解就相当于定义了一个Bean，它有一个可选的名称，默认是mailService，即小写开头的类名
@Component
public class UserService {
    @Autowired //使用@Autowired就相当于把指定类型的Bean注入到指定的字段中
    MailService mailService;
    
    /@Autowired大幅简化了注入，因为它不但可以写在set()方法上，还可以直接写在字段上，甚至可以写在构造方法中
    public UserService(@Autowired MailService mailService) { 
        this.mailService = mailService;
    }

    ...
}
```















https://zhuanlan.zhihu.com/p/308663980