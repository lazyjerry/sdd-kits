## Step 2：建立變更提案（Propose）

### 目的

為新功能、破壞性變更或架構改動建立提案。系統會產生 `proposal.md`、`tasks.md`、`specs/` 與 `design.md`。

### 執行指令（新版）

```
/opsx:propose <描述>
```

範例：

```
/opsx:propose 新增使用者搜尋功能
```

### 預期產出

```
openspec/changes/<change-name>/
├── proposal.md   # 原因與範圍
├── design.md     # 技術方案
├── tasks.md      # 待辦清單
└── specs/        # 規格差異（Delta）
    └── spec.md
```

### 引導提示

```
請描述你想要建立的變更：
（例如：新增使用者搜尋功能、重構認證模組、新增暗黑模式）
```

### 注意事項

- 提案描述越具體，AI 產出的規格與任務清單越準確
- 建立後建議先進入 Step 3 檢查規格格式
