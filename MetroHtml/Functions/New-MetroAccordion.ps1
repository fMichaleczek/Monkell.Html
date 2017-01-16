function New-MetroAccordion {
 
[CmdletBinding()]
    param(
    [System.Management.Automation.SwitchParameter] 
    $IsLargeHeading, 

    [System.Management.Automation.SwitchParameter] 
    $IsCollapsible, 

    [System.String] 
    $OnFrameOpen, 

    [System.String] 
    $OnFrameOpened, 

    [System.String] 
    $OnFrameClosed,

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
      $PSBoundParameters.ClassName =  [string[]]@($PSBoundParameters.ClassName, 'accordion')
 
        $PSBoundParameters.Data =  $PSBoundParameters.Data +  @{'role'='accordion';}
 

      if ('IsLargeHeading' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'large-heading')    
            $null = $PSBoundParameters.Remove('IsLargeHeading') 
      } 
 
      if ('IsCollapsible' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["Data"] = $PSBoundParameters["Data"] + $(   
            @{ 'close-any' = 'true' }
         )    
            $null = $PSBoundParameters.Remove('IsCollapsible') 
      } 
 
      if ('OnFrameOpen' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["Data"] = $PSBoundParameters["Data"] + $(   
            @{ 'on-frame-open' = "$OnFrameOpen" }
         )    
            $null = $PSBoundParameters.Remove('OnFrameOpen') 
      } 
 
      if ('OnFrameOpened' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["Data"] = $PSBoundParameters["Data"] + $(   
            @{ 'on-frame-opened' = "$OnFrameOpened" }
         )    
            $null = $PSBoundParameters.Remove('OnFrameOpened') 
      } 
 
      if ('OnFrameClosed' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["Data"] = $PSBoundParameters["Data"] + $(   
            @{ 'on-frame-closed' = "$OnFrameClosed" }
         )    
            $null = $PSBoundParameters.Remove('OnFrameClosed') 
      } 


    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('New-HtmlDiv', [System.Management.Automation.CommandTypes]::Function)
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
