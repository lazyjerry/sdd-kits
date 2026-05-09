English | [简体中文](README_CN.md) | [繁體中文](README_TW.md) | [日本語](README_JP.md) | [한국어](README_KR.md)

# SDD-Kits

Two sets of SDD (Spec-Driven Development) step templates and AI-guided wizards, with install scripts for quick deployment to your project.

## Contents

| Item | Description |
|------|-------------|
| `files/open-spec-steps/` | OpenSpec step templates (source) |
| `files/spec-kit-steps/` | Spec Kit step templates (source) |
| `skills/sdd-openspec/` | OpenSpec guided wizard (Copilot / Claude Skill) |
| `skills/sdd-speckit/` | Spec Kit guided wizard (Copilot / Claude Skill) |
| `scripts/init.sh` | Copy step templates to a target project |
| `scripts/init-skill.sh` | Install guided wizards to Copilot or Claude |

---

## Prerequisites

Install at least one SDD tool:

### OpenSpec

```bash
npm install -g @fission-ai/openspec@latest
```

### Spec Kit (requires uv)

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
uv tool upgrade specify-cli
specify version
```

---

## Usage 1: Install Step Templates (init.sh)

Copies SDD step Markdown files (from `01.*` onward) and `prompt.md` to the target project's `sdd-steps/` directory for reference during development.

### Interactive Mode

```bash
bash scripts/init.sh
```

Follow the prompts to select the tool type and enter the project path.

### Non-interactive Mode

```bash
# OpenSpec steps only
bash scripts/init.sh --tool openspec --project ~/work/my-app

# Spec Kit steps only
bash scripts/init.sh --tool speckit --project ~/work/my-app

# Install both
bash scripts/init.sh --tool all --project ~/work/my-app
```

| Flag | Description |
|------|-------------|
| `-t, --tool` | `openspec` / `speckit` / `all` |
| `-p, --project` | Target project path (supports `~`) |
| `-h, --help` | Show help |

### Output Directory

```text
<your-project>/
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

> Note: `00.setup.md` is kept in this repo as a setup reference and is not copied to the target project by `init.sh`.

---

## Usage 2: Install AI Guided Wizards (init-skill.sh)

Installs SDD guided wizards to the VS Code Copilot or Claude Code skills directory. After installation, mention OpenSpec or Spec Kit in a conversation and the wizard will auto-launch with a step-by-step menu.

### Interactive Mode

```bash
bash scripts/init-skill.sh
```

Follow the prompts to select the wizard and target platform.

### Non-interactive Mode

```bash
# Install OpenSpec wizard to Copilot
bash scripts/init-skill.sh --skill openspec --target copilot

# Install Spec Kit wizard to Claude Code
bash scripts/init-skill.sh --skill speckit --target claude

# Install all to Copilot
bash scripts/init-skill.sh --skill all --target copilot

# Overwrite existing destination without prompt
bash scripts/init-skill.sh --skill all --target copilot --force
```

| Flag | Description |
|------|-------------|
| `-s, --skill` | `openspec` / `speckit` / `all` |
| `-t, --target` | `copilot` (~/.copilot/skills) / `claude` (~/.claude/skills) |
| `-f, --force` | Overwrite existing target directory without prompt |
| `-h, --help` | Show help |


## SDD Step Overview
## Usage 3: Install AI Guided Wizards via ai-global

[ai-global](https://github.com/lazyjerry/ai-global) is a unified configuration manager for multiple AI tools (Copilot, Claude Code, Cursor, Windsurf, etc.). Use this method to install skills globally and sync them across all your AI tools.

### Prerequisites

Install ai-global first:

```bash
# Using curl (recommended)
curl -fsSL https://raw.githubusercontent.com/lazyjerry/ai-global/main/install.sh | bash

# Or using npm
npm install -g ai-global
```

### Installation

```bash
# Add SDD OpenSpec wizard
ai-global add-skill lazyjerry/SDD-Kits/skills/sdd-openspec

# Add SDD Spec Kit wizard
ai-global add-skill lazyjerry/SDD-Kits/skills/sdd-speckit

# Or install both at once by cloning the repo
git clone https://github.com/lazyjerry/SDD-Kits.git
ai-global add-skill ./SDD-Kits/skills/sdd-openspec
ai-global add-skill ./SDD-Kits/skills/sdd-speckit
```

### Verify Installation

```bash
# List all installed skills
ai-global list-skills

# Check status
ai-global status
```

After installation, the skills will be available in all configured AI tools (Copilot, Claude Code, Cursor, etc.). Mention OpenSpec or Spec Kit in a conversation and the wizard will auto-launch.

---

## SDD Step Overview

### OpenSpec Workflow

> Core flow: `proposal` → `apply` → `archive`

| Step | File | Description |
|------|------|-------------|
| 00 | `00.setup.md` | Install CLI and run `openspec init` |
| 01 | `01.project-setup.md` | Fill in `openspec/project.md` project info |
| 02 | `02.proposal.md` | Create a change proposal (proposal + tasks + specs) |
| 03 | `03.spec-format.md` | Check spec format (SHALL/MUST, Scenario, Delta) |
| 04 | `04.validate.md` | Run `openspec validate` to verify format |
| 05 | `05.apply.md` | AI implements tasks from tasks.md one by one |
| 06 | `06.archive.md` | Archive; merge spec deltas back into specs/ |
| — | `advanced.md` | Advanced: design.md and multi-spec changes |
| — | `commands.md` | CLI & Slash Command cheat sheet |
| — | `prompt.md` | Common prompt templates |

### Spec Kit Workflow

> Core flow: `constitution` → `specify` → `plan` → `tasks` → `implement`

| Step | File | Description |
|------|------|-------------|
| 00 | `00.setup.md` | Install CLI and run `specify init --integration <agent>` |
| 01 | `01.constitution.md` | Define governance principles (tech stack, conventions, constraints) |
| 02 | `02.specify.md` | Describe feature specs |
| 03 | `03.clarify.md` | Clarify ambiguities (optional) |
| 04 | `04.plan.md` | Create technical plan |
| 05 | `05.tasks.md` | Break down task list |
| 06 | `06.analyze.md` | Analyze specs and plan (optional) |
| 07 | `07.implement.md` | Implement step by step |
| — | `prompt.md` | Common prompt templates |

---

## Project Structure

```text
SDD-Kits/
├── files/                    # Step template sources
│   ├── open-spec-steps/
│   └── spec-kit-steps/
├── skills/                   # AI guided wizards
│   ├── sdd-openspec/
│   │   ├── SKILL.md
│   │   └── references/steps.md
│   └── sdd-speckit/
│       ├── SKILL.md
│       └── references/steps.md
├── scripts/
│   ├── init.sh               # Install step templates
│   └── init-skill.sh         # Install guided wizards
└── sdd-steps/                # Step template copies (for this repo's reference)
    └── open-spec-steps/
```

## FAQ

- **"OpenSpec or Spec Kit CLI tool not detected"**
  - Neither `openspec` nor `specify` is in your PATH. Install at least one first.

- **"Directory does not exist"**
  - Verify the target project path is correct.

- **"Invalid selection"**
  - Enter a valid number from the interactive menu.
