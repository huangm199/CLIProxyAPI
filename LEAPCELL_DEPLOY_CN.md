# CLIProxyAPI 在 Leapcell 的最简部署说明

这份文件配合下面 3 个新增文件使用：

- `config.leapcell.yaml`
- `scripts/build-leapcell.sh`
- `scripts/start-leapcell.sh`

## 适用场景

- 你在 Leapcell 上部署 `CLIProxyAPI`
- 希望少填命令
- 优先跑通服务
- 当前先用 API Key 模式，而不是长期依赖本地 OAuth 文件

## 先改一个文件

打开：

- `config.leapcell.yaml`

把这一行改掉：

```yaml
api-keys:
  - "replace-this-with-a-long-random-api-key"
```

换成你自己的强随机字符串。

如果你已经有上游 API Key，也可以顺手把 `openai-compatibility` / `codex-api-key` / `claude-api-key` 里对应配置补上。

## Leapcell 页面怎么填

### Runtime

选：

- `Go`

不要选 `Python`。

### Build Command

填：

```bash
sh ./scripts/build-leapcell.sh
```

### Start Command

填：

```bash
sh ./scripts/start-leapcell.sh
```

### Serving Port

填：

```text
8080
```

## Env Variables 里加这些

最少加这 3 个：

```text
DEPLOY=cloud
WRITABLE_PATH=/tmp
TZ=Asia/Shanghai
```

如果你要开管理密码，再加：

```text
MANAGEMENT_PASSWORD=你自己的强密码
```

参考模板：

- `.env.leapcell.example`

## 部署后怎么验证

部署成功后，先用你自己的域名或 Leapcell 分配的域名访问：

```text
https://你的服务域名/v1/models
```

记得带上请求头：

```text
Authorization: Bearer 你在 config.leapcell.yaml 里填的 api key
```

如果能返回模型列表或正常 JSON，说明服务已经跑起来了。

## 重要限制

这套文件是为 Leapcell 免费 / serverless 这种“偏无状态”环境准备的。

适合：

- API Key 方式接上游
- 临时 auth 文件
- 快速验证服务能跑

不太适合：

- 长期依赖本地 OAuth 文件
- 希望认证信息永久保留
- 希望日志长期落盘

如果你后面要长期用 OAuth / Auth 文件，建议再补一个持久化后端：

- Postgres
- GitStore
- Object Storage

这些环境变量我也已经在 `.env.leapcell.example` 里给你预留好了。
