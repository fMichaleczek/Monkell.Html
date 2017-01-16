function New-MetroImageContainer {
 
[CmdletBinding()]
    param(
    [Parameter()]
    [ValidateSet("Rounded", "Bordered", "Polaroid", "Handing", "HandingAnimated")] 
    [System.String] 
    $ContainerType, 

    [Parameter()]
    [MetroPredefinedColors] 
    $ColorOverlay, 

    [Parameter()]
    [System.Management.Automation.SwitchParameter] 
    $IsSelected,

    [string]
    ${SourceSet},

    [string]
    ${Sizes},

    [string]
    ${Source},

    [string]
    ${AlternativeText},

    [string]
    ${CrossOrigin},

    [string]
    ${UseMap},

    [int]
    ${DisplayWidth},

    [int]
    ${DisplayHeight},

    [switch]
    ${IsMap},

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
            $null = $PSBoundParameters.Remove('ContainerType')  
 
            $null = $PSBoundParameters.Remove('ColorOverlay')  
 
            $null = $PSBoundParameters.Remove('IsSelected')  


	}

    process {


	}

    end {

    if ($PSBoundParameters["Append"]) {
        $OverlayNodes = & $PSBoundParameters["Append"]
        $null = $PSBoundParameters.Remove("Append")
    }
    $null = $PSBoundParameters.Remove("ContainerType")
    $null = $PSBoundParameters.Remove("ColorOverlay")
    $null = $PSBoundParameters.Remove("IsSelected")
    
    
    $ImagePSBoundParameters = $PSBoundParameters
    
    if ($ContainerType) {
        $ContainerTypeClass = switch($ContainerType) {
              'Rounded' { "rounded" }
              'Bordered' { "bordered" }
              'Polaroid' { "polaroid" }          
              'Handing' { "bordered handing image-format-hd" }
              'HandingAnimated' { "bordered handing ani image-format-hd" }
        }
    }
    
    if ($IsSelected) {
        $SelectedClass = 'element-selected'
    }
    
    if ($ColorOverlay) {
        $ColorOverlayClass = "op-" + $ColorOverlay.ToString().ToLower()
    }
    
    New-HtmlDiv -Class "image-container $ContainerTypeClass $SelectedClass" {
        New-HtmlDiv -Class 'frame' {
            New-HtmlImg @ImagePSBoundParameters
        }
        if ($null -ne $OverlayNodes) {
            New-HtmlDiv -Class "image-overlay $ColorOverlayClass" {
                $OverlayNodes
            }
        }
    }
    


	}

}
