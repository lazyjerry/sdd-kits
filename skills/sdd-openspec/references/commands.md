## 常用指令速查

### CLI 指令

| 指令 | 說明 |
|------|------|
| `openspec init` | 初始化專案 |
| `openspec list` | 列出進行中的變更（`--specs` 列規格） |
| `openspec show [name]` | 顯示詳細內容（`--json` 取 JSON） |
| `openspec validate [name] --strict` | 驗證格式 |
| `openspec archive [name]` | 歸檔（`--yes` 跳過確認） |
| `openspec view` | 開啟互動式 dashboard |
| `openspec config profile` | 選擇設定檔 |
| `openspec update` | 更新 AI 指令檔案 |

### Slash Commands（新版 /opsx:*）

| 指令 | 說明 |
|------|------|
| `/opsx:propose <描述>` | 建立提案 |
| `/opsx:apply` | 開始實作 |
| `/opsx:archive` | 歸檔 |
| `/opsx:new` | 建立新變更（擴充工作流） |
| `/opsx:continue` | 繼續未完成的實作 |
| `/opsx:ff` | 快速推進 |
| `/opsx:verify` | 驗證實作結果 |
| `/opsx:sync` | 同步規格 |
| `/opsx:bulk-archive` | 批次歸檔 |
| `/opsx:onboard` | 新手引導 |

> 擴充工作流指令需透過 `openspec config profile` 選擇對應 profile 並執行 `openspec update` 後才可使用。
