## Step 2：描述功能規格（Specify）

### 目的

用自然語言描述要建造什麼功能，著重「what & why」。系統會產生 `spec.md`，包含功能需求與驗收場景。

### 執行指令

```
/speckit.specify <功能描述>
```

### 提示詞模板

```
/speckit.specify Build an application that can help me organize my photos
in separate photo albums. Albums are grouped by date and can be re-organized
by dragging and dropping on the main page.
```

範例（中文）：

```
/speckit.specify 建立一個使用者搜尋功能，支援依照名稱、Email 和部門搜尋，結果以分頁方式呈現
```

### 引導提示

```
請描述你想要建造的功能。

重點放在「做什麼」和「為什麼」，不需要描述技術細節（技術方案在 Step 4 處理）。

例如：
- 使用者面向功能：「用戶可以上傳照片並建立相簿」
- 系統需求：「系統需要支援即時通知功能」
- 改進項目：「改善搜尋效能，回應時間低於 200ms」

請輸入功能描述：
```

### 注意事項

- **不要**在這個步驟提供技術規範，專注在需求與目的
- 描述越具體，AI 產出的規格越精準
- 描述完後建議進入 Step 3 釐清模糊地帶
