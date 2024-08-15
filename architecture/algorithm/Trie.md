# 排序字典实现
```c#
using System.Diagnostics;
using System.Globalization;
using System.Text;

public class SortedDic
{
    private SortedDictionary<string, string> users;

    private Stopwatch watch=new Stopwatch();

    // public class MyStringOrder : IComparer<string>
    // {
    //     public int Compare(string? x, string? y)
    //     {
    //         throw new NotImplementedException();
    //     }
    // }

    public SortedDic()
    {
         CultureInfo ci = new CultureInfo(133124);
         Thread.CurrentThread.CurrentCulture = ci;
        this.users = new SortedDictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        watch.Start();
        LoadData();
        watch.Stop();
        System.Console.WriteLine($"load data count {users.Count}, total elipsed{watch.ElapsedMilliseconds}ms");

        var proc=Process.GetCurrentProcess();
        long b=proc.PrivateMemorySize64;
        System.Console.WriteLine($"Memeory size:{b/1024/1024}Mb");
    }
    private void LoadData()
    {
        string fileName="UserData.txt";
        if(!File.Exists(fileName))
        {
            GenerateData();
        }
        using (var sr=new StreamReader(fileName))
        {
            string line=null;
            while((line=sr.ReadLine())!=null)
            {
                var arr=line.Split(",");
                users.Add(arr[0],arr[1]);
            }
        }
    }

    public void GenerateData()
    {
        using (StreamWriter sw = new StreamWriter("userData.txt"))
        {
            Dictionary<string,string> temp=new Dictionary<string, string>();
            for (int i = 0; i < 800000; i++)
            {
                int len = new Random().Next(2, 12);
                var sb = new StringBuilder();
                for (int j = 0; j < len; j++)
                {
                    int a = Guid.NewGuid().GetHashCode() % 3;
                    if (a == 0)
                    {
                        sb.Append((char)new Random().Next(0x61, 0x7A));
                    }
                    else if (a == 1)
                    {
                        sb.Append((char)new Random().Next(0x4e00, 0x9fa5));
                    }
                    else
                    {
                        sb.Append((char)new Random().Next(0x0030, 0x0039));
                    }
                }
                if(temp.ContainsKey(sb.ToString())) 
                {
                    i-=1;
                    continue;
                }
                temp.Add(sb.ToString(),null);
                sw.WriteLine(sb.Append(",").Append(i.ToString("D8")));
            }
        }
    }
    public void Search()
    {
        System.Console.WriteLine("选择功能，按1查询,按2更新，\\结束");
        string ins=System.Console.ReadLine();
        while (ins != "\\")
        {
            string input=null;
            if (ins == "1")
            {
                System.Console.WriteLine("输入查询的前缀");
                input=System.Console.ReadLine();
                watch.Restart();
                var u = users.Where(u => u.Key.StartsWith(input)).Take(50);
                watch.Stop();
                System.Console.WriteLine($"search elapsed:{watch.ElapsedMilliseconds}ms");
                var count = u.Count() < 10 ? u.Count() : 10;
                foreach (var item in u)
                {
                    System.Console.WriteLine($"name:{item.Key},id:{item.Value}");
                }
            }
            else if (ins == "2")
            {
                System.Console.WriteLine("输入修改信息a,b");
                input=System.Console.ReadLine();
                var names=input.Split(",");
                var old=users.FirstOrDefault(u=>u.Key==names[0]);
                if(old.Key==null)
                {
                    System.Console.WriteLine("not found!");
                }
                else
                {
                    watch.Restart();
                    users.Remove(old.Key);
                    users.Add(names[1],null);
                    watch.Stop();
                    System.Console.WriteLine($"update list total elipsed {watch.ElapsedMilliseconds}ms");
                }
            }
            System.Console.WriteLine("选择功能，按1查询,按2更新，\\结束");
            ins=System.Console.ReadLine();
        }
    }
}
```