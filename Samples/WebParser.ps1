Import-Module $PSScriptRoot\..\Html -Force
# Invoke-WebParser -url "https://en.wikipedia.org/wiki/List_of_The_Big_Bang_Theory_episodes" -selector "tr.vevent td:nth-child(3)"
Invoke-WebParser -url http://www.powershellmagazine.com/ -Selector "div.content-loop div.post h2 a" | select TextContent, href