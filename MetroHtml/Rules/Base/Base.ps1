New-HtmlProxyCommand -Name New-MetroDiv -TargetCommandName New-HtmlDiv -AddClassParameter ( $HelperClassParameters + $ColorParameters) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroSpan -TargetCommandName New-HtmlSpan -AddClassParameter ( 
    $HelperClassParameters + $ColorParameters + @(
        @{
            Name = "VerticalAlign"
            ValidateSet = 'Top', 'Bottom', 'Baseline', 'Middle', 'Sub', 'Super', 'TopText', 'BottomText'
            Type = [string]
            Value = {  
                switch($_) {
                  'Top' { 'v-align-top' }
                  'Bottom' { 'v-align-bottom' }
                  'Baseline' { 'v-align-baseline' }
                  'Middle' { 'v-align-middle' }
                  'Sub' { 'v-align-sub' }
                  'Super' { 'v-align-super' }
                  'TopText' { 'v-align-top-text' }
                  'BottomText' { 'v-align-bottom-text' }
                }
            }
        }
    )
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroAnchor -TargetCommandName New-HtmlA  | Invoke-Expression