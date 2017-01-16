function New-MetroImage {
 
[CmdletBinding()]
    param(
    [Parameter()]
    [ValidateSet("HD", "SD", "Square", "Diamond", "Cycle", "Bordered", "HandingAnimated")] 
    [System.String] 
    $Format, 

    [Parameter()]
    [System.String] 
    $OverlayText,

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
      $PSBoundParametersKeys = $PSBoundParameters.Keys  
    $null = $PSBoundParameters.Remove("Class") 
    if ($Class.Count -gt 0) { $PSBoundParameters["ClassName"] = ($Class -join " ").Trim() } 
            $null = $PSBoundParameters.Remove('Format')  
 
            $null = $PSBoundParameters.Remove('OverlayText')  


    foreach($RemainingArgument in $PSBoundParameters["RemainingArguments"]) {
        if ($RemainingArgument -is [scriptblock]) {
            $PSBoundParameters["Append"] = $RemainingArgument
        }
    }
    $null = $PSBoundParameters.Remove("RemainingArguments")
    
    if ($PSBoundParameters["Append"]) {
        $OverlayNodes = & $PSBoundParameters["Append"]
        $null = $PSBoundParameters.Remove("Append")
    }
    
    $null = $PSBoundParameters.Remove("Format")
    $null = $PSBoundParameters.Remove("OverlayText")
    
    $ImagePSBoundParameters = $PSBoundParameters
    
    $ImageData = @{}
    
    if ($Format) {
        $ImageData = @{ role = 'fitImage' }
        $ImageData += switch($Format) {
            'HD' { @{ format = "hd" } }
            'SD' { @{ format = "sd" } }
            'Square' { @{ format = "square" } }          
            'Diamond' { @{ format = "square" ; type = "diamond" } }
            'Cycle' { @{ format = "cycle" } }
            'Bordered' { @{ type = "bordered" } }
            'HandingAnimated' { @{ type = "handing-ani" } }
        }
    }
    
    if ($OverlayText -ne [string]::Empty) {
        $ImageData += @{ overlay = $OverlayText }
    }
    
    New-HtmlImg @ImagePSBoundParameters -Data $ImageData
    


	}

    process {


	}

    end {


	}

}
