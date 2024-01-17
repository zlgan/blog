```c#
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace CancelToken
{
    class Program
    {
        static CancellationTokenSource cts = new CancellationTokenSource();
        static int count = 0;
        static List<Task> tasks = new List<Task>();    
        static void Main(string[] args)
        {
            while (Console.ReadKey().Key!=ConsoleKey.Q)
            {
                count+=1;
                var c = new[] { "A", "B", "C" };
                cts.Cancel();
                if(tasks.Count>0)
                {
                    Task.WaitAll(tasks.ToArray());
                }
                tasks.Clear();

                Console.WriteLine("aaaaaaaaaaaaaaaaaaaaaaa");
                cts =new CancellationTokenSource();
                foreach (var v in c) 
                {
                    tasks.Add(Task.Run(async () => { await f1(v, count, cts.Token); }));
                }
            }
        }

        private static async Task f1(string v, int count, CancellationToken token)
        {
            while (!token.IsCancellationRequested)
            {
                for (int i = 0; i < 10; i++)
                {
                    Console.Write($"{v}{count}");
                    await Task.Delay(500);
                }
            }
        }
    }
}

```
