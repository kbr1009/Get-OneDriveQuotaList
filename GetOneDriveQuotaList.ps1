# SPO AdminサイトURL
$AdminSiteURL="https://xxxx-admin.sharepoint.com"
# 管理者によるログイン情報
$Cred = Get-Credential
# SPOサービスへのコネクト
Connect-SPOService -Url $AdminSiteURL -credential $Cred
# OneDriveデータへのアクセス
$OneDriveSites = Get-SPOSite -Template "SPSPERS" -Limit ALL -includepersonalsite $True

#結果表示用変数
$Result=@()
#データ数分結果変数に入れる
Foreach($Site in $OneDriveSites)
{
    $Result += New-Object PSObject -property @{
        URL = $Site.URL # url
        UserName = $Site.Owner # who
        MAX_GB = $Site.StorageQuota/1024 # OneDrive容量上限
        InUse_MB = $Site.StorageUsageCurrent # 使用量
    }
}

# データ表示 *テーブル形式
$Result | Format-Table

## CSVにエクスポート
$Result | Export-Csv "C:\<xxxxxx>" -NoTypeInformation