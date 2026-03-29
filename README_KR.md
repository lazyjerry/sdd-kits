[English](README.md) | [简体中文](README_CN.md) | [繁體中文](README_TW.md) | [日本語](README_JP.md) | 한국어

# SDD-Kits

2종의 SDD(Spec-Driven Development, 사양 주도 개발) 단계 템플릿과 AI 운영 가이드 위저드를 제공합니다. 설치 스크립트를 통해 프로젝트에 빠르게 배포할 수 있습니다.

## 포함 내용

| 항목 | 설명 |
|------|------|
| `files/open-spec-steps/` | OpenSpec 단계 템플릿 (소스) |
| `files/spec-kit-steps/` | Spec Kit 단계 템플릿 (소스) |
| `skills/openspec-wizard/` | OpenSpec 운영 가이드 위저드 (Copilot / Claude Skill) |
| `skills/speckit-wizard/` | Spec Kit 운영 가이드 위저드 (Copilot / Claude Skill) |
| `scripts/init.sh` | 단계 템플릿을 대상 프로젝트에 복사 |
| `scripts/init-skill.sh` | 운영 가이드 위저드를 Copilot 또는 Claude에 설치 |

---

## 사전 요구 사항

최소 하나의 SDD 도구를 설치하세요:

### OpenSpec

```bash
npm install -g @fission-ai/openspec@latest
```

### Spec Kit (uv 필요)

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

---

## 사용법 1: 단계 템플릿 설치 (init.sh)

SDD 단계 Markdown 파일을 대상 프로젝트의 `sdd-steps/` 디렉토리에 복사합니다. 개발 시 참고 자료로 활용할 수 있습니다.

### 대화형 모드

```bash
bash scripts/init.sh
```

안내에 따라 도구 유형을 선택하고 프로젝트 경로를 입력하세요.

### 비대화형 모드

```bash
# OpenSpec 단계만 설치
bash scripts/init.sh --tool openspec --project ~/work/my-app

# Spec Kit 단계만 설치
bash scripts/init.sh --tool speckit --project ~/work/my-app

# 모두 설치
bash scripts/init.sh --tool all --project ~/work/my-app
```

| 매개변수 | 설명 |
|----------|------|
| `-t, --tool` | `openspec` / `speckit` / `all` |
| `-p, --project` | 대상 프로젝트 경로 (`~` 지원) |
| `-h, --help` | 도움말 표시 |

### 출력 디렉토리

```text
<프로젝트>/
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

## 사용법 2: AI 운영 가이드 위저드 설치 (init-skill.sh)

SDD 운영 가이드 위저드를 VS Code Copilot 또는 Claude Code의 skills 디렉토리에 설치합니다. 설치 후 대화에서 OpenSpec 또는 Spec Kit을 언급하면 위저드가 자동으로 시작되어 메뉴 형식으로 전체 흐름을 안내합니다.

### 대화형 모드

```bash
bash scripts/init-skill.sh
```

안내에 따라 설치할 위저드와 대상 플랫폼을 선택하세요.

### 비대화형 모드

```bash
# OpenSpec 위저드를 Copilot에 설치
bash scripts/init-skill.sh --skill openspec --target copilot

# Spec Kit 위저드를 Claude Code에 설치
bash scripts/init-skill.sh --skill speckit --target claude

# 모두 Copilot에 설치
bash scripts/init-skill.sh --skill all --target copilot
```

| 매개변수 | 설명 |
|----------|------|
| `-s, --skill` | `openspec` / `speckit` / `all` |
| `-t, --target` | `copilot` (~/.copilot/skills) / `claude` (~/.claude/skills) |
| `-h, --help` | 도움말 표시 |

---

## SDD 단계 개요

### OpenSpec 흐름

> 핵심 흐름: `proposal` → `apply` → `archive`

| 단계 | 파일 | 설명 |
|------|------|------|
| 00 | `00.setup.md` | CLI 설치 및 `openspec init` 실행 |
| 01 | `01.project-setup.md` | `openspec/project.md`에 프로젝트 정보 작성 |
| 02 | `02.proposal.md` | 변경 제안 생성 (proposal + tasks + specs) |
| 03 | `03.spec-format.md` | 사양 형식 확인 (SHALL/MUST, Scenario, Delta) |
| 04 | `04.validate.md` | `openspec validate`로 형식 검증 |
| 05 | `05.apply.md` | AI가 tasks.md에 따라 순차 구현 |
| 06 | `06.archive.md` | 아카이브 후 사양 차이를 specs/에 병합 |
| — | `advanced.md` | 고급: design.md 및 다중 Specs 변경 |
| — | `commands.md` | CLI 및 Slash Command 빠른 참조표 |
| — | `prompt.md` | 자주 쓰는 프롬프트 템플릿 |

### Spec Kit 흐름

> 핵심 흐름: `constitution` → `specify` → `plan` → `tasks` → `implement`

| 단계 | 파일 | 설명 |
|------|------|------|
| 00 | `00.setup.md` | CLI 설치 및 `specify init` 실행 |
| 01 | `01.constitution.md` | 거버넌스 원칙 정의 (기술 스택, 관례, 제약) |
| 02 | `02.specify.md` | 기능 사양 기술 |
| 03 | `03.clarify.md` | 모호한 부분 명확화 (선택) |
| 04 | `04.plan.md` | 기술 계획 수립 |
| 05 | `05.tasks.md` | 작업 목록 분해 |
| 06 | `06.analyze.md` | 사양 및 계획 분석 (선택) |
| 07 | `07.implement.md` | 단계별 구현 |
| — | `prompt.md` | 자주 쓰는 프롬프트 템플릿 |

---

## 프로젝트 구조

```text
SDD-Kits/
├── files/                    # 단계 템플릿 소스
│   ├── open-spec-steps/
│   └── spec-kit-steps/
├── skills/                   # AI 운영 가이드 위저드
│   ├── openspec-wizard/
│   │   ├── SKILL.md
│   │   └── references/steps.md
│   └── speckit-wizard/
│       ├── SKILL.md
│       └── references/steps.md
├── scripts/
│   ├── init.sh               # 단계 템플릿 설치
│   └── init-skill.sh         # 운영 가이드 위저드 설치
└── sdd-steps/                # 단계 템플릿 사본 (본 저장소 참조용)
    └── open-spec-steps/
```

## 자주 묻는 질문

- **"OpenSpec 또는 Spec Kit CLI 도구가 감지되지 않습니다"**
  - `openspec`과 `specify` 모두 PATH에 없습니다. 최소 하나를 먼저 설치하세요.

- **"디렉토리가 존재하지 않습니다"**
  - 대상 프로젝트 경로가 올바른지 확인하세요.

- **"잘못된 선택입니다"**
  - 대화형 메뉴에 표시된 번호를 입력하세요.
