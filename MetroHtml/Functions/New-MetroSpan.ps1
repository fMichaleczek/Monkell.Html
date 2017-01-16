function New-MetroSpan {
 
[CmdletBinding()]
    param(
    [ValidateSet("0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100")] 
    [System.String] 
    $Margin, 

    [System.Management.Automation.SwitchParameter] 
    $NoMargin, 

    [System.Management.Automation.SwitchParameter] 
    $NoMarginLeft, 

    [System.Management.Automation.SwitchParameter] 
    $NoMarginRight, 

    [System.Management.Automation.SwitchParameter] 
    $NoMarginTop, 

    [System.Management.Automation.SwitchParameter] 
    $NoMarginBottom, 

    [ValidateSet("0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100")] 
    [System.String] 
    $Padding, 

    [System.Management.Automation.SwitchParameter] 
    $NoPadding, 

    [System.Management.Automation.SwitchParameter] 
    $NoPaddingLeft, 

    [System.Management.Automation.SwitchParameter] 
    $NoPaddingRight, 

    [System.Management.Automation.SwitchParameter] 
    $NoPaddingTop, 

    [System.Management.Automation.SwitchParameter] 
    $NoPaddingBottom, 

    [ValidateSet("PlaceLeft", "PlaceRight", "NoFloat", "ClearFloat")] 
    [System.String] 
    $Floating, 

    [ValidateSet("Shadow", "BlockShadow", "BlockShadowImpact", "BottomShadow", "TextShadow", "BlockShadowSuccess", "BlockShadowInfo", "BlockShadowDanger", "BlockShadowError", "BlockShadowWarning")] 
    [System.String] 
    $Shadow, 

    [ValidateSet("45", "90", "135", "180", "225", "270", "360")] 
    [System.String] 
    $Rotate, 

    [System.Management.Automation.SwitchParameter] 
    $IsDebug, 

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

    [ValidateSet("Top", "Bottom", "Baseline", "Middle", "Sub", "Super", "TopText", "BottomText")] 
    [System.String] 
    $VerticalAlign,

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

      if ('Margin' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  "margin" + $Margin  ) )    
            $null = $PSBoundParameters.Remove('Margin') 
      } 
 

      if ('NoMargin' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-margin')    
            $null = $PSBoundParameters.Remove('NoMargin') 
      } 
 

      if ('NoMarginLeft' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-margin-left')    
            $null = $PSBoundParameters.Remove('NoMarginLeft') 
      } 
 

      if ('NoMarginRight' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-margin-right')    
            $null = $PSBoundParameters.Remove('NoMarginRight') 
      } 
 

      if ('NoMarginTop' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-margin-top')    
            $null = $PSBoundParameters.Remove('NoMarginTop') 
      } 
 

      if ('NoMarginBottom' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-margin-bottom')    
            $null = $PSBoundParameters.Remove('NoMarginBottom') 
      } 
 

      if ('Padding' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  "padding" + $Padding  ) )    
            $null = $PSBoundParameters.Remove('Padding') 
      } 
 

      if ('NoPadding' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-padding')    
            $null = $PSBoundParameters.Remove('NoPadding') 
      } 
 

      if ('NoPaddingLeft' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-padding-left')    
            $null = $PSBoundParameters.Remove('NoPaddingLeft') 
      } 
 

      if ('NoPaddingRight' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-padding-right')    
            $null = $PSBoundParameters.Remove('NoPaddingRight') 
      } 
 

      if ('NoPaddingTop' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-padding-top')    
            $null = $PSBoundParameters.Remove('NoPaddingTop') 
      } 
 

      if ('NoPaddingBottom' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-padding-bottom')    
            $null = $PSBoundParameters.Remove('NoPaddingBottom') 
      } 
 

      if ('Floating' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $( 
        switch($Floating) {
          'PlaceLeft' { 'place-left' }
          'PlaceRight' { 'place-right' }
          'NoFloat' { 'no-float' }
          'ClearFloat' { 'clear-float' }
        }
     ) )    
            $null = $PSBoundParameters.Remove('Floating') 
      } 
 

      if ('Shadow' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $( 
        switch($Shadow) {
          'Shadow' { 'shadow' }
          'TextShadow' { 'text-shadow' }
          'BottomShadow' { 'bottom-shadow' }
          'BlockShadow' { 'block-shadow' }
          'BlockShadowImpact' { 'block-shadow-impact' }
          'BlockShadowSuccess' { 'block-shadow-success' }
          'BlockShadowInfo' { 'block-shadow-info' }
          'BlockShadowDanger' { 'block-shadow-danger' }
          'BlockShadowError' { 'block-shadow-error' }
          'BlockShadowWarning' { 'block-shadow-warning' }
        }
     ) )    
            $null = $PSBoundParameters.Remove('Shadow') 
      } 
 

      if ('Rotate' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  "rotate" + $Rotate  ) )    
            $null = $PSBoundParameters.Remove('Rotate') 
      } 
 

      if ('IsDebug' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'debug')    
            $null = $PSBoundParameters.Remove('IsDebug') 
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
 

      if ('VerticalAlign' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(   
                switch($VerticalAlign) {
                  'Top' { 'v-align-top' }
                  'Bottom' { 'v-align-bottom' }
                  'Baseline' { 'v-align-baseline' }
                  'Middle' { 'v-align-middle' }
                  'Sub' { 'v-align-sub' }
                  'Super' { 'v-align-super' }
                  'TopText' { 'v-align-top-text' }
                  'BottomText' { 'v-align-bottom-text' }
                }
             ) )    
            $null = $PSBoundParameters.Remove('VerticalAlign') 
      } 


    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('New-HtmlSpan', [System.Management.Automation.CommandTypes]::Function)
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
