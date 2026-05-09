## Step 0：初始化專案

### 目的

在目標專案目錄中初始化 Spec Kit 結構，產生 `specs/` 資料夾與基礎檔案。

### 前置條件

- 已安裝 uv 套件管理工具
- 已安裝 Spec Kit CLI（`uv tool install specify-cli --from git+https://github.com/github/spec-kit.git`）
- 已安裝 Python 3.11+、Git

### 執行指令

新專案：

```bash
specify init <project-name> --ai <agent>
```

既有專案：

```bash
cd <專案目錄>
specify init . --ai <agent>
# 或
specify init --here --ai <agent>
```

支援的 `--ai` 選項包括：`claude`、`copilot`、`cursor-agent`、`gemini`、`codex`、`windsurf` 等。

環境檢查：

```bash
specify check
```

### 預期產出

```
specs/
├── constitution.md   # 專案治理原則
├── spec.md           # 功能規格
├── clarifications.md # 釐清紀錄
├── plan.md           # 技術實作計畫
└── tasks.md          # 任務清單
```

### 引導提示

```
請確認以下資訊：
1. 這是新專案還是既有專案？
2. 你使用的 AI 工具是？（claude / copilot / cursor-agent / gemini / 其他）
```

### 注意事項

- 既有專案使用 `specify init .` 或 `specify init --here`
- 可加 `--force` 強制覆寫（非空白目錄）
- 可加 `--ai-skills` 安裝 agent skills
- 初始化後建議立即進入 Step 1 建立治理原則
