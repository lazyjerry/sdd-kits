English | [简体中文](README_CN.md) | 繁體中文 | [日本語](README_JP.md) | [한국어](README_KR.md)

# SDD-Kits

兩套 SDD（Spec-Driven Development）步驟範本與 AI 操作指引精靈，搭配安裝腳本快速部署到你的專案。

## 包含內容

| 項目 | 說明 |
|------|------|
| `files/open-spec-steps/` | OpenSpec 步驟範本（來源） |
| `files/spec-kit-steps/` | Spec Kit 步驟範本（來源） |
| `skills/sdd-openspec/` | OpenSpec 操作指引精靈（Copilot / Claude Skill） |
| `skills/sdd-speckit/` | Spec Kit 操作指引精靈（Copilot / Claude Skill） |
| `scripts/init.sh` | 將步驟範本複製到目標專案 |
| `scripts/init-skill.sh` | 將操作指引精靈安裝到 Copilot 或 Claude |

---

## 先決條件

至少安裝其中一個 SDD 工具：

### OpenSpec

```bash
npm install -g @fission-ai/openspec@latest
```

### Spec Kit（需先安裝 uv）

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
uv tool upgrade specify-cli
specify version
```

---

## 使用方式一：安裝步驟範本（init.sh）

將 SDD 步驟 Markdown 檔（從 `01.*` 開始）與 `prompt.md` 複製到目標專案的 `sdd-steps/` 目錄，方便開發時參考。

### 互動模式

```bash
bash scripts/init.sh
```

依提示選擇工具類型並輸入專案路徑即可。

### 非互動模式

```bash
# 只安裝 OpenSpec 步驟
bash scripts/init.sh --tool openspec --project ~/work/my-app

# 只安裝 Spec Kit 步驟
bash scripts/init.sh --tool speckit --project ~/work/my-app

# 同時安裝兩套
bash scripts/init.sh --tool all --project ~/work/my-app
```

| 參數 | 說明 |
|------|------|
| `-t, --tool` | `openspec` / `speckit` / `all` |
| `-p, --project` | 目標專案路徑（支援 `~`） |
| `-h, --help` | 顯示說明 |

### 輸出目錄

```text
<你的專案>/
└── sdd-steps/
    ├── open-spec-steps/
    │   ├── 01.project-setup.md
    │   ├── ...
    │   └── prompt.md
    └── spec-kit-steps/
        ├── 01.constitution.md
        ├── ...
        └── prompt.md
```

> 註：`00.setup.md` 會保留在本 repo 作為初始化參考，`init.sh` 不會複製到目標專案。

---

## 使用方式二：安裝 AI 操作指引精靈（init-skill.sh）

將 SDD 操作指引精靈安裝到 VS Code Copilot 或 Claude Code 的 skills 目錄。安裝後在對話中提及 OpenSpec 或 Spec Kit，精靈會自動啟動並以選單引導你完成完整流程。

### 互動模式

```bash
bash scripts/init-skill.sh
```

依提示選擇要安裝的精靈與目標平台。

### 非互動模式

```bash
# 安裝 OpenSpec 精靈到 Copilot
bash scripts/init-skill.sh --skill openspec --target copilot

# 安裝 Spec Kit 精靈到 Claude Code
bash scripts/init-skill.sh --skill speckit --target claude

# 全部安裝到 Copilot
bash scripts/init-skill.sh --skill all --target copilot

# 目標已存在時直接覆蓋，不再詢問
bash scripts/init-skill.sh --skill all --target copilot --force
```

| 參數 | 說明 |
|------|------|
| `-s, --skill` | `openspec` / `speckit` / `all` |
| `-t, --target` | `copilot`（~/.copilot/skills）/ `claude`（~/.claude/skills） |
| `-f, --force` | 目標已存在時直接覆蓋，不再詢問 |
| `-h, --help` | 顯示說明 |


## SDD 步驟概覽
## 使用方式三：透過 ai-global 安裝操作指引精靈

[ai-global](https://github.com/lazyjerry/ai-global) 是多個 AI 工具（Copilot、Claude Code、Cursor、Windsurf 等）的統一配置管理器。使用此方式全域安裝精靈並同步到所有 AI 工具。

### 先決條件

先安裝 ai-global：

```bash
# 使用 curl（推薦）
curl -fsSL https://raw.githubusercontent.com/lazyjerry/ai-global/main/install.sh | bash

# 或使用 npm
npm install -g ai-global
```

### 安裝精靈

```bash
# 新增 SDD OpenSpec 精靈
ai-global add-skill lazyjerry/SDD-Kits/skills/sdd-openspec

# 新增 SDD Spec Kit 精靈
ai-global add-skill lazyjerry/SDD-Kits/skills/sdd-speckit

# 或克隆本 repo 後一次安裝兩個
git clone https://github.com/lazyjerry/SDD-Kits.git
ai-global add-skill ./SDD-Kits/skills/sdd-openspec
ai-global add-skill ./SDD-Kits/skills/sdd-speckit
```

### 驗證安裝

```bash
# 列出所有已安裝的 skills
ai-global list-skills

# 檢查狀態
ai-global status
```

安裝完成後，精靈將在所有配置的 AI 工具中可用（Copilot、Claude Code、Cursor 等）。在對話中提及 OpenSpec 或 Spec Kit，精靈會自動啟動。

---

## SDD 步驟概覽

### OpenSpec 流程

> 核心三招：`proposal` → `apply` → `archive`

| 步驟 | 檔案 | 說明 |
|------|------|------|
| 00 | `00.setup.md` | 安裝 CLI 並執行 `openspec init` |
| 01 | `01.project-setup.md` | 填寫 `openspec/project.md` 專案資訊 |
| 02 | `02.proposal.md` | 建立變更提案（proposal + tasks + specs） |
| 03 | `03.spec-format.md` | 檢查規格格式（SHALL/MUST、Scenario、Delta） |
| 04 | `04.validate.md` | 執行 `openspec validate` 驗證格式 |
| 05 | `05.apply.md` | AI 依 tasks.md 逐項實作 |
| 06 | `06.archive.md` | 歸檔，規格差異合併回 specs/ |
| — | `advanced.md` | 進階：design.md 與多 Specs 變更 |
| — | `commands.md` | CLI 與 Slash Command 速查表 |
| — | `prompt.md` | 常用提示詞範本 |

### Spec Kit 流程

> 核心路徑：`constitution` → `specify` → `plan` → `tasks` → `implement`

| 步驟 | 檔案 | 說明 |
|------|------|------|
| 00 | `00.setup.md` | 安裝 CLI 並執行 `specify init --integration <agent>` |
| 01 | `01.constitution.md` | 建立治理原則（技術棧、慣例、限制） |
| 02 | `02.specify.md` | 描述功能規格 |
| 03 | `03.clarify.md` | 釐清模糊地帶（選用） |
| 04 | `04.plan.md` | 製作技術計畫 |
| 05 | `05.tasks.md` | 拆解任務清單 |
| 06 | `06.analyze.md` | 分析規格與計畫（選用） |
| 07 | `07.implement.md` | 逐步實作 |
| — | `prompt.md` | 常用提示詞範本 |

---

## 專案結構

```text
SDD-Kits/
├── files/                    # 步驟範本來源
│   ├── open-spec-steps/
│   └── spec-kit-steps/
├── skills/                   # AI 操作指引精靈
│   ├── sdd-openspec/
│   │   ├── SKILL.md
│   │   └── references/steps.md
│   └── sdd-speckit/
│       ├── SKILL.md
│       └── references/steps.md
├── scripts/
│   ├── init.sh               # 安裝步驟範本
│   └── init-skill.sh         # 安裝操作指引精靈
└── sdd-steps/                # 步驟範本副本（供本專案參考）
    └── open-spec-steps/
```

## 常見問題

- 顯示「未偵測到 OpenSpec 或 Spec Kit CLI 工具」
  - 代表 `openspec` 與 `specify` 都不在 PATH，請先安裝其一。

- 顯示「目錄不存在」
  - 請確認輸入的目標專案路徑正確。

- 顯示「無效的選擇」
  - 請輸入互動列表中的數字編號。
