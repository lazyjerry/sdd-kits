## Step 0：初始化專案

### 目的

在目標專案目錄中初始化 OpenSpec 結構，產生 `openspec/` 資料夾與基礎檔案。

### 前置條件

- 已安裝 OpenSpec CLI（`npm install -g @fission-ai/openspec@latest`）
- 已切換到目標專案目錄

建議先檢測套件版本：

```bash
npm install -g @fission-ai/openspec@latest
openspec --version
```

### 執行指令

```bash
cd <專案目錄>
openspec init
```

非互動模式（指定整合工具）：

```bash
openspec init --tools github-copilot .
```

系統會詢問使用的 AI 工具，根據使用者選擇自動設定 Slash Command。

若專案已初始化過且剛更新套件，建議同步整合指令檔：

```bash
openspec update
```

### 預期產出

```
.github/
├── prompts/      # /opsx:* 提示詞
└── skills/       # OpenSpec 技能檔

openspec/
├── changes/
│   └── archive/
└── specs/
```

### 引導提示

```
精靈會替你執行 openspec init，請確認：
1. 你使用的 AI 工具是？（Claude / Copilot / Cursor / 其他）
```

### 注意事項

- 如已經初始化過，再次執行會提示是否覆寫
- OpenSpec 套件更新後，建議在專案目錄執行 `openspec update`
- 初始化後建議立即進入 Step 1 建立專案背景（選用）
