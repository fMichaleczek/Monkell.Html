function New-HtmlProxyCommand {
    [CmdletBinding(DefaultParameterSetName="MultiBlock")]
	param(
		[Parameter(Position=0, Mandatory=$True)] 
		[Alias('CommandName')]
		[string] $Name,
		
		[string] $TargetCommandName,
		
        [System.Management.Automation.CommandInfo]
        $TargetCommand,
          
        [Parameter(ParameterSetName="MultiBlock")]
        [scriptblock]
        $Begin,
        
        [Parameter(ParameterSetName="MultiBlock")]
        [scriptblock]
        $Process,
        
        [Parameter(ParameterSetName="MultiBlock")]
        [scriptblock]
        $End,
        
        [Parameter(ParameterSetName="ScriptBlock")]
        [scriptblock]
        $ScriptBlock,
        
        [hashtable[]]
        $AddParameter,
        
        [hashtable[]]
        $SetParameter,
        
        [hashtable[]]
        $RemoveParameter,      
        
		[Alias('Class')]
		[string[]] $AddClass,
        
		[Alias('ClassParameter')]
		[hashtable[]] 
        $AddClassParameter,
        
		[Alias('Data')]
		[hashtable[]] $AddData,
        
		[Alias('DataParameter')]
		[hashtable[]] 
        $AddDataParameter
        
	)
    
    if (-not $TargetCommand) {
        $OriginCommandName = Split-Path $TargetCommandName -Leaf
        try { 
            $TargetCommand = Get-Command -Name $OriginCommandName -ErrorAction stop | Select -First 1
        }
        catch { 
            Throw $_ 
            return 
        } 
    }
    
    $CommandMetaData = [System.Management.Automation.CommandMetaData]::new($TargetCommand) 
  
    if ($PSBoundParameters["AddParameter"]) {
        foreach ($ap in $AddParameter) {
            if ($CommandMetaData.Parameters.ContainsKey($ap.Name)) {
                $null = $CommandMetaData.Parameters.Remove($ap.Name) 
            }
        }
    }
    
    if ($PSBoundParameters["SetParameter"]) {
        foreach ($sp in $SetParameter) {
            if ($CommandMetaData.Parameters.ContainsKey($sp.Name)) {
                $null = $CommandMetaData.Parameters.Remove($sp.Name) 
            }
        }
    }     
    
    if ($PSBoundParameters["RemoveParameter"]) {
        foreach ($rp in $RemoveParameter) {
            if ($CommandMetaData.Parameters.ContainsKey($rp.Name)) {
                $null = $CommandMetaData.Parameters.Remove($rp.Name)
            }
        }
    }
     
    if ($PSBoundParameters["AddClassParameter"]) {
        foreach ($acp in $AddClassParameter) {
            if ($CommandMetaData.Parameters.ContainsKey($acp.Name)) {
                $null = $CommandMetaData.Parameters.Remove($acp.Name) 
            }
        }
    }
       
    if ($PSBoundParameters["AddDataParameter"]) {
        foreach ($adp in $AddDataParameter) {
            if ($CommandMetaData.Parameters.ContainsKey($adp.Name)) {
                $null = $CommandMetaData.Parameters.Remove($adp.Name) 
            }
        }
    }
    
    # Get Script parts
    $CommandBlocks = @{}
    
    $CommandBlocks.CmdletBinding = [System.Management.Automation.ProxyCommand]::GetCmdletBindingAttribute($CommandMetaData)
    
    $CommandBlocks.Params        = [System.Management.Automation.ProxyCommand]::GetParamBlock($CommandMetaData)
  
    
    if (-not $PSBoundParameters["ScriptBlock"]) {
        if ($PSBoundParameters["Begin"]) {
            $CommandBlocks.Begin = $Begin
        }
        else {
            $CommandBlocks.Begin  = [System.Management.Automation.ProxyCommand]::GetBegin($CommandMetaData)
        }
        
        if ($PSBoundParameters["Process"]) {
            $CommandBlocks.Process = $Process
        }
        else {
            $CommandBlocks.Process = [System.Management.Automation.ProxyCommand]::GetProcess($CommandMetaData)
        }
        
        if ($PSBoundParameters["End"]) {
            $CommandBlocks.End = $End
        }
        else {
            $CommandBlocks.End = [System.Management.Automation.ProxyCommand]::GetEnd($CommandMetaData)
        }
    }
    else {
        $CommandBlocks.Begin = @'
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
'@
        $CommandBlocks.Process = $null
        $CommandBlocks.End = $PSBoundParameters["ScriptBlock"] 
    }
    
     
    $Parameters = @()
    
    $Begins = @()
    
    $Begins += '      $PSBoundParametersKeys = $PSBoundParameters.Keys '
    $Begins += '    $null = $PSBoundParameters.Remove("Class")'
	$Begins += "    if (`$Class.Count -gt 0) { `$PSBoundParameters[`"ClassName`"] = (`$Class -join `" `").Trim() }" 
	
    if ($PSBoundParameters["AddClass"]) { 
        $Begins += ( "      `$PSBoundParameters.ClassName =  [string[]]@(`$PSBoundParameters.ClassName, '{0}')" -f $($AddClass -join ' ')  ) + "`n"
    }
    
    if ($PSBoundParameters["AddData"]) { 
        $DataString = '@{'
        $PSBoundParameters["AddData"] | Foreach {
            $_.GetEnumerator() | Foreach {
                $DataString += "'{0}'='{1}';" -f $_.Key, $_.Value
            }
        }
        $DataString += '}'
        $Begins += ( "        `$PSBoundParameters.Data =  `$PSBoundParameters.Data +  {0}" -f $DataString  ) + "`n"
    }
    
    if ($PSBoundParameters["AddClassParameter"]) {
        foreach ($acp in $AddClassParameter) {
            
            # Parameter Block
            if ($acp.Mandatory) {
                $Parameter =  "    [Parameter(Mandatory=`$true)]`n"
            }
            else {
                # $Parameter =  "    [Parameter()]`n"
                $Parameter = [string]::Empty
            }
            
            if ($acp.ValidateSet) {
                $ValidateSetArray = @()
                foreach ($vs in $acp.ValidateSet) {
                    $ValidateSetArray += '"{0}"' -f $vs
                }
                $Parameter += "    [ValidateSet({0})] `n" -f ($ValidateSetArray -join ", ")
            }
            
            $Parameter += "    [{0}] `n" -f $acp.Type.FullName
            
            if ($acp.DefaultValue) {
                $Parameter += "    `${0} = '{1}'," -f $acp.Name, $acp.DefaultValue
            }
            else {
                $Parameter += "    `${0}," -f $acp.Name
            }
            
            $Parameters += $Parameter
            
            # BeginBlock
            if ($acp.DefaultValue) {
                $BeginBlock  = "`n      if ('$($acp.Name)' -in `$PSBoundParametersKeys -or `$$($acp.Name) -ne [string]::empty ) { `n"
            }
            else {    
                $BeginBlock  = "`n      if ('$($acp.Name)' -in `$PSBoundParametersKeys) { `n"
            }
            
            if ($acp.Value -is [string]) {
                $BeginBlock += "            `$PSBoundParameters[`"ClassName`"] = [string[]]@(`$PSBoundParameters[`"ClassName`"], '$($acp.Value)')    `n"
            }
            elseif ($acp.Value -is [scriptblock]) {
                $Value = $acp.Value.ToString().Replace('$_', ('${0}' -f $acp.Name))
                $BeginBlock += "            `$PSBoundParameters[`"ClassName`"] = [string[]]@(`$PSBoundParameters[`"ClassName`"], `$( $Value ) )    `n"
            }
            
            $BeginBlock += "            `$null = `$PSBoundParameters.Remove('$( $acp.Name )') `n"
            $BeginBlock += "      } `n"
            
            $Begins += $BeginBlock
        }
    }
   
    if ($PSBoundParameters["AddDataParameter"]) {
        foreach ($adp in $AddDataParameter) {
            
            # Parameter Block
            if ($adp.Mandatory) {
                $Parameter =  "    [Parameter(Mandatory=`$true)]`n"
            }
            else {
                # $Parameter =  "    [Parameter()]`n"
                $Parameter = [string]::Empty
            }
            
            if ($adp.ValidateSet) {
                $ValidateSetArray = @()
                foreach ($vs in $adp.ValidateSet) {
                    $ValidateSetArray += '"{0}"' -f $vs
                }
                $Parameter += "    [ValidateSet({0})] `n" -f ($ValidateSetArray -join ", ")
            }
            
            $Parameter += "    [{0}] `n" -f $adp.Type.FullName
            
            if ($adp.DefaultValue) {
                $Parameter += "    `${0} = '{1}'," -f $adp.Name, $adp.DefaultValue
            }
            else {
                $Parameter += "    `${0}," -f $adp.Name
            }
            
            $Parameters += $Parameter
            
            # BeginBlock
            $BeginBlock  = "      if ('$($adp.Name)' -in `$PSBoundParametersKeys) { `n"
            if ($adp.Value -is [string]) {
                $BeginBlock += "            `$PSBoundParameters[`"Data`"] = `$PSBoundParameters[`"Data`"] + $($adp.Value)    `n"
            }
            elseif ($adp.Value -is [scriptblock]) {
                $Value = $adp.Value.ToString().Replace('$_', ('${0}' -f $adp.Name))
                $BeginBlock += "            `$PSBoundParameters[`"Data`"] = `$PSBoundParameters[`"Data`"] + `$(  $Value )    `n"
            }
            $BeginBlock += "            `$null = `$PSBoundParameters.Remove('$( $adp.Name )') `n"
            $BeginBlock += "      } `n"
            
            $Begins += $BeginBlock
        }
    }
   
    if ($PSBoundParameters["AddParameter"]) {
        foreach ($ap in $AddParameter) {
            
            # Parameter Block
            $Parameter =  "    [Parameter("
            
            if ($ap.Mandatory) {
                $Parameter += ", Mandatory=`$true"
            }
            
            if ($ap.ValueFromPipeline) {
                $Parameter += ", ValueFromPipeline=`$true"
            }
            
            $Parameter += ")]`n"
            
            if ($ap.ValidateSet) {
                $ValidateSetArray = @()
                foreach ($vs in $ap.ValidateSet) {
                    $ValidateSetArray += '"{0}"' -f $vs
                }
                $Parameter += "    [ValidateSet({0})] `n" -f ($ValidateSetArray -join ", ")
            }
            
            $Parameter += "    [{0}] `n" -f $ap.Type.FullName
            
            if ($ap.DefaultValue) {
                $Parameter += "    `${0} = '{1}'," -f $ap.Name, $ap.DefaultValue
            }
            else {
                $Parameter += "    `${0}," -f $ap.Name
            }
            
            $Parameters += $Parameter
            
            # BeginBlock
            $Begins +=  "            `$null = `$PSBoundParameters.Remove('$( $ap.Name )')  `n"
            
        }       
    }
    
    if ($PSBoundParameters["SetParameter"]) {
        foreach ($sp in $SetParameter) {
            
            # BeginBlock
            $BeginBlock  = ""
            if ($sp.Value -is [string]) {
                $BeginBlock += "            `$PSBoundParameters[`"$($sp.Name)`"] = '$($sp.Value)'  `n"
            }
            elseif ($sp.Value -is [scriptblock]) {
                $BeginBlock += "            `$PSBoundParameters[`"$($sp.Name)`"] = `$( $( $sp.Value.ToString().Trim() ) ) `n"
            }
            $Begins += $BeginBlock
        }
    }
    
    $CommandBlocks.Params = ( $Parameters -join " `n`n" ) + "`n" + $CommandBlocks.Params
    
    if (-not $PSBoundParameters["ScriptBlock"]) {
        $CommandBlocks.Begin = ( $Begins -join " `n" ) + "`n" + $CommandBlocks.Begin
    }
    else {
        $CommandBlocks.Begin = $CommandBlocks.Begin + "`n" + ( $Begins -join " `n" )
    }
     
    
    $Definition = @"
function $Name { 
$($CommandBlocks.CmdletBinding)
    param(
$($CommandBlocks.Params)
    )
    
    begin {
$($CommandBlocks.Begin)

	}

    process {
$($CommandBlocks.Process)

	}

    end {
$($CommandBlocks.End)

	}
}
"@
    try {
       $ScriptBlock = [scriptblock]::Create($Definition)
       $ScriptBlock
    }
    catch {
        Write-Error "Function $TargetCommand not working"
        Write-Error $_
        Write-Error $Definition
    }
}
