## Step 4：製作技術計畫（Plan）

### 目的

根據規格和技術棧，產生詳細的架構設計與實作計畫。系統會產生 `plan.md`，包含模組分工、資料流與技術決策。

### 執行指令

```
/speckit.plan <技術棧描述>
```

### 提示詞模板

```
/speckit.plan The application uses Vite with minimal number of libraries.
Use vanilla HTML, CSS, and JavaScript as much as possible. Images are not
uploaded anywhere and metadata is stored in a local SQLite database.
```

範例（中文）：

```
/speckit.plan 使用 Next.js 14 + TypeScript + Tailwind CSS，資料庫為 PostgreSQL，部署到 Vercel
```

### 引導提示

```
請描述你的技術棧和架構選擇：

1. 前端框架？（React / Vue / Svelte / 原生 HTML）
2. 後端框架？（Express / FastAPI / Laravel / Go）
3. 資料庫？（PostgreSQL / MySQL / SQLite / MongoDB）
4. 部署方式？（Docker / Vercel / AWS / 自建機器）
5. 其他重要的技術決策？

請輸入技術規範：
```

### 注意事項

- 這裡才是提供技術細節的地方（與 Step 2 相反）
- plan.md 會成為 tasks 拆解的依據
- 如有特殊環境需求（如 air-gapped 環境），在此步驟說明
