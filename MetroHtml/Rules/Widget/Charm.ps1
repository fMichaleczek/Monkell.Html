New-HtmlProxyCommand -Name New-MetroCharm -TargetCommandName New-MetroDiv -AddParameter @(
    @{ 
        Name = "Position"
        Mandatory = $true
        ValidateSet = 'Left','Right','Top','Bottom'
        Type = [string]
        DefaultValue = 'Left'
    }
    @{ 
        Name = "LayoutSource"
        Type = [string]
    }   
) -SetParameter @(
    @{
        Name = 'Data'
        Value = {
            @{
                'role' = 'charm'
                'position' = $Position.ToLower()
            }
        }
    }
    @{
        Name = 'Class'
        Value = {
            'charm ' + $Position.ToLower() + '-side'
        }
    }
) | Invoke-Expression

