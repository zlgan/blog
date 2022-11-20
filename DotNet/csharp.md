## Linq
### Groupby的一个重载
```C#
public static IEnumerable<TResult> GroupBy<TSource, TKey, TResult>
(
 this IEnumerable<TSource> source,
 Func<TSource, TKey> keySelector, //指定一个分组的列 
 Func<TKey, IEnumerable<TSource>, TResult> resultSelector // 根据分组的key，和分组后的每个集合返回一下新的结果
 );
 ```
```C#
 class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
           var tags = new tag[] {
                new tag{matchId="m1",tagid= "t1"},
                new tag{matchId="m1",tagid= "t2"},
                new tag{matchId="m3",tagid= "t3"},
                new tag{matchId="m4",tagid= "t5"},
                new tag{matchId="m4",tagid= "t4"},
                new tag{matchId="m5",tagid= "t6"},
            };
            var result = tags.GroupBy(t => t.matchId, (t, tg) => new tagInfo { matchId = t, tg = tg.Select(t => t.tagid) });
        }
    }
    public class tag
    {
        public string matchId { get; set; }
        public string tagid { get; set; }
    }
    public class tagInfo
    {
        public string matchId { get; set; }
        public IEnumerable<string> tg { get; set; }
    }
```