#!/usr/bin/env bash
set -euo pipefail

# ── 取得 SDD-Kits 根目錄（scripts/ 的上層） ──
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

SKILLS_DIR="$ROOT_DIR/skills"

# ── 顏色定義 ──
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ── 輔助函式 ──
info()  { echo -e "${CYAN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
err()   { echo -e "${RED}[ERROR]${NC} $1"; }

usage() {
  cat <<'EOF'
用法：
  bash scripts/init-skill.sh
  bash scripts/init-skill.sh --skill <openspec|speckit|all> --target <copilot|claude>

參數：
  -s, --skill      指定要安裝的 skill：openspec / speckit / all
  -t, --target     指定安裝目標：copilot（~/.copilot/skills）/ claude（~/.claude/skills）
  -h, --help       顯示此說明

說明：
  - 未提供參數時，採互動模式
  - 提供 --skill 與 --target 時，採非互動模式
EOF
}

selected=""
target=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -s|--skill)
      selected="${2:-}"
      shift 2
      ;;
    -t|--target)
      target="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      err "未知參數：$1"
      echo ""
      usage
      exit 1
      ;;
  esac
done

# ── 檢查 skills 來源目錄 ──
if [[ ! -d "$SKILLS_DIR" ]]; then
  err "找不到 skills 來源目錄：$SKILLS_DIR"
  exit 1
fi

has_openspec_skill=false
has_speckit_skill=false

if [[ -f "$SKILLS_DIR/openspec-wizard/SKILL.md" ]]; then
  has_openspec_skill=true
fi

if [[ -f "$SKILLS_DIR/speckit-wizard/SKILL.md" ]]; then
  has_speckit_skill=true
fi

if ! $has_openspec_skill && ! $has_speckit_skill; then
  err "找不到任何 skill 檔案，請確認 skills/ 目錄結構完整。"
  exit 1
fi

# ── Step 1：選擇要安裝的 Skill ──
echo ""
info "可安裝的 SDD 操作指引精靈："

options=()

if $has_openspec_skill; then
  options+=("openspec")
  echo "  [${#options[@]}] OpenSpec Wizard"
fi

if $has_speckit_skill; then
  options+=("speckit")
  echo "  [${#options[@]}] Spec Kit Wizard"
fi

if $has_openspec_skill && $has_speckit_skill; then
  options+=("all")
  echo "  [${#options[@]}] 全部安裝"
fi

if [[ -z "$selected" ]]; then
  echo ""
  read -rp "請選擇要安裝的 skill（輸入編號）: " choice

  if [[ -z "$choice" ]] || ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#options[@]} )); then
    err "無效的選擇，結束。"
    exit 1
  fi

  selected="${options[$((choice - 1))]}"
else
  case "$selected" in
    openspec|speckit|all)
      ;;
    *)
      err "--skill 僅接受 openspec、speckit、all"
      exit 1
      ;;
  esac

  if [[ "$selected" == "openspec" ]] && ! $has_openspec_skill; then
    err "找不到 openspec-wizard skill"
    exit 1
  fi

  if [[ "$selected" == "speckit" ]] && ! $has_speckit_skill; then
    err "找不到 speckit-wizard skill"
    exit 1
  fi

  if [[ "$selected" == "all" ]] && { ! $has_openspec_skill || ! $has_speckit_skill; }; then
    err "--skill all 需要兩個 skill 都存在"
    exit 1
  fi

  ok "已使用非互動模式：--skill $selected"
fi

# ── Step 2：選擇安裝目標 ──
COPILOT_SKILLS="$HOME/.copilot/skills"
CLAUDE_SKILLS="$HOME/.claude/skills"

if [[ -z "$target" ]]; then
  echo ""
  info "請選擇安裝目標："
  echo "  [1] VS Code Copilot （$COPILOT_SKILLS）"
  echo "  [2] Claude Code     （$CLAUDE_SKILLS）"
  echo ""
  read -rp "請選擇（輸入編號）: " target_choice

  case "$target_choice" in
    1) target="copilot" ;;
    2) target="claude" ;;
    *)
      err "無效的選擇，結束。"
      exit 1
      ;;
  esac
else
  case "$target" in
    copilot|claude)
      ;;
    *)
      err "--target 僅接受 copilot、claude"
      exit 1
      ;;
  esac

  ok "已使用非互動模式：--target $target"
fi

if [[ "$target" == "copilot" ]]; then
  dest_dir="$COPILOT_SKILLS"
else
  dest_dir="$CLAUDE_SKILLS"
fi

# ── Step 3：複製 Skill ──
install_skill() {
  local skill_name="$1"
  local src="$SKILLS_DIR/$skill_name"
  local dest="$dest_dir/$skill_name"

  if [[ ! -d "$src" ]]; then
    err "來源目錄不存在：$src"
    return 1
  fi

  if [[ -d "$dest" ]]; then
    warn "目標已存在：$dest"
    read -rp "是否覆蓋？(y/N) " overwrite
    if [[ "$overwrite" != "y" && "$overwrite" != "Y" ]]; then
      info "跳過 $skill_name"
      return 0
    fi
    rm -rf "$dest"
  fi

  mkdir -p "$dest_dir"
  cp -r "$src" "$dest"

  local file_count
  file_count=$(find "$dest" -type f | wc -l | tr -d ' ')
  ok "$skill_name：已複製 $file_count 個檔案到 $dest"
}

echo ""

if [[ "$selected" == "openspec" ]] || [[ "$selected" == "all" ]]; then
  install_skill "openspec-wizard"
fi

if [[ "$selected" == "speckit" ]] || [[ "$selected" == "all" ]]; then
  install_skill "speckit-wizard"
fi

# ── Step 4：印出使用說明 ──
echo ""
echo "════════════════════════════════════════"
info "安裝完成"
echo "════════════════════════════════════════"
echo ""

if [[ "$target" == "copilot" ]]; then
  info "Skill 已安裝到 $COPILOT_SKILLS"
  echo ""
  echo "  使用方式："
  echo "    在 VS Code Copilot Chat 中提及 OpenSpec 或 Spec Kit，"
  echo "    精靈會自動啟動並引導你完成 SDD 流程。"
else
  info "Skill 已安裝到 $CLAUDE_SKILLS"
  echo ""
  echo "  使用方式："
  echo "    在 Claude Code 中提及 OpenSpec 或 Spec Kit，"
  echo "    精靈會自動啟動並引導你完成 SDD 流程。"
fi

echo ""
ok "完成！"
