﻿Add-Type -Path "$PSScriptRoot\AngleSharp.dll"

# Invoke-WebPageParser -url "https://en.wikipedia.org/wiki/List_of_The_Big_Bang_Theory_episodes" -selector "tr.vevent td:nth-child(3)"
# Invoke-WebPageParser -url http://www.powershellmagazine.com/ -Selector "div.content-loop div.post h2 a" | select TextContent, href

function Get-HtmlTag {
    $Tags = @()
    $Type = [AngleSharp.Configuration].Assembly.GetType("AngleSharp.Html.TagNames")
    $Members = $Type.GetMembers([System.Reflection.BindingFlags]'Public,Static').Where({ $_.Name -notlike "All*" })
    foreach($Member in $Members) {
        $Tags += [pscustomobject]@{
            Name = $Member.Name
            Value = $Member.GetValue($null)
        }
    }
    $Tags | Sort Name
}

function Get-HtmlTagType {
    Param(
        [Parameter(Mandatory=$true)]
        [Alias('Tag','Name')]
        [string]
        $TagName
    )
    $script:HtmlDocument.CreateElement($TagName).GetType()
}

function Invoke-WebParser {
     [CmdletBinding(DefaultParameterSetName='Html')]
    Param(
        [Parameter(ParameterSetName='Html',Mandatory=$true,Position=0)]
        [string]
        $Html,
    
        [Parameter(ParameterSetName='Url',Mandatory=$true,Position=0)]
        [string]
        $Url,
        
        [Parameter(Position=1)]
        [Alias('Selector')]
        [string]
        $CssSelector
    )
    
    if ($PSCmdlet.ParameterSetName -eq 'Html') {
        $HtmlParser = [AngleSharp.Parser.Html.HtmlParser]::new()
        $HtmlDocument = $HtmlParser.Parse($Html)
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'Url') {
        
        $DefaultConfiguration = [AngleSharp.Configuration]::Default
        $Configuration = [AngleSharp.ConfigurationExtensions]::WithDefaultLoader($DefaultConfiguration)
        
        $BrowsingContext = [AngleSharp.BrowsingContext]::New.Invoke($Configuration)
        
        $Task = [AngleSharp.BrowsingContextExtensions]::OpenAsync($BrowsingContext, $Url)
        $Task.Wait()
        $HtmlDocument = $Task.Result
    } 
    
    if ($CssSelector) {
        $HtmlDocument.QuerySelectorAll($CssSelector)
    }
    else {
        $HtmlDocument
    }
}
        
function New-HtmlDocument {
    [CmdletBinding()]
    Param(
        [Parameter()]
        [Alias('Append')]
        [scriptblock]
        $AppendNode
    )
    $Document = $script:HtmlDocument.Clone()
    if ($AppendNode -ne $null) { 
        $Nodes = @( & $AppendNode )
        if ($Nodes.Count -gt 0) { 
            foreach ($Node in $Nodes) { 
                if ($Node.GetType().FullName -eq 'AngleSharp.Dom.Html.HtmlHeadElement') {
                    Write-Verbose "New-HtmlDocument - Add Head Attribute"
                    foreach ($attribute in $Node.Attributes) {
                        [void] $Document.Head.SetAttribute($Attribute.Name, $Attribute.Value)
                    }
                    Write-Verbose "New-HtmlDocument - Append Head Nodes"
                    [void] $Document.Head.Append($Node.ChildNodes)
                }
                elseif ($Node.GetType().FullName -eq 'AngleSharp.Dom.Html.HtmlBodyElement') {
                    Write-Verbose "New-HtmlDocument - Add Body Attribute"
                    foreach ($attribute in $Node.Attributes) {
                        [void] $Document.Body.SetAttribute($Attribute.Name, $Attribute.Value)
                    }
                    Write-Verbose "New-HtmlDocument - Append Body Nodes"
                    [void] $Document.Body.Append($Node.ChildNodes)
                }
                else {
                    Write-Warning "HtmlDocument can only append Head and Body Element"
                }
            }
        }
    }
    $Document | Add-Member -MemberType ScriptMethod -Name ToFlatHtml -Value   { $this.ToHtml([AngleSharp.Html.HtmlMarkupFormatter]::Instance) }
    $Document | Add-Member -MemberType ScriptMethod -Name ToPrettyHtml -Value { $this.ToHtml([AngleSharp.Html.PrettyMarkupFormatter]::new())  }
    $Document
}

function New-HtmlPage {
    Param(
        [Parameter()]
        [string] $Title,

        [Parameter()]
        [string] $Description,

        [Parameter()]
        [string] $Author,

        [Parameter()]
        [string[]] $Keywords,

        [Parameter()]
        [string] $Language = '',

        [Parameter()]
        [string] $Charset = "UTF-8",

        [Parameter()]
        [string[]] $Stylesheet,

        [Parameter()]
        [string[]] $StylesheetMedia,

        [Parameter()]
        [string[]] $Javascript,

        [Parameter()]
        [string[]] $JavascriptInline,

        [Parameter()]
        [hashtable] $Css,
        
        [Parameter()]
        [string[]] $BodyClass,
        
        [Parameter()]
        [hashtable] $BodyStyle,

        [Parameter()]
        [string] $BaseUrl,

        # [Parameter()]
        # [string] $Font,

        # [Parameter()]
        # [string] $TypographySet,

        [Parameter()]
        [Alias('Append')]
        [scriptblock]
        $AppendNode,
        
        [Parameter()]
        [switch] $AsHtml,
        
        [Parameter()]
        [switch] $AsPrettyHtml,

        [Parameter()]
        [switch] $AsBrowser,

        [Parameter(ParameterSetName="Standard",ValueFromRemainingArguments=$true)]
        $RemainingArguments
    )
    Begin {
        foreach($RemainingArgument in $PSBoundParameters.RemainingArguments) {
            if ($RemainingArgument -is [scriptblock]) {
                $PSBoundParameters.AppendNode = $RemainingArgument
                $AppendNode = $RemainingArgument
            }
        }
        $PSBoundParameters.Remove("RemainingArguments") | Out-Null
    }
    
    Process {
       $PageTitle = $Title
       $PageBaseUrl = $BaseUrl
       $PageAppendNode = $AppendNode
       
       $Document = Html.Document {
            Html.Head -Language $Language {
                Html.Meta -Charset $Charset
                Html.Meta -HttpEquivalent "X-UA-Compatible" -Content "IE=edge"
                Html.Meta -Name "viewport" -Content "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
                Html.Meta -Name "description" -Content $Description
                Html.Meta -Name "author"  -Content $Author
                Html.Meta -Name "keywords"  -Content ( $Keywords -join ", " )
                Html.Title -Text $PageTitle
                $Stylesheet | Foreach { 
                    $Url = if ($_ -notlike "http*") { "$PageBaseUrl$_" } else { $_ }
                    Html.Link -Relation stylesheet -Type text/css -Href $Url
                }
                $StylesheetMedia | Foreach { 
                    $Url = if ($_ -notlike "http*") { "$PageBaseUrl$_" } else { $_ }
                    Html.Link -Media All -Relation stylesheet -Type text/css -Href $Url
                }
                $Javascript | Foreach { 
                    $Url = if ($_ -notlike "http*") { "$PageBaseUrl$_" } else { $_ }
                    Html.Script -Type "text/javascript" -Source $Url
                }
                if ($CSS) {
                    $CssTextContent = @()
                    $CSS.GetEnumerator() | Foreach {
                        $CssProperty = @()
                        $CssProperty += "$($_.Name) {"
                        $_.Value.GetEnumerator() | Foreach {
                            $CssProperty += "$($_.Name) : $($_.Value) ; "
                        }
                        $CssProperty += "}"
                        $CssTextContent += $CssProperty -join " "
                    }
                    Html.Style -TextContent ( "`n" +  ( $CssTextContent -join "`n" ) + "`n" )
                }
                if ($JavascriptInline) {
                    Html.Script -Type "text/javascript" -TextContent ("`n" + ( $JavascriptInline -join "`n" ) + "`n"  )
                }
            }
            Html.Body -Class $BodyClass -Style $BodyStyle -AppendNode $PageAppendNode
        }
        
        if ($AsHtml -eq $true) {
            $Document.ToFlatHtml()
        }
        elseif ($AsPrettyHtml -eq $true) {
            $Document.ToPrettyHtml()
        }
        elseif ($AsBrowser -eq $true) {
            $TempFilePath = [System.IO.Path]::GetTempFileName()
            $Document.ToFlatHtml() | Set-Content $TempFilePath
            Invoke-Item $TempFilePath
        }
        else {
            $Document  
        }
    }
}


function New-HtmlText {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [Alias('Text')]
        [string]
        $TextContent
    )
    $script:HtmlDocument.CreateTextNode($TextContent)
}
    
function New-HtmlComment {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [Alias('Text')]
        [string]
        $TextContent
    )
    $script:HtmlDocument.CreateComment($TextContent)
}
    
function New-HtmlFunction {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [Alias('Function')]
        [string]
        $FunctionName,
        
        [Parameter(Mandatory=$true)]
        [Alias('Tag')]
        [string]
        [string]
        $TagName
    )
    
    $Type = Get-HtmlTagType -TagName $TagName
    
    $Params = $Begin = $Process = $End = @()
    
    # Add Remaining Arguments
    $Begin  += @'
    # Analyze Remaining Arguments
    if ($PSBoundParameters.ContainsKey("RemainingArguments")) {
        foreach($RemainingArgument in $PSBoundParameters["RemainingArguments"]) {
            if ($RemainingArgument -is [scriptblock]) {
                $AppendNode = $RemainingArgument
            }
            elseif ($RemainingArgument -is [string]) {
                $PSBoundParameters["TextContent"] += $RemainingArgument
            }
            else {
                $PSBoundParameters["TextContent"] += $RemainingArgument.ToString()
            }
        }
        $null = $PSBoundParameters.Remove("RemainingArguments")
    }
    $PSBoundParametersKeys = $PSBoundParameters.Keys
    
    # Initialize AppendNode
    # if ($PSBoundParameters.ContainsKey("AppendNode") {
        # $AppendNode = $PSBoundParameters["AppendNode"]
    # }
    # else {
        # $AppendNode = $null
    # }
    
    # Initialize AppendNode
    # if ($PSBoundParameters.ContainsKey("PrependNode")) {
        # $PrependNode = $PSBoundParameters["PrependNode"]
    # }
    # else {
        # $PrependNode = $null
    # }
    
'@

    $Process += @'
    # Create HtmlElement
    $HtmlElement = $script:HtmlDocument.CreateElement('{0}')
    
'@  -f $TagName

    $Process += @'
    # Set HtmlElement Property from Not Null Parameter
    foreach ($Key in @($PSBoundParameters.Keys)) {
        $HtmlElement.$Key = $PSBoundParameters[$Key]
    }
    
'@
    
    # Build Command Parameters from Object Properties
    $ConstructorArgumentsName = $Type.GetConstructors()[0].GetParameters() | Select -Expand Name
    $Properties = $Type.GetProperties() | Where { $_.CanWrite -and $_.Name -notin $ConstructorArgumentsName } # | Select Name, PropertyType, DeclaringType
    
    $DefaultParameter = "[Parameter()]`n      "
    foreach($Property in $Properties) {
        # ByPass Property that not working
        if ($Property.Name -in "InnerHtml","OuterHtml") {
            continue
        }
        elseif ($Property.PropertyType -eq [System.Boolean] -and $Property.Name -notlike "NotBoolean*") {
            $Params += "      $DefaultParameter[switch]`n      `${0}" -f ($Property.Name, $Property.PropertyType)
            $Begin  += "    if (`${0}  -eq `$False) {{  `$null = `$PSBoundParameters.Remove(`"{0}`") }}" -f $Property.Name 
        }
        # Variable Host is reserved, so convert to HtmlHost
        elseif ($Property.Name -eq "Host") {
            $Params += "      $DefaultParameter [{1}]`n      `$Html{0}" -f ($Property.Name, $Property.PropertyType)
            $Begin  += "    if (`"Html{0}`" -in `$PSBoundParametersKeys) {{ `$null = `$PSBoundParameters.Add(`"{0}`",`$Html{0}) ; `$null = `$PSBoundParameters.Remove(`"Html{0}`")  }}" -f $Property.Name 
        }
        # Convert ClassName String of Array to String
        elseif ($Property.Name -eq "ClassName") {
            $Params += "      $DefaultParameter[Alias('{2}')]`n      [string[]]`n      `${0}" -f ($Property.Name, $Property.PropertyType, "Class")
            $Begin  += "    if (`"{0}`"  -in `$PSBoundParametersKeys) {{ `$PSBoundParameters[`"{0}`"] = (`${0} -join `" `").Trim() }}" -f $Property.Name 
        }
        elseif ($Property.PropertyType.FullName -eq 'AngleSharp.Dom.Html.Alignment') {
            # Do Nothing. Maybe need a fix.
        }
        else {
            $Params += "      $DefaultParameter[{1}]`n      `${0}" -f ($Property.Name, $Property.PropertyType)
        }
    }
   
    # Add Attributes
    $Params += "      $DefaultParameter[hashtable]`n      `$Attributes"
    $Begin  += '    if ("Attributes" -in $PSBoundParametersKeys) { $null = $PSBoundParameters.Remove("Attributes") }'
    $Process+= '    if ($Attributes -ne $null) { $Attributes.GetEnumerator() | Foreach { $null = $HtmlElement.SetAttribute($_.Key, $_.Value) } }'
    
    # Add Style
    $Params  += "      $DefaultParameter[Alias('CSS')]`n      [hashtable]`n      `$Style"
    $Begin   += '    if ("Style" -in $PSBoundParametersKeys) { $null = $PSBoundParameters.Remove("Style") }'
    $Process += '    if ($Style -ne $null) { $Styles = $Style.GetEnumerator() | Foreach { "{0} : {1}; " -f $_.Key, $_.Value } ; $null = $HtmlElement.SetAttribute("style", $Styles -join "") } '
    
         
    # Add Data
    $Params  += "      $DefaultParameter`n      [hashtable]`n      `$Data"
    $Begin   += '    if ("Data" -in $PSBoundParametersKeys) { $null = $PSBoundParameters.Remove("Data") }'
    $Process += '    if ($Data -ne $null) { $Datas = $Data.GetEnumerator() | Foreach { $null = $HtmlElement.SetAttribute("data-$($_.Key)", $_.Value) } }'
   
    # Add AppendNode
    $Params  += "      $DefaultParameter`n      [Alias('Append')]`n      [scriptblock]`n      `$AppendNode"
    $Begin   += '    if ("AppendNode" -in $PSBoundParametersKeys) { $null = $PSBoundParameters.Remove("AppendNode") }'
    $End += @'
    if ($AppendNode -ne $null) { 
        $Nodes = @( & $AppendNode )
        foreach ($Node in $Nodes) {
            if ($null -ne $Node) {
                $NodeTypeFullName = $Node.Gettype().FullName
                if ($NodeTypeFullName -eq "System.String") {
                    $String = New-HtmlText -Text $Node
                    $null = $HtmlElement.Append($String) 
                }
                elseif ($NodeTypeFullName -like "AngleSharp.*") { 
                    $null = $HtmlElement.Append($Node) 
                }
                else {
                    $String = New-HtmlText -Text ( $Node.ToString() )
                    $null = $HtmlElement.Append($String) 
                }
            }
        }
    }
'@
    
          
                 
    # Add PrependNode
    $Params  += "      $DefaultParameter`n      [Alias('Prepend')]`n      [scriptblock]`n      `$PrependNode"
    $Begin   += '    if ("PrependNode" -in $PSBoundParametersKeys) { $null = $PSBoundParameters.Remove("PrependNode") }'
    $End += @'
    if ($PrependNode -ne $null) { 
        $Nodes = @( & $PrependNode )
        foreach ($Node in $Nodes) { 
            $NodeTypeFullName = $Node.Gettype().FullName
            if ($NodeTypeFullName -match "^AngleSharp") { 
                $null = $HtmlElement.Prepend($Node) 
            }
            elseif ($NodeTypeFullName -eq "System.String") {
                $String = New-HtmlText -Text $Node
                $null = $HtmlElement.Prepend($String) 
            }
            else {
                $String = New-HtmlText -Text ( $Node.ToString() )
                $null = $HtmlElement.Prepend($String) 
            }
        }
    }
'@
    
    # Add Remaining Arguments (Last Argument)
    $Params += "      [parameter(ParameterSetName=`"Remaining`",ValueFromRemainingArguments=`$true)]`n      `$RemainingArguments"
    
    # Return Object
    $End    += @'
    
    return $HtmlElement
'@

    # Build Function 
    $StringBuilder = [System.Text.StringBuilder]::new()

    [void] $StringBuilder.AppendLine("function $FunctionName {")
    
    if ('IHtmlElement' -in $Type.GetInterfaces().Name) {
        [void] $StringBuilder.AppendLine("   [OutputType([AngleSharp.Dom.Html.IHtmlElement])]")
    }
    [void] $StringBuilder.AppendLine("   [CmdletBinding()]")
    [void] $StringBuilder.AppendLine("   param(")
    [void] $StringBuilder.AppendLine($Params -join ",`n`n")
    [void] $StringBuilder.AppendLine("   )`n")
    
    [void] $StringBuilder.AppendLine("   begin {")
    [void] $StringBuilder.AppendLine($Begin -join "`n")
    [void] $StringBuilder.AppendLine("   }`n")
    
    [void] $StringBuilder.AppendLine("   process {")
    [void] $StringBuilder.AppendLine($Process -join "`n")
    [void] $StringBuilder.AppendLine("   }`n")
    
    [void] $StringBuilder.AppendLine("   end {")
    [void] $StringBuilder.AppendLine($End -join "`n")
    [void] $StringBuilder.AppendLine("   }`n")
    [void] $StringBuilder.AppendLine("}`n")
    
    [void] $StringBuilder.AppendLine("")
    
    $Definition = $StringBuilder.ToString()
    
    try {
        [scriptblock]::Create($Definition)
    }
    catch {
        Write-Error $_
        Write-Error $Definition
    }
}

############################################################


# Script Variable used by all function to create Element
$script:HtmlDocument = Invoke-WebParser '<!DOCTYPE html>'

foreach($Tag in Get-HtmlTag) {
    $FunctionName = "New-Html{0}" -f $Tag.Name
    $Function = New-HtmlFunction -FunctionName $FunctionName -TagName $Tag.Value 
    $Function | Invoke-Expression
}

Get-Item function:\New-Html* | Foreach {
    New-Alias -Name $_.Noun.Replace("Html","Html.") -Value $_.Name -Force
}

Export-ModuleMember -Function New-Html*,Get-Html* -Alias Html*