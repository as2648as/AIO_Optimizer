# ZiLin 的超懶人系統自動優化腳本 (ﾟ∀。)

個人使用的 Windows 11 優化腳本，搭配 [Optimizer](https://github.com/hellzerg/optimizer) 服用可達最佳效果。  
不保障系統更新後可能產生的問題，使用前請自行風險評估。

## 這個腳本可以做什麼事?

- [o] 套用已設定的群組管理原則
- [o] 新增鍵盤語言 (en-US)
- [o] 右鍵雜項移除
- [o] 自動安裝已放置的軟體
- [o] 設定主題為黑暗模式
- [o] 設定電腦睡眠、螢幕關閉時間
- [o] 移除內建的OneDrive
- [o] ~~移除工作列小工具、新聞、聊天~~ (使用 [Optimizer](https://github.com/hellzerg/optimizer) 取代撰寫腳本)

## 未來新增

- none

## 執行方式

### 1. 選擇執行腳本

若要自行選擇執行腳本的內容，請於 `AIO_Quick_Setup.ps1` 中註解不執行的腳本。

### 2. 自動安裝軟體

當選擇 `auto-install-soft.ps1` 時，將會自動執行位於 `.\soft` 資料夾中的 `.exe .msi` 檔案，目前已設定可自動以預設路徑無聲安裝的程式有：

- 7zip
- Java (x86/64)
- VC++ 2005 - 2022 (x86/64)
- .Net Framework 3.5

> 自動安裝僅限於位於 `.\soft` 的 `exe`、`msi` 安裝程式。

### 3. 停用安全性警告

如果執行出現 `安全性警告` 或是 `閃退`，請使用 `系統管理員` 執行 `Powershell` 並輸入

```powershell
Set-ExecutionPolicy Unrestricted
```

請注意使用此操作對未來可能有風險，
應在腳本執行結束後使用 `系統管理員` 執行 `Powershell` 並輸入以下內容還原執行原則等級：

```powershell
Set-ExecutionPolicy Default
```

### 4. 執行腳本

以下二者則一即可：

1. 對 `AIO_Quick_Setup.ps1` 右鍵 `使用Powershell` 執行即可。
2. 在終端機中輸入 `./AIO_Quick_Setup.ps1` 執行。

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
