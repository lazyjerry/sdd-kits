# OpenSpec 步驟詳細指引

> 本文件為 OpenSpec 操作指引精靈的參考資料，包含每個步驟的完整說明、提示詞與注意事項。
> 精靈在執行每個步驟前會讀取對應段落。

---

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

---

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

---

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

---

## Step 3：檢查規格格式

### 目的

確認提案中的 `specs/spec.md` 格式正確，避免驗證失敗和歸檔時合併出錯。

### 提示詞模板

```
請檢查這次提案的 specs 格式是否符合 OpenSpec 規範，有錯請修正
```

### 手動檢查清單

#### 檢查 1：每個 Requirement 是否有 Scenario

每個 `### Requirement:` 底下至少要有一個 `#### Scenario:`：

```markdown
### Requirement: User Login
使用者 SHALL 能夠使用 Email 和密碼登入系統。

#### Scenario: 登入成功
- WHEN 使用者輸入正確的 Email 和密碼
- THEN 系統回傳 JWT token
```

#### 檢查 2：需求描述是否包含 SHALL 或 MUST

每條需求的描述句中**必須**出現 `SHALL` 或 `MUST`，這是驗證的必要條件。

#### 檢查 3：Delta 標記是否正確

提案中的 spec.md 使用差異格式（Delta）：

| 標題 | 用途 | 注意事項 |
|------|------|----------|
| `## ADDED Requirements` | 新增需求 | 寫完整的新需求 |
| `## MODIFIED Requirements` | 修改既有需求 | **必須貼修改後的完整內容**，不只寫差異 |
| `## REMOVED Requirements` | 移除需求 | 附上 Reason 和 Migration |

### 引導提示

```
要我自動檢查規格格式，還是你想手動對照清單檢查？
  [A] 自動檢查（AI 讀取 spec.md 後回報）
  [M] 手動檢查（顯示檢查清單）
```

---

## Step 4：驗證提案（Validate）

### 目的

使用 CLI 驗證提案格式，確保規格可以正確歸檔。

### 執行指令

```bash
openspec validate <change-name> --strict
```

- `<change-name>` 為 Step 2 建立提案時的名稱（如 `add-user-search`）

### 失敗時的除錯指令

```bash
openspec show <change-name> --json --deltas-only
```

### 引導提示

```
請輸入變更名稱（即 openspec/changes/ 下的資料夾名稱）：
```

### 注意事項

- 驗證失敗最常見的原因：缺少 Scenario、缺少 SHALL/MUST、Delta 標記格式錯誤
- 建議在 Step 3 先手動檢查過後再執行驗證

---

## Step 5：開始實作（Apply）

### 目的

AI 依照 `tasks.md` 逐項完成實作，每完成一項自動打勾。

### 執行指令（新版）

```
/opsx:apply
```

如需指定變更名稱：

```
/opsx:apply <change-name>
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

- OpenSpec 建議使用高推理能力模型（如 Opus 4.5、GPT 5.2）
- 保持乾淨的上下文視窗，實作前建議清理對話歷史
- 如果 AI 偏離範圍，使用範圍控制提示：`這不在提案範圍內，請專注在 tasks.md 列出的項目`

---

## Step 6：歸檔（Archive）

### 目的

所有任務完成、測試通過後執行歸檔。變更目錄移至 `archive/` 並加上日期前綴，規格差異合併回 `specs/`。

### 執行指令（新版）

```
/opsx:archive
```

如需指定變更名稱：

```
/opsx:archive <change-name>
```

### 預期結果

```
openspec/changes/archive/2025-01-23-add-user-search/  # 舊提案移到這裡
openspec/specs/                                         # 規格差異已合併回主目錄
```

### 引導提示

```
歸檔前請確認：
1. tasks.md 中所有項目是否都已打勾？
2. 測試是否全部通過？
3. 是否確定要歸檔此變更？

確認後將執行歸檔。
```

---

## 進階：design.md 與多 Specs 變更

### 適用場景

- 跨模組變更
- 引入新的外部依賴
- 有安全性或效能考量

### design.md

在提案資料夾中加入 `design.md` 記錄技術決策（選用）：

```
openspec/changes/add-2fa/
├── proposal.md
├── design.md          # 選用
├── tasks.md
└── specs/
    ├── auth/spec.md
    └── notifications/spec.md
```

### 多 Specs 變更

一次變更影響多個功能時，在 `specs/` 下建立多個子目錄，歸檔時各自合併。

---

## 常用指令速查

### CLI 指令

| 指令 | 說明 |
|------|------|
| `openspec init` | 初始化專案 |
| `openspec list` | 列出進行中的變更（`--specs` 列規格） |
| `openspec show [name]` | 顯示詳細內容（`--json` 取 JSON） |
| `openspec validate [name] --strict` | 驗證格式 |
| `openspec archive [name]` | 歸檔（`--yes` 跳過確認） |
| `openspec view` | 開啟互動式 dashboard |
| `openspec config profile` | 選擇設定檔 |
| `openspec update` | 更新 AI 指令檔案 |

### Slash Commands（新版 /opsx:*）

| 指令 | 說明 |
|------|------|
| `/opsx:propose <描述>` | 建立提案 |
| `/opsx:apply` | 開始實作 |
| `/opsx:archive` | 歸檔 |
| `/opsx:new` | 建立新變更（擴充工作流） |
| `/opsx:continue` | 繼續未完成的實作 |
| `/opsx:ff` | 快速推進 |
| `/opsx:verify` | 驗證實作結果 |
| `/opsx:sync` | 同步規格 |
| `/opsx:bulk-archive` | 批次歸檔 |
| `/opsx:onboard` | 新手引導 |

> 擴充工作流指令需透過 `openspec config profile` 選擇對應 profile 並執行 `openspec update` 後才可使用。
