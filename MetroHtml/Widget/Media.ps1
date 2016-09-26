function New-MetroVideoContainer {
    Param(
        $EmbedUrl
    )
    New-MetroDiv -Class video-container {
        New-HtmlIframe -Source $EmbedUrl
    }
}

New-HtmlProxyCommand -Name New-MetroVideoPlayer -TargetCommandName New-MetroDiv -AddParameter @(
    @{ 
        Name = "Source"
        Mandatory = $true
        Type = [string]
    }
    @{ 
        Name = "MimeType"
        Type = [string]
        DefaultValue = 'video/mp4'
    }
    @{ 
        Name = "FullScreenMode"
        ValidateSet = 'Window','Screen'
        Type = [string]
        DefaultValue = 'Screen'
    }
    @{ 
        Name = "Preload"
        ValidateSet = 'True','False'
        Type = [string]
        DefaultValue = 'True'
    }
    @{ 
        Name = "LogoUrl"
        Type = [string]
    }
) -SetParameter @(
    @{
        Name = 'Data'
        Value = {
            @{
                'role' = 'video'
                'full-screen-mode' = $FullScreenMode.ToLower()
                'preload' = $Preload.ToLower()
                'logo' = $LogoUrl
            }
        }
    }
    @{
        Name = 'Class'
        Value = 'video-player'
    }
    @{
        Name = 'AppendNode'
        Value = {
            {
                New-HtmlVideo {
                    New-HtmlSource -Source $Source -Type $MimeType
                }
            }
        }
    }
) | Invoke-Expression

New-HtmlProxyCommand -Name New-MetroAudioPlayer -TargetCommandName New-MetroDiv -AddParameter @(
    @{ 
        Name = "Source"
        Mandatory = $true
        Type = [string]
    }
    @{ 
        Name = "MimeType"
        Type = [string]
        DefaultValue = 'audio/mp3'
    }
    @{ 
        Name = "DisplayMode"
        ValidateSet = 'Micro','Small','Medium','Full'
        Type = [string]
        DefaultValue = 'Medium'
    }
) -SetParameter @(
    @{
        Name = 'Data'
        Value = {
            @{
                'role' = 'audio'
            }
        }
    }
    @{
        Name = 'Class'
        Value = { 'audio-player ' + $DisplayMode.ToLower() }
    }
    @{
        Name = 'AppendNode'
        Value = {
            {
                New-HtmlAudio {
                    New-HtmlSource -Source $Source -Type $MimeType
                }
            }
        }
    }
) | Invoke-Expression
