Import-Module $PSScriptRoot\..\Html, $PSScriptRoot\..\MetroHtml
$PageParams = @{
    Title = "frpsug.github.io"
    Description = "Association Francophone des Utilisateurs de Powershell"
    Author = "Me"
    Keywords = "powershell, PowerShell, FRPSUG, frpsug, association, utilisateurs, actualité¬ traduction, support, information, informations, forum, aide, support, module, command, powershellday, franè¢©s, francophone, francophonie" -split ","
    Language = "FR"
    Charset = "UTF-8"
    Stylesheet = @(
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro.min.css"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro-icons.min.css"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro-responsive.min.css"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/css/metro-schemes.min.css"
    )
    Css = @{
        'div#heading' = @{
            'padding-top' = '1.5rem'
        }
        '.app-bar, .app-bar .app-bar-divider, .app-bar .app-bar-element, .app-bar .app-bar-menu>li, .app-bar .app-bar-menu>li>a ' = @{
            'line-height' = '2.00rem !important'
            'height' = '2.00rem !important'
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
$MetroPage = Html.Page @PageParams -Append {
    Html.Div -Style @{ 'height' = '100%' ; 'background-color' = '#EFEAE3' } {
        Metro.AppBar -Fixed Top -Style @{ 'background-color' = '#000000' } {
            Html.Div -Class 'container' {
                 Metro.AppBarElement -IsBranding -TextContent "Accueil" -Prepend {
                    Html.Span -Class "mif-home icon" -Style @{ 'display' = 'inline-block' ; 'margin-right' = '10px' }
                }
                Metro.AppBarElement -IsPositionRight -TextContent "Contactez-nous"
                Metro.AppBarElement -IsPositionRight -TextContent "FAQ"
                Metro.AppBarElement -IsPositionRight -TextContent "A propos"
                Metro.AppBarElement -IsPositionRight -TextContent "S'authentifier"
            }
        }
        Html.Div -Id heading -Class 'bg-darkBlue', 'fg-white' -Style @{ 'min-height' = '100px' } {
             Html.Div -Class 'container block-shadow padding10 no-padding-bottom' {
                    Html.Div {
                        Html.Div  {
                            Html.Div -Class 'place-left' -Style @{ height = '200px'; 'padding-right' = '20px' } {
                                Html.Img -Source 'https://www.powershellgallery.com/Content/Images/packageDefaultIcon.png'
                            }
                            Html.H1 -Class 'text-shadow metro-title' 'French PowerShell User Group'
                        }
                        Html.Div -Class 'place-right' {
                           
                        }
                    }
                    Html.Div {
                        Html.Div -Class 'no-overflow' {
                            Html.Div -Class 'grid', 'no-margin-bottom' {
                                Html.Div -Class 'row','cells4' -Style @{ 'text-align' = 'center' } {
                                    Html.Div -Class 'cell no-overflow' -Style @{ 'height' = '60px' } {
                                        Metro.Div -Class 'bg-white', 'fg-dark', 'block-shadow' -Style @{ 'height' = '60px' ; 'padding-top' = '1px' ; 'margin-top' = '0px' } {
                                            Html.H2 -Class "text-shadow text-light" -Text "Accueil"
                                        }
                                    }
                                    Html.Div -Class 'cell no-overflow' -Style @{ 'height' = '60px' } {
                                        Metro.Div -Class 'bg-yellow', 'fg-white', 'block-shadow' -Style @{ 'height' = '60px' ; 'padding-top' = '1px' ; 'margin-top' = '0px' } {
                                            Html.H2 -Class "text-shadow text-light" -Text "Actualités"
                                        }
                                    }
                                    Html.Div -Class 'cell no-overflow' -Style @{ 'height' = '60px' } {
                                        Metro.Div -Class 'bg-green', 'fg-white', 'block-shadow' -Style @{ 'height' = '60px' ; 'padding-top' = '1px' ; 'margin-top' = '0px' } {
                                            Html.H2 -Class "text-shadow text-light" -Text "Association"
                                        }
                                    }
                                    Html.Div -Class 'cell no-overflow' -Style @{ 'height' = '60px' } {
                                        Metro.Div -Class 'bg-red', 'fg-white', 'block-shadow' -Style @{ 'height' = '60px' ; 'padding-top' = '1px' ; 'margin-top' = '0px' } {
                                            Html.H2 -Class "text-shadow text-light" -Text "PowerShell"
                                        } 
                                    }
                                }
                            }
                        }
                    }
                }
        }
        Html.Div -Class 'page-content', 'bg-white' {
            Html.Div -Class 'container block-shadow' -Style @{ 'min-height' = '100px' }  {
                Html.Div -Class 'bg-gray' {
                    Html.Ul -Class 'm-menu' -Style @{'box-shadow'= '0 0 0 0'} {
                        Html.Li { Html.A 'Accueil' -Href '#' }
                        Html.Li { 
                            Html.A -Class 'dropdown-toggle' -Href '#' 'Actualités' 
                            Html.Ul -Class 'd-menu' -Data @{ 'role' = 'dropdown' } {
                                Html.Li { Html.A 'Evènements Francophone' -Href '#' }
                                Html.Li { Html.A "L'équipe PowerShell" -Href '#' }
                                Html.Li { Html.A 'Informations techniques' -Href '#' }
                                Html.Li { Html.A 'La communauté' -Href '#' }
                            }
                        }
                        Html.Li { 
                            Html.A -Class 'dropdown-toggle' -Href '#' 'Association'
                            Html.Ul -Class 'd-menu' -Data @{ 'role' = 'dropdown' } {
                                Html.Li { Html.A "FRPSUG" -Href '#' }
                                Html.Li { Html.A "Adhérer" -Href '#' }
                                Html.Li { Html.A "Conseil d'administration" -Href '#' }
                                Html.Li { Html.A 'Status' -Href '#' }
                                Html.Li { Html.A 'Règlement intérieur' -Href '#' }
                                Html.Li { Html.A 'Assemblée générale' -Href '#' }
                            }
                        }
                        Html.Li { 
                            Html.A 'PowerShell' -Href '#' 
                        }
                        Html.Li { 
                            Html.A 'Overview' -Href '#'
                            Html.Div -Class 'm-menu-container' -Data @{ 'role' = 'dropdown' ; 'no-close' = 'true' } {
                                Html.Img -Source "https://www.powershellgallery.com/Content/Images/packageDefaultIcon.png"
                            }
                        }
                    }
                }
                Html.Div -Class 'padding10' {
                    Html.Div -Style @{ 'padding-top' = '1px' } {
                        Metro.Breadcrumbs  {
                            Html.A 'Accueil'
                            Html.A 'Actualités'
                            Html.A 'La Communauté'
                        }
                    }
                    Html.Div -Class 'example' -Data @{ 'text' = 'Actualités' } {
                        Html.Text "page-content"
                        0..5 | %{ Html.Br }

                        Html.Div -Class 'carousel square-bullets' -Data @{role="carousel"} {
                            Html.Div -Class 'slide' {
                                    Html.Div -class "window" -Style @{ width = '480px' ; height = '250px' } { 
                                        Html.Div -class "window-caption bg-cyan fg-white" {
                                            Html.span -class "window-caption-icon" {
                                                Html.span -class "mif-windows"
                                            }
                                            Html.span -class "window-caption-title" -Text "20/09/2016 - Analyse syntaxique de données"
                                            Html.span -class "btn-close bg-red fg-white"
                                        }
                                        Html.Div -class "window-content bg-dark fg-white" {
                                            Html.Div -Class 'video-container'  {
                                                Html.Iframe -Source "https://www.youtube.com/embed/sCd8YufeyUI?showinfo=0" -Frameborder 0 -IsFullscreenAllowed -Style @{ width="480px" ; height="240px" }
                                            }
                                       }
                                 }
                            }
                            Html.Div -Class 'slide' {
                                 "AAAAAAAAAAAAa"
                            }
                      }
                    }
                }
            }
        }
        Html.Div -Class 'bg-grayDarker' {
            Html.Div -Class 'container block-shadow', 'padding10', 'fg-white' {
                Html.Div -Class 'place-left' -Style @{ 'padding-right' = '20px' } {
                    Html.Img -Source 'https://www.powershellgallery.com/Content/Images/packageDefaultIcon.png'
                }
                Html.H1 -Class 'text-shadow' 'Thanks to Microsoft'
                Html.P 'This Project was created in the best IDE - PhpStorm. Thanks to the company JetBrains for supporting the project in the form of a license for a great product PhpStorm.'
                Html.A -Class "button","success" -Href "http://www.jetbrains.com/phpstorm/" -Text 'Get Powershell'
            }
        }
        Html.Footer {
            Html.Div -Class 'container' {
                Html.Div -Class 'bottom-menu-wrapper' {
                    Html.Ul -Class 'horizontal-menu compact' {
                        Html.Li { Html.A -Text '© 2016 AFUPS' }
                        Html.Li -Class 'place-right' { Html.A -Text 'Contact' -Href '#' }
                        Html.Li -Class 'place-right' { Html.A -Text 'CGU' -Href '#' }
                        Html.Li -Class 'place-right' { Html.A -Text 'Mentions légales' -Href '#' }
                        Html.Li -Class 'place-right' { Html.A -Text 'Plan de site' -Href '#' }
                        Html.Li -Class 'place-right' { Html.A -Text 'Recherche' -Href '#' }
                    }
                }
                Metro.Div -Class 'place-right' -Padding 10 {
                    Html.Text "Ce site n'est pas affilié au projet Powershell ni approuvé par eux."
                }
            }
        }
    }
}
$Html = $MetroPage.ToPrettyHtml()
$HtmlFile = "$env:Temp\HtmlTest.html"
Set-Content -Value $Html -Path $HtmlFile
Invoke-Item $HtmlFile