# ==============================================================
# Author      : ZiLin
# Name        : Add English Language
# Description : 增加鍵盤語言 (en-US)
# LastUpdate  : 2026-01-02
# ==============================================================

$languageList = (Get-WinUserLanguageList).languageTag

if ($languageList -notcontains "en-US") {
    $languageList.Add("en-US")
    Set-WinUserLanguageList -LanguageList $languageList -Force
}

Return
