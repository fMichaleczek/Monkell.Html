Import-Module $PSScriptRoot\..\Html -Force

$HtmlDocument = [AngleSharp.Parser.Html.HtmlParser]::new().Parse(@"
<!DOCTYPE html>
<html lang=en>
  <meta charset=utf-8>
  <meta name=viewport content=""initial-scale=1, minimum-scale=1, width=device-width"">
  <title>Error 404 (Not Found)!!1</title>
  <style>
    *{margin:0;padding:0}html,code{font:15px/22px arial,sans-serif}html{background:#fff;color:#222;padding:15px}body{margin:7% auto 0;max-width:390px;min-height:180px;padding:30px 0 15px}* > body{background:url(//www.google.com/images/errors/robot.png) 100% 5px no-repeat;padding-right:205px}p{margin:11px 0 22px;overflow:hidden}ins{color:#777;text-decoration:none}a img{border:0}@media screen and (max-width:772px){body{background:none;margin-top:0;max-width:none;padding-right:0}}#logo{background:url(//www.google.com/images/errors/logo_sm_2.png) no-repeat}@media only screen and (min-resolution:192dpi){#logo{background:url(//www.google.com/images/errors/logo_sm_2_hr.png) no-repeat 0% 0%/100% 100%;-moz-border-image:url(//www.google.com/images/errors/logo_sm_2_hr.png) 0}}@media only screen and (-webkit-min-device-pixel-ratio:2){#logo{background:url(//www.google.com/images/errors/logo_sm_2_hr.png) no-repeat;-webkit-background-size:100% 100%}}#logo{display:inline-block;height:55px;width:150px}
  </style>
  <a href=//www.google.com/><span id=logo aria-label=Google></span></a>
  <p><b>404.</b> <ins>That’s an error.</ins>
  <p>The requested URL <code>/error</code> was not found on this server.  <ins>That’s all we know.</ins>";
"@)

$HtmlDocument = Invoke-WebParser -Html @"
<!DOCTYPE html>
<html lang=en>
  <meta charset=utf-8>
  <meta name=viewport content=""initial-scale=1, minimum-scale=1, width=device-width"">
  <title>Error 404 (Not Found)!!1</title>
  <style>
    *{margin:0;padding:0}html,code{font:15px/22px arial,sans-serif}html{background:#fff;color:#222;padding:15px}body{margin:7% auto 0;max-width:390px;min-height:180px;padding:30px 0 15px}* > body{background:url(//www.google.com/images/errors/robot.png) 100% 5px no-repeat;padding-right:205px}p{margin:11px 0 22px;overflow:hidden}ins{color:#777;text-decoration:none}a img{border:0}@media screen and (max-width:772px){body{background:none;margin-top:0;max-width:none;padding-right:0}}#logo{background:url(//www.google.com/images/errors/logo_sm_2.png) no-repeat}@media only screen and (min-resolution:192dpi){#logo{background:url(//www.google.com/images/errors/logo_sm_2_hr.png) no-repeat 0% 0%/100% 100%;-moz-border-image:url(//www.google.com/images/errors/logo_sm_2_hr.png) 0}}@media only screen and (-webkit-min-device-pixel-ratio:2){#logo{background:url(//www.google.com/images/errors/logo_sm_2_hr.png) no-repeat;-webkit-background-size:100% 100%}}#logo{display:inline-block;height:55px;width:150px}
  </style>
  <a href=//www.google.com/><span id=logo aria-label=Google></span></a>
  <p><b>404.</b> <ins>That’s an error.</ins>
  <p>The requested URL <code>/error</code> was not found on this server.  <ins>That’s all we know.</ins>";
"@

$HtmlAList = Invoke-WebParser -url http://www.powershellmagazine.com/ -Selector "div.content-loop div.post h2 a"
$LinkList = $HtmlAList  | select TextContent, href


$HtmlAList = Invoke-WebParser -url "https://en.wikipedia.org/wiki/List_of_The_Big_Bang_Theory_episodes" -selector "tr.vevent td:nth-child(3) a" | Where { $_.Title } 
$TheBigBangTheoryEpisodeList = for ($i = 0; $i -lt $HtmlAList.Count ; $i++) {
	$HtmlAList[$i] | Select @{N='Id';E={$i}}, Title, Href
}

$Configuration = [AngleSharp.Configuration]::Default
$Configuration = [AngleSharp.ConfigurationExtensions]::WithDefaultLoader($Configuration)
$BrowsingContext = [AngleSharp.BrowsingContext]::New.Invoke($Configuration)
$Url = "https://en.wikipedia.org/wiki/List_of_The_Big_Bang_Theory_episodes"
$Document = [AngleSharp.BrowsingContextExtensions]::OpenAsync($BrowsingContext, $Url) | Select -Expand Result
$CellSelector = "tr.vevent td:nth-child(3) a"
$Cells = $Document.QuerySelectorAll($CellSelector) | Where { $_.Title } 
$TheBigBangTheoryEpisodeList = for ($i = 0; $i -lt $Cells.Count ; $i++) {
	$Cells[$i] | Select @{N='#';E={$i}}, Title, Href
}