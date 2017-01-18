# API 
# https://ace.c9.io/#nav=howto&api=ace


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
        "https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.3/ace.js"
        "https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.3/ext-language_tools.js"
        "https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.3/theme-xcode.js"
        "https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.3/mode-powershell.js"
    )
}

$MetroPage = Html.Page @PageParams -Append {

	Html.Style -Type text/css -Media screen -TextContent @'
	#editor { 
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
    }
'@

	Html.Div -Id editor

	Html.Script -Type "text/javascript" -TextContent @'
    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/clouds");
    editor.getSession().setMode("ace/mode/powershell");
	editor.setValue("Get-Process | Sort | Select -First 5");
	editor.commands.addCommand({
		name: 'myCommand',
		bindKey: {win: 'Ctrl-M',  mac: 'Command-M'},
		exec: function(editor) {
			//...
		},
		readOnly: true // false if this command should not apply in readOnly mode
	});
'@

}

$Html = $MetroPage.ToPrettyHtml()
# $Html = $MetroPage.ToFlatHtml()

$HtmlFile = "$env:Temp\HtmlTest.html"
Set-Content -Value $Html -Path $HtmlFile

Invoke-Item $HtmlFile
