function New-MetroIconButton {
 
[CmdletBinding()]
    param(
    [Parameter()]
    [MetroIcons] 
    $LayoutIcon,

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

    [Parameter(ParameterSetName='Remaining', ValueFromRemainingArguments=$true)]
    [System.Object]
    ${RemainingArguments}
    )
    
    begin {
      $PSBoundParametersKeys = $PSBoundParameters.Keys  
    $null = $PSBoundParameters.Remove("Class") 
    if ($Class.Count -gt 0) { $PSBoundParameters["ClassName"] = ($Class -join " ").Trim() } 
            $null = $PSBoundParameters.Remove('LayoutIcon')  
 
            $PSBoundParameters["Prepend"] = $( {
                if ($LayoutIcon) {
                    Html.Span -Class "mif-$LayoutIcon"
                }
            } ) 


    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('New-MetroButton', [System.Management.Automation.CommandTypes]::Function)
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
