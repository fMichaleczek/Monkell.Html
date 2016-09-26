New-HtmlProxyCommand -Name New-MetroAppBar -TargetCommandName New-HtmlDiv -AddClass 'app-bar' -AddClassParameter @(
    @{
        Name = 'IsDropUp'
        Type = [switch]
        Value = 'drop-up'
    }
    @{
        Name = 'Fixed'
        ValidateSet = 'Top','Bottom'
        Type = [string]
        Value = {
            switch($_) {
              'Top' { 'fixed-top' }
              'Bottom' { 'fixed-bottom' }
            }
        }
    }
    @{
        Name = 'ColorScheme'
        Type = [string]
        ValidateSet = 'Darcula','Pink','Navy','Red','Green','Orange'
        Value = { $_.ToLower() } 
    }
) -AddData @{ role = 'appbar' } -AddDataParameter @(
    @{
        Name = 'FlexClass'
        Type = [string]
        Value = {
            @{ flexstyle = "$_" }
        }
    }
) | Invoke-Expression
  

New-HtmlProxyCommand -Name New-MetroAppBarElement -TargetCommandName New-HtmlA -AddClass 'app-bar-element' -AddClassParameter @(
    @{
        Name = 'IsPositionRight'
        Type = [switch]
        Value = 'place-right'
    }
    @{
        Name = 'IsBranding'
        Type = [switch]
        Value = 'branding'
    }
)  | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroAppBarDivider -TargetCommandName New-HtmlSpan -AddClass 'app-bar-divider' | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroAppBarMenu -TargetCommandName New-MetroUnorderedList -AddClass 'app-bar-menu' -AddClassParameter @(
     @{
        Name = 'IsPositionRight'
        Type = [switch]
        Value = 'place-right'
    }
    @{
        Name = 'IsSmallDropdown'
        Type = [switch]
        Value = 'small-dropdown'
    }
) | Invoke-Expression
New-HtmlProxyCommand -Name New-MetroAppBarMenuItem -TargetCommandName New-MetroUnorderedListItem -AddClassParameter @(
     # Always display on screen
     @{
        Name = 'IsNotFlexible'
        Type = [switch]
        Value = 'no-flexible'
    }
) -AddDataParameter @(
     @{
        Name = 'Order'
        Type = [int]
        Value = {
            @{ 'flexorder' = $_ }
        }
    }
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroAppBarPullButton -TargetCommandName New-HtmlDiv -AddClass 'app-bar-pullbutton  automatic' | Invoke-Expression



New-HtmlProxyCommand -Name New-MetroDMenuList -TargetCommandName New-MetroUnorderedList  -AddClass 'd-menu' | Invoke-Expression
New-HtmlProxyCommand -Name New-MetroDMenuListItem -TargetCommandName New-MetroUnorderedListItem | Invoke-Expression

<#
ApplicationBar
SideBar

HorizontalMenu
VerticalMenu
M-Menu
F-Menu => FlexMenu
H-Menu
T-Menu
V-Menu
D-Menu

RibbonMenu

#>
