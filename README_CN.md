[English](README.md) | 简体中文 | [繁體中文](README_TW.md) | [日本語](README_JP.md) | [한국어](README_KR.md)

# SDD-Kits

两套 SDD（Spec-Driven Development，规格驱动开发）步骤模板与 AI 操作引导精灵，搭配安装脚本快速部署到你的项目。

## 包含内容

| 项目 | 说明 |
|------|------|
| `files/open-spec-steps/` | OpenSpec 步骤模板（来源） |
| `files/spec-kit-steps/` | Spec Kit 步骤模板（来源） |
| `skills/openspec-wizard/` | OpenSpec 操作引导精灵（Copilot / Claude Skill） |
| `skills/speckit-wizard/` | Spec Kit 操作引导精灵（Copilot / Claude Skill） |
| `scripts/init.sh` | 将步骤模板复制到目标项目 |
| `scripts/init-skill.sh` | 将操作引导精灵安装到 Copilot 或 Claude |

---

## 先决条件

至少安装其中一个 SDD 工具：

### OpenSpec

```bash
npm install -g @fission-ai/openspec@latest
```

### Spec Kit（需先安装 uv）

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

---

## 使用方式一：安装步骤模板（init.sh）

将 SDD 步骤的 Markdown 文件复制到目标项目的 `sdd-steps/` 目录，方便开发时参考。

### 交互模式

```bash
bash scripts/init.sh
```

按提示选择工具类型并输入项目路径即可。

### 非交互模式

```bash
# 只安装 OpenSpec 步骤
bash scripts/init.sh --tool openspec --project ~/work/my-app

# 只安装 Spec Kit 步骤
bash scripts/init.sh --tool speckit --project ~/work/my-app

# 同时安装两套
bash scripts/init.sh --tool all --project ~/work/my-app
```

| 参数 | 说明 |
|------|------|
| `-t, --tool` | `openspec` / `speckit` / `all` |
| `-p, --project` | 目标项目路径（支持 `~`） |
| `-h, --help` | 显示说明 |

### 输出目录

```text
<你的项目>/
└── sdd-steps/
    ├── open-spec-steps/
    │   ├── 00.setup.md
    │   ├── 01.project-setup.md
    │   ├── ...
    │   └── prompt.md
    └── spec-kit-steps/
        ├── 00.setup.md
        ├── 01.constitution.md
        ├── ...
        └── prompt.md
```

---

## 使用方式二：安装 AI 操作引导精灵（init-skill.sh）

将 SDD 操作引导精灵安装到 VS Code Copilot 或 Claude Code 的 skills 目录。安装后在对话中提及 OpenSpec 或 Spec Kit，精灵会自动启动并以菜单引导你完成完整流程。

### 交互模式

```bash
bash scripts/init-skill.sh
```

按提示选择要安装的精灵与目标平台。

### 非交互模式

```bash
# 安装 OpenSpec 精灵到 Copilot
bash scripts/init-skill.sh --skill openspec --target copilot

# 安装 Spec Kit 精灵到 Claude Code
bash scripts/init-skill.sh --skill speckit --target claude

# 全部安装到 Copilot
bash scripts/init-skill.sh --skill all --target copilot
```

| 参数 | 说明 |
|------|------|
| `-s, --skill` | `openspec` / `speckit` / `all` |
| `-t, --target` | `copilot`（~/.copilot/skills）/ `claude`（~/.claude/skills） |
| `-h, --help` | 显示说明 |

---

## SDD 步骤概览

### OpenSpec 流程

> 核心三招：`proposal` → `apply` → `archive`

| 步骤 | 文件 | 说明 |
|------|------|------|
| 00 | `00.setup.md` | 安装 CLI 并执行 `openspec init` |
| 01 | `01.project-setup.md` | 填写 `openspec/project.md` 项目信息 |
| 02 | `02.proposal.md` | 创建变更提案（proposal + tasks + specs） |
| 03 | `03.spec-format.md` | 检查规格格式（SHALL/MUST、Scenario、Delta） |
| 04 | `04.validate.md` | 执行 `openspec validate` 验证格式 |
| 05 | `05.apply.md` | AI 按 tasks.md 逐项实现 |
| 06 | `06.archive.md` | 归档，规格差异合并回 specs/ |
| — | `advanced.md` | 进阶：design.md 与多 Specs 变更 |
| — | `commands.md` | CLI 与 Slash Command 速查表 |
| — | `prompt.md` | 常用提示词模板 |

### Spec Kit 流程

> 核心路径：`constitution` → `specify` → `plan` → `tasks` → `implement`

| 步骤 | 文件 | 说明 |
|------|------|------|
| 00 | `00.setup.md` | 安装 CLI 并执行 `specify init` |
| 01 | `01.constitution.md` | 建立治理原则（技术栈、惯例、限制） |
| 02 | `02.specify.md` | 描述功能规格 |
| 03 | `03.clarify.md` | 厘清模糊地带（可选） |
| 04 | `04.plan.md` | 制作技术计划 |
| 05 | `05.tasks.md` | 拆解任务清单 |
| 06 | `06.analyze.md` | 分析规格与计划（可选） |
| 07 | `07.implement.md` | 逐步实现 |
| — | `prompt.md` | 常用提示词模板 |

---

## 项目结构

```text
SDD-Kits/
├── files/                    # 步骤模板来源
│   ├── open-spec-steps/
│   └── spec-kit-steps/
├── skills/                   # AI 操作引导精灵
│   ├── openspec-wizard/
│   │   ├── SKILL.md
│   │   └── references/steps.md
│   └── speckit-wizard/
│       ├── SKILL.md
│       └── references/steps.md
├── scripts/
│   ├── init.sh               # 安装步骤模板
│   └── init-skill.sh         # 安装操作引导精灵
└── sdd-steps/                # 步骤模板副本（供本项目参考）
    └── open-spec-steps/
```

## 常见问题

- 显示「未侦测到 OpenSpec 或 Spec Kit CLI 工具」
  - 说明 `openspec` 与 `specify` 都不在 PATH，请先安装其一。

- 显示「目录不存在」
  - 请确认输入的目标项目路径正确。

- 显示「无效的选择」
  - 请输入交互列表中的数字编号。
