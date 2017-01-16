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
    Javascript = @(
        "https://code.jquery.com/jquery-2.2.3.min.js"
        "https://cdn.rawgit.com/olton/Metro-UI-CSS/master/build/js/metro.js"
    )
}

$MetroPage = Html.Page @PageParams -Append {
    Html.Text 'éllo Word !'
}

$Html = $MetroPage.ToPrettyHtml()
# $Html = $MetroPage.ToFlatHtml()

$HtmlFile = "$env:Temp\HtmlTest.html"
Set-Content -Value $Html -Path $HtmlFile

Invoke-Item $HtmlFile