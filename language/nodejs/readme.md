# Nodejs 工作过程

## Node.js 启动

当你输入 `node a.js` 并按下回车，操作系统会启动 Node.js 进程，接下来的一系列步骤如下：

##  **Node.js 查找并加载 V8 引擎**

Node.js 本质上是一个 JavaScript 运行时环境，它的核心组件是 Google 的 **V8 引擎**。Node.js 会调用 **V8 引擎** 来解析并执行 JavaScript 代码。

1. **加载 Node.js 核心模块**：Node.js 首先初始化自己的一些核心模块，比如文件系统模块 (`fs`)、HTTP 模块 (`http`)、事件处理模块 (`events`) 等。这些核心模块提供了 JavaScript 与操作系统交互的能力。
2. **加载 V8 引擎**：Node.js 会初始化并加载 V8 引擎，V8 引擎是一个将 JavaScript 代码编译成机器码并执行的引擎。Node.js 会利用 V8 来解析和执行你编写的 JavaScript 代码。

##  **读取并解析 JavaScript 文件**

- Node.js 使用 **文件系统模块** (`fs`) 打开并读取 `a.js` 文件的内容。读取的文件内容会被当作 **字符串** 传递给 V8 引擎。

```
javascript复制代码const fs = require('fs');
const script = fs.readFileSync('a.js', 'utf8');
```

## 将 JavaScript 源码编译为机器代码

V8 引擎接收到 JavaScript 源码后，首先会将其解析为抽象语法树（AST），然后使用即时编译（Just-In-Time，JIT）技术，将 JavaScript 代码 **编译为机器代码**，这样代码就可以在 CPU 上直接执行。

- **解析（Parsing）**：V8 首先将 JavaScript 代码解析为抽象语法树（AST）。AST 是 JavaScript 代码的结构化表示。
- **字节码生成**：V8 会将 AST 编译成字节码，字节码是一种更接近机器语言的中间表示形式，稍后可以快速执行。
- **优化编译（Optimization）**：V8 使用即时编译技术，将字节码编译成机器码，并对常用代码路径进行优化。

## 执行编译后的代码

- V8 执行已经编译为机器码的 JavaScript 代码。
- 当遇到 `require()`、`import` 等模块导入时，Node.js 会找到相应的模块并将其加载到当前上下文中，供后续代码使用。

```
javascript复制代码// 例如你的 a.js 文件可能包含：
const http = require('http');
http.createServer((req, res) => {
    res.end('Hello, world!');
}).listen(3000);
```

Node.js 会在这个过程中加载 `http` 模块，并创建一个 HTTP 服务器。

## 事件循环的启动

- 如果你的 `a.js` 文件包含 **异步操作**，如文件 I/O、网络请求等，Node.js 的 **事件循环（Event Loop）** 会被启动。

- **事件循环** 是 Node.js 的核心部分，用于管理所有异步操作。Node.js 是单线程的，但是事件循环允许它处理大量并发的 I/O 操作，而不会阻塞。

  事件循环的步骤包括：

  - **定时器阶段**：处理 `setTimeout()` 和 `setInterval()` 的回调。
  - **I/O 回调阶段**：处理异步 I/O 操作的回调。
  - **空闲阶段**：内部处理。
  - **轮询阶段**：等待新的 I/O 事件。
  - **关闭回调阶段**：处理如 `socket.on('close')` 等的关闭回调。

## 执行回调函数

- 当某个异步操作完成时，Node.js 将会把相应的回调函数添加到事件循环中，以便稍后执行。比如，当你创建一个 HTTP 服务器时，服务器会在某个请求到来时触发回调函数。

## 输出结果

- 最终，任何代码中的 `console.log()` 输出、或 HTTP 响应等，会通过 Node.js 与操作系统的接口输出到终端或网络中。
- 比如，如果 `a.js` 是一个简单的输出程序：

```
console.log("Hello, World!");
```

- V8 会执行这段代码，然后通过 Node.js 的 `stdout` 将 "Hello, World!" 输出到终端。

## Node.js 进程退出

- 如果 `a.js` 没有任何持续运行的任务（例如没有未处理的定时器、事件或服务器请求），Node.js 会 **退出事件循环** 并终止进程。
- 如果有像 HTTP 服务器或长时间运行的任务，Node.js 进程会保持运行，直到所有事件和回调处理完毕。

# npm 包管理

## 全局安装

包托管地址：www.npmjs.com/package

npm install -g <packagename>

npm update -g <packa

npm install -g <packagename>@version

npm uninstall -g <packagename>

## 本地安装

```POWERSHELL
npm init # 初始化package.json包描述和项目描述
npm init -y # 初始化package.json文件

npm install # 根据package.json文件中的描述下载安装依赖的包
npm install --development

```

## 切换成淘宝的源

```powershell
npm config set registry https://registry.npmmirror.com
```

## 查看npm配置信息

```bash
PS E:\workspace\Project\nodejs> npm config list 
; cli configs
metrics-registry = "https://registry.npmjs.org/"
scope = ""
user-agent = "npm/6.14.8 node/v14.15.1 win32 x64"

; builtin config undefined
prefix = "C:\\Users\\Administrator\\AppData\\Roaming\\npm" #全局包安装路径

; node bin location = D:\Program Files\nodejs\node.exe    
; cwd = E:\workspace\Project\nodejs
; HOME = C:\Users\Administrator
; "npm config ls -l" to show all defaults.
```

