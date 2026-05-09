## Step 3：檢查規格格式

### 目的

確認提案中的 `specs/spec.md` 格式正確，避免驗證失敗和歸檔時合併出錯。

### 提示詞模板

```
請檢查這次提案的 specs 格式是否符合 OpenSpec 規範，有錯請修正
```

### 手動檢查清單

#### 檢查 1：每個 Requirement 是否有 Scenario

每個 `### Requirement:` 底下至少要有一個 `#### Scenario:`：

```markdown
### Requirement: User Login
使用者 SHALL 能夠使用 Email 和密碼登入系統。

#### Scenario: 登入成功
- WHEN 使用者輸入正確的 Email 和密碼
- THEN 系統回傳 JWT token
```

#### 檢查 2：需求描述是否包含 SHALL 或 MUST

每條需求的描述句中**必須**出現 `SHALL` 或 `MUST`，這是驗證的必要條件。

#### 檢查 3：Delta 標記是否正確

提案中的 spec.md 使用差異格式（Delta）：

| 標題 | 用途 | 注意事項 |
|------|------|----------|
| `## ADDED Requirements` | 新增需求 | 寫完整的新需求 |
| `## MODIFIED Requirements` | 修改既有需求 | **必須貼修改後的完整內容**，不只寫差異 |
| `## REMOVED Requirements` | 移除需求 | 附上 Reason 和 Migration |

### 引導提示

```
要我自動檢查規格格式，還是你想手動對照清單檢查？
  [A] 自動檢查（AI 讀取 spec.md 後回報）
  [M] 手動檢查（顯示檢查清單）
```
