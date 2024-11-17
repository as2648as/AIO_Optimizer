#      author: ZiLin (as2648as)
# script-name: add-en-US-keybroad-language
# last-update: 2024-11-17

Write-Host "===== 新增鍵盤語言(en-US) =====`n"

$languageList = (Get-WinUserLanguageList).languageTag

if ($languageList -Contains "en-US") {
    Write-Host "en-US 鍵盤已存在`n"
}
else {
    $languageList.Add("EN-US")
    Set-WinUserLanguageList -LanguageList $languageList -Force
}

Write-Host "新增鍵盤語言 (en-US) 完成`n";