function New-MetroTableHeaderCell {
 
[CmdletBinding()]
    param(
    [System.Management.Automation.SwitchParameter] 
    $IsSortable, 

    [ValidateSet("Ascending", "Descending")] 
    [System.String] 
    $SortOrder, 

    [ValidateSet("Top", "Bottom", "Baseline", "Middle", "Sub", "Super", "TopText", "BottomText")] 
    [System.String] 
    $VerticalAlign, 

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

    [AngleSharp.Dom.HorizontalAlignment]
    ${Align},

    [AngleSharp.Dom.VerticalAlignment]
    ${VAlign},

    [string]
    ${BgColor},

    [string]
    ${Width},

    [string]
    ${Height},

    [int]
    ${ColumnSpan},

    [int]
    ${RowSpan},

    [switch]
    ${NoWrap},

    [string]
    ${Abbr},

    [string]
    ${Scope},

    [string]
    ${Axis},

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

      if ('IsSortable' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], 'sortable-column')    
            $null = $PSBoundParameters.Remove('IsSortable') 
      } 
 

      if ('SortOrder' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
            switch($SortOrder) {
              'Ascending' { "sort-asc" }
              'Descending' { "sort-desc" }   
            } 
         ) )    
            $null = $PSBoundParameters.Remove('SortOrder') 
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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('New-HtmlTh', [System.Management.Automation.CommandTypes]::Function)
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
