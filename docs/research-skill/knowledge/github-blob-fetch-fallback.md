# GitHub blob 擷取失敗改用 repo 搜尋

## 觸發時機
當 `fetch_webpage` 對 GitHub `blob` 頁面回傳「Failed to extract meaningful content」或內容不足時。

## 摘要
先嘗試 `fetch_webpage`，若失敗立即切換 `github_repo` 以關鍵字定位 templates/scripts 片段。

## 知識內容
- 優先流程：
  1. 先用 `fetch_webpage` 抓 README 或 docs 主頁。
  2. 若特定 `blob` 頁面抽取失敗，改用 `github_repo` 以檔名 + 關鍵字搜尋。
  3. 優先抓 `templates/`、`scripts/`、`README.md` 與核心 docs。
- 對研究型任務的價值：
  - 可以避免因單頁抽取失敗而中斷。
  - 能直接取得可引用的檔案路徑與片段。
- 本次任務案例：
  - `https://github.com/github/spec-kit/blob/main/docs/templates.md` 抽取失敗。
  - 改用 `github_repo` 成功補齊 `templates/spec-template.md`、`templates/plan-template.md`、`scripts/*` 等資訊。

### 範例
```text
先 fetch_webpage(README / commands)
失敗後 github_repo(repo, query="templates plan-template tasks-template scripts")
再整理為報告結論
```
