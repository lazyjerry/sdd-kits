# 常用指令速查

> CLI 指令與 Slash Command 總覽。
> 完整流程：`proposal` → `validate` → `apply` → `archive`。

| 指令 | 說明 |
|------|------|
| `openspec init` | 初始化專案 |
| `openspec list` | 列出進行中的變更（`--specs` 列規格） |
| `openspec show [name]` | 顯示詳細內容（`--json` 取 JSON） |
| `openspec validate [name] --strict` | 驗證格式 |
| `openspec archive [name]` | 歸檔（`--yes` 跳過確認） |
| `openspec view` | 開啟互動式 dashboard |
| `/openspec:proposal [描述]` | 建立提案 |
| `/openspec:apply [name]` | 開始實作 |
| `/openspec:archive [name]` | 歸檔 |
