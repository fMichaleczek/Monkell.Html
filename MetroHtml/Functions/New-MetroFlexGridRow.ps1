function New-MetroFlexGridRow {
 
[CmdletBinding()]
    param(
    [ValidateSet("Default", "Auto")] 
    [System.String] 
    $CellSize, 

    [ValidateSet("Row", "RowReverse", "Column", "ColumnReverse")] 
    [System.String] 
    $FlexDirection, 

    [ValidateSet("Start", "Center", "End", "SpaceAround", "SpaceBetween")] 
    [System.String] 
    $Justify, 

    [ValidateSet("Wrap", "WrapReverse", "NoWrap")] 
    [System.String] 
    $Wrap, 

    [ValidateSet("Stretch", "Start", "End", "Center", "Base")] 
    [System.String] 
    $Align, 

    [ValidateSet("Stretch", "Start", "End", "Center", "SpaceAround", "SpaceBetween")] 
    [System.String] 
    $Content, 

    [ValidateSet("Auto", "Start", "End", "Center", "Base", "Stretch")] 
    [System.String] 
    $Self, 

    [System.Management.Automation.SwitchParameter] 
    $NoShrink, 

    [System.Management.Automation.SwitchParameter] 
    $NoGrow,

    [ValidateSet('0','10','20','30','40','50','60','70','80','90','100')]
    [string]
    ${Margin},

    [switch]
    ${NoMargin},

    [switch]
    ${NoMarginLeft},

    [switch]
    ${NoMarginRight},

    [switch]
    ${NoMarginTop},

    [switch]
    ${NoMarginBottom},

    [ValidateSet('0','10','20','30','40','50','60','70','80','90','100')]
    [string]
    ${Padding},

    [switch]
    ${NoPadding},

    [switch]
    ${NoPaddingLeft},

    [switch]
    ${NoPaddingRight},

    [switch]
    ${NoPaddingTop},

    [switch]
    ${NoPaddingBottom},

    [ValidateSet('PlaceLeft','PlaceRight','NoFloat','ClearFloat')]
    [string]
    ${Floating},

    [ValidateSet('Shadow','BlockShadow','BlockShadowImpact','BottomShadow','TextShadow','BlockShadowSuccess','BlockShadowInfo','BlockShadowDanger','BlockShadowError','BlockShadowWarning')]
    [string]
    ${Shadow},

    [ValidateSet('45','90','135','180','225','270','360')]
    [string]
    ${Rotate},

    [switch]
    ${IsDebug},

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
      $PSBoundParameters.ClassName =  [string[]]@($PSBoundParameters.ClassName, 'row')
 

      if ('CellSize' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $( 
        switch($CellSize) {
          'Default' { $null }
          'Auto' { "cell-auto-size" }
        }
     ) )    
            $null = $PSBoundParameters.Remove('CellSize') 
      } 
 

      if ('FlexDirection' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $( 
        switch($FlexDirection) {
          'Row' { 'flex-dir-row' }
          'RowReverse' { "flex-dir-row-reverse" }
          'Column' { "flex-dir-column" }
          'ColumnReverse' { "flex-dir-column-reverse" }
        }
     ) )    
            $null = $PSBoundParameters.Remove('FlexDirection') 
      } 
 

      if ('Justify' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
       switch($Justify) {
          'Start' { "flex-just-start" }
          'Center' { "flex-just-center" }
          'End' { "flex-just-end" }          
          'SpaceAround' { "flex-just-sa" }
          'SpaceBetween' { "flex-just-sb" }
        }
     ) )    
            $null = $PSBoundParameters.Remove('Justify') 
      } 
 

      if ('Wrap' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
       switch($Wrap) {
          'Wrap' { "flex-wrap" }
          'WrapReverse' { "flex-wrap-reverse" }
          'NoWrap' { "flex-no-wrap" }   
        }
     ) )    
            $null = $PSBoundParameters.Remove('Wrap') 
      } 
 

      if ('Align' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
       switch($Align) {
          'Stretch' { "flex-align-stretch" }
          'Start' { "flex-align-start" }
          'End' { "flex-align-end" }          
          'Center' { "flex-align-center" }
          'Base' { "flex-align-base" }
        }
     ) )    
            $null = $PSBoundParameters.Remove('Align') 
      } 
 

      if ('Content' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
       switch($Content) {
          'Stretch' { "flex-content-stretch" }
          'Start' { "flex-content-start" }
          'End' { "flex-content-end" }          
          'Center' { "flex-content-center" }
          'SpaceAround' { "flex-content-sa" }
          'SpaceBetween' { "flex-content-sb" }
        }
     ) )    
            $null = $PSBoundParameters.Remove('Content') 
      } 
 

      if ('Self' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
       switch($Self) {
          'Auto' { "flex-self-auto" }
          'Start' { "flex-self-start" }
          'End' { "flex-self-end" }          
          'Center' { "flex-self-center" }
          'Base' { "flex-self-base" }
          'Stretch' { "flex-self-stretch" }
        }
     ) )    
            $null = $PSBoundParameters.Remove('Self') 
      } 
 

      if ('NoShrink' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-shrink')    
            $null = $PSBoundParameters.Remove('NoShrink') 
      } 
 

      if ('NoGrow' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'no-grow')    
            $null = $PSBoundParameters.Remove('NoGrow') 
      } 


    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('New-MetroDiv', [System.Management.Automation.CommandTypes]::Function)
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
