## Step 6：歸檔（Archive）

### 目的

所有任務完成、測試通過後執行歸檔。變更目錄移至 `archive/` 並加上日期前綴，規格差異合併回 `specs/`。

### 執行指令（新版）

```
/opsx:archive
```

如需指定變更名稱：

```
/opsx:archive <change-name>
```

### 預期結果

```
openspec/changes/archive/2025-01-23-add-user-search/  # 舊提案移到這裡
openspec/specs/                                         # 規格差異已合併回主目錄
```

### 引導提示

```
歸檔前請確認：
1. tasks.md 中所有項目是否都已打勾？
2. 測試是否全部通過？
3. 是否確定要歸檔此變更？

確認後將執行歸檔。
```
