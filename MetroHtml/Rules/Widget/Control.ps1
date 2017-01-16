New-HtmlProxyCommand -Name New-MetroAccordion -TargetCommandName New-HtmlDiv -AddClass 'accordion' -AddClassParameter @(
    @{ 
        Name = "IsLargeHeading"
        Type = [switch]
        Value = 'large-heading'
    } 
) -AddData @{ role = "accordion" } -AddDataParameter @(
    @{
        Name = "IsCollapsible"
        Type = [switch]
        Value = { 
            @{ 'close-any' = 'true' }
        }
    }
    @{
        Name = "OnFrameOpen"
        Type = [string]
        Value = { 
            @{ 'on-frame-open' = "$_" }
        }
    }
    @{
        Name = "OnFrameOpened"
        Type = [string]
        Value = { 
            @{ 'on-frame-opened' = "$_" }
        }
    }
        @{
        Name = "OnFrameClosed"
        Type = [string]
        Value = { 
            @{ 'on-frame-closed' = "$_" }
        }
    }
) | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroAccordionItem -TargetCommandName New-HtmlDiv -AddClass 'frame' -AddClassParameter @(
    @{
        Name = "IsActive"
        Type = [switch]
        Value = 'active'
    }
    @{
        Name = "IsDisabled"
        Type = [switch]
        Value = 'disabled'
    }
) -AddParameter @(
    @{
        Name = "LayoutTitle"
        Type = [string]
    }
    @{ 
        Name = "LayoutIcon"
        Type = [MetroIcons]
    }
) -Scriptblock {
    $AccordionItemAppend = $PSBoundParameters["Append"]
    $AccordionItemPrepend = $PSBoundParameters["Prepend"]
    
    $null = $PSBoundParameters.Remove("Append")
    $null = $PSBoundParameters.Remove("Prepend")
    $null = $PSBoundParameters.Remove("LayoutTitle")
    $null = $PSBoundParameters.Remove("LayoutIcon")
    
    New-HtmlDiv @PSBoundParameters {
        if ($LayoutIcon) {
            New-HtmlDiv -Class "heading" -TextContent $LayoutTitle -Prepend $AccordionItemPrepend -Append { New-MetroIcon -Icon $LayoutIcon }
        }
        else {
            New-HtmlDiv -Class "heading" -TextContent $LayoutTitle -Prepend $AccordionItemPrepend
        }
        New-HtmlDiv -Class "content" -Append $AccordionItemAppend
    } 
}   | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroTab -TargetCommandName New-HtmlDiv -AddData @{ role = "tabcontrol" } -AddClassParameter @(
    @{
        Name = 'TabStyle'
        Type = [string]
        ValidateSet = 'Dark','Light'
        Value = { 
            switch($_) {
              'Dark' { 'tabcontrol' }
              'Light' { 'tabcontrol2' }   
            } 
        } 
        DefaultValue = 'Dark'
    }
    @{
        Name = 'Position'
        Type = [string]
        ValidateSet = 'Top','Bottom'
        Value = { 
            switch($_) {
              'Top' { 'tabs-top' }
              'Bottom' { 'tabs-bottom' }   
            } 
        } 
        DefaultValue = 'Top'
    }
) -AddDataParameter @(
    @{
        Name = 'OpenTabId'
        Type = [string]
        Value = {
            @{ 'open-target' = "$_" }
        }
    }
    @{
        Name = 'EnableSaveState'
        Type = [switch]
        Value = {
            @{ 'save-state' = 'true' }
        }
    }
    @{
        Name = 'OnTabClick'
        Type = [switch]
        Value = {
            @{ 'on-tab-click' = "$_" }
        }
    }
    @{
        Name = 'OnTabChange'
        Type = [switch]
        Value = {
            @{ 'on-tab-change' = "$_" }
        }
    }
) -Scriptblock {
    $null = $PSBoundParameters.Remove("Append")
    
    $TabControl = New-HtmlDiv @PSBoundParameters
    $Tabs = New-HtmlUl -Class "tabs"
    $Frames = New-HtmlDiv -Class "frames"
    
    $TabItemAppend = @( & $Append )
    
    $TabGuid = "Tab" + [Guid]::NewGuid().ToString() + "-frame"
    $i = 0
    foreach ($Node in $TabItemAppend) {
        $Anchor = $Node[0]
        $Anchor.Href = "#" + $TabGuid + "$i"
        $ListItem = New-HtmlLi -Append { $Anchor }
        
        $Frame = $Node[1]
        $Frame.Id = $TabGuid + "$i"
        
        $null = $Tabs.Append($ListItem)
        $null = $Frames.Append($Frame)
        $i++
    }
    
    if ($Position -eq "Top") {
        $null = $TabControl.Append($Tabs)
        $null = $TabControl.Append($Frames)
    }
    else {
        $null = $TabControl.Append($Frames)
        $null = $TabControl.Append($Tabs)
    }
    
    $TabControl
    
}   | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroTabItem -TargetCommandName New-HtmlA -AddClassParameter @(
    @{
        Name = "IsActive"
        Type = [switch]
        Value = 'active'
    }
    @{
        Name = "IsDisabled"
        Type = [switch]
        Value = 'disabled'
    }
) -AddParameter @(
    @{
        Name = "LayoutTitle"
        Type = [string]
    }
) -Scriptblock {
    $null = $PSBoundParameters.Remove("Append")
    $null = $PSBoundParameters.Remove("LayoutTitle")
    $PSBoundParameters.TextContent = $LayoutTitle
    
    $Anchor = New-HtmlA @PSBoundParameters
    $Div = New-HtmlDiv -Class frame -Append $Append
    
    Write-Output @(,@($Anchor, $Div))
    
}  | Invoke-Expression