New-HtmlProxyCommand -Name New-MetroInputText -TargetCommandName New-HtmlInput -AddParameter @(
    @{
        Name = "Size"
        Type = [string]
        ValidateSet = 'Normal', 'Big'
        DefaultValue = 'Normal'
    }
    @{
        Name = "IsFullWidth"
        Type = [switch]
    }
    @{
        Name = "PrependIcon"
        Type = [MetroIcons]
    }
    @{
        Name = "State"
        Type = [string]
        ValidateSet = 'Error', 'Warning', 'Success', 'Required'
    }
    @{
        Name = "WithClearer"
        Type = [switch]
    }   
) -SetParameter @(
@{
    Name = 'Type'
    Value = { 'text' }
}
) -Scriptblock {
    if ($PSBoundParameters["Append"]) {
        $InputNodes = & $PSBoundParameters["Append"]
        $null = $PSBoundParameters.Remove("Append")
    }
    
    $null = $PSBoundParameters.Remove('Size')
    if ($IsFullWidth) {
        $FullWidth = 'full-size'
    }
    $null = $PSBoundParameters.Remove('IsFullWidth')
    $null = $PSBoundParameters.Remove('PrependIcon')
    $null = $PSBoundParameters.Remove('State')
    $null = $PSBoundParameters.Remove('WithClearer')
    $InputPSBoundParameters = $PSBoundParameters
    New-HtmlDiv -Class "input-control text $($State.ToLower()) $($Size.ToLower())-input $FullWidth" -Data @{role="input"} {
        if ($PrependIcon) {
            New-HtmlSpan -Class "mif-$($PrependIcon.ToString().ToLower()) prepend-icon"
        }
        New-HtmlInput @InputPSBoundParameters
        if ($WithClearer) {
            New-MetroIconButton -Class "helper-button clear" -LayoutIcon cross 
        }
        
        $InputNodes 
    }
} | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroInputPassword -TargetCommandName New-HtmlInput -AddParameter @(
     @{
        Name = "Size"
        Type = [string]
        ValidateSet = 'Normal', 'Big'
        DefaultValue = 'Normal'
    }
    @{
        Name = "IsFullWidth"
        Type = [switch]
    }
    @{
        Name = "PrependIcon"
        Type = [MetroIcons]
    }
    @{
        Name = "State"
        Type = [string]
        ValidateSet = 'Error', 'Warning', 'Success', 'Required'
    }
    @{
        Name = "WithRevealer"
        Type = [switch]
    }   
) -SetParameter @(
@{
    Name = 'Type'
    Value = { 'password' }
}
) -Scriptblock {
   
    if ($PSBoundParameters["Append"]) {
        $InputNodes = & $PSBoundParameters["Append"]
        $null = $PSBoundParameters.Remove("Append")
    }
    
    $null = $PSBoundParameters.Remove('Size')  
    if ($IsFullWidth) {
        $FullWidth = 'full-size'
    }
    $null = $PSBoundParameters.Remove('IsFullWidth')
    $null = $PSBoundParameters.Remove('PrependIcon')
    $null = $PSBoundParameters.Remove('State')
    $null = $PSBoundParameters.Remove('WithRevealer')
    $InputPSBoundParameters = $PSBoundParameters
    New-HtmlDiv -Class "input-control password $($State.ToLower()) $($Size.ToLower())-input $FullWidth" -Data @{role="input"} {
        if ($InputPrependIcon) {
            New-HtmlSpan -Class "mif-$($PrependIcon.ToString().ToLower()) $InputPrependIcon prepend-icon"
        }
        New-HtmlInput @InputPSBoundParameters
        if ($WithRevealer) {
            New-MetroIconButton -Class "helper-button reveal" -LayoutIcon looks 
        }
        $InputNodes 
    }
} | Invoke-Expression



New-HtmlProxyCommand -Name New-MetroInputCheckbox -TargetCommandName New-HtmlInput -AddParameter @(
    @{
        Name = 'Caption'
        Type = [string]
    }
    @{
        Name = 'Size'
        Type = [string]
        ValidateSet = 'Normal','Small'
        DefaultValue = 'Normal'
    }   
    @{
        Name = "IsFullWidth"
        Type = [switch]
    }
) -SetParameter @(
    @{
        Name = 'Type'
        Value = { 'checkbox' }
    }
) -Scriptblock { 
    if ($IsFullWidth) {
        $FullWidth = 'full-size'
    }
    $null = $PSBoundParameters.Remove('IsFullWidth')
    $InputPSBoundParameters = $PSBoundParameters
    New-HtmlLabel -Class "input-control checkbox $($Size.ToLower())-check $FullWidth" {
        New-HtmlInput @InputPSBoundParameters
        New-HtmlSpan -Class "check"
        New-HtmlSpan -Class "caption" -TextContent $Caption
    }
} | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroInputRadio -TargetCommandName New-HtmlInput -AddParameter @(
    @{
        Name = 'Caption'
        Type = [string]
    }
    @{
        Name = 'Size'
        Type = [string]
        ValidateSet = 'Normal','Small'
        DefaultValue = 'Normal'
    }
    @{
        Name = "IsFullWidth"
        Type = [switch]
    }
) -SetParameter @(
    @{
        Name = 'Type'
        Value = { 'radio' }
    }
) -Scriptblock {
    if ($IsFullWidth) {
        $FullWidth = 'full-size'
    }
    $null = $PSBoundParameters.Remove('IsFullWidth')
    $InputPSBoundParameters = $PSBoundParameters
    New-HtmlLabel -Class "input-control radio $($Size.ToLower())-check $FullWidth" {
        New-HtmlInput @InputPSBoundParameters
        New-HtmlSpan -Class "check"
        New-HtmlSpan -Class "caption" -TextContent $Caption
    }
    
} | Invoke-Expression



New-HtmlProxyCommand -Name New-MetroInputSwitcher -TargetCommandName New-HtmlInput -AddParameter @(
    @{
        Name = 'SwitcherStyle'
        Type = [string]
        ValidateSet = 'Modern','Original'
        DefaultValue = 'Modern'
    }
) -SetParameter @(
    @{
        Name = 'Type'
        Value = { 'checkbox' }
    }
) -Scriptblock {
    $SwitcherPSBoundParameters = $PSBoundParameters
    
    if ($SwitcherStyle -eq 'Modern') {
        $SwitchClass = "switch"
    }
    else {
        $SwitchClass = "switch-original"
    }
    
    New-HtmlLabel -Class "$SwitchClass" {
        New-HtmlInput @SwitcherPSBoundParameters
        New-HtmlSpan -Class "check"
    }
    
} | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroTextarea -TargetCommandName New-HtmlTextarea -AddParameter @(
    @{
        Name = 'IsAutoResizeHeight'
        Type = [switch]
    }
    @{
        Name = 'MaxHeight'
        Type = [int]
    }
) -Scriptblock {
    $TextareaPSBoundParameters = $PSBoundParameters
    
    if ($IsAutoResizeHeight) {
        if ($Data -eq $null) {
            $Data = @{}
        }
        $Data.Add("text-auto-resize","true")
        if ($MaxHeight -ne 0) {
            $Data.Add("text-max-height",$MaxHeight)
        }
    }
    
    New-HtmlDiv -Class "input-control textarea" -Data $Data {
        New-HtmlTextarea @TextareaPSBoundParameters
    }
    
} | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroSelect -TargetCommandName New-HtmlSelect -AddParameter @(
    @{
        Name = "IsFullWidth"
        Type = [switch]
    }
) -Scriptblock {
    if ($IsFullWidth) {
        $FullWidth = 'full-size'
    }
    $null = $PSBoundParameters.Remove('IsFullWidth')
    $SelectPSBoundParameters = $PSBoundParameters
    New-HtmlDiv -Class "input-control select $FullWidth" {
        New-HtmlSelect @SelectPSBoundParameters
    }
    
} | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroOption -TargetCommandName New-HtmlOption | Invoke-Expression



New-HtmlProxyCommand -Name New-MetroInputFile -TargetCommandName New-HtmlInput -AddParameter @(
    @{ 
        Name = "LayoutIcon"
        Type = [MetroIcons]
        DefaultValue = [MetroIcons]::Folder
    }  
    @{
        Name = "IsFullWidth"
        Type = [switch]
    }
) -SetParameter @(
    @{
        Name = 'Type'
        Value = { 'file' }
    }
) -Scriptblock {
    if ($IsFullWidth) {
        $FullWidth = 'full-size'
    }
    $null = $PSBoundParameters.Remove('IsFullWidth')
    $InputPSBoundParameters = $PSBoundParameters
    New-HtmlLabel -Class "input-control file $FullWidth" -Data @{role='input'} {
        New-HtmlInput @InputPSBoundParameters
        New-MetroIconButton -LayoutIcon $LayoutIcon
    }
    
} | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroInputButton -TargetCommandName New-HtmlInput -SetParameter @(
    @{
        Name = 'Type'
        Value = { 'button' }
    }
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroInputReset -TargetCommandName New-HtmlInput -SetParameter @(
    @{
        Name = 'Type'
        Value = { 'reset' }
    }
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroInputSubmit -TargetCommandName New-HtmlInput -SetParameter @(
    @{
        Name = 'Type'
        Value = { 'submit' }
    }
) | Invoke-Expression



New-HtmlProxyCommand -Name New-MetroInputTextModern -TargetCommandName New-HtmlInput -AddParameter @(
    @{
        Name = "Label"
        Type = [string]
    }
    @{
        Name = "Informer"
        Type = [string]
    }
    @{
        Name = "PrependIcon"
        Type = [MetroIcons]
    } 
) -SetParameter @(
@{
    Name = 'Type'
    Value = { 'text' }
}
) -Scriptblock {

    if ($PSBoundParameters["Append"]) {
        $InputNodes = & $PSBoundParameters["Append"]
        $null = $PSBoundParameters.Remove("Append")
    }
    
    $null = $PSBoundParameters.Remove('Label')
    $null = $PSBoundParameters.Remove('Informer')
    $null = $PSBoundParameters.Remove('Placeholder')
    $null = $PSBoundParameters.Remove('PrependIcon')
    $InputPSBoundParameters = $PSBoundParameters
    
    if ($PrependIcon) {
        $IconicClass = 'iconic'
    }
    New-HtmlDiv -Class "input-control modern text $IconicClass" -Data @{role='input'} {
        New-HtmlInput @InputPSBoundParameters
        New-HtmlSpan -Class "label" -TextContent $Label
        New-HtmlSpan -Class "informer" -TextContent $Informer
        New-HtmlSpan -Class "placeholder" -TextContent $Placeholder
        if ($PrependIcon) {
            New-HtmlSpan -Class "icon mif-$($PrependIcon.ToString().ToLower())"
        }
        $InputNodes 
    }
} | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroInputPasswordModern -TargetCommandName New-HtmlInput -AddParameter @(
    @{
        Name = "Label"
        Type = [string]
    }
    @{
        Name = "Informer"
        Type = [string]
    }
    @{
        Name = "PrependIcon"
        Type = [MetroIcons]
    } 
    @{
        Name = "WithRevealer"
        Type = [switch]
    } 
) -SetParameter @(
@{
    Name = 'Type'
    Value = { 'password' }
}
) -Scriptblock {

    if ($PSBoundParameters["Append"]) {
        $InputNodes = & $PSBoundParameters["Append"]
        $null = $PSBoundParameters.Remove("Append")
    }
    
    $null = $PSBoundParameters.Remove('Label')
    $null = $PSBoundParameters.Remove('Informer')
    $null = $PSBoundParameters.Remove('Placeholder')
    $null = $PSBoundParameters.Remove('PrependIcon')
    $null = $PSBoundParameters.Remove('WithRevealer')
    $InputPSBoundParameters = $PSBoundParameters
    
    if ($PrependIcon) {
        $IconicClass = 'iconic'
    }
    
    New-HtmlDiv -Class "input-control modern password $IconicClass" -Data @{role='input'} {
        New-HtmlInput @InputPSBoundParameters
        New-HtmlSpan -Class "label" -TextContent $Label
        New-HtmlSpan -Class "informer" -TextContent $Informer
        New-HtmlSpan -Class "placeholder" -TextContent $Placeholder
        if ($PrependIcon) {
            New-HtmlSpan -Class "icon mif-$($PrependIcon.ToString().ToLower())"
        }
        if ($WithRevealer) {
            New-MetroIconButton -Class "helper-button reveal" -LayoutIcon looks 
        }
        $InputNodes 
    }
} | Invoke-Expression

