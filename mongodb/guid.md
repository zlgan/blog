### guid

```c#

using MongoDB.Bson;
using MongoDB.Bson.Serialization;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;
// See https://aka.ms/new-console-template for more information

Console.WriteLine("Hello, World!");

// 建立与 MongoDB 数据库的连接
var settings = new MongoClientSettings();
var client = new MongoClient("mongodb://localhost:27017");
var database = client.GetDatabase("test");
var persons = database.GetCollection<Person>("persons");


BsonDefaults.GuidRepresentationMode = GuidRepresentationMode.V3;

var person = new Person{Name="Leo2",Id=Guid.Parse("21e71f7c-e8f8-47de-b8ff-fffaf26246ba") };

persons.InsertOne(person);

var filter = persons.Find(x => x.Id == Guid.Parse("21e71f7c-e8f8-47de-b8ff-fffaf26246ba")).FirstOrDefault();
public class Person
{
    public string Name { get; set; }
    [BsonGuidRepresentation(GuidRepresentation.Standard)]
    public Guid Id { get; set; }
}
```



### Serilog

```c#


using Serilog;

var builder = WebApplication.CreateBuilder(args);

builder.Host.UseSerilog((context, services, configuration) => {
    configuration.ReadFrom.Configuration(context.Configuration);
});

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseSerilogRequestLogging();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

```



jsonconfig

```javascript
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },

  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft": "Warning",
        "Microsoft.Hosting.Lifetime": "Information"
      }
    },
    "WriteTo": [
      {
        "Name": "File",
        "Args": {
          "path": "./logs/log-.txt",
          "rollingInterval": "Minute"
        }
      }
    ]
  },
  "AllowedHosts": "*"
}

```

