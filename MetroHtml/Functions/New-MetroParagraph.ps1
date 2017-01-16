function New-MetroParagraph {
 
[CmdletBinding()]
    param(
    [ValidateSet("Default", "Accent", "Secondary", "Small", "Dashed")] 
    [System.String] 
    $TextStyle, 

    [ValidateSet("Left", "Center", "Right", "Justify")] 
    [System.String] 
    $TextAlign, 

    [ValidateSet("Top", "Bottom", "Middle", "Sub", "Super", "Top-Text", "Bottom-Text")] 
    [System.String] 
    $VerticalTextAlign, 

    [ValidateSet("Lowercase", "Uppercase", "Capital")] 
    [System.String] 
    $Transform, 

    [System.Management.Automation.SwitchParameter] 
    $IsIndent,

    [AngleSharp.Dom.HorizontalAlignment]
    ${Align},

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
      $PSBoundParameters.ClassName =  [string[]]@($PSBoundParameters.ClassName, 'cell')
 

      if ('TextStyle' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  "text-" + $TextStyle.ToLower()  ) )    
            $null = $PSBoundParameters.Remove('TextStyle') 
      } 
 

      if ('TextAlign' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  $TextAlign.ToLower()  ) )    
            $null = $PSBoundParameters.Remove('TextAlign') 
      } 
 

      if ('VerticalTextAlign' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  $VerticalTextAlign.ToLower()  ) )    
            $null = $PSBoundParameters.Remove('VerticalTextAlign') 
      } 
 

      if ('Transform' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  $Transform.ToLower()  ) )    
            $null = $PSBoundParameters.Remove('Transform') 
      } 
 

      if ('IsIndent' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'indent')    
            $null = $PSBoundParameters.Remove('IsIndent') 
      } 


    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('New-HtmlP', [System.Management.Automation.CommandTypes]::Function)
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
