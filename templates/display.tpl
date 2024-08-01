<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
    <!-- ENG - Meta tags for encoding and viewport settings -->
    <!-- ESP - Etiquetas meta para la codificación y la configuración del viewport -->
    <meta http-equiv="X-UA-Compatible" content"ie=edge">
    <meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$title|escape}</title>

    <!-- ENG - Loading headers, stylesheets, and scripts specific to the frontend context -->
    <!-- ESP - Cargando encabezados, hojas de estilo y scripts específicos para el contexto de frontend -->
    {load_header context="frontend" headers=$headers}
    {load_stylesheet context="frontend" stylesheets=$stylesheets}
    {load_script context="frontend" scripts=$scripts}

    <!-- ENG - Loading Video.js styles and scripts for video playback -->
    <!-- ESP - Cargando estilos y scripts de Video.js para la reproducción de video -->
    <link href="https://vjs.zencdn.net/7.19.2/video-js.css" rel="stylesheet" />
    <script src="https://vjs.zencdn.net/7.19.2/video.js"></script>

    <!-- ENG - Custom styles for the page -->
    <!-- ESP - Estilos personalizados para la página -->
    <style>
        body {
            font-family: 'Georgia', serif;
            text-align: justify;
            line-height: 1.6;
            background-color: #f9f9f9;
            color: #333;
        }
        .header_view {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            text-align: justify;
            margin-bottom: 20px;
            padding: 19px;
            background-color: #1e6292;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .header_view a {
            text-decoration: none;
            color: #1e6292;
        }
        .header_view .return {
            position: absolute;
            top: 0;
            left: 0;
            width: 34px;
            height: 38px;
            line-height: 41px;
            text-align: center;
        }
        .header_view .download {
           width: auto;
           height: auto;
           padding: 3.8px;
           margin: auto;
        }
        .header_view h1 {
            margin: 0;
            font-size: 24px;
        }
        .header_view h2 {
            position: absolute;
            top: 10px;
            left: 50px;
            font-size: 15px;
            color: white;
            margin: 0;
        }
        @media (max-width: 600px) {
            .header_view h2 {
                font-size: 12px;
                top: 5px;
                left: 45px;
            }
        }
        .content {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .content h2, .content h3, .content p {
            margin: 0 0 10px;
        }
        .content h2 {
            font-size: 20px;
            color: black;
        }
        .content h3 {
            font-size: 18px;
            color: black;
        }
        .content p {
            font-size: 16px;
            color: black;
        }
        .video-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px 0;
            padding: 20px;
            position: relative;
        }
        .video-js {
            width: 100%;
            max-width: 800px;
            height: 450px; /* ENG - Set a fixed height for the player */
            /* ESP - Establecer una altura fija para el reproductor */
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
    </style>
</head>
<body class="pkp_page_{$requestedPage|escape} pkp_op_{$requestedOp|escape}">

    <!-- ENG - Header of the view -->
    <!-- ESP - Encabezado de la vista -->
    <header class="header_view">
        <!-- ENG - Link to go back to the previous page -->
        <!-- ESP - Enlace para regresar a la página anterior -->
        <a href="javascript:history.go(-1);" class="return">
            <span class="pkp_screen_reader">
                {if $parent instanceOf Issue}
                    {translate key="issue.return"}
                {else}
                    {translate key="article.return"}
                {/if}
            </span>
        </a>
        <h2>{$page_title}</h2>
        <!-- ENG - Link to download the video -->
        <!-- ESP - Enlace para descargar el video -->
        <a href="{$videoUrl}" class="download" download>
            <span class="label">
                {translate key="common.download"}
            </span>
            <span class="pkp_screen_reader">
                {translate key="common.downloadVideo"}
            </span>
        </a>
    </header>
    <!-- ENG - Additional space -->
    <!-- ESP - Espacio adicional -->
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <!-- ENG - Video container -->
    <!-- ESP - Contenedor del video -->
    <div id="videoCanvasContainer" class="galley_view{if !$isLatestPublication} galley_view_with_notice{/if}">
        <div class="video-container">
            <!-- ENG - Video player using Video.js -->
            <!-- ESP - Reproductor de video usando Video.js -->
            <video id="video-js" class="video-js vjs-default-skin" controls preload="auto" autoplay>
                <source src="{$videoUrl}" type="video/mp4">
                <p class="vjs-no-js">
                    {translate key="plugins.generic.videoJsViewer.noJsMessage"}
                </p>
            </video>
        </div>
    </div>
    <!-- ENG - Additional space -->
    <!-- ESP - Espacio adicional -->
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <!-- ENG - Additional content -->
    <!-- ESP - Contenido adicional -->
    <div class="content">
        <h1>{$page_title|escape}</h1>
        <h3>{translate key="author.name"}: {$author->getFullName()}</h3>
        <p><strong>{translate key="article.abstract"}:</strong> {$submission->getLocalizedAbstract()}</p>
        <p><strong>{translate key="article.publicationDate"}:</strong> {$datePublished|date_format:"%B %e, %Y"}</p>
    </div>
    <!-- ENG - Video.js script initialization and custom controls -->
    <!-- ESP - Inicialización del script Video.js y controles personalizados -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const player = videojs('video-js');
            const bigPlayButton = document.querySelector('.vjs-big-play-button');

            player.ready(function() {
                this.play();

                // ENG - Ensure controls are visible
                // ESP - Asegurar que los controles sean visibles
                this.controls(true);

                this.on('play', function() {
                    bigPlayButton.style.display = 'none';
                });

                this.on('pause', function() {
                    bigPlayButton.style.display = '';
                });

                // ENG - Add skip buttons to the control bar
                // ESP - Agregar botones de avance rápido a la barra de controles
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
