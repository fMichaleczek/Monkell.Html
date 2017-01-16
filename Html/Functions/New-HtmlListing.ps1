function New-HtmlListing {
   [OutputType([AngleSharp.Dom.Html.IHtmlElement])]
   [CmdletBinding()]
   param(
      [Parameter()]
      [switch]
      $IsHidden,

      [Parameter()]
      [AngleSharp.Dom.Html.IHtmlMenuElement]
      $ContextMenu,

      [Parameter()]
      [switch]
      $IsDraggable,

      [Parameter()]
      [System.String]
      $AccessKey,

      [Parameter()]
      [System.String]
      $Language,

      [Parameter()]
      [System.String]
      $Title,

      [Parameter()]
      [System.String]
      $Direction,

      [Parameter()]
      [switch]
      $IsSpellChecked,

      [Parameter()]
      [System.Int32]
      $TabIndex,

      [Parameter()]
      [System.String]
      $ContentEditable,

      [Parameter()]
      [switch]
      $IsTranslated,

      [Parameter()]
      [System.String]
      $Slot,

      [Parameter()]
      [System.String]
      $TextContent,

      [Parameter()]
      [Alias('ClassName')]
      [string[]]
      $Class,

      [Parameter()]
      [System.String]
      $Id,

      [Parameter()]
      [switch]
      $IsFocused,

      [Parameter()]
      [AngleSharp.Url]
      $BaseUrl,

      [Parameter()]
      [System.String]
      $NodeValue,

      [Parameter()]
      
      [hashtable]
      $Attributes,

      [Parameter()]
      
      [Alias('CSS')]
      [hashtable]
      $Style,

      [Parameter()]
      
      [hashtable]
      $Data,

      [Parameter()]
      
              [Alias('AppendNode')]
      $Append,

      [Parameter()]
      
      $Prepend,

      [parameter(ParameterSetName="Remaining",ValueFromRemainingArguments=$true)]
      $RemainingArguments
   )

   begin {
    # Analyze Remaining Arguments
    if ($PSBoundParameters.ContainsKey("RemainingArguments")) {
        foreach($RemainingArgument in $PSBoundParameters["RemainingArguments"]) {
            if ($RemainingArgument -is [scriptblock]) {
                $Append = $RemainingArgument
            }
            elseif ($RemainingArgument -is [string]) {
                $PSBoundParameters["TextContent"] += $RemainingArgument
            }
            elseif ($null -ne $RemainingArgument) {
                $PSBoundParameters["TextContent"] += $RemainingArgument.ToString()
            }
        }
        $null = $PSBoundParameters.Remove("RemainingArguments")
    }
	$null = $PSBoundParameters.Remove("Class")
    if ($IsHidden  -eq $False) {  $null = $PSBoundParameters.Remove("IsHidden") }
    if ($IsDraggable  -eq $False) {  $null = $PSBoundParameters.Remove("IsDraggable") }
    if ($IsSpellChecked  -eq $False) {  $null = $PSBoundParameters.Remove("IsSpellChecked") }
    if ($IsTranslated  -eq $False) {  $null = $PSBoundParameters.Remove("IsTranslated") }
    if ($Class.Count -gt 0) { $PSBoundParameters["ClassName"] = ($Class -join " ").Trim() }
    if ($IsFocused  -eq $False) {  $null = $PSBoundParameters.Remove("IsFocused") }
    $null = $PSBoundParameters.Remove("Attributes") 
    $null = $PSBoundParameters.Remove("Style")
    $null = $PSBoundParameters.Remove("Data") 
      $null = $PSBoundParameters.Remove("Append") 
      $null = $PSBoundParameters.Remove("Prepend") 
   }

   process {
    # Create HtmlElement
    $HtmlElement = $script:HtmlDocument.CreateElement('listing')
    
    # Set HtmlElement Property from Not Null Parameter
    foreach ($Key in @($PSBoundParameters.Keys)) {
       $HtmlElement.$Key = $PSBoundParameters[$Key]
    }
    
    if ($Attributes -ne $null) { $Attributes.GetEnumerator() | Foreach { $null = $HtmlElement.SetAttribute($_.Key, $_.Value) } }
    if ($Style.Count -gt 0) { $Styles = $Style.GetEnumerator() | Foreach { "{0} : {1}; " -f $_.Key, $_.Value } ; $null = $HtmlElement.SetAttribute("style", $Styles -join "") } 
    if ($Data -ne $null) { $Datas = $Data.GetEnumerator() | Foreach { $null = $HtmlElement.SetAttribute("data-$($_.Key.ToString().ToLower())", $_.Value) } }
   }

   end {
    if ($Append -ne $null) { 
        if ($Append -is [scriptblock]) { 
            $Nodes = @( & $Append )
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
        elseif ($Append -is [string]) {
            $String = New-HtmlText -Text $Append
            $null = $HtmlElement.Append($String) 
        }
    }
    if ($Prepend -ne $null) { 
        if ($Prepend -is [scriptblock]) { 
            $Nodes = @( & $Prepend )
            foreach ($Node in $Nodes) { 
                $NodeTypeFullName = $Node.Gettype().FullName
                if ($NodeTypeFullName -match "^AngleSharp") { 
                    $null = $HtmlElement.Prepend($Node) 
                }
                elseif ($NodeTypeFullName -eq "System.String") {
                    $String = New-HtmlText -Text $Node
                    $null = $HtmlElement.Prepend($String) 
                }
                elseif ($null -ne $Node) {
                    $String = New-HtmlText -Text ( $Node.ToString() )
                    $null = $HtmlElement.Prepend($String) 
                }
            }
        }
        elseif ($Prepend -is [string]) {
            $String = New-HtmlText -Text $Prepend
            $null = $HtmlElement.Prepend($String) 
        }
    }
    
    return $HtmlElement
   }

}



