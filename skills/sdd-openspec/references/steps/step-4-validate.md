## Step 4：驗證提案（Validate）

### 目的

使用 CLI 驗證提案格式，確保規格可以正確歸檔。

### 執行指令

```bash
openspec validate <change-name> --strict
```

- `<change-name>` 為 Step 2 建立提案時的名稱（如 `add-user-search`）

### 失敗時的除錯指令

```bash
openspec show <change-name> --json --deltas-only
```

### 引導提示

```
請輸入變更名稱（即 openspec/changes/ 下的資料夾名稱）：
```

### 注意事項

- 驗證失敗最常見的原因：缺少 Scenario、缺少 SHALL/MUST、Delta 標記格式錯誤
- 建議在 Step 3 先手動檢查過後再執行驗證
