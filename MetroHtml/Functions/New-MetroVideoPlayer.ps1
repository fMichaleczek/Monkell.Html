function New-MetroVideoPlayer {
 
[CmdletBinding()]
    param(
    [Parameter(, Mandatory=$true)]
    [System.String] 
    $Source, 

    [Parameter()]
    [System.String] 
    $MimeType = 'video/mp4', 

    [Parameter()]
    [ValidateSet("Window", "Screen")] 
    [System.String] 
    $FullScreenMode = 'Screen', 

    [Parameter()]
    [ValidateSet("True", "False")] 
    [System.String] 
    $Preload = 'True', 

    [Parameter()]
    [System.String] 
    $LogoUrl,

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
            $null = $PSBoundParameters.Remove('Source')  
 
            $null = $PSBoundParameters.Remove('MimeType')  
 
            $null = $PSBoundParameters.Remove('FullScreenMode')  
 
            $null = $PSBoundParameters.Remove('Preload')  
 
            $null = $PSBoundParameters.Remove('LogoUrl')  
 
            $PSBoundParameters["Data"] = $( @{
                'role' = 'video'
                'full-screen-mode' = $FullScreenMode.ToLower()
                'preload' = $Preload.ToLower()
                'logo' = $LogoUrl
            } ) 
 
            $PSBoundParameters["Class"] = 'video-player'  
 
            $PSBoundParameters["Append"] = $( {
                New-HtmlVideo {
                    New-HtmlSource -Source $Source -Type $MimeType
                }
            } ) 


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
