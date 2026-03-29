# Spec Kit 步驟詳細指引

> 本文件為 Spec Kit 操作指引精靈的參考資料，包含每個步驟的完整說明、提示詞與注意事項。
> 精靈在執行每個步驟前會讀取對應段落。

---

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

---

## Step 1：建立治理原則（Constitution）

### 目的

定義專案的治理原則，包括決策流程、編碼風格、架構規範。`constitution.md` 作為後續所有技術決策的基礎依據。

### 執行指令

```
/speckit.constitution <治理原則描述>
```

### 提示詞模板

```
/speckit.constitution Create principles focused on code quality, testing
standards, user experience consistency, and performance requirements
```

範例（中文）：

```
/speckit.constitution 建立專案治理原則，包含：程式碼品質標準、測試覆蓋率要求、使用者體驗一致性、效能要求
```

### 引導提示

```
治理原則用來規範整個專案的開發方向，通常包括：
- 程式碼品質標準（命名規則、架構規範）
- 測試要求（單元測試、整合測試覆蓋率）
- 使用者體驗一致性（UI 規範、無障礙設計）
- 效能要求（回應時間、資源限制）

請描述你希望團隊遵守的開發原則：
```

### 注意事項

- 新專案必須先定義治理原則
- 治理原則會影響後續所有步驟的 AI 判斷
- 建議包含：品質標準、測試策略、安全性要求

---

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

---

## Step 3：釐清模糊地帶（Clarify）— 選用

### 目的

針對規格中的模糊或有爭議的地方進行釐清。釐清結果會記錄在 `clarifications.md`，確保需求無歧義。

### 執行指令

```
/speckit.clarify
```

### 說明

AI 會閱讀 `spec.md`，找出可能模糊、遺漏或有多種解讀的部分，並提出問題。你的回答會被記錄到 `clarifications.md`。

### 引導提示

```
（選用步驟）釐清規格中的模糊地帶。

AI 會針對你描述的功能提出問題，幫助你釐清：
- 邊界情況（edge cases）
- 未定義的行為
- 可能有歧義的需求

是否要執行釐清？（建議在 /speckit.plan 之前進行）
  [Y] 是，開始釐清
  [N] 跳過，直接進入下一步
```

### 注意事項

- 建議在 `/speckit.plan` 之前執行
- 可以多次執行，每次釐清更多細節
- 即使跳過，仍可在後續步驟中回來補充

---

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

---

## Step 5：拆解任務清單（Tasks）

### 目的

從實作計畫拆解出可執行的任務清單，採 TDD 方法並標記可平行處理的項目。系統會產生 `tasks.md`，每項任務都有明確的驗收條件。

### 執行指令

```
/speckit.tasks
```

### 說明

AI 會根據 `plan.md` 和 `spec.md` 自動拆解任務。不需要額外輸入。

### 引導提示

```
AI 將根據技術計畫自動拆解任務清單。

任務清單會包含：
- 每項任務的描述與驗收條件
- TDD 導向：先寫測試再實作
- 標記可平行處理的項目
- 依據依賴關係排序

是否要開始拆解？
```

### 注意事項

- 任務拆解完成後，建議先進入 Step 6 分析（選用）再開始實作
- tasks.md 是實作階段的唯一依據

---

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

---

## Step 7：逐步實作（Implement）

### 目的

AI 按照任務清單逐項完成實作，每完成一項自動打勾。

### 執行指令

```
/speckit.implement
```

### 引導提示

```
準備開始實作。以下是注意事項：
- AI 會依照 tasks.md 逐項完成
- 如果 AI 超出範圍，請提醒：「請專注在 tasks.md 列出的項目」
- 建議實作前先清理 AI 的上下文視窗

是否要開始實作？
```

### 注意事項

- AI 會按照 tasks.md 的順序逐項實作
- 如果 AI 偏離範圍，使用範圍控制提示：`這不在提案範圍內，請專注在 tasks.md 列出的項目`
- 實作完成後，所有任務應該都被打勾

---

## 常用指令速查

### CLI 指令

| 指令 | 說明 |
|------|------|
| `specify init <name>` | 初始化新專案 |
| `specify init . --ai <agent>` | 在當前目錄初始化 |
| `specify check` | 檢查已安裝的工具 |
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
