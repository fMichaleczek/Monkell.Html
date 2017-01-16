
# Simple Grid

New-HtmlProxyCommand -Name New-MetroGrid -TargetCommand ( Get-Command New-MetroDiv ) -AddClass "grid" -AddClassParameter @(
@{ 
    Name = "IsCondensed"
    Type = [switch]
    Value = "condensed" 
}
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroGridRow -TargetCommand ( Get-Command New-MetroDiv ) -AddClass "row" -AddClassParameter @( 
@{
    Name = "Row"
    Type = [int]
    Value = { "cells" + "$_" }
}
) | Invoke-Expression
 
New-HtmlProxyCommand -Name New-MetroGridCell -TargetCommand ( Get-Command New-MetroDiv ) -AddClass "cell" -AddClassParameter @(
@{
    Name = "ColumnSpan"
    Type = [int]
    Value = { "colspan" + $_ }
}
@{
    Name = "OffSet"
    Type = [int]
    Value = { "offset" + $_ }
}
) | Invoke-Expression

# Flex Grid
New-HtmlProxyCommand -Name New-MetroFlexGrid -TargetCommand ( Get-Command New-MetroDiv ) -AddClass "flex-grid" | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroFlexGridRow -TargetCommand ( Get-Command New-MetroDiv ) -AddClass "row" -AddClassParameter @( 
@{
    Name = "CellSize"
    ValidateSet = 'Default','Auto'
    Type = [string]
    Value = {
        switch($_) {
          'Default' { $null }
          'Auto' { "cell-auto-size" }
        }
    }
}
@{
    Name = "FlexDirection"
    ValidateSet = 'Row','RowReverse','Column','ColumnReverse'
    Type = [string]
    Value = {
        switch($_) {
          'Row' { 'flex-dir-row' }
          'RowReverse' { "flex-dir-row-reverse" }
          'Column' { "flex-dir-column" }
          'ColumnReverse' { "flex-dir-column-reverse" }
        }
    }
}
@{
    Name = "Justify"
    ValidateSet = 'Start','Center','End','SpaceAround','SpaceBetween'
    Type = [string]
    Value = { 
       switch($_) {
          'Start' { "flex-just-start" }
          'Center' { "flex-just-center" }
          'End' { "flex-just-end" }          
          'SpaceAround' { "flex-just-sa" }
          'SpaceBetween' { "flex-just-sb" }
        }
    }
}
@{
    Name = "Wrap"
    ValidateSet = 'Wrap','WrapReverse','NoWrap'
    Type = [string]
    Value = { 
       switch($_) {
          'Wrap' { "flex-wrap" }
          'WrapReverse' { "flex-wrap-reverse" }
          'NoWrap' { "flex-no-wrap" }   
        }
    }
}
@{
    Name = "Align"
    ValidateSet = 'Stretch','Start','End','Center','Base'
    Type = [string]
    Value = { 
       switch($_) {
          'Stretch' { "flex-align-stretch" }
          'Start' { "flex-align-start" }
          'End' { "flex-align-end" }          
          'Center' { "flex-align-center" }
          'Base' { "flex-align-base" }
        }
    }
}
@{
    Name = "Content"
    ValidateSet = 'Stretch','Start','End','Center','SpaceAround','SpaceBetween'
    Type = [string]
    Value = { 
       switch($_) {
          'Stretch' { "flex-content-stretch" }
          'Start' { "flex-content-start" }
          'End' { "flex-content-end" }          
          'Center' { "flex-content-center" }
          'SpaceAround' { "flex-content-sa" }
          'SpaceBetween' { "flex-content-sb" }
        }
    }
}
@{
    Name = "Self"
    ValidateSet = 'Auto','Start','End','Center','Base','Stretch'
    Type = [string]
    Value = { 
       switch($_) {
          'Auto' { "flex-self-auto" }
          'Start' { "flex-self-start" }
          'End' { "flex-self-end" }          
          'Center' { "flex-self-center" }
          'Base' { "flex-self-base" }
          'Stretch' { "flex-self-stretch" }
        }
    }
}
@{
    Name = "NoShrink"
    Type = [switch]
    Value = "no-shrink" 
}
@{
    Name = "NoGrow"
    Type = [switch]
    Value = "no-grow" 
}
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroFlexGridCell -TargetCommand ( Get-Command New-MetroDiv) -AddClass "cell" -AddClassParameter @(
@{
    Name = "ColumnSpan"
    Type = [int]
    Value = { "colspan" + $_ }
}
) | Invoke-Expression
