[English](README.md) | [简体中文](README_CN.md) | [繁體中文](README_TW.md) | 日本語 | [한국어](README_KR.md)

# SDD-Kits

2種類の SDD（Spec-Driven Development、仕様駆動開発）ステップテンプレートと AI 操作ガイドウィザードを提供します。インストールスクリプトでプロジェクトへの迅速なデプロイが可能です。

## 内容

| 項目 | 説明 |
|------|------|
| `files/open-spec-steps/` | OpenSpec ステップテンプレート（ソース） |
| `files/spec-kit-steps/` | Spec Kit ステップテンプレート（ソース） |
| `skills/openspec-wizard/` | OpenSpec 操作ガイドウィザード（Copilot / Claude Skill） |
| `skills/speckit-wizard/` | Spec Kit 操作ガイドウィザード（Copilot / Claude Skill） |
| `scripts/init.sh` | ステップテンプレートをターゲットプロジェクトにコピー |
| `scripts/init-skill.sh` | 操作ガイドウィザードを Copilot または Claude にインストール |

---

## 前提条件

少なくとも1つの SDD ツールをインストールしてください：

### OpenSpec

```bash
npm install -g @fission-ai/openspec@latest
```

### Spec Kit（uv が必要です）

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

---

## 使い方1：ステップテンプレートのインストール（init.sh）

SDD ステップの Markdown ファイルをターゲットプロジェクトの `sdd-steps/` ディレクトリにコピーします。開発時の参考として利用できます。

### 対話モード

```bash
bash scripts/init.sh
```

プロンプトに従ってツールタイプを選択し、プロジェクトパスを入力してください。

### 非対話モード

```bash
# OpenSpec ステップのみ
bash scripts/init.sh --tool openspec --project ~/work/my-app

# Spec Kit ステップのみ
bash scripts/init.sh --tool speckit --project ~/work/my-app

# 両方インストール
bash scripts/init.sh --tool all --project ~/work/my-app
```

| パラメータ | 説明 |
|------------|------|
| `-t, --tool` | `openspec` / `speckit` / `all` |
| `-p, --project` | ターゲットプロジェクトパス（`~` 対応） |
| `-h, --help` | ヘルプを表示 |

### 出力ディレクトリ

```text
<プロジェクト>/
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

## 使い方2：AI 操作ガイドウィザードのインストール（init-skill.sh）

SDD 操作ガイドウィザードを VS Code Copilot または Claude Code の skills ディレクトリにインストールします。インストール後、会話で OpenSpec または Spec Kit に言及すると、ウィザードが自動的に起動し、メニュー形式で完全なフローを案内します。

### 対話モード

```bash
bash scripts/init-skill.sh
```

プロンプトに従ってインストールするウィザードとターゲットプラットフォームを選択してください。

### 非対話モード

```bash
# OpenSpec ウィザードを Copilot にインストール
bash scripts/init-skill.sh --skill openspec --target copilot

# Spec Kit ウィザードを Claude Code にインストール
bash scripts/init-skill.sh --skill speckit --target claude

# すべてを Copilot にインストール
bash scripts/init-skill.sh --skill all --target copilot
```

| パラメータ | 説明 |
|------------|------|
| `-s, --skill` | `openspec` / `speckit` / `all` |
| `-t, --target` | `copilot`（~/.copilot/skills）/ `claude`（~/.claude/skills） |
| `-h, --help` | ヘルプを表示 |

---

## SDD ステップ概要

### OpenSpec フロー

> コアフロー：`proposal` → `apply` → `archive`

| ステップ | ファイル | 説明 |
|----------|----------|------|
| 00 | `00.setup.md` | CLI をインストールし `openspec init` を実行 |
| 01 | `01.project-setup.md` | `openspec/project.md` にプロジェクト情報を記入 |
| 02 | `02.proposal.md` | 変更提案を作成（proposal + tasks + specs） |
| 03 | `03.spec-format.md` | 仕様フォーマットを確認（SHALL/MUST、Scenario、Delta） |
| 04 | `04.validate.md` | `openspec validate` でフォーマットを検証 |
| 05 | `05.apply.md` | AI が tasks.md に従って順次実装 |
| 06 | `06.archive.md` | アーカイブし、仕様の差分を specs/ にマージ |
| — | `advanced.md` | 応用：design.md と複数 Specs の変更 |
| — | `commands.md` | CLI と Slash Command 早見表 |
| — | `prompt.md` | よく使うプロンプトテンプレート |

### Spec Kit フロー

> コアフロー：`constitution` → `specify` → `plan` → `tasks` → `implement`

| ステップ | ファイル | 説明 |
|----------|----------|------|
| 00 | `00.setup.md` | CLI をインストールし `specify init` を実行 |
| 01 | `01.constitution.md` | ガバナンス原則を定義（技術スタック、慣例、制約） |
| 02 | `02.specify.md` | 機能仕様を記述 |
| 03 | `03.clarify.md` | 曖昧な部分を明確化（任意） |
| 04 | `04.plan.md` | 技術計画を作成 |
| 05 | `05.tasks.md` | タスクリストを分解 |
| 06 | `06.analyze.md` | 仕様と計画を分析（任意） |
| 07 | `07.implement.md` | 段階的に実装 |
| — | `prompt.md` | よく使うプロンプトテンプレート |

---

## プロジェクト構造

```text
SDD-Kits/
├── files/                    # ステップテンプレートソース
│   ├── open-spec-steps/
│   └── spec-kit-steps/
├── skills/                   # AI 操作ガイドウィザード
│   ├── openspec-wizard/
│   │   ├── SKILL.md
│   │   └── references/steps.md
│   └── speckit-wizard/
│       ├── SKILL.md
│       └── references/steps.md
├── scripts/
│   ├── init.sh               # ステップテンプレートのインストール
│   └── init-skill.sh         # 操作ガイドウィザードのインストール
└── sdd-steps/                # ステップテンプレートのコピー（本リポジトリ参照用）
    └── open-spec-steps/
```

## よくある質問

- **「OpenSpec または Spec Kit CLI ツールが検出されません」と表示される**
  - `openspec` と `specify` のいずれも PATH に存在しません。少なくとも1つをインストールしてください。

- **「ディレクトリが存在しません」と表示される**
  - ターゲットプロジェクトのパスが正しいことを確認してください。

- **「無効な選択です」と表示される**
  - 対話メニューに表示された番号を入力してください。
