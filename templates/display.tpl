<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
    <!-- Meta tags for encoding and viewport settings -->
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$title|escape}</title>

    <!-- Loading headers, stylesheets, and scripts specific to the frontend context -->
    {load_header context="frontend" headers=$headers}
    {load_stylesheet context="frontend" stylesheets=$stylesheets}
    {load_script context="frontend" scripts=$scripts}

    <!-- Loading Video.js styles and scripts for video playback -->
    <link href="https://vjs.zencdn.net/7.19.2/video-js.css" rel="stylesheet" />
    <script src="https://vjs.zencdn.net/7.19.2/video.js"></script>

    <!-- Custom styles for the page -->
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: justify;
            line-height: 1.6;
            background-color: white;
            color: #333;
        }
         .header_view .page_title {
            display: block;
            padding-left: 2.857rem;
            max-width: 100%;
            overflow-x: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #fff;
         }
        .container {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            max-width: 2072px;
            width: 92.9%;
            margin: 20px auto;
        }
        .video-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px 0;
            padding: 20px;
            position: relative;
            box-sizing: border-box;
            height: 590px;
        }
        .video-js {
            height: 590px;
            max-width: 100%;
            width: 100%;
        }
        .content {
            flex: 0.5;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 19px;
            max-height: 592px;
            overflow-y: auto; 
        }
        .content h3, .content p {
            margin: 0 0 10px;
        }
        .content h1 {
            font-family: 'Montserrat', sans-serif;
            font-size: 34.5px;
            color: black;
        }
        .content h3 {
            font-family: 'Times New Roman', sans-serif;
            font-style: italic;
            font-size: 24px;
            color: black;
        }
        .content p {
            font-family: 'Merriweather', serif;
            font-size: 17.5px;
            line-height: 1.8;
            color: black;
        }
        @media (max-width: 600px) {
            .container {
                flex-direction: column;
            }
            .video-container {
                margin: 20px 0 0 0; 
                padding: 0 !important; 
                height: 200px;
                width: 100%;
            }
            .video-js {
                width: 100%;
                height: 220px; 
                font-size: 10px !important;
            }
            .content{
                width: 100%;
                margin-top: 20px;
                max-height: 100%;
                overflow-y: visible;
            }
            .galley_view {
                padding: 20px !important;
            }
        }
        .video-js {
            font-size: 15px;
        }
        .vjs-big-play-button {
            display: none !important;
        }
        .vjs-control-bar {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .skip-button {
            background-color: rgba(0, 0, 0, 0.5);
            border: none;
            color: white;
            font-size: 14px;
            padding: 5px 10px;
            cursor: pointer;
            margin: 0 5px;
        }
        .skip-button:hover {
            background-color: rgba(0, 0, 0, 0.7);
        }
        .galley_view {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            overflow-y: hidden;
            padding: 34.5px;
        }
    </style>
</head>
<body class="pkp_page_{$requestedPage|escape} pkp_op_{$requestedOp|escape}">

    <!-- Header of the view -->
    <header class="header_view">
        <!-- Link to go back to the previous page -->
        <a href="javascript:history.go(-1);" class="return">
            <span class="pkp_screen_reader">
                {if $parent instanceOf Issue}
                    {translate key="issue.return"}
                {else}
                    {translate key="article.return"}
                {/if}
            </span>
        </a>
        <a class="title">{$page_title}</a>
        <!-- Link to download the video -->
        <a href="{$videoUrl}" class="download" download>
            <span class="label">
                {translate key="common.download"}
            </span>
            <span class="pkp_screen_reader">
                {translate key="common.downloadVideo"}
            </span>
        </a>
    </header>

    <!-- Main container for video and content -->
    <div class="container">
        <!-- Video container -->
        <div class="video-container">
            <!-- Video player using Video.js -->
            <video id="video-js" class="video-js vjs-default-skin" controls preload="auto" autoplay="true">
                <source src="{$videoUrl}" type="video/mp4">
                <p class="vjs-no-js">
                    {translate key="plugins.generic.videoJsViewer.noJsMessage"}
                </p>
            </video>
        </div>
        <!-- Additional content -->
<div class="content">
    <h1>{$page_title|escape}</h1>

    {if $authors}
    <div class="authors">
        <h3>{translate key="article.authors"}:</h3>
        {foreach from=$authors item=author}
            <div class="author-details">
                <p><strong>{translate key="author.name"}:</strong> {$author.name|escape}</p>
                {if $author.orcid}
                    <p><strong>{translate key="author.orcid"}:</strong> <a href="{$author.orcid|escape}" target="_blank">{$author.orcid|escape}</a></p>
                {/if}
                {if $author.affiliation}
                    <p><strong>{translate key="author.affiliation"}:</strong> {$author.affiliation|escape}</p>
                {/if}
            </div>
        {/foreach}
    </div>
    {/if}

    {if $doi}
        <p><strong>DOI:</strong> <a href="https://doi.org/{$doi}" target="_blank">{$doi}</a></p>
    {/if}

     {if $keywords}
        <p><strong>{translate key="article.keywords"}:</strong> {foreach from=$keywords item=keyword}{$keyword|escape}{if !$smarty.foreach.keywords.last}, {/if}{/foreach}</p>
    {/if}
    <p><strong>{translate key="article.abstract"}:</strong> {$submission->getLocalizedAbstract()}</p>
    <p><strong>{translate key="article.publicationDate"}:</strong> {$datePublished|date_format:"%B %e, %Y"}</p>
    
</div>
</div>

    <!-- Video.js script initialization and custom controls -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const player = videojs('video-js');
            const bigPlayButton = document.querySelector('.vjs-big-play-button');

            player.ready(function() {
                this.play();

                // Ensure controls are visible
                this.controls(true);

                this.on('play', function() {
                    bigPlayButton.style.display = 'none';
                });

                this.on('pause', function() {
                    bigPlayButton.style.display = '';
                });

                // Add skip buttons to the control bar
                const skipBackwardButton = document.createElement('button');
                skipBackwardButton.className = 'vjs-control skip-button';
                skipBackwardButton.innerHTML = '-5s';
                skipBackwardButton.onclick = function() {
                    player.currentTime(player.currentTime() - 5);
                };

                const skipForwardButton = document.createElement('button');
                skipForwardButton.className = 'vjs-control skip-button';
                skipForwardButton.innerHTML = '+5s';
                skipForwardButton.onclick = function() {
                    player.currentTime(player.currentTime() + 5);
                };

                const controlBar = player.controlBar.el();
                controlBar.appendChild(skipBackwardButton);
                controlBar.appendChild(skipForwardButton);
            });
        });
    </script>
</body>
</html>
