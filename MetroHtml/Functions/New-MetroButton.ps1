function New-MetroButton {
 
[CmdletBinding()]
    param(
    [ValidateSet("Rounded", "Cycle", "Square")] 
    [System.String] 
    $ButtonStyle, 

    [ValidateSet("Mini", "Small", "Large")] 
    [System.String] 
    $Size, 

    [System.Management.Automation.SwitchParameter] 
    $BlockShadow, 

    [System.Management.Automation.SwitchParameter] 
    $TextShadow, 

    [ValidateSet("Pulse", "PulseLighten", "Cube", "CubeLighten")] 
    [System.String] 
    $LoadingLogo, 

    [System.Management.Automation.SwitchParameter] 
    $Disabled, 

    [ProfileColors] 
    $ProfileColor, 

    [MetroPredefinedColors] 
    $ForegroundColor, 

    [MetroPredefinedColors] 
    $BackgroundColor, 

    [MetroPredefinedColors] 
    $HoverForegroundColor, 

    [MetroPredefinedColors] 
    $HoverBackgroundColor, 

    [MetroPredefinedColors] 
    $ActiveForegroundColor, 

    [MetroPredefinedColors] 
    $ActiveBackgroundColor, 

    [MetroPredefinedColors] 
    $RibbedBackgroundColor,

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
      $PSBoundParametersKeys = $PSBoundParameters.Keys  
    $null = $PSBoundParameters.Remove("Class") 
    if ($Class.Count -gt 0) { $PSBoundParameters["ClassName"] = ($Class -join " ").Trim() } 
      $PSBoundParameters.ClassName =  [string[]]@($PSBoundParameters.ClassName, 'button')
 

      if ('ButtonStyle' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
            switch($ButtonStyle) {
              'Rounded' { 'rounded' }
              'Cycle' { 'cycle-button' } 
              'Square' { 'square-button' }
            } 
         ) )    
            $null = $PSBoundParameters.Remove('ButtonStyle') 
      } 
 

      if ('Size' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
            $Size.ToLower() + '-button'
         ) )    
            $null = $PSBoundParameters.Remove('Size') 
      } 
 

      if ('BlockShadow' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'block-shadow')    
            $null = $PSBoundParameters.Remove('BlockShadow') 
      } 
 

      if ('TextShadow' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'text-shadow')    
            $null = $PSBoundParameters.Remove('TextShadow') 
      } 
 

      if ('LoadingLogo' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
            switch($LoadingLogo) {
              'Pulse' { 'loading-pulse' }
              'PulseLighten' { 'loading-pulse lighten' } 
              'Cube' { 'loading-cube' }
              'CubeLighten' { 'loading-cube lighten' }
            } 
         ) )    
            $null = $PSBoundParameters.Remove('LoadingLogo') 
      } 
 

      if ('Disabled' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'disabled')    
            $null = $PSBoundParameters.Remove('Disabled') 
      } 
 

      if ('ProfileColor' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
            $ProfileColor.ToString().ToLower() 
         ) )    
            $null = $PSBoundParameters.Remove('ProfileColor') 
      } 
 

      if ('ForegroundColor' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  'fg-' + $ForegroundColor.ToString().ToLower()  ) )    
            $null = $PSBoundParameters.Remove('ForegroundColor') 
      } 
 

      if ('BackgroundColor' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  'bg-' + $BackgroundColor.ToString().ToLower()  ) )    
            $null = $PSBoundParameters.Remove('BackgroundColor') 
      } 
 

      if ('HoverForegroundColor' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  'fg-hover-' + $HoverForegroundColor.ToString().ToLower()  ) )    
            $null = $PSBoundParameters.Remove('HoverForegroundColor') 
      } 
 

      if ('HoverBackgroundColor' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  'bg-hover-' + $HoverBackgroundColor.ToString().ToLower()  ) )    
            $null = $PSBoundParameters.Remove('HoverBackgroundColor') 
      } 
 

      if ('ActiveForegroundColor' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  'fg-active-' + $ActiveForegroundColor.ToString().ToLower()  ) )    
            $null = $PSBoundParameters.Remove('ActiveForegroundColor') 
      } 
 

      if ('ActiveBackgroundColor' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  'bg-active-' + $ActiveBackgroundColor.ToString().ToLower()  ) )    
            $null = $PSBoundParameters.Remove('ActiveBackgroundColor') 
      } 
 

      if ('RibbedBackgroundColor' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  'ribbed-' + $RibbedBackgroundColor.ToString().ToLower()  ) )    
            $null = $PSBoundParameters.Remove('RibbedBackgroundColor') 
      } 


    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('New-HtmlButton', [System.Management.Automation.CommandTypes]::Function)
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
