# Define the URL for fetching cat facts
$url = "https://raw.githubusercontent.com/raylbrwn1/CatFax-Txt/main/_101_CFscrirea.txt"

# Fetch the cat facts
$response = Invoke-RestMethod -Uri $url

# Split the response into individual cat facts
$catFacts = $response -split "`r?`n"

# Function to perform text-to-speech on a given text
function Speak-Text {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text
    )
    try {
        # Create a new SAPI.SpVoice object and use it to speak the text
        $sapi = New-Object -ComObject SAPI.SpVoice
        $sapi.Speak($Text)
    } catch {
        Write-Host "An error occurred while trying to perform text-to-speech: $_"
    }
}

# Outer loop to iterate 4 times
1..4 | ForEach-Object {
    Write-Output "Iteration $_ of the outer loop started."

    # Inner loop to read cat facts 5 times
    1..5 | ForEach-Object {
        # Select a random cat fact
        $randomFact = Get-Random -InputObject $catFacts
        
        # Use the Speak-Text function to read the cat fact
        Speak-Text -Text $randomFact
        
        # Wait a bit before reading the next fact (optional, adjust as desired)
        Start-Sleep -Seconds 10
    }

    # Check if it's not the last iteration before the break
    if ($_ -lt 4) {
        Write-Output "Starting a 90-minute break."
        Start-Sleep -Seconds (90 * 60) # 90 minutes break
    }
}

Write-Output "Process completed."
