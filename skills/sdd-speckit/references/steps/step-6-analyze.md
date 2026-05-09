## Step 6：分析規格與計畫（Analyze）— 選用

### 目的

檢查規格完整性、計畫可行性，進行跨 artifact 一致性與覆蓋率分析，找出潛在的設計問題與風險。

### 執行指令

```
/speckit.analyze
```

### 說明

AI 會交叉比對 `spec.md`、`plan.md`、`tasks.md`，檢查：

- 所有需求是否都有對應的任務
- 計畫中的技術方案是否可行
- 是否有遺漏的邊界情況

### 引導提示

```
（選用步驟）分析規格與計畫的一致性。

建議在 /speckit.tasks 之後、/speckit.implement 之前執行。
AI 會檢查所有 artifact 之間的一致性，找出潛在問題。

是否要執行分析？
  [Y] 是，開始分析
  [N] 跳過，直接進入實作
```

### 注意事項

- 建議在 `/speckit.tasks` 之後、`/speckit.implement` 之前執行
- 分析結果可能會建議修改 spec 或 plan
- 如有修改，需重新執行 `/speckit.tasks` 更新任務清單
