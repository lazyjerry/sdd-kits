## Step 1：填寫專案資訊

### 目的

填寫 `openspec/project.md`，讓 AI 了解專案背景、技術棧和編碼慣例，提升後續提案品質。

### 提示詞模板

直接貼給 AI：

```
Please read openspec/project.md and help me fill it out
with details about my project, tech stack, and conventions
```

### project.md 內容欄位

| 區塊 | 填寫內容 |
|------|----------|
| 專案描述 | 專案目的、主要功能 |
| 技術棧 | 語言、框架、資料庫、部署方式 |
| 撰寫慣例 | 命名規則、程式碼風格、目錄結構 |
| 重要限制 | 效能需求、安全性要求、相容性 |

### 引導提示

```
請簡述你的專案：
1. 專案目的是什麼？
2. 使用什麼技術棧？（語言、框架、資料庫）
3. 有沒有特殊的編碼慣例或限制？
```

### 注意事項

- 既有專案（Brownfield）不需一次補齊所有規格，先從下一個要做的功能開始
- project.md 填越完整，AI 產出越貼近專案風格
