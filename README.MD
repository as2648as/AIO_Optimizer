# ZiLin 的超懶人系統自動優化腳本 (ﾟ ∀。)

個人使用的 Windows 11 優化腳本，搭配 [CrapFixer](https://github.com/builtbybel/CrapFixer) 服用可達最佳效果。
不保障系統更新後可能產生的問題，使用前請自行風險評估。

## 執行方式

### 停用安全性警告

如果執行出現 `安全性警告` 或是 `閃退`，請使用 `系統管理員` 執行 `Powershell` 並輸入

```powershell
Set-ExecutionPolicy Unrestricted
```

請注意使用此操作對未來可能有風險，應在腳本執行結束後還原執行原則等級：

```powershell
Set-ExecutionPolicy Default
```

## 備註

編輯 `ps1` 檔案時，務必將檔案編碼儲存為 `UTF-8 with BOM`，否則會導致非英文字元顯示亂碼。

`VScode` 新建 `ps1` 檔案時，務必在 [".vscode/settings.json"](.vscode/settings.json) 中加入以下設定，
將 `ps1` 的預設編碼轉為 `UTF-8 with BOM`，否則會導致中文等字元亂碼。

```json
"[powershell]": {
    "files.encoding": "utf8bom",
    "files.autoGuessEncoding": true
}
```
