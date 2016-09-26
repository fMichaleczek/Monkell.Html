
New-HtmlProxyCommand -Name New-MetroImage -TargetCommandName New-HtmlImg -AddParameter @(
    @{
        Name = "Format"
        ValidateSet = 'HD','SD','Square','Diamond','Cycle','Bordered','HandingAnimated'
        Type = [string]
    }
    @{
        Name = "OverlayText"
        Type = [string]
    }
) -Begin {
    foreach($RemainingArgument in $PSBoundParameters["RemainingArguments"]) {
        if ($RemainingArgument -is [scriptblock]) {
            $PSBoundParameters["AppendNode"] = $RemainingArgument
        }
    }
    $null = $PSBoundParameters.Remove("RemainingArguments")
    
    if ($PSBoundParameters["AppendNode"]) {
        $OverlayNodes = & $PSBoundParameters["AppendNode"]
        $null = $PSBoundParameters.Remove("AppendNode")
    }
    
    $null = $PSBoundParameters.Remove("Format")
    $null = $PSBoundParameters.Remove("OverlayText")
    
    $ImagePSBoundParameters = $PSBoundParameters
    
    $ImageData = @{}
    
    if ($Format) {
        $ImageData = @{ role = 'fitImage' }
        $ImageData += switch($Format) {
            'HD' { @{ format = "hd" } }
            'SD' { @{ format = "sd" } }
            'Square' { @{ format = "square" } }          
            'Diamond' { @{ format = "square" ; type = "diamond" } }
            'Cycle' { @{ format = "cycle" } }
            'Bordered' { @{ type = "bordered" } }
            'HandingAnimated' { @{ type = "handing-ani" } }
        }
    }
    
    if ($OverlayText -ne [string]::Empty) {
        $ImageData += @{ overlay = $OverlayText }
    }
    
    New-HtmlImg @ImagePSBoundParameters -Data $ImageData
    
} -Process {} -End {} | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroImageContainer -TargetCommandName New-HtmlImg -AddParameter @(
    @{
        Name = "ContainerType"
        ValidateSet = 'Rounded','Bordered','Polaroid','Handing','HandingAnimated'
        Type = [string]
    }
    @{
        Name = "ColorOverlay"
        Type = [MetroPredefinedColors]
    }
    @{
        Name = "IsSelected"
        Type = [switch]
    }
) -ScriptBlock {
    if ($PSBoundParameters["AppendNode"]) {
        $OverlayNodes = & $PSBoundParameters["AppendNode"]
        $null = $PSBoundParameters.Remove("AppendNode")
    }
    $null = $PSBoundParameters.Remove("ContainerType")
    $null = $PSBoundParameters.Remove("ColorOverlay")
    $null = $PSBoundParameters.Remove("IsSelected")
    
    
    $ImagePSBoundParameters = $PSBoundParameters
    
    if ($ContainerType) {
        $ContainerTypeClass = switch($ContainerType) {
              'Rounded' { "rounded" }
              'Bordered' { "bordered" }
              'Polaroid' { "polaroid" }          
              'Handing' { "bordered handing image-format-hd" }
              'HandingAnimated' { "bordered handing ani image-format-hd" }
        }
    }
    
    if ($IsSelected) {
        $SelectedClass = 'element-selected'
    }
    
    if ($ColorOverlay) {
        $ColorOverlayClass = "op-" + $ColorOverlay.ToString().ToLower()
    }
    
    New-HtmlDiv -Class "image-container $ContainerTypeClass $SelectedClass" {
        New-HtmlDiv -Class 'frame' {
            New-HtmlImg @ImagePSBoundParameters
        }
        if ($null -ne $OverlayNodes) {
            New-HtmlDiv -Class "image-overlay $ColorOverlayClass" {
                $OverlayNodes
            }
        }
    }
    
} | Invoke-Expression
    