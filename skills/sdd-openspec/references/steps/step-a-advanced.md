## 進階：design.md 與多 Specs 變更

### 適用場景

- 跨模組變更
- 引入新的外部依賴
- 有安全性或效能考量

### design.md

在提案資料夾中加入 `design.md` 記錄技術決策（選用）：

```
openspec/changes/add-2fa/
├── proposal.md
├── design.md          # 選用
├── tasks.md
└── specs/
    ├── auth/spec.md
    └── notifications/spec.md
```

### 多 Specs 變更

一次變更影響多個功能時，在 `specs/` 下建立多個子目錄，歸檔時各自合併。
