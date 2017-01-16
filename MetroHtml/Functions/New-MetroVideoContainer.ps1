function New-MetroVideoContainer {

    Param(
        $EmbedUrl
    )
    New-MetroDiv -Class video-container {
        New-HtmlIframe -Source $EmbedUrl
    }

}
