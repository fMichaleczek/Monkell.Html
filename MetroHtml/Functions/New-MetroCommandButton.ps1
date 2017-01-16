function New-MetroCommandButton {
 
[CmdletBinding()]
    param(
    [ValidateSet("Right", "Left")] 
    [System.String] 
    $LayoutIconAlign = 'Left', 

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

    [Parameter()]
    [System.String] 
    $LayoutTitle, 

    [Parameter()]
    [System.String] 
    $LayoutDescription, 

    [Parameter(, Mandatory=$true)]
    [MetroIcons] 
    $LayoutIcon,

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
      $PSBoundParameters.ClassName =  [string[]]@($PSBoundParameters.ClassName, 'command-button')
 

      if ('LayoutIconAlign' -in $PSBoundParametersKeys -or $LayoutIconAlign -ne [string]::empty ) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
            'icon-' + $LayoutIconAlign.ToLower()
         ) )    
            $null = $PSBoundParameters.Remove('LayoutIconAlign') 
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
 
            $null = $PSBoundParameters.Remove('LayoutTitle')  
 
            $null = $PSBoundParameters.Remove('LayoutDescription')  
 
            $null = $PSBoundParameters.Remove('LayoutIcon')  
 
            $PSBoundParameters["Append"] = $( {
            New-HtmlSpan -Class "icon mif-$($LayoutIcon.ToString())"
            New-HtmlText -Text $LayoutTitle
            New-HtmlSmall -TextContent $LayoutDescription
        } ) 


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
