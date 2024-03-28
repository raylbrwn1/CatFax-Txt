$url = "https://raw.githubusercontent.com/raylbrwn1/CatFax-Txt/main/_101_CFscrirea.txt"
$response = Invoke-RestMethod -Uri $url
$catFacts = $response -split "`r?`n"

function Speak-Text {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text
    )
    try {
        $sapi = New-Object -ComObject SAPI.SpVoice
        $sapi.Speak($Text)
    } catch {
        Write-Host "An error occurred while trying to perform text-to-speech: $_"
    }
}

$randomFact = Get-Random -InputObject $catFacts
Speak-Text -Text $randomFact
