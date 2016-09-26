New-HtmlProxyCommand -Name New-MetroIcon -TargetCommandName New-HtmlSpan -AddClassParameter @(
    @{ 
        Name = "Icon"
        Type = [MetroIcons]
        Value = {
            'icon mif-' + $_.ToString().ToLower()
        }
    } 
    @{ 
        Name = "IconNoStyle"
        Type = [MetroIcons]
        Value = {
            'mif-' + $_.ToString().ToLower()
        }
    } 
    @{ 
        Name = "IsDoubleSize"
        Type = [switch]
        Value = 'mif-2x'
    } 
) | Invoke-Expression