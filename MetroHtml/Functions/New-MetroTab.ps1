function New-MetroTab {
 
[CmdletBinding()]
    param(
    [ValidateSet("Dark", "Light")] 
    [System.String] 
    $TabStyle = 'Dark', 

    [ValidateSet("Top", "Bottom")] 
    [System.String] 
    $Position = 'Top', 

    [System.String] 
    $OpenTabId, 

    [System.Management.Automation.SwitchParameter] 
    $EnableSaveState, 

    [System.Management.Automation.SwitchParameter] 
    $OnTabClick, 

    [System.Management.Automation.SwitchParameter] 
    $OnTabChange,

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
            if ($PSBoundParameters.ContainsKey('RemainingArguments')) {
                foreach($RemainingArgument in $PSBoundParameters["RemainingArguments"]) {
                    if ($RemainingArgument -is [scriptblock]) {
                        $PSBoundParameters["Append"] = $RemainingArgument
                        $Append = $RemainingArgument
                    }  
                    elseif ($RemainingArgument -is [string]) {
                        $PSBoundParameters["TextContent"] += $RemainingArgument
                        $TextContent = $PSBoundParameters["TextContent"]
                    }
                    elseif ($null -ne $RemainingArgument) {
                        $PSBoundParameters["TextContent"] += $RemainingArgument.ToString()
                        $TextContent = $PSBoundParameters["TextContent"]
                    }
                }
                $null = $PSBoundParameters.Remove("RemainingArguments")
            }
      $PSBoundParametersKeys = $PSBoundParameters.Keys  
    $null = $PSBoundParameters.Remove("Class") 
    if ($Class.Count -gt 0) { $PSBoundParameters["ClassName"] = ($Class -join " ").Trim() } 
        $PSBoundParameters.Data =  $PSBoundParameters.Data +  @{'role'='tabcontrol';}
 

      if ('TabStyle' -in $PSBoundParametersKeys -or $TabStyle -ne [string]::empty ) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
            switch($TabStyle) {
              'Dark' { 'tabcontrol' }
              'Light' { 'tabcontrol2' }   
            } 
         ) )    
            $null = $PSBoundParameters.Remove('TabStyle') 
      } 
 

      if ('Position' -in $PSBoundParametersKeys -or $Position -ne [string]::empty ) { 
            $PSBoundParameters["ClassName"] = [string[]]@($PSBoundParameters["ClassName"], $(  
            switch($Position) {
              'Top' { 'tabs-top' }
              'Bottom' { 'tabs-bottom' }   
            } 
         ) )    
            $null = $PSBoundParameters.Remove('Position') 
      } 
 
      if ('OpenTabId' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["Data"] = $PSBoundParameters["Data"] + $(  
            @{ 'open-target' = "$OpenTabId" }
         )    
            $null = $PSBoundParameters.Remove('OpenTabId') 
      } 
 
      if ('EnableSaveState' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["Data"] = $PSBoundParameters["Data"] + $(  
            @{ 'save-state' = 'true' }
         )    
            $null = $PSBoundParameters.Remove('EnableSaveState') 
      } 
 
      if ('OnTabClick' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["Data"] = $PSBoundParameters["Data"] + $(  
            @{ 'on-tab-click' = "$OnTabClick" }
         )    
            $null = $PSBoundParameters.Remove('OnTabClick') 
      } 
 
      if ('OnTabChange' -in $PSBoundParametersKeys) { 
            $PSBoundParameters["Data"] = $PSBoundParameters["Data"] + $(  
            @{ 'on-tab-change' = "$OnTabChange" }
         )    
            $null = $PSBoundParameters.Remove('OnTabChange') 
      } 


	}

    process {


	}

    end {

    $null = $PSBoundParameters.Remove("Append")
    
    $TabControl = New-HtmlDiv @PSBoundParameters
    $Tabs = New-HtmlUl -Class "tabs"
    $Frames = New-HtmlDiv -Class "frames"
    
    $TabItemAppend = @( & $Append )
    
    $TabGuid = "Tab" + [Guid]::NewGuid().ToString() + "-frame"
    $i = 0
    foreach ($Node in $TabItemAppend) {
        $Anchor = $Node[0]
        $Anchor.Href = "#" + $TabGuid + "$i"
        $ListItem = New-HtmlLi -Append { $Anchor }
        
        $Frame = $Node[1]
        $Frame.Id = $TabGuid + "$i"
        
        $null = $Tabs.Append($ListItem)
        $null = $Frames.Append($Frame)
        $i++
    }
    
    if ($Position -eq "Top") {
        $null = $TabControl.Append($Tabs)
        $null = $TabControl.Append($Frames)
    }
    else {
        $null = $TabControl.Append($Frames)
        $null = $TabControl.Append($Tabs)
    }
    
    $TabControl
    


	}

}
