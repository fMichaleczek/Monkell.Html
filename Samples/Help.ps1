$PageParams = @{
    Title = "Monkell"
    Description = "Some Description"
    Author = "Me"
    Keywords = "About Some","Things"
    Language = "EN"
    Charset = "UTF-8"
    Stylesheet = @(
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro.min.css"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro-icons.min.css"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro-responsive.min.css"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro-schemes.min.css"
    )
    Javascript = @(
        "https://code.jquery.com/jquery-2.2.3.min.js"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/js/metro.js"
    )
}

$BlackListModule = @('ShowUI','ShowUI.CLR')

$global:CachedModuleListAvailable = @()
$global:CachedHelpList = @()

if (-not $global:CachedModuleListAvailable) {
	$global:CachedModuleListAvailable = Get-Module -ListAvailable | Where Name -notin $BlackListModule
	foreach ($Module in $global:CachedModuleListAvailable) {
		Write-Host "Module $($Module.Name)"
		try {
			$global:CachedModuleListAvailable += $Module | Import-Module -DisableNameChecking -Force-PassThru
		}
		catch {
			Write-Warning $_.Exception.ToString()
		}
	}
}

if (-not $global:CachedHelpList) {
	$global:CachedHelpList = @()
	foreach ($Module in $global:CachedModuleListAvailable) { 
		Write-Host "Module $($Module.Name)"
		$CommandList = Get-Command -Module $Module.Name
		foreach ($Command in $CommandList) {
			try {
				$global:CachedHelpList += Get-Help -Name $Command.Name
			}
			catch {
				Write-Warning $_.Exception.ToString()
			}
		}
	}
}

$MetroPage = Html.Page @PageParams -Append {
	$Categories = $global:CachedHelpList | Select -ExpandProperty Category -Unique | Where { $_ -ne "Alias"}
	foreach ($Category in $Categories) {
		"<h3>$HelpCategory</h3>"
		$HelpCategoryList = $global:CachedHelpList| Where { $_.Category -eq $Category -and $_.Name -notlike "*:"} | Sort Name
		foreach ($HelpCategory in $HelpCategoryList ) {
			$Properties = @(
				@{
					Name = "Name"
					Expression = { '<a href="{1}">{0}</a>' -f $_.Name , $_.URL }
				}
				@{
					Name= "Synopsis"
					Expression = {
						$Syn = $_.Synopsis.Trim().Replace("`n"," ")
						if ($Syn -eq $_.Name) {
						
						} 
						elseif ( $Syn.Length -le 100 ) {
							$Syn
						} 
						else {
							$Syn.Substring(0,100)
						}
						
					}
				}
				'Category','Module'
			)
			$HelpCategory |	Select -Properties $Properties | ConvertTo-Html -Fragment
		}
	}
}
		
$Html = $MetroPage.ToPrettyHtml()
# $Html = $MetroPage.ToFlatHtml()

$HtmlFile = "$env:Temp\HtmlTest.html"
Set-Content -Value $Html -Path $HtmlFile

Invoke-Item $HtmlFile
