# Button
New-HtmlProxyCommand -Name New-MetroGroupButton -TargetCommandName New-HtmlDiv -AddClass "button-group" | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroButton -TargetCommandName New-HtmlButton -AddClass "button" -AddClassParameter (
@(
    
    @{
        Name = "ButtonStyle"
        Type = [string]
        ValidateSet = 'Rounded','Cycle','Square'
        Value = { 
            switch($_) {
              'Rounded' { 'rounded' }
              'Cycle' { 'cycle-button' } 
              'Square' { 'square-button' }
            } 
        } 
    }
    @{
        Name = "Size"
        Type = [string]
        ValidateSet = 'Mini','Small','Large'
        Value = { 
            $_.ToLower() + '-button'
        } 
    }
    @{ 
        Name = "BlockShadow"
        Type = [switch]
        Value = 'block-shadow'
    }
    @{ 
        Name = "TextShadow"
        Type = [switch]
        Value = 'text-shadow'
    }
    @{
        Name = "LoadingLogo"
        Type = [string]
        ValidateSet = 'Pulse','PulseLighten','Cube','CubeLighten'
        Value = { 
            switch($_) {
              'Pulse' { 'loading-pulse' }
              'PulseLighten' { 'loading-pulse lighten' } 
              'Cube' { 'loading-cube' }
              'CubeLighten' { 'loading-cube lighten' }
            } 
        } 
    }
    @{ 
        Name = "Disabled"
        Type = [switch]
        Value = 'disabled'
    }
) + $ColorParameters ) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroIconButton -TargetCommandName New-MetroButton -AddParameter @(
    @{ 
        Name = "LayoutIcon"
        Type = [MetroIcons]
    } 
) -SetParameter @(
    @{
        Name = 'Prepend'
        Value = {
            {
                if ($LayoutIcon) {
                    Html.Span -Class "mif-$LayoutIcon"
                }
            }
        }
    }
) | Invoke-Expression
    
New-HtmlProxyCommand -Name New-MetroToolbar -TargetCommandName New-MetroDiv -AddClass 'toolbar' | Invoke-Expression   
New-HtmlProxyCommand -Name New-MetroToolbarSection -TargetCommandName New-MetroDiv -AddClass 'toolbar-section' | Invoke-Expression   
New-HtmlProxyCommand -Name New-MetroToolbarButton  -TargetCommandName New-MetroIconButton -AddClass 'toolbar-button' | Invoke-Expression  
    
New-HtmlProxyCommand -Name New-MetroCommandButton -TargetCommandName New-HtmlButton -AddClass "command-button" -AddParameter @(
    @{ 
        Name = "LayoutTitle"
        Type = [string]
    }
    @{ 
        Name = "LayoutDescription"
        Type = [string]
    }   
    @{ 
        Name = "LayoutIcon"
        Mandatory = $true
        Type = [MetroIcons]
    }   
)  -AddClassParameter ( @(
    @{
        Name = "LayoutIconAlign"
        Type = [string]
        ValidateSet = 'Right','Left'
        DefaultValue = 'Left'
        Value = { 
            'icon-' + $_.ToLower()
        } 
    }
) + $ColorParameters ) -SetParameter @{
    Name = 'Append'
    Value = {
        {
            New-HtmlSpan -Class "icon mif-$($LayoutIcon.ToString())"
            New-HtmlText -Text $LayoutTitle
            New-HtmlSmall -TextContent $LayoutDescription
        }
    }
} | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroImageButton -TargetCommandName New-HtmlButton -AddClass "image-button" -AddParameter @(
    @{ 
        Name = "LayoutTitle"
        Type = [string]
    }  
    @{ 
        Name = "LayoutIcon"
        Mandatory = $true
        Type = [MetroIcons]
    }   
) -AddClassParameter ( @(
    @{
        Name = "LayoutIconAlign"
        Type = [string]
        ValidateSet = 'Right','Left'
        DefaultValue = 'Left'
        Value = { 
            'icon-' + $_.ToLower()
        } 
    }
) + $ColorParameters )  -SetParameter @{
    Name = 'Append'
    Value = {
        {
            New-HtmlText -Text $LayoutTitle
            New-HtmlSpan -Class "icon mif-$($LayoutIcon.ToString())"
        }
    }
} | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroShortcutButton -TargetCommandName New-HtmlButton -AddClass "shortcut-button" -AddParameter @(
    @{ 
        Name = "LayoutTitle"
        Type = [string]
    }  
    @{ 
        Name = "LayoutIcon"
        Mandatory = $true
        Type = [MetroIcons]
    }
    @{ 
        Name = "LayoutBadge"
        Type = [string]
    }   
) -AddClassParameter $ColorParameters -SetParameter @{
    Name = 'Append'
    Value = {
        {
            New-HtmlSpan -Class "icon mif-$($LayoutIcon.ToString())"
            New-HtmlSpan -Class "title" -Textcontent $LayoutTitle
            if ($LayoutBadge) {
                New-HtmlSpan -Class "badge" -TextContent $LayoutBadge
            }
        }
    }
} | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroDropdownButton -TargetCommandName New-MetroButton -AddParameter @(
    @{
        Name = 'Position'
        ValidateSet = 'Left','Right'
        Type = [string]
        DefaultValue = 'Left'
    }
) -Scriptblock {

    $ButtonNodes = & $PSBoundParameters["Append"]
    $null = $PSBoundParameters.Remove("Append")
    
    $ButtonPSBoundParameters = $PSBoundParameters
    
    New-HtmlDiv -Class "dropdown-button place-$($Position.ToLower())" {
        New-MetroButton -Class 'dropdown-toggle' @ButtonPSBoundParameters
        New-MetroUnorderedList -Class "split-content d-menu place-$($Position.ToLower())" -Data @{role='dropdown'} {
            foreach ($ButtonNode in $ButtonNodes) {
                New-MetroUnorderedListItem {
                    $ButtonNode
                }
            }
        }
    }
    
} | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroSplitButton -TargetCommandName New-MetroButton -Scriptblock {
    
    $ButtonNodes = & $PSBoundParameters["Append"]
    $null = $PSBoundParameters.Remove("Append")
    
    $ButtonPSBoundParameters = $PSBoundParameters
    
    New-HtmlDiv -Class "split-button" {
        New-MetroButton @ButtonPSBoundParameters
        New-HtmlButton -Class 'split dropdown-toggle'
        New-MetroUnorderedList -Class 'split-content d-menu' -Data @{role='dropdown'} {
            foreach ($ButtonNode in $ButtonNodes) {
                New-MetroUnorderedListItem {
                    $ButtonNode
                }
            }
        }
    }
    
}  | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroPagination -TargetCommandName New-MetroDiv -AddClass pagination -AddClassParameter @(
   @{
        Name = "PaginationStyle"
        Type = [string]
        ValidateSet = 'Rounded','Cycle','NoBorder'
        Value = { 
            switch($_) {
              'Rounded' { 'rounded' }
              'Cycle' { 'cycle' } 
              'NoBorder' { 'no-border' }
            } 
        } 
    }
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroPaginationItem -TargetCommandName New-MetroSpan -AddClass item  -AddClassParameter @(
    @{
        Name = "IsCurrent"
        Type = [switch]
        Value = 'current' 
    }
    @{
        Name = "IsDisabled"
        Type = [switch]
        Value = 'disabled' 
    }
    @{
        Name = "IsSpaces"
        Type = [switch]
        Value = 'spaces' 
    }
) | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroBreadcrumbs -TargetCommandName New-HtmlUl -AddParameter @(
    @{
        Name = "Size"
        Type = [string]
        ValidateSet = 'Normal','Small','Mini'
    }
) -Scriptblock {

    $BreadcrumbsNodes = & $PSBoundParameters["Append"]
    $null = $PSBoundParameters.Remove("Append")
    
    $BreadcrumbsPSBoundParameters = $PSBoundParameters
    
    New-HtmlUl -Class "breadcrumbs2 $($Size.ToLower())" {
        foreach ($BreadcrumbsNode in $BreadcrumbsNodes) {
            New-MetroUnorderedListItem {
                $BreadcrumbsNode
            }
        }
    }
    
} | Invoke-Expression



New-HtmlProxyCommand -Name New-MetroBreadcrumbsSimple -TargetCommandName New-HtmlUl  -AddParameter @(
    @{
        Name = "BackgroundColor"
        Type = [MetroPredefinedColors]
    }
) -Scriptblock {
    
    if ($PSBoundParameters["Append"]) {
        $BreadcrumbsNodes = & $PSBoundParameters["Append"]
        $null = $PSBoundParameters.Remove("Append")
    }
    
    $BreadcrumbsPSBoundParameters = $PSBoundParameters
    
    if ($BackgroundColor) {
        $BgColor = $($BackgroundColor.ToString().ToLower())
    }
    New-HtmlUl -Class "breadcrumbs $BgColor" {
        foreach ($BreadcrumbsNode in $BreadcrumbsNodes) {
            New-MetroUnorderedListItem {
                $BreadcrumbsNode
            }
        }
    }
    
} | Invoke-Expression
