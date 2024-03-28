$serviceName = "Dhcp"
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
if ($null -ne $service -and $service.Status -eq 'Running') {
    $url = "https://raw.githubusercontent.com/raylbrwn1/CatFax-Txt/main/_101_CFscrirea.txt"
    $response = Invoke-RestMethod -Uri $url
    $catFacts = $response -split "`r?`n"
    $randomFact = Get-Random -InputObject $catFacts
    
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
    
    Speak-Text -Text $randomFact
} else {
    Write-Host "The DHCP service is not running. No cat fact for you!"
}
