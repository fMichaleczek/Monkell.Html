function New-MetroAccordionItem {
 
[CmdletBinding()]
    param(
    [System.Management.Automation.SwitchParameter] 
    $IsActive, 

    [System.Management.Automation.SwitchParameter] 
    $IsDisabled, 

    [Parameter()]
    [System.String] 
    $LayoutTitle, 

    [Parameter()]
    [MetroIcons] 
    $LayoutIcon,

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
      $PSBoundParameters.ClassName =  [string[]]@($PSBoundParameters.ClassName, 'frame')
 

      if ('IsActive' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'active')    
            $null = $PSBoundParameters.Remove('IsActive') 
      } 
 

      if ('IsDisabled' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'disabled')    
            $null = $PSBoundParameters.Remove('IsDisabled') 
      } 
 
            $null = $PSBoundParameters.Remove('LayoutTitle')  
 
            $null = $PSBoundParameters.Remove('LayoutIcon')  


	}

    process {


	}

    end {

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


	}

}
