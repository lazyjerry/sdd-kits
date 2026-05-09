## Step 1：建立治理原則（Constitution）

### 目的

定義專案的治理原則，包括決策流程、編碼風格、架構規範。`constitution.md` 作為後續所有技術決策的基礎依據。

### 執行指令

```
/speckit.constitution <治理原則描述>
```

### 提示詞模板

```
/speckit.constitution Create principles focused on code quality, testing
standards, user experience consistency, and performance requirements
```

範例（中文）：

```
/speckit.constitution 建立專案治理原則，包含：程式碼品質標準、測試覆蓋率要求、使用者體驗一致性、效能要求
```

### 引導提示

```
治理原則用來規範整個專案的開發方向，通常包括：
- 程式碼品質標準（命名規則、架構規範）
- 測試要求（單元測試、整合測試覆蓋率）
- 使用者體驗一致性（UI 規範、無障礙設計）
- 效能要求（回應時間、資源限制）

請描述你希望團隊遵守的開發原則：
```

### 注意事項

- 新專案必須先定義治理原則
- 治理原則會影響後續所有步驟的 AI 判斷
- 建議包含：品質標準、測試策略、安全性要求
