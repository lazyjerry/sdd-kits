#!/usr/bin/env bash
set -euo pipefail

# ── 取得 SDD-Kits 根目錄（scripts/ 的上層） ──
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

OPENSPEC_DIR="$ROOT_DIR/files/Open-spec-steps"
SPECKIT_DIR="$ROOT_DIR/files/Spec-kit-steps"

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
  bash scripts/init.sh
  bash scripts/init.sh --tool <openspec|speckit|all> --project <目標專案路徑>

參數：
  -t, --tool       指定要安裝的步驟類型：openspec / speckit / all
  -p, --project    指定目標專案路徑（支援 ~）
  -h, --help       顯示此說明

說明：
  - 未提供參數時，採互動模式
  - 提供 --tool 與 --project 時，採非互動模式
EOF
}

selected=""
project_dir=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -t|--tool)
      selected="${2:-}"
      shift 2
      ;;
    -p|--project)
      project_dir="${2:-}"
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

# ── Step 1：偵測已安裝的套件 ──
has_openspec=false
has_speckit=false

if command -v openspec &>/dev/null; then
  has_openspec=true
fi

if command -v specify &>/dev/null; then
  has_speckit=true
fi

if ! $has_openspec && ! $has_speckit; then
  warn "未偵測到 OpenSpec 或 Spec Kit CLI 工具。"
  echo ""
  echo "  OpenSpec 安裝方式："
  echo "    npm install -g @fission-ai/openspec@latest"
  echo ""
  echo "  Spec Kit 安裝方式（需先安裝 uv）："
  echo "    uv tool install specify-cli --from git+https://github.com/github/spec-kit.git"
  echo ""
  exit 1
fi

# ── Step 2：列出可用選項讓使用者選擇 ──
echo ""
info "偵測到以下 SDD 工具："

options=()

if $has_openspec; then
  options+=("openspec")
  echo "  [${#options[@]}] OpenSpec"
fi

if $has_speckit; then
  options+=("speckit")
  echo "  [${#options[@]}] Spec Kit"
fi

if $has_openspec && $has_speckit; then
  options+=("all")
  echo "  [${#options[@]}] 全部安裝"
fi

if [[ -z "$selected" ]]; then
  echo ""
  read -rp "請選擇要安裝的輔助步驟檔案（輸入編號）: " choice

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
      err "--tool 僅接受 openspec、speckit、all"
      exit 1
      ;;
  esac

  if [[ "$selected" == "openspec" ]] && ! $has_openspec; then
    err "目前環境未偵測到 openspec，無法使用 --tool openspec"
    exit 1
  fi

  if [[ "$selected" == "speckit" ]] && ! $has_speckit; then
    err "目前環境未偵測到 specify，無法使用 --tool speckit"
    exit 1
  fi

  if [[ "$selected" == "all" ]] && { ! $has_openspec || ! $has_speckit; }; then
    err "--tool all 需要同時偵測到 openspec 與 specify"
    exit 1
  fi

  ok "已使用非互動模式：--tool $selected"
fi

# ── Step 3：輸入專案目錄路徑 ──
if [[ -z "$project_dir" ]]; then
  echo ""
  read -rp "請輸入專案目錄路徑: " project_dir
else
  ok "已使用非互動模式：--project $project_dir"
fi

# 展開 ~ 為 $HOME
project_dir="${project_dir/#\~/$HOME}"

if [[ ! -d "$project_dir" ]]; then
  err "目錄不存在：$project_dir"
  exit 1
fi

ok "目錄確認：$project_dir"

# ── Step 4：複製步驟檔案 ──
copy_steps() {
  local src_dir="$1"
  local label="$2"
  local dest="$project_dir/sdd-steps/$label"

  mkdir -p "$dest"

  # 複製 01 開始的步驟檔案
  local count=0
  for f in "$src_dir"/0[1-9]*.md "$src_dir"/[1-9]*.md; do
    [[ -f "$f" ]] || continue
    cp "$f" "$dest/"
    count=$((count + 1))
  done

  # 複製 prompt.md
  if [[ -f "$src_dir/prompt.md" ]]; then
    cp "$src_dir/prompt.md" "$dest/"
    count=$((count + 1))
  fi

  ok "${label}：已複製 $count 個檔案到 $dest"
}

echo ""

if [[ "$selected" == "openspec" ]] || [[ "$selected" == "all" ]]; then
  copy_steps "$OPENSPEC_DIR" "open-spec-steps"
fi

if [[ "$selected" == "speckit" ]] || [[ "$selected" == "all" ]]; then
  copy_steps "$SPECKIT_DIR" "spec-kit-steps"
fi

# ── Step 5：印出使用說明 ──
echo ""
echo "════════════════════════════════════════"
info "快速用法參考"
echo "════════════════════════════════════════"

if [[ "$selected" == "openspec" ]] || [[ "$selected" == "all" ]]; then
  echo ""
  cat "$OPENSPEC_DIR/prompt.md"
fi

if [[ "$selected" == "speckit" ]] || [[ "$selected" == "all" ]]; then
  echo ""
  cat "$SPECKIT_DIR/prompt.md"
fi

echo ""
ok "完成！步驟檔案已複製到 $project_dir/sdd-steps/"
