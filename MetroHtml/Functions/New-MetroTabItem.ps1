function New-MetroTabItem {
 
[CmdletBinding()]
    param(
    [System.Management.Automation.SwitchParameter] 
    $IsActive, 

    [System.Management.Automation.SwitchParameter] 
    $IsDisabled, 

    [Parameter()]
    [System.String] 
    $LayoutTitle,

    [string]
    ${Charset},

    [string]
    ${Name},

    [string]
    ${Text},

    [string]
    ${Download},

    [string]
    ${Href},

    [string]
    ${Hash},

    [string]
    ${HtmlHost},

    [string]
    ${HostName},

    [string]
    ${PathName},

    [string]
    ${Port},

    [string]
    ${Protocol},

    [string]
    ${UserName},

    [string]
    ${Password},

    [string]
    ${Search},

    [string]
    ${TargetLanguage},

    [string]
    ${Media},

    [string]
    ${Relation},

    [string]
    ${Target},

    [string]
    ${Type},

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

      if ('IsActive' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'active')    
            $null = $PSBoundParameters.Remove('IsActive') 
      } 
 

      if ('IsDisabled' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'disabled')    
            $null = $PSBoundParameters.Remove('IsDisabled') 
      } 
 
            $null = $PSBoundParameters.Remove('LayoutTitle')  


	}

    process {


	}

    end {

    $null = $PSBoundParameters.Remove("Append")
    $null = $PSBoundParameters.Remove("LayoutTitle")
    $PSBoundParameters.TextContent = $LayoutTitle
    
    $Anchor = New-HtmlA @PSBoundParameters
    $Div = New-HtmlDiv -Class frame -Append $Append
    
    Write-Output @(,@($Anchor, $Div))
    


	}

}
