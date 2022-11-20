---
title: 搞懂ref关键字
date: 10/10/2021 08:09:35
tags: 
categories: DotNet
---
```c#
    public class person
    {
        public int MyProperty { get; set; }

        public void Test1()
        {
          
            person p1 = new person { MyProperty = 1 };  //内存地址 &p1：0x000000f8a5f7e680 ，*&p1: 0x000002371814af20
            Change(p1); 
            Console.WriteLine(p1.MyProperty);//值为1，因为p1的指向并没有发生任何变化
            Change2(ref p1);
            Console.WriteLine(p1.MyProperty);
        }

        private void Change2(ref person p1)
        {
            //内存地址 &p1：0x000000f8a5f7e680 ，*&p1: 0x000002371814af20，此时栈上并没有产生新的变量，传递的就是外层p1本身
            p1 = new person { MyProperty = 2 };
        }

        private void Change(person p1) 
        {
            //内存地址 &p1：0x000000f8a5f7e658 ，*&p1: 0x000002371814af20
            //此时的P1是栈上的一个新的变量（地址不同），只不过他的值是拷贝外面p1的值
            p1 = new person { MyProperty = 2 };
            //内存地址 &p1：0x000000f8a5f7e658 ，*&p1: 0x000002371814af38，运行到这里，P1的值指向了新的堆内存
        }
    }
```


