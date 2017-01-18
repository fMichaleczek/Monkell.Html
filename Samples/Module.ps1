Import-Module $PSScriptRoot\..\Html -Force
Import-Module $PSScriptRoot\..\MetroHtml -Force

$Stylesheet = @(
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro.min.css"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro-responsive.min.css"
)
$MetroPage = Html.Page -Title Module -Stylesheet $Stylesheet {
	Metro.Div -Padding 20 {

        Metro.Tab {
            Metro.TabItem -LayoutTitle "Heading1" { Get-Module | ConvertTo-MetroTable -IsStriped -RibbedBackgroundColor gray -ForegroundColor amber } -IsActive
            Metro.TabItem -LayoutTitle "Heading2" { Get-Command | ConvertTo-MetroTable -IsStriped -RibbedBackgroundColor gray -ForegroundColor amber }
            Metro.TabItem -LayoutTitle "Heading3" { "Content3" }
        }
    }
}
$Html = $MetroPage.ToPrettyHtml()


$HtmlFile = "$env:Temp\HtmlTest.html"
Set-Content -Value $Html -Path $HtmlFile
Invoke-Item $HtmlFile