New-HtmlProxyCommand -Name New-MetroTable -TargetCommandName New-HtmlTable -AddClass table -AddClassParameter ( @(
    @{ 
        Name = "IsStriped"
        Type = [switch]
        Value = 'striped'
    }
    @{ 
        Name = "IsBorder"
        Type = [switch]
        Value = 'border'
    }
    @{ 
        Name = "IsBordered"
        Type = [switch]
        Value = 'bordered'
    }
    @{ 
        Name = "IsHovered"
        Type = [switch]
        Value = 'hovered'
    }
    @{ 
        Name = "IsCellHovered"
        Type = [switch]
        Value = 'cell-hovered'
    }
    @{
        Name = "SortablePosition"
        Type = [string]
        ValidateSet = 'Left','Right'
        Value = { 
            switch($_) {
              'Left' { "sortable-markers-on-left" }
              'Right' { $null }   
            } 
        } 
    }
)  + $ColorParameters ) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroTableSectionHead -TargetCommandName New-HtmlThead | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroTableSectionBody -TargetCommandName New-HtmlTBody | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroTableSectionFoot -TargetCommandName New-HtmlTFoot | Invoke-Expression


New-HtmlProxyCommand -Name New-MetroTableRow -TargetCommandName New-HtmlTr -AddClassParameter (
    @( $ColorParameters | Where { $_.Name -ne "ProfileColor" } ) + @(
        @{
            Name = "ProfileColor"
            Type = [string]
            ValidateSet = 'Error','Warning','Info','Success'
            Value = { $_.ToString().ToLower() } 
        }
    )
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroTableHeaderCell -TargetCommandName New-HtmlTh -AddClassParameter ( @(
    @{ 
        Name = "IsSortable"
        Type = [switch]
        Value = 'sortable-column'
    }
    @{
        Name = "SortOrder"
        Type = [string]
        ValidateSet = 'Ascending','Descending'
        Value = { 
            switch($_) {
              'Ascending' { "sort-asc" }
              'Descending' { "sort-desc" }   
            } 
        } 
    }
    @{
        Name = "VerticalAlign"
        ValidateSet = 'Top', 'Bottom', 'Baseline', 'Middle', 'Sub', 'Super', 'TopText', 'BottomText'
        Type = [string]
        Value = {  
            switch($_) {
              'Top' { 'v-align-top' }
              'Bottom' { 'v-align-bottom' }
              'Baseline' { 'v-align-baseline' }
              'Middle' { 'v-align-middle' }
              'Sub' { 'v-align-sub' }
              'Super' { 'v-align-super' }
              'TopText' { 'v-align-top-text' }
              'BottomText' { 'v-align-bottom-text' }
            }
        }
    }
) + $ColorParameters ) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroTableDataCell -TargetCommandName New-HtmlTd -AddClassParameter (
    $ColorParameters + @(
           @{
            Name = "VerticalAlign"
            ValidateSet = 'Top', 'Bottom', 'Baseline', 'Middle', 'Sub', 'Super', 'TopText', 'BottomText'
            Type = [string]
            Value = {  
                switch($_) {
                  'Top' { 'v-align-top' }
                  'Bottom' { 'v-align-bottom' }
                  'Baseline' { 'v-align-baseline' }
                  'Middle' { 'v-align-middle' }
                  'Sub' { 'v-align-sub' }
                  'Super' { 'v-align-super' }
                  'TopText' { 'v-align-top-text' }
                  'BottomText' { 'v-align-bottom-text' }
                }
            }
        } 
    )
) | Invoke-Expression


#####################################################################################

$script:CachedFormatData = @{}
$script:CachedProperties = @{}

function Get-ObjectProperty {
    [CmdletBinding(DefaultParameterSetName='DefaultFormatter')]
    param(
        [PSObject]
        $InputObject,
        
        [switch]
        $AllProperties
    )
    
    $Properties = [ordered]@{}
    
    $MatchingtypeName = $null
    foreach($TypeName in $InputObject.PSTypeNames) {
        if ($script:CachedFormatData[$TypeName]) {
            $MatchingtypeName = $TypeName
            $FormatData = $script:CachedFormatData[$TypeName]
            break
        }
        $FormatData = Get-FormatData -TypeName $TypeName -ErrorAction 0
        if ($null -ne $FormatData) {
            $MatchingtypeName = $TypeName
            $script:CachedFormatData[$TypeName] = $FormatData
            break
        }
    }
    $TypeName = $MatchingtypeName
    
    if ($FormatData -and $AllProperties -eq $False) {
    
        if ($CachedProperties[$TypeName]) {
            $Properties = $CachedProperties[$TypeName]
        }
        else {
            $Control = $FormatData.FormatViewDefinition | Select -First 1 | Select -ExpandProperty Control
            $HeadersCount = $Control.Headers.Count
            $Columns = @($Control.Rows[0].Columns)

            for ($i=0; $i -lt $HeadersCount ; $i++ ) {  
                $Label = $Control.Headers[$i].Label
                if (-not $Label) {
                    $Label = $Columns[$i].DisplayEntry.Value
                }
                if ($label) {
                    if ($columns[$i].DisplayEntry.ValueType -eq 'Property') {
                        $Property = $Columns[$i].DisplayEntry.Value
                        $Properties[$label] = [ScriptBlock]::Create("`$InputObject.'$Property'")
                    } 
                    elseif ($columns[$i].DisplayEntry.ValueType -eq 'ScriptBlock') {
                        $Properties[$label] = [ScriptBlock]::Create($columns[$i].DisplayEntry.Value.Replace('$_','$InputObject'))
                    } 
                }
            }
            $CachedProperties[$TypeName] = $Properties
        }
    }
    else {
        $InputObject.PSObject.Properties | Foreach { $Properties.Add($_.Name, [ScriptBlock]::Create("`$InputObject.'$($_.Name)'")) }
    }

    $Properties
}



New-HtmlProxyCommand -Name ConvertTo-MetroTable -TargetCommandName New-MetroTable -AddParameter @(
    @{
        Name = 'AllProperties'
        Type = [switch]
    }
    @{
        Name = 'HideHeader'
        Type = [switch]
    }
    @{
        Name = 'ShowFooter'
        Type = [switch]
    }
    @{
        Name = 'InputObject'
        ValueFromPipeline = $true
        Type = [psobject]
    }
) -Begin {
    $Properties = $null
    $Table = New-MetroTable @PSBoundParameters 
    $TableHeader = $null
    $TableBody = New-MetroTableSectionBody
    $TableFooter = $null
} -Process {
    if (-not $InputObject ) {  
        return  
    }
    
    if ($null -eq $Properties) {
        $Properties = Get-ObjectProperty -InputObject $InputObject -AllProperties:$AllProperties
        if ( -not $HideHeader -or $ShowFooter) {
            $TableRow = New-MetroTableRow
            foreach($Property in $Properties.GetEnumerator()) {
                $TableHeaderCell = New-MetroTableHeaderCell -TextContent $Property.Name
                $TableRow.Append($TableHeaderCell)
            }
        }
        if (-not $HideHeader) {
            $TableHeader = New-MetroTableSectionHead
            $TableHeader.Append($TableRow.Clone())
        }
        if ($ShowFooter) {
            $TableFooter = New-MetroTableSectionFoot
            $TableFooter.Append($TableRow.Clone())
        }
        
    }
    
    $TableRow = Metro.TableRow
    foreach($Property in $Properties.GetEnumerator()) {
        $Value = & $Property.Value
        if ($null -eq $Value) {
            $ValueString = [string]::Empty
        }
        elseif ($Value -is [System.Collections.IEnumerable]) {
            $ValueString  = [string]::Empty
            foreach($EachValue in $Value) {
                $ValueString += "$EachValue `n"
            }
        }
        else {
            $ValueString = $Value.ToString()
        }
        $TableDataCell =  New-MetroTableDataCell -TextContent $ValueString
        $TableRow.Append($TableDataCell)
    }
    $TableBody.Append($TableRow)
    
} -End {
    if ($TableHeader) {
        $Table.Append($TableHeader)
    }
    $Table.Append($TableBody)
    if ($TableFooter) {
        $Table.Append($TableFooter)
    }
    $Table
} | Invoke-Expression

