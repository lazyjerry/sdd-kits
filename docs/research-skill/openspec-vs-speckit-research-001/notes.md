# 筆記：OpenSpec vs Spec Kit 研究

---  [2026-02-17] [00:00:00]  第 1 次更新筆記 ---
## 任務摘要
本任務目標是比較 OpenSpec 與 Spec Kit 的安裝方式、檔案輸出格式、用例與實際使用流程。
研究資料以兩個專案的 README、官方 docs、templates 與 scripts 為主。
輸出為一份繁中報告，供選型或流程設計使用。

## 來源

### 來源 1：Fission-AI/OpenSpec
- URL：https://github.com/Fission-AI/OpenSpec
- 重點：
  - 安裝依賴為 Node.js 20.19+，支援 npm/pnpm/yarn/bun/nix。
  - 核心流程以 `/opsx:new`、`/opsx:ff`、`/opsx:apply`、`/opsx:verify`、`/opsx:archive` 為主。
  - 主要產物是 `openspec/changes/<name>/` 下的 proposal/design/tasks/specs，以及 `openspec/specs/` 主規格。

### 來源 2：OpenSpec docs
- URL：https://github.com/Fission-AI/OpenSpec/blob/main/docs/installation.md
- 重點：
  - 明確列出各套件管理器安裝命令。
  - 初始化為 `openspec init`，更新為 `openspec update`。

### 來源 3：OpenSpec commands/workflows
- URL：https://github.com/Fission-AI/OpenSpec/blob/main/docs/commands.md
- 重點：
  - `new/continue/ff/apply/verify/sync/archive/bulk-archive/onboard` 行為清楚。
  - archive 會移動到 `openspec/changes/archive/YYYY-MM-DD-<name>/`。

### 來源 4：github/spec-kit
- URL：https://github.com/github/spec-kit
- 重點：
  - 安裝主軸為 `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git`。
  - 流程命令為 `/speckit.constitution` → `/speckit.specify` → `/speckit.plan` → `/speckit.tasks` → `/speckit.implement`。

### 來源 5：spec-driven 與 templates/scripts
- URL：https://github.com/github/spec-kit/blob/main/spec-driven.md
- 重點：
  - feature 目錄常見輸出：`spec.md`、`plan.md`、`research.md`、`data-model.md`、`quickstart.md`、`contracts/`、`tasks.md`。
  - `tasks.md` 有固定 task 格式與 phase 規則，可標註 `[P]` 並依 user story 切分。

## 綜合發現

### 安裝與執行環境
- OpenSpec 走 Node 生態；Spec Kit 走 Python + uv 生態。
- 兩者都支援多種 AI agent，但命令前綴與流程習慣不同。

### 產物模型
- OpenSpec 是「change-centric」，以 `openspec/changes/<name>/` 為單位管理變更生命週期。
- Spec Kit 是「feature-centric」，以 `specs/<###-feature>/` 為單位擴充 spec/plan/tasks 與 supporting docs。

### 流程特性
- OpenSpec 重流動迭代與快速往返，封存機制完整。
- Spec Kit 重模板治理與規範一致性，文件顆粒度更細。

### 報告輸出
- 已建立比較報告：`files/OpenSpec-vs-SpecKit-研究報告.md`。
---