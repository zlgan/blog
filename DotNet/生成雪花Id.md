```c#
using System;

namespace SnowflakeIdGenerator
{
    public class SnowflakeId
    {
        private static readonly long Twepoch = 1288834974657L;
        private static readonly long WorkerIdBits = 6L;
        private static readonly long DatacenterIdBits = 4L;
        private static readonly long MaxWorkerId = -1L ^ (-1L << (int)WorkerIdBits);
        private static readonly long MaxDatacenterId = -1L ^ (-1L << (int)DatacenterIdBits);
        private static readonly long SequenceBits = 12L;
        private static readonly long WorkerIdShift = SequenceBits;
        private static readonly long DatacenterIdShift = SequenceBits + WorkerIdBits;
        private static readonly long TimestampLeftShift = SequenceBits + WorkerIdBits + DatacenterIdBits;
        private static readonly long SequenceMask = -1L ^ (-1L << (int)SequenceBits);

        private long _sequence = 0L;
        private long _lastTimestamp = -1L;

        private readonly long _workerId;
        private readonly long _datacenterId;

        public SnowflakeId(long workerId, long datacenterId)
        {
            if (workerId > MaxWorkerId || workerId < 0)
                throw new ArgumentException(string.Format("worker Id can't be greater than {0} or less than 0", MaxWorkerId));
            if (datacenterId > MaxDatacenterId || datacenterId < 0)
                throw new ArgumentException(string.Format("datacenter Id can't be greater than {0} or less than 0", MaxDatacenterId));
            _workerId = workerId;
            _datacenterId = datacenterId;
        }

        public long NextId()
        {
            lock (this)
            {
                var timestamp = TimeGen();
                if (timestamp < _lastTimestamp)
                {
                    for (int i = 0; i < 1000; i++)
                    {
                        Thread.Sleep(2);
                        timestamp=TimeGen();
                        if (timestamp >=_lastTimestamp)
                        {
                            break;
                        }
                    }
                }       
                if (timestamp < _lastTimestamp)
                    throw new Exception(string.Format("Clock moved backwards. Refusing to generate id for {0} milliseconds", _lastTimestamp - timestamp));
                if (_lastTimestamp == timestamp)
                {
                    _sequence = (_sequence + 1) & SequenceMask;
                    if (_sequence == 0)
                    {
                        timestamp = TilNextMillis(_lastTimestamp);
                    }
                }
                else
                {
                    _sequence = 0;
                }
                _lastTimestamp = timestamp;
                var id = ((timestamp - Twepoch) << (int)TimestampLeftShift) | (_datacenterId << (int)DatacenterIdShift) | (_workerId << (int)WorkerIdShift) | _sequence;
                return id;
            }
        }

        private static long TilNextMillis(long lastTimestamp)
        {
            var timestamp = TimeGen();
            while (timestamp <= lastTimestamp)
                timestamp = TimeGen();
            return timestamp;
        }

        private static long TimeGen()
        {
             return (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
        }
    }
}

```