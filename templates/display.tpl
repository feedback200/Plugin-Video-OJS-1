<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
    <!-- Meta tags for encoding and viewport settings -->
    <!-- ENG - Meta tags for encoding and viewport settings -->
    <!-- ESP - Etiquetas meta para codificación y configuración del viewport -->
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$title|escape}</title>

    <!-- Loading headers, stylesheets, and scripts specific to the frontend context -->
    <!-- ENG - Loading headers, stylesheets, and scripts specific to the frontend context -->
    <!-- ESP - Cargando encabezados, hojas de estilo y scripts específicos del contexto de frontend -->
    {load_header context="frontend" headers=$headers}
    {load_stylesheet context="frontend" stylesheets=$stylesheets}
    {load_script context="frontend" scripts=$scripts}

    <!-- Loading Video.js styles and scripts for video playback -->
    <!-- ENG - Loading Video.js styles and scripts for video playback -->
    <!-- ESP - Cargando estilos y scripts de Video.js para la reproducción de video -->
    <link href="https://vjs.zencdn.net/7.19.2/video-js.css" rel="stylesheet" />
    <script src="https://vjs.zencdn.net/7.19.2/video.js"></script>

    <!-- Custom styles for the page -->
    <!-- ENG - Custom styles for the page -->
    <!-- ESP - Estilos personalizados para la página -->
    <style>
        body {
            text-align: justify;
            line-height: 1.6;
            background-color: white;
            color: #333;
        }
        .header_view {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            text-align: justify;
            margin-bottom: 571px;
            padding: 31.5px;
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
            top: 50%;
            left: 20px;
            transform: translateY(-50%);
            width: 34px;
            height: 38px;
            line-height: 37.5px;
            text-align: center;
            border-radius: 50%;
            font-size: 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
        .header_view .download {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            width: auto;
            height: auto;
            padding: 10px;
            border-radius: 9px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            color: #1e6292; 
        }
        .header_view h1 {
            margin: 0;
            font-size: 24px;
        }
        .header_view h2 {
            position: absolute;
            top: 10px;
            left: 50px;
            font-size: 25px;
            color: white;
            margin: 0;
            padding: 0 50px;
        }
        @media (max-width: 600px) {
            .header_view h2 {
                font-size: 12px;
                top: 5px;
                left: 45px;
            }
			.header_view {
             margin-bottom: 200px !important;
        }
        }
        .content {
            max-width: 1606px;
            width: 92.9%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

        .video-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px 0;
            padding: 20px;
            position: relative;
            width: 100%;
            box-sizing: border-box;
        }

        .video-js {
           height: 590px;
           max-width: 1606px;
           width: 100%;
       }

       @media (max-width: 600px) {
          .video-container {
             margin: 50px 0 0 0; 
             padding: 0 !important; 
			 height: 200px;
			 width: 100%;
			 
        }

        .video-js {
           width: 100%;
           height: 180px; 
		   font-size: 10px !important;
       }

       .content{
           width: 88.8%;
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
    <!-- ENG - Header of the view -->
    <!-- ESP - Encabezado de la vista -->
    <header class="header_view">
        <!-- Link to go back to the previous page -->
        <!-- ENG - Link to go back to the previous page -->
        <!-- ESP - Enlace para volver a la página anterior -->
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
        <!-- Link to download the video -->
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
    <!-- Video container -->
    <!-- ENG - Video container -->
    <!-- ESP - Contenedor de video -->
    <div id="videoCanvasContainer" class="galley_view{if !$isLatestPublication} galley_view_with_notice{/if}">
        <div class="video-container">
            <!-- Video player using Video.js -->
            <!-- ENG - Video player using Video.js -->
            <!-- ESP - Reproductor de video usando Video.js -->
            <video id="video-js" class="video-js vjs-default-skin" controls preload="auto" autoplay="true">
                <source src="{$videoUrl}" type="video/mp4">
                <p class="vjs-no-js">
                    {translate key="plugins.generic.videoJsViewer.noJsMessage"}
                </p>
            </video>
        </div>
    </div>
    <!-- Additional content -->
    <!-- ENG - Additional content -->
    <!-- ESP - Contenido adicional -->
    <div class="content">
        <h1>{$page_title|escape}</h1>
        <h3>{translate key="author.name"}: {$author->getFullName()}</h3>
        <p><strong>{translate key="article.abstract"}:</strong> {$submission->getLocalizedAbstract()}</p>
        <p><strong>{translate key="article.publicationDate"}:</strong> {$datePublished|date_format:"%B %e, %Y"}</p>
    </div>
    <!-- Video.js script initialization and custom controls -->
    <!-- ENG - Video.js script initialization and custom controls -->
    <!-- ESP - Inicialización del script de Video.js y controles personalizados -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const player = videojs('video-js');
            const bigPlayButton = document.querySelector('.vjs-big-play-button');

            player.ready(function() {
                this.play();

                // Ensure controls are visible
                // ENG - Ensure controls are visible
                // ESP - Asegurar que los controles sean visibles
                this.controls(true);

                this.on('play', function() {
                    bigPlayButton.style.display = 'none';
                });

                this.on('pause', function() {
                    bigPlayButton.style.display = '';
                });

                // Add skip buttons to the control bar
                // ENG - Add skip buttons to the control bar
                // ESP - Agregar botones de adelantar y retroceder a la barra de controles
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
