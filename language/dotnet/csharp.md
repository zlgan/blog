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

# stream

## 二进制序列化

### 序列化

```c#
using System;
using System.IO;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;

[Serializable]
class Person
{
    public string Name { get; set; }
    public int Age { get; set; }
}

class Program
{
    static void Main()
    {
        // 创建一个 Person 对象
        Person person = new Person
        {
            Name = "John",
            Age = 30
        };

        // 创建 BinaryFormatter 对象
        BinaryFormatter formatter = new BinaryFormatter();

        // 创建一个 MemoryStream 来保存序列化后的数据
        using (MemoryStream memoryStream = new MemoryStream())
        {
            // 使用 BinaryFormatter 将对象序列化到 MemoryStream
            formatter.Serialize(memoryStream, person);

            // 从 MemoryStream 中获取序列化后的二进制数据
            byte[] binaryData = memoryStream.ToArray();

            // 可以将 binaryData 存储到文件、发送到网络等
            // 还可以在需要时反序列化对象
        }

        Console.WriteLine("Object serialized successfully.");
    }
}

```

### 反序列化

```c#
using System;
using System.IO;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;

[Serializable]
class Person
{
    public string Name { get; set; }
    public int Age { get; set; }
}

class Program
{
    static void Main()
    {
        // 二进制数据（这里是示例数据，实际中通常从文件、网络等获取）
        byte[] binaryData = GetBinaryData();

        // 创建 BinaryFormatter 对象
        BinaryFormatter formatter = new BinaryFormatter();

        // 创建 MemoryStream 来包装二进制数据
        using (MemoryStream memoryStream = new MemoryStream(binaryData))
        {
            // 使用 BinaryFormatter 反序列化对象
            Person deserializedPerson = (Person)formatter.Deserialize(memoryStream);

            // 现在，deserializedPerson 包含了从二进制数据还原的对象
            Console.WriteLine($"Name: {deserializedPerson.Name}, Age: {deserializedPerson.Age}");
        }
    }

    // 模拟获取二进制数据的方法（实际中可根据需要替换为从文件、网络等获取数据的方法）
    static byte[] GetBinaryData()
    {
        // 示例二进制数据
        return new byte[]
        {
            0x00, 0x00, 0x00, 0x1A,  // 数据长度
            0x53, 0x79, 0x73, 0x74,  // 类型信息
            0x65, 0x6D, 0x2E, 0x4F,
            0x62, 0x6A, 0x65, 0x63,
            0x74, 0x53, 0x65, 0x72,
            0x69, 0x61, 0x6C, 0x69,
            0x7A, 0x61, 0x74, 0x69,
            0x6F, 0x6E, 0x2E, 0x50,
            0x65, 0x72, 0x73, 0x6F,
            0x6E,                    // 版本信息
            0x00, 0x02,              // 对象数据
            0x00, 0x00, 0x00, 0x04,  // Name 字符串长度
            0x4A, 0x6F, 0x68, 0x6E,  // "John"
            0x00, 0x00, 0x00, 0x00,  // Age 整数值 0x00000000 = 0
        };
    }
}

```

## 压缩与解压缩

```c#
using System;
using System.IO;
using System.IO.Compression;
using System.Text;

class Program
{
    static void Main()
    {
        string originalText = "这是一个示例文本，将被压缩和解压缩。";
        Console.WriteLine("原始文本: " + originalText);

        // 压缩数据
        byte[] compressedData = CompressText(originalText);

        // 解压缩数据
        string decompressedText = DecompressText(compressedData);
        Console.WriteLine("解压缩后的文本: " + decompressedText);
    }

    static byte[] CompressText(string text)
    {
        byte[] bytes = Encoding.UTF8.GetBytes(text);

        using (MemoryStream memoryStream = new MemoryStream())
        {
            using (GZipStream gzipStream = new GZipStream(memoryStream, CompressionMode.Compress, true))
            {
                gzipStream.Write(bytes, 0, bytes.Length);
            }

            return memoryStream.ToArray();
        }
    }

    static string DecompressText(byte[] compressedData)
    {
        using (MemoryStream memoryStream = new MemoryStream(compressedData))
        {
            using (GZipStream gzipStream = new GZipStream(memoryStream, CompressionMode.Decompress))
            {
                using (StreamReader reader = new StreamReader(gzipStream, Encoding.UTF8))
                {
                    return reader.ReadToEnd();
                }
            }
        }
    }
}

```

## 设计一个二进制协议

设计一个二进制协议通常需要定义协议的消息格式，包括消息头和消息体的结构，以及编码和解码规则。在C#中，你可以使用 `BinaryWriter` 和 `BinaryReader` 来轻松地编码和解码二进制数据。

以下是一个简单的示例，演示如何设计一个二进制协议并实现客户端与服务端之间的通信。协议包括一个消息头，其中包含消息类型和消息体的长度，以及一个消息体，用于传输数据。

首先，定义一个消息类型的枚举：

```c#
public enum MessageType
{
    Login,
    Chat,
    Logout
}
```

然后，设计消息格式，包括消息头和消息体：

```c#
public class Message
{
    public MessageType Type { get; set; }
    public int Length { get; set; }
    public byte[] Data { get; set; }
}
```

接下来，创建一个简单的客户端和服务端的通信示例。以下是一个简化的示例，其中包括客户端和服务端的代码：

### **服务器端：**

```c#
using System;
using System.IO;
using System.Net;
using System.Net.Sockets;

class Server
{
    static void Main()
    {
        TcpListener server = new TcpListener(IPAddress.Any, 12345);
        server.Start();

        Console.WriteLine("服务器已启动，等待客户端连接...");

        while (true)
        {
            using (TcpClient client = server.AcceptTcpClient())
            using (NetworkStream stream = client.GetStream())
            using (BinaryReader reader = new BinaryReader(stream))
            using (BinaryWriter writer = new BinaryWriter(stream))
            {
                // 读取消息头
                MessageType messageType = (MessageType)reader.ReadInt32();
                int messageLength = reader.ReadInt32();

                // 读取消息体
                byte[] messageData = reader.ReadBytes(messageLength);

                // 处理消息
                HandleMessage(messageType, messageData);

                // 发送响应
                byte[] responseData = Encoding.UTF8.GetBytes("服务器收到消息并处理。");
                writer.Write((int)MessageType.Chat);
                writer.Write(responseData.Length);
                writer.Write(responseData);
            }
        }
    }

    static void HandleMessage(MessageType messageType, byte[] messageData)
    {
        // 根据消息类型处理消息
        string message = Encoding.UTF8.GetString(messageData);
        Console.WriteLine($"接收到消息类型: {messageType}, 内容: {message}");
    }
}
```

### **客户端：**

```c#
using System;
using System.IO;
using System.Net.Sockets;
using System.Text;

class Client
{
    static void Main()
    {
        TcpClient client = new TcpClient("127.0.0.1", 12345);

        using (NetworkStream stream = client.GetStream())
        using (BinaryReader reader = new BinaryReader(stream))
        using (BinaryWriter writer = new BinaryWriter(stream))
        {
            // 创建并发送消息
            Message message = new Message
            {
                Type = MessageType.Chat,
                Data = Encoding.UTF8.GetBytes("Hello, Server!")
            };

            // 发送消息头
            writer.Write((int)message.Type);
            writer.Write(message.Data.Length);

            // 发送消息体
            writer.Write(message.Data);

            // 读取服务器响应
            MessageType responseType = (MessageType)reader.ReadInt32();
            int responseLength = reader.ReadInt32();
            byte[] responseData = reader.ReadBytes(responseLength);

            Console.WriteLine($"服务器响应类型: {responseType}, 内容: {Encoding.UTF8.GetString(responseData)}");
        }
    }
}
```