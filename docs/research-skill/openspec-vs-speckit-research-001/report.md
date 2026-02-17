# OpenSpec 與 Spec Kit 研究報告

> 研究日期：2026-02-17  
> 研究對象：
> - https://github.com/Fission-AI/OpenSpec
> - https://github.com/github/spec-kit

---

## 1) 專案定位摘要

### OpenSpec（Fission-AI/OpenSpec）
- 核心定位：針對 AI coding assistant 的「變更導向」規格流程（change-based workflow）。
- 關鍵概念：以 `openspec/changes/<change-name>/` 作為每次變更的工作單位，透過 proposal/specs/design/tasks 驅動實作。
- 風格：偏輕量、可來回迭代（官方描述為 fluid actions，不強制鎖死在階段門檻）。

### Spec Kit（github/spec-kit）
- 核心定位：Spec-Driven Development（SDD）工具包，透過 `specify` CLI + `/speckit.*` 命令建立規格→計畫→任務→實作流程。
- 關鍵概念：先建立 constitution（專案原則），再以 feature 目錄（`specs/<###-feature>/`）產生一系列文件。
- 風格：流程較制度化，模板與檢核規範較完整，適合標準化團隊協作。

---

## 2) 安裝方法比較

## 2.1 OpenSpec 安裝

### 需求
- Node.js `20.19.0+`

### 安裝方式（官方文件）
- npm：`npm install -g @fission-ai/openspec@latest`
- pnpm：`pnpm add -g @fission-ai/openspec@latest`
- yarn：`yarn global add @fission-ai/openspec@latest`
- bun：`bun add -g @fission-ai/openspec@latest`
- Nix（可直接 run 或安裝到 profile）

### 初始化與更新
- 初始化：`openspec init`
- 更新模板/代理指引：`openspec update`

---

## 2.2 Spec Kit 安裝

### 需求
- Python `3.11+`
- `uv`
- Git
- 支援的 AI agent（例如 Claude/Copilot/Cursor 等）

### 安裝方式（官方 README）
- 持久安裝（建議）：
  - `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git`
- 一次性執行：
  - `uvx --from git+https://github.com/github/spec-kit.git specify init <PROJECT_NAME>`

### 初始化
- 新專案：`specify init <PROJECT_NAME>`
- 目前目錄：`specify init . --ai copilot` 或 `specify init --here --ai copilot`
- 可選參數：`--script sh|ps`、`--no-git`、`--force`、`--debug`、`--github-token`

---

## 3) 產生的檔案格式與結構

## 3.1 OpenSpec 典型輸出

初始化後主要在專案內建立（或維護）`openspec/` 結構。官方文件顯示核心結構為：

```text
openspec/
├── specs/                          # 當前行為規格（source of truth）
│   └── <domain>/spec.md
├── changes/                        # 每次變更的工作區
│   └── <change-name>/
│       ├── proposal.md
│       ├── design.md
│       ├── tasks.md
│       ├── .openspec.yaml          # 可選：每個 change 的 metadata
│       └── specs/
│           └── <domain>/spec.md    # delta / future-state specs
└── config.yaml                     # 專案層設定（可選）
```

### 主要文件角色
- `proposal.md`：為何做、做什麼、影響面。
- `design.md`：技術決策與取捨。
- `tasks.md`：可勾選任務清單，供 `/opsx:apply` 執行與追蹤。
- `specs/.../spec.md`（change 內）：描述 ADDED/MODIFIED/REMOVED 的變更內容。
- 封存後：`openspec/changes/archive/YYYY-MM-DD-<name>/` 保留完整脈絡。

---

## 3.2 Spec Kit 典型輸出

`specify init` 後會建立 `.specify/` 與模板/腳本資產，並在功能流程中於 `specs/<###-feature>/` 生成文件。

### 初始化後常見骨架
```text
.specify/
├── memory/
│   └── constitution.md
├── scripts/
├── templates/
│   ├── spec-template.md
│   ├── plan-template.md
│   ├── tasks-template.md
│   └── commands/*.md
└── ...

specs/
└── <###-feature-name>/
    └── spec.md   # 由 /speckit.specify 建立
```

### 後續命令會新增的文件
依 `/speckit.plan`、`/speckit.tasks` 與相關腳本，feature 目錄常見：

```text
specs/<###-feature-name>/
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── ...
└── tasks.md
```

### 文件格式特徵
- `spec.md`：固定包含 User Scenarios、Requirements、Success Criteria。
- `plan.md`：含 Constitution Check、技術脈絡、專案結構與複雜度追蹤。
- `tasks.md`：強調格式規則（如 `- [ ] T001 [P] [US1] ...`），並按 user story 分 phase。
- `constitution.md`：專案原則（可版本化治理）。

---

## 4) 用例（適用情境）比較

## 4.1 OpenSpec 適合
- 既有專案持續演進（brownfield）且需求變動頻繁。
- 希望用「每個 change 一個資料夾」追蹤提案、實作、封存。
- 需要快速從規劃跳實作，且允許中途回改 artifacts。
- 想在多個 AI 工具間共用相同變更流程（`/opsx:*`）。

## 4.2 Spec Kit 適合
- 想建立較完整、制度化的 SDD 工作流。
- 團隊需要先定義憲章（constitution）與一致治理規則。
- 需要較明確的文件產物（research/data-model/contracts/quickstart/tasks）。
- 需要把任務切分成可並行、可驗證、可追蹤的 story-based phases。

---

## 5) 用法流程（實務操作）

## 5.1 OpenSpec 建議流程（OPSX）
1. `openspec init`
2. 在 agent 內：`/opsx:new <change-name>`
3. 產生規劃文件：`/opsx:ff`（或逐步 `/opsx:continue`）
4. 實作：`/opsx:apply`
5. 驗證：`/opsx:verify`
6. 封存：`/opsx:archive`

補充：
- 多變更平行可用 `/opsx:bulk-archive`。
- archive 會處理 delta spec 合併與歷史保留。

## 5.2 Spec Kit 建議流程
1. `specify init <project> --ai <agent>`
2. `/speckit.constitution` 建立專案原則
3. `/speckit.specify` 生成 feature spec（建立分支與 `spec.md`）
4. （建議）`/speckit.clarify` 釐清模糊需求
5. `/speckit.plan` 產生 plan/research/data-model/contracts/quickstart
6. `/speckit.tasks` 生成 tasks
7. （建議）`/speckit.analyze`
8. `/speckit.implement` 實作

---

## 6) 差異總表（精簡）

| 面向 | OpenSpec | Spec Kit |
|---|---|---|
| 主要執行器 | Node CLI (`openspec`) | Python CLI (`specify`) |
| 安裝依賴 | Node 20.19+ | Python 3.11+ + uv |
| 工作單位 | `changes/<change-name>` | `specs/<###-feature-name>` |
| 流程風格 | 動作導向、可流動迭代 | 階段化、模板驅動與治理較強 |
| 核心命令 | `/opsx:new/ff/apply/verify/archive` | `/speckit.constitution/specify/plan/tasks/implement` |
| 主要文件 | proposal/design/tasks/delta specs | constitution/spec/plan/research/data-model/contracts/tasks |
| 封存機制 | `changes/archive/YYYY-MM-DD-<name>` | 以 feature 規格與任務文件持續演進（無同型 archive 模型） |
| 適合團隊型態 | 要速度、可變更、重落地 | 要規範、可審核、重文件完整度 |

---

## 7) 導入建議

- 若你要快速落地、以「變更提案→實作→封存」為主線：優先選 OpenSpec。
- 若你要制度化 SDD、重視憲章治理與標準化文件：優先選 Spec Kit。
- 若團隊成熟度不一：
  - 可先用 OpenSpec 降低上手門檻；
  - 再把 Spec Kit 的 constitution/checklist 精神抽進內部流程。

---

## 8) 研究限制與備註

- 本報告以兩專案公開 README、docs、templates、scripts 與 repo 程式碼片段為主。
- 兩專案更新頻繁（尤其 templates 與命令細節），導入前建議再跑一次：
  - OpenSpec：`openspec update`
  - Spec Kit：`uv tool install specify-cli --force --from git+https://github.com/github/spec-kit.git`
