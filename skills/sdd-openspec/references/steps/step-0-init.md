## Step 0：初始化專案

### 目的

在目標專案目錄中初始化 OpenSpec 結構，產生 `openspec/` 資料夾與基礎檔案。

### 前置條件

- 已安裝 OpenSpec CLI（`npm install -g @fission-ai/openspec@latest`）
- 已切換到目標專案目錄

### 執行指令

```bash
cd <專案目錄>
openspec init
```

系統會詢問使用的 AI 工具，根據使用者選擇自動設定 Slash Command。

### 預期產出

```
openspec/
├── AGENTS.md     # 給 AI 讀的工作流程
├── project.md    # 專案基本資訊
├── changes/      # 變更提案
│   └── archive/  # 已完成的變更
└── specs/        # 目前系統的規格（真相來源）
```

### 引導提示

```
精靈會替你執行 openspec init，請確認：
1. 你使用的 AI 工具是？（Claude / Copilot / Cursor / 其他）
```

### 注意事項

- 如已經初始化過，再次執行會提示是否覆寫
- 初始化後建議立即進入 Step 1 填寫專案資訊
