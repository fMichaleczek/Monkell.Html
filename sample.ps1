Import-Module $PSScriptRoot\Html -Force
Import-Module $PSScriptRoot\MetroHtml -Force
# . $PSScriptRoot\..\Functions\ConvertTo-MetroForm.ps1

$PageParams = @{
    Title = "Monkell"
    Description = "Some Description"
    Author = "Me"
    Keywords = "About Some","Things"
    Language = "EN"
    Charset = "UTF-8"
    Stylesheet = @(
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro.min.css"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro-icons.min.css"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro-responsive.min.css"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro-schemes.min.css"
    )
    Css = @{
        '.page-content' = @{
            'padding-top' = '2.25rem'
        }
        '.app-bar, .app-bar .app-bar-divider, .app-bar .app-bar-element, .app-bar .app-bar-menu>li, .app-bar .app-bar-menu>li>a ' = @{
            'line-height' = '2.25rem !important'
            'height' = '2.25rem !important'
        }
        '.op-black' = @{
            'background-color' = 'rgba(0, 0, 0, 0.7) !important'
        }
        '.op-red' = @{
            'background-color' = 'rgba(206, 53, 44, 0.7) !important'
        }
    }
    Javascript = @(
        "https://code.jquery.com/jquery-2.2.3.min.js"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/js/metro.js"
        "https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.3/ace.js"
        "https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.3/ext-language_tools.js"
        "https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.3/theme-xcode.js"
        "https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.3/mode-powershell.js"
    )
}
$Menus = @(
    @{
        Name = "Control Panel"
        Children = @(
            @{ Name = "Settings Panel" }
            @{ Name = "#" }
            @{ 
                Name = "System" 
                Children = @(
                    @{ Name = "Configuration" }
                    @{ Name = "Database" }
                    @{ Name = "Cache" }
                    @{ Name = "Storage" }
                    @{ Name = "Features" }
                    @{ Name = "Notifications" }
                    @{ Name = "System Information" }
                )
            }
            @{  
                Name = "Services" 
                Children = @(
                    @{ Name = "Task Scheduler" }
                    @{ Name = "Event Manager (IFTTT)" }
                    @{ Name = "REST Services" }
                    @{ Name = "ODATA Services" }
                )
            }
            @{ Name = "Devices" }
            @{ Name = "Network & Internet" 
                Children = @(
                    @{ Name = "Status" }
                    @{ Name = "Proxy" }
                    @{ Name = "Data Usage" }
                )
            
            }
            @{ Name = "Personalization" 
                Children = @(
                    @{ Name = "Background" }
                    @{ Name = "Start" }
                    @{ Name = "Themes" }
                    @{ Name = "Colors" }
                    @{ Name = "Login Screen" }
                    @{ Name = "Lock Screen" }
                    @{
                        Name = "Menus"
                         Children = @(
                            @{ Name = "Admin Menu" }
                            @{ Name = "Site Menu" }
                        )
                    }
                )
            
            }
            @{ 
                Name = "Accounts"
                Children = @(
                    @{ Name = "Sign-in Options" }
                    @{ Name = "Email and App accounts" }
                    @{ Name = "Users" }
                    @{ Name = "Groups" }
                    @{ Name = "Profiles" }
                    @{ Name = "Access Levels" }
                    @{ Name = "Mass Mail" }
                )
            }
            @{ 
                Name = "Time & language" 
                Children = @(
                    @{ Name = "Date & Time" }
                    @{ Name = "Region and language" }
                    @{ Name = "Speech" }
                )
            }
            @{ Name = "Privacy" }
            @{ 
                Name = "Update & security" 
                Children = @(
                    @{ Name = "Update" }
                    @{ Name = "Backup" }
                    @{ Name = "Recovery" }
                    @{ Name = "Activation" }
                    @{ Name = "For developers" }
                )
            }
        )
    }
    @{  Name = "#" }
    @{
        Name = "Automation Kit"
        Children = @(
            @{ Name = "File Explorer" }
            @{ Name = "#" }
            @{ Name = "Snippets" }
            @{ Name = "Scripts" }
            @{ Name = "Modules" }
            @{ Name = "Repository" }
            @{ Name = "#" }
            @{ Name = "Quality Analyzer" }
            @{ Name = "Unit Testing" }
            @{ Name = "GUI Designer" }
        )
    }
    @{  Name = "#" }
    @{  
        Name = "Configuration Management" 
        Children = @(
            @{ Name = "Model" }
            @{ Name = "Database" }
            @{ 
                Name = "Nodes"
                 Children = @(
                     @{ Name = "Managed" }
                     @{ Name = "Stand Alone" }
                     @{ Name = "Agents" }
                     @{ Name = "Deployement" }
                     @{ Name = "Events" }
                )
            }
            @{ Name = "Resources" }
            @{  Name = "#" }
            @{ Name = "Desired State" }
            @{ Name = "Recipes" }
            @{ Name = "Execute Command" }
            @{ Name = "Replicate Files" }
            @{ Name = "Change Control (Tripwire)" }
        )
    }
    @{  Name = "#" }
    @{  
        Name = "Devops" 
        Children = @(
            @{ Name = "Code Management" }
            @{ Name = "Continuous Integration" }
            @{ Name = "Continuous Delivery" }
            @{ Name = "#" }
            @{ Name = "Build Management" }
            @{ Name = "Testing" }
            @{ Name = "Release Management" }
            @{ Name = "#" }
            @{ Name = "Deployment Management" }
        )
    }
    @{  Name = "#" }
    @{ Name = "Monitoring" }
)

$MetroPage = Html.Page @PageParams -Append {
    
    Html.Div {
        Metro.AppBar -Fixed Top <# -ColorScheme Navy #> {

            Html.Div -Class 'container' {
            
                Metro.AppBarElement -IsBranding -TextContent "My Company" -PrependNode {
                    Metro.Image -Source "http://www.icone-png.com/png/24/23725.png"
                }
                Metro.AppBarDivider

                Metro.AppBarElement {
                    Metro.Icon -Icon apps -Id "toggle-tiles-dropdown" -IsDoubleSize
                    Html.Div -Class "app-bar-drop-container" -Data @{role="dropdown";'toggle-element'="#toggle-tiles-dropdown"} -Style @{"width"="200px"} {
                        Html.Div -Class "tile-container bg-white" {
                            Html.Div -Class "tile-small bg-cyan" { Html.Div -Class "tile-content iconic" { Metro.Icon -Icon onedrive } }
                            Html.Div -Class "tile-small bg-yellow" { Html.Div -Class "tile-content iconic" { Metro.Icon -Icon google } }
                        }
                    }
                }
                Metro.AppBarDivider

                Metro.AppBarElement -TextContent Apps -Id "toggle-tiles-dropdown2" {
                    Html.Div -Class "app-bar-drop-container" -Data @{role="dropdown";'toggle-element'="#toggle-tiles-dropdown2"} -Style @{"width"="200px"} {
                        Html.Div -Class "tile-container bg-white" {
                            Html.Div -Class "tile-small bg-cyan" { Html.Div -Class "tile-content iconic" { Metro.Icon -Icon alarm } }
                            Html.Div -Class "tile-small bg-yellow" { Html.Div -Class "tile-content iconic" { Metro.Icon -Icon widgets } }
                        }
                    }
                }
                Metro.AppBarDivider

                Metro.AppBarMenu  {
                    Metro.AppBarMenuItem { Html.A -Href '#' Home -PrependNode { Metro.Icon -Icon bug }  }
                    Metro.AppBarMenuItem { 
                        Html.A -Href '#' Pages  -Class 'dropdown-toggle' 
                        Metro.DMenuList -Data @{role="dropdown"} {
                            Metro.DMenuListItem { Html.A -Href '#' 'Powershell 2.0' -PrependNode { Metro.Icon -Icon air -Class 'icon' } }
                            Metro.DMenuListItem { Html.A -Href '#' 'Powershell 3.0' }
                        }
                    }
                }

                Metro.AppBarMenu -IsSmallDropdown {
                    Metro.AppBarMenuItem { Html.A -Href '#' Admin }
                    Metro.AppBarMenuItem { 
                        Html.A -TextContent 'Products' -Href '' -Class 'dropdown-toggle' 
                        Metro.DMenuList -Data @{role="dropdown"} {
                            Metro.DMenuListItem { Html.A -Href '#'  'Windows10' }
                            Metro.DMenuListItem { Html.A -Href '#' 'Spartan' }
                            Metro.DMenuListItem { Html.A -Href '#' 'Outlook' }
                            Metro.DMenuListItem -Class divider
                            Metro.DMenuListItem { 
                                Html.A 'Other Products' -Class "dropdown-toggle"
                                Metro.DMenuList -Data @{role="dropdown"} {
                                    Metro.DMenuListItem { Html.A -Href 'http://www.chrome.com' -Textcontent 'Internet Explorer 10' -Target '_blank' <# -Data @{ hotkey = 'alt+3' } #>   } 
                                    Metro.DMenuListItem { Html.A -Href '#' 'Spartan' }
                                    Metro.DMenuListItem { Html.A -Href '#' 'Outlook' }
                                }
                            }
                        }
                    }
                    Metro.AppBarMenuItem -IsNotFlexible { Html.A 'Help' }
                }
                
                <#
                # Show when bar is minimal
                Metro.AppBarPullButton {
                    Html.A -TextContent "Plus..."
                    Metro.IconButton -LayoutIcon plus
                }
                #>
                
                Metro.AppBarElement -IsPositionRight -TextContent "Link3"
                Metro.AppBarElement -IsPositionRight -TextContent "Link4"
                Metro.AppBarMenu -IsPositionRight {
                    Metro.AppBarMenuItem { Html.A -Href '#' Link }
                    Metro.AppBarMenuItem { Html.A -Href '#' Link2 }
                }
            }
        }
    }
    
    Html.Div -Class "container page-content" {

        Html.Div {

                    
            Metro.Div -Padding 20 {
                
                Metro.Accordion -OnFrameOpened "alert('You open frame '+frame.find('.heading').text())" {
                    Metro.AccordionItem -LayoutTitle "Heading1" { "Content" } -IsActive
                    Metro.AccordionItem -LayoutTitle "Heading2" { "Content" }
                    Metro.AccordionItem -LayoutTitle "Heading3" { "Content" } -LayoutIcon database
                }
                Html.Br
            
                Metro.Accordion -IsLargeHeading -IsCollapsible {
                    Metro.AccordionItem -LayoutTitle "Heading1" { "Content" } -LayoutIcon database
                    Metro.AccordionItem -LayoutTitle "Heading2" { "Content" } -IsDisabled 
                    Metro.AccordionItem -LayoutTitle "Heading3" { "Content" }
                }
                Html.Br
                    
                Metro.Accordion {
                    Metro.AccordionItem -LayoutTitle "Heading3" { "Content" }
                }
                Html.Br

            }

            
            Metro.Div -Padding 20 {

                Metro.Tab {
                    Metro.TabItem -LayoutTitle "Heading1" { "Content1" } -IsActive
                    Metro.TabItem -LayoutTitle "Heading2" { "Content2" }
                    Metro.TabItem -LayoutTitle "Heading3" { "Content3" }
                }
                Html.Br
                
                Metro.Tab -TabStyle Light -Position Bottom {
                    Metro.TabItem -LayoutTitle "Heading1" { "Content1" } -IsActive
                    Metro.TabItem -LayoutTitle "Heading2" { "Content2" }
                    Metro.TabItem -LayoutTitle "Heading3" { "Content3" }
                }
                Html.Br

                Metro.Tab {
                    Metro.TabItem -LayoutTitle "Heading1" { "Content1" }
                    Metro.TabItem -LayoutTitle "Heading1" { "Content1" }
                }

                Html.Br
                Html.Div -Class tabcontrol -Data @{role="tabcontrol"} {
                    Html.Ul -Class tabs {
                        Html.Li { Html.A "Heading 1" -Href '#frame1' }
                        Html.Li { Html.A "Heading 2" -Href '#frame2'  }
                        Html.Li { Html.A "Heading 3" -Href '#frame3'  }
                    }
                    Html.Div -Class frames {
                        Html.Div -Class frame -Id frame1 { "1" }
                        Html.Div -Class frame -Id frame2 { "2" }
                        Html.Div -Class frame -Id frame3 { "3" }
                    }
                }
                
                Html.Br

                Html.Div -Class tabcontrol2 -Data @{role="tabcontrol"} {
                    Html.Ul -Class tabs {
                        Html.Li { Html.A "Heading 1" -Href '#tframe1' }
                        Html.Li { Html.A "Heading 2" -Href '#tframe2'  }
                        Html.Li { Html.A "Heading 3" -Href '#tframe3'  }
                    }
                    Html.Div -Class frames {
                        Html.Div -Class frame -Id tframe1 { "1" }
                        Html.Div -Class frame -Id tframe2 { "2" }
                        Html.Div -Class frame -Id tframe3 { "3" }
                    }
                }
                
                Html.Br

                Html.Div -Class 'tabcontrol2','tabs-bottom' -Data @{role="tabcontrol"} {
                    
                    Html.Div -Class frames {
                        Html.Div -Class frame -Id vframe1 { "1" }
                        Html.Div -Class frame -Id vframe2 { "2" }
                        Html.Div -Class frame -Id vframe3 { "3" }
                    }

                    Html.Ul -Class tabs {
                        Html.Li { Html.A "Heading 1" -Href '#vframe1' }
                        Html.Li { Html.A "Heading 2" -Href '#vframe2'  }
                        Html.Li { Html.A "Heading 3" -Href '#vframe3'  }
                    }
                }

                Html.Br
            }

        }

        Html.H1 -TextContent 'Metro heading'
        Html.H2 "Metro heading"
        Html.H3 { "Metro heading" }
    
        Html.H1 -TextContent 'Metro heading ' {
            Html.Small "Secondary text"
        }
    
        $Lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean luctus lectus sit amet odio ullamcorper malesuada dignissim justo gravida. Pellentesque sagittis, tellus id sagittis accumsan, augue velit pretium urna, ac interdum dui nibh et orci. Quisque dapibus elit ut metus varius ac bibendum sem luctus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis sagittis lorem. Praesent ac eros quam."
        Metro.Paragraph -TextStyle Accent  $Lorem

        Metro.Paragraph -TextStyle Dashed $Lorem

        Metro.Paragraph -TextStyle Small $Lorem
    

        Metro.Div -Padding 20 -Style @{ 'line-height' = '30px' ; 'font-size' = '200%'} {
            Metro.Span -Margin 10 -VerticalAlign Baseline 'Baseline'
            Metro.Span -Margin 10 -VerticalAlign Bottom 'Bottom'
            Metro.Span -Margin 10 -VerticalAlign BottomText 'BottomText'
            Metro.Span -Margin 10 -VerticalAlign Middle 'Middle'
            Metro.Span -Margin 10 -VerticalAlign Sub 'Sub'
            Metro.Span -Margin 10 -VerticalAlign Super 'Super'
            Metro.Span -Margin 10 -VerticalAlign Top 'Top'
            Metro.Span -Margin 10 -VerticalAlign TopText 'TopText'
        }

        Html.Address {
            Html.Strong 'Metro UI CSS'
            'Khreschatyk str, Suite 1'
            'Kiev, Ukraine 01001'
        }

        Metro.Quote -Name blockquote -LayoutContent $Lorem -LayoutSource $Lorem

        Metro.OrderedList {
            Metro.OrderedListItem 'Lorem ipsum dolor sit amet'
            Metro.OrderedListItem 'Consectetur adipiscing elit'
            Metro.OrderedListItem 'Integer molestie lorem at massa'
            Metro.OrderedListItem 'Facilisis in pretium nisl aliquet'
            Metro.OrderedList {
                Metro.OrderedListItem 'Lorem ipsum dolor sit amet'
                Metro.OrderedListItem 'Consectetur adipiscing elit'
                Metro.OrderedListItem 'Integer molestie lorem at massa'
            }
            Metro.OrderedListItem 'Facilisis in pretium nisl aliquet'
            Metro.OrderedListItem 'Consectetur adipiscing elit'
        }

         Metro.OrderedList -BulletStyle Numeric {
            Metro.OrderedListItem 'Lorem ipsum dolor sit amet'
            Metro.OrderedListItem 'Consectetur adipiscing elit'
            Metro.OrderedListItem 'Integer molestie lorem at massa'
            Metro.OrderedListItem 'Facilisis in pretium nisl aliquet'
            Metro.OrderedList -BulletStyle Numeric {
                Metro.OrderedListItem 'Lorem ipsum dolor sit amet'
                Metro.OrderedListItem 'Consectetur adipiscing elit'
                Metro.OrderedListItem 'Integer molestie lorem at massa'
            }
            Metro.OrderedListItem 'Facilisis in pretium nisl aliquet'
            Metro.OrderedListItem 'Consectetur adipiscing elit'
        }

    
         Metro.OrderedList -BulletStyle NumericSquareMarker {
            Metro.OrderedListItem 'Lorem ipsum dolor sit amet'
            Metro.OrderedListItem 'Consectetur adipiscing elit'
            Metro.OrderedListItem 'Integer molestie lorem at massa'
            Metro.OrderedListItem 'Facilisis in pretium nisl aliquet'
            Metro.OrderedList -BulletStyle NumericSquareMarker {
                Metro.OrderedListItem 'Lorem ipsum dolor sit amet'
                Metro.OrderedListItem 'Consectetur adipiscing elit'
                Metro.OrderedListItem 'Integer molestie lorem at massa'
            }
            Metro.OrderedListItem 'Facilisis in pretium nisl aliquet'
            Metro.OrderedListItem 'Consectetur adipiscing elit'
        }

        Metro.OrderedList -BulletStyle NumericSquareMarker -IsLargeBullet -ColorBullet green {
            Metro.OrderedListItem 'Lorem ipsum dolor sit amet'
            Metro.OrderedListItem 'Consectetur adipiscing elit'
        }

        Metro.DefinitionList {
            Metro.DefinitionListNameItem 'Description lists'
            Metro.DefinitionListValueItem 'A description list is perfect for defining terms.'
            Metro.DefinitionListNameItem 'Euismod'
            Metro.DefinitionListValueItem 'Vestibulum id ligula porta felis euismod semper eget lacinia odio sem nec elit.
                Donec id elit non mi porta gravida at eget metus.'
        }

        Metro.StepList {
            Metro.StepListItem {
                Html.H2 "Improve user sign-in experience"
                Html.Hr 
                "Add a custom domain so that your users can sign in with familiar user names. For example, if your organization owns 'contoso.com', users can sign in Azure AD with user names such as 'joe@contoso.com'"
            }
            Metro.StepListItem {
                Html.H2 "Integrate with your local directory"
                Html.Hr 
                "Use the same user accounts and groups in the cloud that you already use on premises. "
       
            }
        }

        Metro.Tag -TagType Alert "Alert"
        Metro.Tag -TagType Default "Default"
        Metro.Tag -TagType Info "Info"
        Metro.Tag -TagType Success "Success"
        Metro.Tag -TagType Warning "Warning"

        Metro.AnchorTag -TagType Alert "Alert"
        Metro.AnchorTag -TagType Default "Default"
        Metro.AnchorTag -TagType Info "Info"
        Metro.AnchorTag -TagType Success "Success"
        Metro.AnchorTag -TagType Warning "Warning"


        Metro.Grid -IsCondensed {
            Metro.GridRow -Row 4 {
                Metro.GridCell -IsDebug -TextContent "1/4"
                Metro.GridCell -IsDebug -TextContent "2/4"
                Metro.GridCell -IsDebug -TextContent "3/4"
                Metro.GridCell -IsDebug -TextContent "4/4"
            }
        }
        Metro.Grid {
            Metro.GridRow -Row 4 {
                Metro.GridCell -IsDebug  "1/4"
                Metro.GridCell -IsDebug -ColumnSpan 3 "3/4"
            }
        }
    
        Metro.Grid {
            Metro.GridRow -Row 12 {
                Metro.GridCell -IsDebug -OffSet 11  "OffSet 11"
            }
        }
    
    
        Metro.Table -IsBorder -IsBordered -IsStriped -IsHovered -IsCellHovered {
            Metro.TableSectionHead {
                Metro.TableRow {
                    Metro.TableHeaderCell "Header 1"
                    Metro.TableHeaderCell "Header 2"
                    Metro.TableHeaderCell "Header 3"
                }
            }
            Metro.TableSectionBody {
                Metro.TableRow {
                    Metro.TableDataCell "a"
                    Metro.TableDataCell "b"
                    Metro.TableDataCell "c"
                }
                Metro.TableRow {
                    Metro.TableDataCell "a"
                    Metro.TableDataCell "b"
                    Metro.TableDataCell "c"
                }
            }
        }

        Metro.Table -IsBorder -IsBordered {
            Metro.TableRow {
                Metro.TableHeaderCell "Header 1"
                Metro.TableHeaderCell -IsSortable -SortOrder Ascending "Header 2"
                Metro.TableHeaderCell "Header 3"
            }
            Metro.TableRow -ProfileColor Success    {
                Metro.TableDataCell "a"
                Metro.TableDataCell "b"
                Metro.TableDataCell "c"
            }
            Metro.TableRow -ActiveForegroundColor brown {
                Metro.TableDataCell "a"
                Metro.TableDataCell "b"
                Metro.TableDataCell "c"
            }
            Metro.TableRow {
                Metro.TableDataCell "a" -RibbedBackgroundColor crimson
                Metro.TableDataCell "b"
                Metro.TableDataCell "c"
            }
            Metro.TableRow {
                Metro.TableDataCell "a"
                Metro.TableDataCell "b"
                Metro.TableDataCell "c"
            }
        }

    
        Metro.Table -IsBorder -IsBordered {
           Metro.TableSectionHead {
                Metro.TableRow {
                    Metro.TableHeaderCell "Header 1"
                    Metro.TableHeaderCell "Header 2"
                    Metro.TableHeaderCell "Header 3"
                }
            }
            Metro.TableSectionBody {
                Metro.TableRow -RibbedBackgroundColor blue {
                    Metro.TableDataCell "a"
                    Metro.TableDataCell "b"
                    Metro.TableDataCell "c"
                }
                Metro.TableRow -ForegroundColor white -HoverForegroundColor red -BackgroundColor red -HoverBackgroundColor white -{
                    Metro.TableDataCell - "a"
                    Metro.TableDataCell "b"
                    Metro.TableDataCell "c"
                }
            }
        }

        Html.Br
        Html.Br
    
        Metro.InputText -Size Big -State Required -Placeholder "aaaaaaaaaa" -IsFullWidth
        Metro.InputText -Size Big -State Error    -Placeholder "aaaaaaaaaa" -IsFullWidth
        Metro.InputText -Size Big -State Success  -Placeholder "aaaaaaaaaa"
        Metro.InputText -Size Big -State Warning  -Placeholder "aaaaaaaaaa"

        Metro.InputText -WithClearer -DefaultValue "AAAAAAAa"
        Metro.InputText -DefaultValue "eeeeeeeeee"
        Metro.InputText -DefaultValue "prepend" -PrependIcon alarm 

        Metro.InputPassword -WithRevealer -Placeholder "Enter your password"
    
        Metro.InputCheckbox -Caption "azerty" -Size Normal -Name AAAA
        Metro.InputCheckbox -Caption "bbbbbb" -Size Normal -Name AAAA
        Metro.InputCheckbox -Caption "cccccc" -Size Normal -Name AAAA -IsDisabled

        Metro.InputRadio -Caption "aaaa" -Name BBBB
        Metro.InputRadio -Caption "bbbb" -Name BBBB
        Metro.InputRadio -Caption "cccc" -Name BBBB -IsDisabled

        Metro.InputSwitcher

        Metro.InputFile

        Metro.InputButton -DefaultValue "dfsdfsdfd"
        Metro.InputReset
        Metro.InputSubmit

        Metro.Textarea

        Metro.Select {
            Metro.Option -Text "azertyu"
            Metro.Option -Text "bbbbbbbb"
        }

        Metro.InputText -PrependIcon android -Placeholder "AAAA" {
            Metro.IconButton -LayoutIcon automobile
        }

    
        Metro.InputText -PrependIcon blocked -Placeholder "AAAA" -IsFullWidth {
            Metro.GroupButton {
                Metro.IconButton -LayoutIcon automobile
                Metro.IconButton -LayoutIcon ambulance
                Metro.IconButton -LayoutIcon redo
            }
        }

        New-MetroInputTextModern -Label "Your Login" -Informer "Please enter your login or email" -Placeholder "Input Login"
        New-MetroInputTextModern -Label "Your Login" -Informer "Please enter your login or email" -Placeholder "Input Login" -PrependIcon user

        New-MetroInputPasswordModern -WithRevealer -Label "Your Password" -Informer "Please enter your password" -Placeholder "Input Password" -PrependIcon lock


        Html.Br
        Html.Br

        Metro.Div -Margin 10 {
            Metro.Button Default
            Metro.Button Disabled -Disabled
            Metro.Button -ButtonStyle Cycle +
            Metro.Button -ButtonStyle Rounded Rounded
            Metro.Button -ButtonStyle Square OK
        }

        Metro.Div -Margin 10 {
            Metro.Button -Size Mini Mini
            Metro.Button -Size Small Small
            Metro.Button -Size Large Large
            Metro.Button -ButtonStyle Cycle -Size Mini Mini
            Metro.Button -ButtonStyle Cycle -Size Small Small
            Metro.Button -ButtonStyle Cycle -Size Large Large
        }

        Metro.Div -Margin 10 {
            Metro.Button -ProfileColor Alert Alert
            Metro.Button -ProfileColor Default Default
            Metro.Button -ProfileColor Info Info
            Metro.Button -ProfileColor Success Success
            Metro.Button -ProfileColor Warning Warning
            Metro.Button -BackgroundColor pink -ActiveForegroundColor darkPink -ForegroundColor white Custom
        }


        Metro.Div -Margin 10 {
            Metro.Button -BlockShadow -TextShadow -ProfileColor Alert Alert
            Metro.Button -BlockShadow -TextShadow -ProfileColor Default Default
            Metro.Button -BlockShadow -TextShadow -ProfileColor Info Info
            Metro.Button -BlockShadow -TextShadow -ProfileColor Success Success
            Metro.Button -BlockShadow -TextShadow -ProfileColor Warning Warning 
        }

        Metro.Div -Margin 10 {
            Metro.IconButton -TextContent "Font Icon" -LayoutIcon checkmark
        }
    
        Metro.Div -Margin 10 {
          Metro.Toolbar {
            Metro.ToolbarSection {
                 Metro.ToolbarButton -LayoutIcon print
                 Metro.ToolbarButton -TextContent "2"
                 Metro.ToolbarButton -LayoutIcon pencil

            }
            Metro.ToolbarSection {
                Metro.ToolbarButton -LayoutIcon print
                Metro.ToolbarButton -LayoutIcon pencil
            }
          }
      
        }

        Metro.Div -Margin 10 {
            Metro.CommandButton -LayoutTitle "Yes, share and connect" -LayoutDescription "Use this option for home or work" -LayoutIcon attachment -LayoutIconAlign Left
            Metro.CommandButton -LayoutTitle "Yes, share and connect" -LayoutDescription "Use this option for home or work" -LayoutIcon bookmark -LayoutIconAlign Right -BackgroundColor amber -ForegroundColor white
        }
    
        Metro.Div -Margin 10 {
            Metro.ImageButton -LayoutTitle "Share this" -LayoutIcon share -LayoutIconAlign Right
        }
    
        Html.Br
        
        Metro.Div -Margin 10 {
            New-MetroShortcutButton -LayoutTitle "Rocket" -LayoutIcon rocket -LayoutBadge 10
            New-MetroShortcutButton -LayoutTitle "Rocket" -LayoutIcon rocket -LayoutBadge 10 -BackgroundColor pink -ActiveForegroundColor darkPink -ForegroundColor white
        }

        Html.Br
         
         Metro.Div -Margin 10 {
            New-MetroDropdownButton -TextContent Menu {
                Html.A 'Reply'
                Html.A 'Reply All'
                Html.A 'Forward'
            }
            New-MetroDropdownButton -TextContent Menu -Position Right {
                Html.A 'Reply' 
                Html.A 'Reply All' 
                Html.A 'Forward' 
            }
        }
    
        Html.Br
        Html.Br

         Metro.Div -Margin 10 {
            New-MetroSplitButton -TextContent Reply {
                Html.A 'Reply'
                Html.A 'Reply All'
                Html.A 'Forward'
            }
        }
         Html.Br

        Metro.Div -Margin 10 {
            Metro.Pagination {
                Metro.PaginationItem '<'
                Metro.PaginationItem 1
                Metro.PaginationItem -IsCurrent 2
                Metro.PaginationItem -IsDisabled 3
                Metro.PaginationItem -IsSpaces
                Metro.PaginationItem '>'
            }
        }
         Html.Br

        Metro.Div -Margin 10 {
            Metro.Pagination -PaginationStyle Cycle {
                Metro.PaginationItem '<'
                Metro.PaginationItem 1
                Metro.PaginationItem -IsCurrent 2
                Metro.PaginationItem -IsDisabled 3
                Metro.PaginationItem -IsSpaces '...'
                Metro.PaginationItem '>'
            }
        }
        Html.Br
   
        Metro.Div -Margin 10 {
            Metro.BreadcrumbsSimple {
                Html.A Home
                Html.A Products 
                Html.A Download
                Html.A 'Windows 10'
            }
        }
         Html.Br

         Metro.Div -Margin 10 {
            Metro.BreadcrumbsSimple -BackgroundColor dark  {
                Html.A Home
                Html.A Products 
                Html.A Download
                Html.A 'Windows 10'
            }
         }
         Html.Br

        Metro.Div -Margin 10 {
            Metro.Breadcrumbs  {
                Html.A Home
                Html.A Products 
                Html.A Download
                Html.A 'Windows 10'
            }
        }
         Html.Br


        Metro.Div -Margin 10 {
            Metro.Breadcrumbs -Size Mini  {
                Html.A Home
                Html.A Products 
                Html.A Download
                Html.A 'Windows 10'
            }
        }
         Html.Br


         Metro.Grid {
            Metro.GridRow -Row 6 {
                Metro.GridCell {
                    Metro.ImageContainer -Source "http://metroui.org.ua/images/1.jpg"
                }
                Metro.GridCell {
                    Metro.ImageContainer -Source "http://metroui.org.ua/images/1.jpg" -ContainerType Rounded
                }
                Metro.GridCell {
                     Metro.ImageContainer -Source "http://metroui.org.ua/images/1.jpg" -ContainerType Bordered
                }
                Metro.GridCell {
                     Metro.ImageContainer -Source "http://metroui.org.ua/images/1.jpg" -ContainerType Polaroid
                }
                Metro.GridCell {
                    Metro.ImageContainer -Source "http://metroui.org.ua/images/1.jpg" -ContainerType Handing
                }
                Metro.GridCell {
                    Metro.ImageContainer -Source "http://metroui.org.ua/images/1.jpg" -ContainerType HandingAnimated
                }
            }
            Metro.GridRow -Row 3 {
                Metro.GridCell {
                     Metro.ImageContainer -Source "http://metroui.org.ua/images/1.jpg" -ColorOverlay red {
                        Html.H2 -TextContent "Title"
                        Metro.Paragraph -TextContent "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing"
                     }
                }
                Metro.GridCell {
                    Metro.ImageContainer -Source "http://metroui.org.ua/images/2.jpg" {
                        Html.H2 -TextContent "Title"
                        Metro.Paragraph -TextContent "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing"
                    }
                }
                Metro.GridCell {
                    Metro.ImageContainer -Source "http://metroui.org.ua/images/4.jpg" -IsSelected -ColorOverlay black {
                        Html.H2 -TextContent "Title"
                        Metro.Paragraph -TextContent "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing"
                    }
                }
            }
            Metro.GridRow -Row 7 {
                Metro.GridCell {
                     Metro.Image -Source "http://metroui.org.ua/images/1.jpg" -Format HD
                }
                Metro.GridCell {
                    Metro.Image -Source "http://metroui.org.ua/images/1.jpg" -Format SD
                }
                Metro.GridCell {
                    Metro.Image -Source "http://metroui.org.ua/images/4.jpg" -Format Square
                }
                 Metro.GridCell {
                    Metro.Image -Source "http://metroui.org.ua/images/4.jpg" -Format Diamond
                }
                 Metro.GridCell {
                    Metro.Image -Source "http://metroui.org.ua/images/4.jpg" -Format Cycle 
                }
                Metro.GridCell {
                    Metro.Image -Source "http://metroui.org.ua/images/4.jpg" -Format Bordered -OverlayText "fdsfsdqfsdfsd"
                }
                 Metro.GridCell {
                    Metro.Image -Source "http://metroui.org.ua/images/4.jpg" -Format HandingAnimated -OverlayText "fdsfsdqfsdfsd"
                }
            }
         }

           Html.Br


        Html.Div -Class countdown -Attributes @{'data-role'='countdown';'data-days'='2'}

          Html.Br
   
        # Metro.Charm  -Position Left -Id 'left-charm' {
            # Html.H3 "Left Charm"
        # }
        # Metro.Charm  -Position Right -Id 'right-charm' {
            # Html.H3 "Right Charm"
        # }
        # Metro.Charm  -Position Top -Id 'top-charm' {
            # Html.H3 "Top Charm"
        # }
        # Metro.Charm  -Position Bottom -Id 'bottom-charm' {
            # Html.H3 "Bottom Charm"
        # }
        # Html.Script -Type text/javascript -TextContent @'
            # function showCharm(id){
                # var  charm = $("#"+id+"-charm").data("charm");
                # if (charm.element.data("opened") === true) {
                    # charm.close();
                # } else {
                    # charm.open();
                # }
            # }
# '@
        # Metro.Button -TextContent "LeftSize" -Attributes @{ 'onClick' = "showCharm('left')" }
        # Metro.Button -TextContent "RightSize" -Attributes @{ 'onClick' = "showCharm('right')" }
        # Metro.Button -TextContent "TopSize" -Attributes @{ 'onClick' = "showCharm('top')" }
        # Metro.Button -TextContent "BottomSize" -Attributes @{ 'onClick' = "showCharm('bottom')" }
    
          Html.Br

        Metro.Grid {
            Metro.GridRow -Row 2 {
                Metro.GridCell  {
                    # Metro.VideoPlayer -Source 'http://metroui.org.ua/res/oceans.mp4'
                }
                Metro.GridCell {
                    # Metro.AudioPlayer -Source 'http://metroui.org.ua/res/rec.mp3'
                    # Metro.AudioPlayer -DisplayMode Small -Source 'http://metroui.org.ua/res/rec.mp3'
                    # Metro.AudioPlayer -DisplayMode Micro -Source 'http://metroui.org.ua/res/rec.mp3'
                }
            }
        }
        Html.Br

        Get-Process | Select -First 5 | ConvertTo-MetroTable -RibbedBackgroundColor gray -IsStriped -ForegroundColor amber -AllProperties
    
        Html.Br
    
        Get-Command -Module PackageManagement | Select -First 5 | ConvertTo-MetroTable -IsStriped -IsBorder -IsBordered -IsHovered -IsCellHovered

        Html.Br
        Html.Br
    }
}

$Html = $MetroPage.ToPrettyHtml()
# $Html = $MetroPage.ToFlatHtml()

$HtmlFile = "$env:Temp\HtmlTest.html"
Set-Content -Value $Html -Path $HtmlFile

Invoke-Item $HtmlFile