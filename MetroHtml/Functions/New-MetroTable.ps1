function New-MetroTable {
 
[CmdletBinding()]
    param(
    [System.Management.Automation.SwitchParameter] 
    $IsStriped, 

    [System.Management.Automation.SwitchParameter] 
    $IsBorder, 

    [System.Management.Automation.SwitchParameter] 
    $IsBordered, 

    [System.Management.Automation.SwitchParameter] 
    $IsHovered, 

    [System.Management.Automation.SwitchParameter] 
    $IsCellHovered, 

    [ValidateSet("Left", "Right")] 
    [System.String] 
    $SortablePosition, 

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

    [AngleSharp.Dom.Html.IHtmlTableCaptionElement]
    ${Caption},

    [AngleSharp.Dom.Html.IHtmlTableSectionElement]
    ${Head},

    [AngleSharp.Dom.Html.IHtmlTableSectionElement]
    ${Foot},

    [AngleSharp.Dom.HorizontalAlignment]
    ${Align},

    [string]
    ${BgColor},

    [uint32]
    ${Border},

    [int]
    ${CellPadding},

    [int]
    ${CellSpacing},

    [AngleSharp.Dom.Html.TableFrames]
    ${Frame},

    [AngleSharp.Dom.Html.TableRules]
    ${Rules},

    [string]
    ${Summary},

    [string]
    ${Width},

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
      $PSBoundParameters.ClassName =  [string[]]@($PSBoundParameters.ClassName, 'table')
 

      if ('IsStriped' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'striped')    
            $null = $PSBoundParameters.Remove('IsStriped') 
      } 
 

      if ('IsBorder' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'border')    
            $null = $PSBoundParameters.Remove('IsBorder') 
      } 
 

      if ('IsBordered' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'bordered')    
            $null = $PSBoundParameters.Remove('IsBordered') 
      } 
 

      if ('IsHovered' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'hovered')    
            $null = $PSBoundParameters.Remove('IsHovered') 
      } 
 

      if ('IsCellHovered' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'cell-hovered')    
            $null = $PSBoundParameters.Remove('IsCellHovered') 
      } 
 

      if ('SortablePosition' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
            switch($SortablePosition) {
              'Left' { "sortable-markers-on-left" }
              'Right' { $null }   
            } 
         ) )    
            $null = $PSBoundParameters.Remove('SortablePosition') 
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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('New-HtmlTable', [System.Management.Automation.CommandTypes]::Function)
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
