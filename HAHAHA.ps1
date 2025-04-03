Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# Try to get system model
try {
    $model = Get-CimInstance -Class Win32_ComputerSystem | Select-Object -ExpandProperty Model
    Write-Output "System Model: $model"
} catch {
    Write-Output "Unable to retrieve system model: $_"
}

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Width="250" Height="250" WindowStyle="None"
        AllowsTransparency="True" Background="Transparent"
        Topmost="True" ShowInTaskbar="False">
    <Canvas Name="canvas">
        <Image Name="mario" Width="250" Height="250"
               Source="C:\Users\Public\Documents\Mario.gif"/>
    </Canvas>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$window.Top = 600
$window.Left = 0
$window.Show()

$screenWidth = [System.Windows.SystemParameters]::PrimaryScreenWidth

for ($x = 0; $x -lt $screenWidth; $x += 15) {
    $window.Left = $x
    Start-Sleep -Milliseconds 20
}

$window.Close()
