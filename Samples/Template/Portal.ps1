Html.Div {
    Html.Header -Class 'margin20', 'no-margin-left', 'no-margin-right' {
        Html.Div -Class 'clear-float' {
            Html.Div -Class 'place-right' {
                Html.Form {
                    Html.Div -Class 'input-control', 'text', 'margin20' -Style @{ Width = '300px' } {
                        Html.Input -Type 'text' -Name 'q' -Placeholder 'Search...'
                        Html.Button -Class 'button' { Html.Span -Class 'mif-search' }
                    }
                }
            }
            Html.A -Class 'place-left' -href '#' { Html.H1 'News Portal' }
        }
        Html.Div -Class 'main-menu-wrapper' {
            Html.Ul -Class 'horizontal-menu' -Style @{ 'margin-left' =  '-20px' } {
                Html.Li { Html.A -href '#' -Text 'news' }
                Html.Li { Html.A -href '#' -Text 'sports' }
                Html.Li { Html.A -href '#' -Text 'entertainment' }
                Html.Li { Html.A -href '#' -Text 'money' }
                Html.Li { Html.A -href '#' -Text 'autos' }
                Html.Li { Html.A -href '#' -Text 'health' }
                Html.Li -Class 'place-right' {
                    Html.A -href '#' -Class 'dropdown-toggle' -Text options
                    Html.Ul -Class 'd-menu', 'place-right' -Data @{ role = 'dropdown' } {
                        Html.Li { Html.A -href '#' -Text 'Go to Classic MSN' }
                        Html.Li { Html.A -href '#' -Text 'MSN Worldwide' } 
                    }
                }
            }
        }
    }

}