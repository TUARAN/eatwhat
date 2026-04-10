# eatwhat

Cloudflare Worker + D1 的点菜 H5 项目。

当前能力：

- 首页随机推荐成人菜单
- 左右滑动切换到“小茉莉吃什么”
- 菜单数据存放在 Cloudflare D1
- 前端通过 `/api/dishes` 读取菜单

## 项目结构

```text
.
├── public/
│   └── index.html
├── src/
│   └── index.js
├── migrations/
│   ├── 0001_create_dishes.sql
│   └── 0002_seed_dishes.sql
└── wrangler.toml
```

## 数据表

当前使用一张 `dishes` 表，主要字段：

- `id`：菜品标识
- `name_zh`：中文名
- `rating_score`：数值评分
- `rating_label`：展示用评分文案
- `short_recipe`：约 30 字的简短做法
- `category`：分类
- `audience`：`adult` / `baby`
- `display_order`：排序
- `is_active`：是否启用

## 本地开发

安装并登录 Wrangler 后可直接启动：

```bash
npx wrangler dev
```

## D1

创建数据库：

```bash
npx wrangler d1 create eatwhat-db
```

执行建表：

```bash
npx wrangler d1 execute eatwhat-db --remote --file=./migrations/0001_create_dishes.sql
```

执行种子数据：

```bash
npx wrangler d1 execute eatwhat-db --remote --file=./migrations/0002_seed_dishes.sql
```

查询菜单：

```bash
curl "http://127.0.0.1:8787/api/dishes?audience=adult"
curl "http://127.0.0.1:8787/api/dishes?audience=baby"
```

## 部署

```bash
npx wrangler deploy
```

如果 Cloudflare API 偶发超时，直接重试一次即可。
