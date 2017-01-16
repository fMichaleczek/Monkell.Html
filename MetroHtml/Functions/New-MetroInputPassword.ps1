function New-MetroInputPassword {
 
[CmdletBinding()]
    param(
    [Parameter()]
    [ValidateSet("Normal", "Big")] 
    [System.String] 
    $Size = 'Normal', 

    [Parameter()]
    [System.Management.Automation.SwitchParameter] 
    $IsFullWidth, 

    [Parameter()]
    [MetroIcons] 
    $PrependIcon, 

    [Parameter()]
    [ValidateSet("Error", "Warning", "Success", "Required")] 
    [System.String] 
    $State, 

    [Parameter()]
    [System.Management.Automation.SwitchParameter] 
    $WithRevealer,

    [string]
    ${DefaultValue},

    [switch]
    ${IsDefaultChecked},

    [switch]
    ${IsChecked},

    [switch]
    ${IsIndeterminate},

    [switch]
    ${IsMultiple},

    [System.Nullable[datetime]]
    ${ValueAsDate},

    [double]
    ${ValueAsNumber},

    [string]
    ${FormAction},

    [string]
    ${FormEncType},

    [string]
    ${FormMethod},

    [switch]
    ${FormNoValidate},

    [string]
    ${FormTarget},

    [string]
    ${Accept},

    [string]
    ${AlternativeText},

    [string]
    ${Autocomplete},

    [string]
    ${Maximum},

    [string]
    ${Minimum},

    [string]
    ${Pattern},

    [string]
    ${Source},

    [string]
    ${Step},

    [string]
    ${UseMap},

    [int]
    ${DisplayWidth},

    [int]
    ${DisplayHeight},

    [switch]
    ${IsDirty},

    [string]
    ${DirectionName},

    [int]
    ${MaxLength},

    [int]
    ${MinLength},

    [string]
    ${Value},

    [string]
    ${Placeholder},

    [switch]
    ${IsRequired},

    [switch]
    ${IsReadOnly},

    [int]
    ${SelectionStart},

    [int]
    ${SelectionEnd},

    [string]
    ${Name},

    [switch]
    ${IsDisabled},

    [switch]
    ${Autofocus},

    [switch]
    ${IsHidden},

    [AngleSharp.Dom.Html.IHtmlMenuElement]
    ${ContextMenu},

    [switch]
    ${IsDraggable},

    [string]
    ${AccessKey},

    [string]
    ${Language},

    [string]
    ${Title},

    [string]
    ${Direction},

    [switch]
    ${IsSpellChecked},

    [int]
    ${TabIndex},

    [string]
    ${ContentEditable},

    [switch]
    ${IsTranslated},

    [string]
    ${Slot},

    [string]
    ${TextContent},

    [Alias('ClassName')]
    [string[]]
    ${Class},

    [string]
    ${Id},

    [switch]
    ${IsFocused},

    [AngleSharp.Url]
    ${BaseUrl},

    [string]
    ${NodeValue},

    [hashtable]
    ${Attributes},

    [Alias('CSS')]
    [hashtable]
    ${Style},

    [hashtable]
    ${Data},

    [Alias('AppendNode')]
    [System.Object]
    ${Append},

    [System.Object]
    ${Prepend},

    [Parameter(ParameterSetName='Remaining', ValueFromRemainingArguments=$true)]
    [System.Object]
    ${RemainingArguments}
    )
    
    begin {
            if ($PSBoundParameters.ContainsKey('RemainingArguments')) {
                foreach($RemainingArgument in $PSBoundParameters["RemainingArguments"]) {
                    if ($RemainingArgument -is [scriptblock]) {
                        $PSBoundParameters["Append"] = $RemainingArgument
                        $Append = $RemainingArgument
                    }  
                    elseif ($RemainingArgument -is [string]) {
                        $PSBoundParameters["TextContent"] += $RemainingArgument
                        $TextContent = $PSBoundParameters["TextContent"]
                    }
                    elseif ($null -ne $RemainingArgument) {
                        $PSBoundParameters["TextContent"] += $RemainingArgument.ToString()
                        $TextContent = $PSBoundParameters["TextContent"]
                    }
                }
                $null = $PSBoundParameters.Remove("RemainingArguments")
            }
      $PSBoundParametersKeys = $PSBoundParameters.Keys  
    $null = $PSBoundParameters.Remove("Class") 
    if ($Class.Count -gt 0) { $PSBoundParameters["ClassName"] = ($Class -join " ").Trim() } 
            $null = $PSBoundParameters.Remove('Size')  
 
            $null = $PSBoundParameters.Remove('IsFullWidth')  
 
            $null = $PSBoundParameters.Remove('PrependIcon')  
 
            $null = $PSBoundParameters.Remove('State')  
 
            $null = $PSBoundParameters.Remove('WithRevealer')  
 
            $PSBoundParameters["Type"] = $( 'password' ) 


	}

    process {


	}

    end {

   
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


	}

}
