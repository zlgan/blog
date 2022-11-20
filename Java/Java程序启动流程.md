---
title: JavaWeb
date: 2021-06-27 07:36:18
tags:
categories: Java
---

###  java.exe

众所周知java.exe是java class文件的执行程序，但实际上java.exe程序只是一个执行的外壳。它会装载jvm.dll（windows下），这个[动态连接库](https://baike.baidu.com/item/动态连接库/10577642)才是[java虚拟机](https://baike.baidu.com/item/java虚拟机/6810577)的实际操作处理所在。java.exe程序只负责查找和装载jvm.dll动态库，并调用它进行class文件执行处理

### JVM.dll

