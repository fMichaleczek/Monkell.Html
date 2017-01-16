function New-MetroInputButton {
 
[CmdletBinding()]
    param(


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

    [int]
    ${Size},

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
      $PSBoundParametersKeys = $PSBoundParameters.Keys  
    $null = $PSBoundParameters.Remove("Class") 
    if ($Class.Count -gt 0) { $PSBoundParameters["ClassName"] = ($Class -join " ").Trim() } 
            $PSBoundParameters["Type"] = $( 'button' ) 


    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('New-HtmlInput', [System.Management.Automation.CommandTypes]::Function)
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
