# Define the script block to run in the background
$ScriptBlock = {
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

    1..4 | ForEach-Object {
        1..5 | ForEach-Object {
            $randomFact = Get-Random -InputObject $catFacts
            Speak-Text -Text $randomFact
            Start-Sleep -Seconds 10
        }

        if ($_ -lt 4) {
            Start-Sleep -Seconds (90 * 60) # 90 minutes break
        }
    }
}

# Start the script block as a background job
$job = Start-Job -ScriptBlock $ScriptBlock

# Example usage, waiting for the job to complete and then receiving any output
Wait-Job -Job $job
Receive-Job -Job $job

# Cleanup the job
Remove-Job -Job $job
