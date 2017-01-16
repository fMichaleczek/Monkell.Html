function New-MetroBreadcrumbs {
 
[CmdletBinding()]
    param(
    [Parameter()]
    [ValidateSet("Normal", "Small", "Mini")] 
    [System.String] 
    $Size,

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


	}

    process {


	}

    end {


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
    


	}

}
