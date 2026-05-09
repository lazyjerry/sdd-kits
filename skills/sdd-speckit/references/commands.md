## 常用指令速查

### CLI 指令

| 指令 | 說明 |
|------|------|
| `specify init <name>` | 初始化新專案 |
| `specify init . --integration <agent>` | 在當前目錄初始化 |
| `specify version` | 顯示 CLI 版本與環境資訊 |
| `specify check` | 檢查已安裝的工具 |
| `uv tool upgrade specify-cli` | 檢測並更新 Spec Kit CLI |
| `specify extension search` | 搜尋可用擴充 |
| `specify extension add <name>` | 安裝擴充 |
| `specify preset search` | 搜尋可用預設 |
| `specify preset add <name>` | 安裝預設 |

### Slash Commands

#### 核心指令

| 指令 | 說明 |
|------|------|
| `/speckit.constitution` | 建立或更新專案治理原則 |
| `/speckit.specify` | 定義功能需求 |
| `/speckit.plan` | 建立技術實作計畫 |
| `/speckit.tasks` | 拆解任務清單 |
| `/speckit.implement` | 執行實作 |

#### 選用指令

| 指令 | 說明 |
|------|------|
| `/speckit.clarify` | 釐清規格模糊地帶（建議在 plan 之前） |
| `/speckit.analyze` | 跨 artifact 一致性分析（建議在 implement 之前） |
| `/speckit.checklist` | 產生品質檢核清單 |

### 環境變數

| 變數 | 說明 |
|------|------|
| `SPECIFY_FEATURE` | 非 Git 環境下覆蓋功能偵測，設為功能目錄名稱 |
