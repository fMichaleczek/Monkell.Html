function New-MetroInputCheckbox {
 
[CmdletBinding()]
    param(
    [Parameter()]
    [System.String] 
    $Caption, 

    [Parameter()]
    [ValidateSet("Normal", "Small")] 
    [System.String] 
    $Size = 'Normal', 

    [Parameter()]
    [System.Management.Automation.SwitchParameter] 
    $IsFullWidth,

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
            $null = $PSBoundParameters.Remove('Caption')  
 
            $null = $PSBoundParameters.Remove('Size')  
 
            $null = $PSBoundParameters.Remove('IsFullWidth')  
 
            $PSBoundParameters["Type"] = $( 'checkbox' ) 


	}

    process {


	}

    end {
 
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


	}

}
