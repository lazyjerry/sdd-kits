# SDD-Kits

這個專案提供兩套 SDD（Spec-Driven Development）步驟範本，並透過 `scripts/init.sh` 快速複製到你的目標專案。

- OpenSpec 步驟來源：`files/Open-spec-steps/`
- Spec Kit 步驟來源：`files/Spec-kit-steps/`

## 主要用途

`init.sh` 會：
1. 偵測你電腦是否安裝 OpenSpec（`openspec`）與 Spec Kit（`specify`）CLI。
2. 讓你互動選擇要匯入哪一套步驟（OpenSpec / Spec Kit / 全部）。
3. 要求輸入目標專案路徑。
4. 將步驟檔複製到目標專案的 `sdd-steps/` 目錄。
5. 顯示對應的 `prompt.md` 內容作為快速參考。

## 先決條件

至少安裝其中一個工具：

### OpenSpec
```bash
npm install -g @fission-ai/openspec@latest
```

### Spec Kit（需先安裝 uv）
```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

## 使用方式（init.sh）

在本專案根目錄執行：

```bash
bash scripts/init.sh
```

或先給執行權限後直接執行：

```bash
chmod +x scripts/init.sh
./scripts/init.sh
```

接著依互動提示操作：
- 選擇要安裝的步驟類型（編號）
- 輸入目標專案路徑（支援 `~`）

## 非互動模式（適合 CI / 腳本）

`init.sh` 支援以下參數：

- `-t, --tool`：`openspec` / `speckit` / `all`
- `-p, --project`：目標專案路徑
- `-h, --help`：顯示說明

### 範例

只安裝 OpenSpec 步驟：

```bash
bash scripts/init.sh --tool openspec --project ~/work/my-app
```

只安裝 Spec Kit 步驟：

```bash
bash scripts/init.sh --tool speckit --project ~/work/my-app
```

同時安裝兩套步驟：

```bash
bash scripts/init.sh --tool all --project ~/work/my-app
```

查看說明：

```bash
bash scripts/init.sh --help
```

## 輸出目錄

執行成功後，檔案會被複製到目標專案：

```text
<你的專案>/
└── sdd-steps/
    ├── open-spec-steps/
    │   ├── 01....md
    │   ├── ...
    │   └── prompt.md
    └── spec-kit-steps/
        ├── 01....md
        ├── ...
        └── prompt.md
```

## 常見問題

- 顯示「未偵測到 OpenSpec 或 Spec Kit CLI 工具」
  - 代表 `openspec` 與 `specify` 都不在 PATH，請先安裝其一。

- 顯示「目錄不存在」
  - 請確認輸入的目標專案路徑正確。

- 顯示「無效的選擇」
  - 請輸入互動列表中的數字編號。
