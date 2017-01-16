function New-MetroDropdownButton {
 
[CmdletBinding()]
    param(
    [Parameter()]
    [ValidateSet("Left", "Right")] 
    [System.String] 
    $Position = 'Left',

    [ValidateSet('Rounded','Cycle','Square')]
    [string]
    ${ButtonStyle},

    [ValidateSet('Mini','Small','Large')]
    [string]
    ${Size},

    [switch]
    ${BlockShadow},

    [switch]
    ${TextShadow},

    [ValidateSet('Pulse','PulseLighten','Cube','CubeLighten')]
    [string]
    ${LoadingLogo},

    [switch]
    ${Disabled},

    [ProfileColors]
    ${ProfileColor},

    [MetroPredefinedColors]
    ${ForegroundColor},

    [MetroPredefinedColors]
    ${BackgroundColor},

    [MetroPredefinedColors]
    ${HoverForegroundColor},

    [MetroPredefinedColors]
    ${HoverBackgroundColor},

    [MetroPredefinedColors]
    ${ActiveForegroundColor},

    [MetroPredefinedColors]
    ${ActiveBackgroundColor},

    [MetroPredefinedColors]
    ${RibbedBackgroundColor},

    [string]
    ${Type},

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
    ${Value},

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
            $null = $PSBoundParameters.Remove('Position')  


	}

    process {


	}

    end {


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
    


	}

}
