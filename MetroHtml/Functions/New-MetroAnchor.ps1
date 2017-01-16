function New-MetroAnchor {
 
[CmdletBinding()]
    param(


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
      $PSBoundParametersKeys = $PSBoundParameters.Keys  
    $null = $PSBoundParameters.Remove("Class") 
    if ($Class.Count -gt 0) { $PSBoundParameters["ClassName"] = ($Class -join " ").Trim() }

    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('New-HtmlA', [System.Management.Automation.CommandTypes]::Function)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline()
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }


	}

    process {

    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }


	}

    end {

    try {
        $steppablePipeline.End()
    } catch {
        throw
    }


	}

}
