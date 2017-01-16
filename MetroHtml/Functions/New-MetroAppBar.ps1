function New-MetroAppBar {
 
[CmdletBinding()]
    param(
    [System.Management.Automation.SwitchParameter] 
    $IsDropUp, 

    [ValidateSet("Top", "Bottom")] 
    [System.String] 
    $Fixed, 

    [ValidateSet("Darcula", "Pink", "Navy", "Red", "Green", "Orange")] 
    [System.String] 
    $ColorScheme, 

    [System.String] 
    $FlexClass,

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
      $PSBoundParameters.ClassName =  [string[]]@($PSBoundParameters.ClassName, 'app-bar')
 
        $PSBoundParameters.Data =  $PSBoundParameters.Data +  @{'role'='appbar';}
 

      if ('IsDropUp' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'drop-up')    
            $null = $PSBoundParameters.Remove('IsDropUp') 
      } 
 

      if ('Fixed' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $( 
            switch($Fixed) {
              'Top' { 'fixed-top' }
              'Bottom' { 'fixed-bottom' }
            }
         ) )    
            $null = $PSBoundParameters.Remove('Fixed') 
      } 
 

      if ('ColorScheme' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  $ColorScheme.ToLower()  ) )    
            $null = $PSBoundParameters.Remove('ColorScheme') 
      } 
 
      if ('FlexClass' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["Data"] = $PSBoundParameters["Data"] + $(  
            @{ flexstyle = "$FlexClass" }
         )    
            $null = $PSBoundParameters.Remove('FlexClass') 
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
