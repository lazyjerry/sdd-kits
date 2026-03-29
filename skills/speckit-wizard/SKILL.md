---
name: speckit-wizard
description: >-
  Spec Kit SDD 操作指引精靈。當使用者意圖使用 Spec Kit、提及 SDD 開發並選擇 Spec Kit、
  或要求以規格驅動開發方式定義功能規格時觸發。
  以選單方式呈現所有步驟，引導使用者完成從初始化到實作的完整流程，
  並將每步操作記錄保存為 log 檔案。
---

# Spec Kit 操作指引精靈

引導使用者完成 Spec Kit SDD 工作流程：從安裝、治理原則到功能規格、計畫、實作。

## 啟動流程

### 1. 環境檢查

執行以下終端指令確認 Spec Kit 是否已安裝：

```bash
specify --version
```

- **已安裝** → 顯示版本號，進入步驟選單
- **未安裝** → 顯示安裝指引後停止：

```
⚠️ 尚未偵測到 Spec Kit CLI（specify）。請先安裝：

  1. 安裝 uv（如尚未安裝）：
     curl -LsSf https://astral.sh/uv/install.sh | sh

  2. 安裝 Spec Kit：
     uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

需要 Python 3.11 以上版本與 Git。
安裝完成後請重新啟動此精靈。
```

### 2. 詢問工作目錄

確認使用者的目標專案目錄：

```
請問要在哪個專案目錄執行 Spec Kit？
（輸入路徑，或按 Enter 使用目前工作區）
```

### 3. 顯示步驟選單

```
══════════════════════════════════════
  Spec Kit 操作指引精靈
══════════════════════════════════════

請選擇要執行的步驟：

  [0] 初始化專案        — specify init
  [1] 建立治理原則      — /speckit.constitution
  [2] 描述功能規格      — /speckit.specify
  [3] 釐清模糊地帶      — /speckit.clarify        (選用)
  [4] 製作技術計畫      — /speckit.plan
  [5] 拆解任務清單      — /speckit.tasks
  [6] 分析規格與計畫    — /speckit.analyze         (選用)
  [7] 逐步實作          — /speckit.implement
  ─────────────────────
  [C] 常用指令速查
  [Q] 結束精靈

輸入編號繼續：
```

### 4. 執行步驟

讀取 `<SKILL_DIR>/references/steps.md` 取得選定步驟的完整指引，依照該步驟：

1. **顯示步驟說明**：該步驟的目的與注意事項
2. **提供提示詞模板**：可直接使用的 slash command 或提示
3. **引導使用者輸入**：收集必要資訊（如技術棧、功能描述等）
4. **協助執行**：根據步驟類型，執行 CLI 指令或提供 AI 提示詞
5. **記錄到 log**：將使用者輸入與執行結果寫入 log 檔案

### 5. 步驟完成後

- 更新 log 檔案
- 顯示下一步建議
- 回到步驟選單

## Log 機制

### Log 檔案位置與命名

```
<專案根目錄>/sdd-logs/speckit-<YYYY-MM-DD>-<功能名稱>.md
```

- 首次啟動時建立 `sdd-logs/` 目錄（如不存在）
- 功能名稱在 Step 2 描述規格時確定；Step 0～1 使用 `init` 作為暫時名稱
- 同一功能的所有步驟記錄在同一檔案中

### Log 檔案初始化模板

首次建立時寫入：

```markdown
# Spec Kit Log: <功能名稱>

- **工具**：Spec Kit
- **日期**：<YYYY-MM-DD>
- **專案**：<專案路徑>

---
```

### 每步驟追加格式

每完成一個步驟，append 以下區塊：

```markdown
## Step <N>: <步驟名稱>

**時間**：<HH:MM>

### 使用者輸入

<使用者提供的原始輸入或選項>

### 執行內容

<實際執行的指令或提示詞>

### 執行結果

<AI 輸出摘要或 CLI 輸出>

### 狀態

✅ 完成

---
```

## 關鍵規則

| # | 規則 | 說明 |
|---|------|------|
| 1 | 先讀再做 | 每次執行步驟前，先讀取 `references/steps.md` 對應段落 |
| 2 | 忠實記錄 | 使用者的每次輸入都必須記錄到 log |
| 3 | 不跳步驟 | 選單讓使用者自由選擇，但提醒建議順序 |
| 4 | what 優先 | Step 2 專注描述「做什麼」與「為什麼」，不提技術細節 |
| 5 | 範圍控制 | 實作階段提醒使用者「請專注在 tasks.md 列出的項目」 |
| 6 | 選用步驟 | Step 3（clarify）與 Step 6（analyze）為選用，但建議執行 |
| 7 | 錯誤處理 | CLI 指令失敗時，建議執行 `specify check` 檢查環境 |
