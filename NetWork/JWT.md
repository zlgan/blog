---
title: JWT实现 身份认证
date: 2021-06-16 16:43:14
tags: 
categories: Network
---
### JWT的构成

- header 头部存放加密算法
- payload 有效载荷
- sign 签名

JWT=Base64(header).Base64(payload).Hash(Base64(header)+Base64(payload))

1. 定义两个接口，一个需要授权，另一个不需要

```c#
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Demo.Jwt.Controllers
{
    [ApiController]
    public class ValuesController : ControllerBase
    {
        [HttpGet]
        [Route("api/value1")]
        public ActionResult<IEnumerable<string>> Get()
        {
            return new string[] { "value1", "value1" };
        }

        [HttpGet]
        [Route("api/value2")]
        [Authorize]
        public ActionResult<IEnumerable<string>> Get2()
        {
            return new string[] { "value2", "value2" };
        }
    }
}
```

2. 定义授权接口，用户提供凭证，返回Token给客户端

``` c#
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace Demo.Jwt.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        [AllowAnonymous]
        [HttpGet]
        public IActionResult Get(string userName, string pwd)
        {
            if (!string.IsNullOrEmpty(userName) && !string.IsNullOrEmpty(pwd))
            {
                var claims = new[]
                {
                    new Claim(JwtRegisteredClaimNames.Nbf,$"{new DateTimeOffset(DateTime.Now).ToUnixTimeSeconds()}") ,
                    new Claim (JwtRegisteredClaimNames.Exp,$"{new DateTimeOffset(DateTime.Now.AddMinutes(30)).ToUnixTimeSeconds()}"),
                    new Claim(ClaimTypes.Name, userName)
                };
                var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Const.SecurityKey));
                var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
                var token = new JwtSecurityToken(
                    issuer: Const.Domain,
                    audience: Const.Domain,
                    claims: claims,
                    expires: DateTime.Now.AddMinutes(30),
                    signingCredentials: creds);

                return Ok(new
                {
                    token = new JwtSecurityTokenHandler().WriteToken(token)
                });
            }
            else
            {
                return BadRequest(new { message = "username or password is incorrect." });
            }
        }
    }
}
```

3. 请求Auth接口，获取token

   *eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYmYiOiIxNjIyOTgxOTM4IiwiZXhwIjoxNjIyOTgzNzM4LCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiYWEiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjUwMDAiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUwMDAifQ.A7huVXlRo_dhq08v98RM_6wC10YMg3AUrtLt3-qLmAo*

3. 使用Token请求需要授权的接口

~~~ powershell
PS D:\workspace\ssl> curl -Uri "http://localhost:5000/api/value2" -header @{"Authorization"="Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYmYiOiIxNjIyOTgxOTM4IiwiZXhwIjoxNjIyOTgzNzM4LCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiYWEiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjUwMDAiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUwMDAifQ.A7huVXlRo_dhq08v98RM_6wC10YMg3AUrtLt3-qLmAo"}
StatusCode        : 200
StatusDescription : OK
Content           : ["value2","value2"]
RawContent        : HTTP/1.1 200 OK
                    Transfer-Encoding: chunked
                    Content-Type: application/json; charset=utf-8
                    Date: Sun, 06 Jun 2021 12:20:51 GMT
                    Server: Kestrel

                    ["value2","value2"]
Forms             : {}
Headers           : {[Transfer-Encoding, chunked], [Content-Type, application/json; charset=utf-8], [Date, Sun, 06 Jun 2021 12:20:51 GMT], [Server, Kestrel]}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 19
~~~



>参考文档
>
>https://www.bilibili.com/video/BV1vk4y1B7g3?from=search&seid=12806066337138035415
>
>https://www.cnblogs.com/7tiny/archive/2019/06/13/11012035.html
>
>https://www.cnblogs.com/RainingNight/p/jwtbearer-authentication-in-asp-net-core.html

