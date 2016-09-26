

## Paragrah

New-HtmlProxyCommand -Name New-MetroQuote -TargetCommandName New-HtmlQuote -AddParameter @(
    @{ 
        Name = "LayoutContent"
        Type = [string]
    }
    @{ 
        Name = "LayoutSource"
        Type = [string]
    }   
) -SetParameter @{
    Name = 'AppendNode'
    Value = {
        {
            Html.P -TextContent $LayoutContent
            Html.Small -TextContent $LayoutSource
        }
    }
} | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroParagraph -TargetCommandName New-HtmlP -AddClass "cell" -AddClassParameter @(
@{
    Name = "TextStyle"
    Type = [string]
    ValidateSet = 'Default','Accent','Secondary','Small','Dashed'
    Value = { "text-" + $_.ToLower() } 
}
@{
    Name = "TextAlign"
    Type = [string]
    ValidateSet = 'Left','Center','Right','Justify'
    Value = { $_.ToLower() } 
}
@{
    Name = "VerticalTextAlign"
    Type = [string]
    ValidateSet = 'Top','Bottom','Middle','Sub','Super','Top-Text','Bottom-Text'
    Value = { $_.ToLower() } 
}
@{
    Name = "Transform"
    Type = [string]
    ValidateSet = 'Lowercase','Uppercase','Capital'
    Value = { $_.ToLower() } 
}
@{
    Name = "IsIndent"
    Type = [switch]
    Value = "indent" 
}
)  | Invoke-Expression


## List

# UnorderedList
New-HtmlProxyCommand -Name New-MetroUnorderedListItem -TargetCommandName New-HtmlLi | Invoke-Expression
New-HtmlProxyCommand -Name New-MetroOrderedListItem -TargetCommandName New-HtmlLi | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroUnorderedList -TargetCommandName New-HtmlUl -AddClassParameter @(
@{
    Name = "BulletStyle"
    Type = [string]
    ValidateSet = 'Simple','Numeric','NumericSquareMarker'
    Value = {  
        switch($_) {
          'Simple' { "simple-list" }
          'Numeric' { "numeric-list" }
          'NumericSquareMarker' { "numeric-list square-marker" }     
        } 
    } 
} 
@{
    Name = "IsLargeBullet"
    Type = [switch]
    Value = "large-bullet" 
}
@{
    Name = "ColorBullet"
    Type = [string]
    ValidateSet = 'Dark','Red','Green','Blue','Yellow'
    Value = { $_.ToString().ToLower() + "-bullet" } 
} 
)  | Invoke-Expression

# OrderedList

New-HtmlProxyCommand -Name New-MetroOrderedList -TargetCommandName New-HtmlOl -AddClassParameter @(
@{
    Name = "BulletStyle"
    Type = [string]
    ValidateSet = 'Simple','Numeric','NumericSquareMarker'
    Value = {  
        switch($_) {
          'Simple' { "simple-list" }
          'Numeric' { "numeric-list" }
          'NumericSquareMarker' { "numeric-list square-marker" }     
        } 
    } 
} 
@{
    Name = "IsLargeBullet"
    Type = [switch]
    Value = "large-bullet" 
}
@{
    Name = "ColorBullet"
    Type = [string]
    ValidateSet = 'Dark','Red','Green','Blue','Yellow'
    Value = { $_.ToString().ToLower() + "-bullet" } 
}
)  | Invoke-Expression

# StepList

New-HtmlProxyCommand -Name New-MetroStepList -TargetCommandName New-HtmlUl -AddClass "step-list" | Invoke-Expression
New-HtmlProxyCommand -Name New-MetroStepListItem -TargetCommandName New-HtmlLi | Invoke-Expression


# DefinitionList

New-HtmlProxyCommand -Name New-MetroDefinitionList -TargetCommandName New-HtmlDl -AddClassParameter @(
@{
    Name = "ListDirection"
    Type = [string]
    ValidateSet = 'Vertical','Horizontal'
    Value = { $_.ToLower() } 
}
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroDefinitionListNameItem -TargetCommandName New-HtmlLi  | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroDefinitionListValueItem -TargetCommandName New-HtmlLi | Invoke-Expression

# Tag

New-HtmlProxyCommand -Name New-MetroTag -TargetCommandName New-HtmlSpan -AddClass "tag" -AddClassParameter @(
@{
    Name = "TagType"
    Type = [ProfileColors]
    Mandatory = $true
    Value = { $_.ToString().ToLower() } 
}
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroAnchorTag -TargetCommandName New-HtmlA -AddClass "tag" -AddClassParameter @(
@{
    Name = "TagType"
    Type = [ProfileColors]
    Mandatory = $true
    Value = { $_.ToString().ToLower() } 
}
) | Invoke-Expression
