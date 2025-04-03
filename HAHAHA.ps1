Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# Path to the Mario GIF
$marioPath = "$env:PUBLIC\Documents\Mario.gif"

# Check if file exists
if (Test-Path $marioPath) {
    # Build WPF window with transparent background and image
    [xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Width="250" Height="250"
        WindowStyle="None"
        AllowsTransparency="True"
        Background="Transparent"
        Topmost="True"
        ShowInTaskbar="False">
    <Canvas Name="canvas">
        <Image Name="mario" Width="250" Height="250" Source="$marioPath"/>
    </Canvas>
</Window>
"@

    # Load XAML
    $reader = (New-Object System.Xml.XmlNodeReader $xaml)
    $window = [Windows.Markup.XamlReader]::Load($reader)

    # Get screen dimensions
    $screenWidth = [System.Windows.SystemParameters]::PrimaryScreenWidth
    $screenHeight = [System.Windows.SystemParameters]::PrimaryScreenHeight

    # Position Mario low on screen
    $window.Top = $screenHeight - 300
    $window.Left = 0

    # Show window
    $window.Show()

    Write-Output "Mario started running..."

    # Move Mario across screen
    for ($x = 0; $x -lt $screenWidth; $x += 20) {
        $window.Left = $x
        Start-Sleep -Milliseconds 20
    }

    # Close window
    $window.Close()
    Write-Output "Mario finished running."
} else {
    Write-Output "File not found: $marioPath"
}
