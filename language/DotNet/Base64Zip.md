```c#
static void Case1()
        {
            long a = 0b111111111111111111111111111111111111111111111111111111111111;
            List<byte> data = new List<byte>();
            var b = BitConverter.GetBytes(a);
            var ind = b.Length - 2;
            while (b[ind] == 0x00 && ind > 0)
            {
                ind--;
            }
            for (int i = 0; i <= ind; i++)
            {
                data.Add(b[i]);
            }
            var c = Convert.ToBase64String(data.ToArray());
            System.Console.WriteLine(c);
            /*
             /////////w==
            */

            var d = Convert.FromBase64String(c);
            data.Clear();
            data.AddRange(d);
            for (int i = 0; i < 8 - d.Length; i++)
            {
                data.Add(0);
            }
            if (BitConverter.IsLittleEndian) Array.Reverse(d);
            var e = BitConverter.ToInt64(data.ToArray(), 0);
            Console.WriteLine(e);
            //AA==
        }


        static string ToBase64(string str)
        {
            var temp = str;
            while(temp.Length*6%24!=0)
            {
                temp += "=";
            }
            return temp;
        }
```