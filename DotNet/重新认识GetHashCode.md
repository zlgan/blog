---
title: 重新认识GetHashCode
date: 10/10/2021 15:21:56
tags: 
categories: DotNet
---


```c#
using System;
using System.Collections.Generic;
using System.Text;

namespace ConsoleApp1
{
    public class node
    {
        public string Data { get; set; }

        //判断node是否相同，hashcode相同的情况下才需要此判断
        public override bool Equals(object obj)
        {
            return obj is node node &&
                   Data == node.Data;
        }

        //通过一个哈希算法得到hashcode，目的是为了通过该值确定key在hash桶中的位置
        //如果hashcode相同，则node位于hash桶索引相同的位置，并且使用链表连接起来
        //经过测试链表使用头插法
        public override int GetHashCode()
        {
            return 1;
        }

        public static void Test()
        {
            var n1 = new node { Data = "1" };
            var n2 = new node { Data = "2" };
            var n3 = new node { Data = "3" };

            var dic = new Dictionary<node, object>();
            dic.Add(n1,1);
            dic.Add(n2,2);
            dic.Add(n3,3);
            var a = dic[n1];
        }
    }
}

```


