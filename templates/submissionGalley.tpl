{**
 * plugins/generic/videoJsViewer/templates/watchVideo.tpl
 *
 * Embedded viewing of a video galley.
 *}
<!-- ENG - Embedded viewing of a video galley -->
<!-- ESP - Visualización integrada de una galería de video -->

<!-- Capture the translated page title -->
<!-- ENG - Capture the translated page title -->
<!-- ESP - Captura el título de la página traducido -->
{capture assign=pageTitle}{translate key="plugins.generic.videoJsViewer.watchVideo"}{/capture}
<!-- ENG - Assign the translated page title to the "pageTitle" variable -->
<!-- ESP - Asigna el título de la página traducido a la variable "pageTitle" -->

<!-- Include the header template file -->
<!-- ENG - Include the header template file -->
<!-- ESP - Incluye el archivo de plantilla del encabezado -->
{include file="frontend/components/header.tpl"}

<!-- Main container centered with top margin -->
<!-- ENG - Main container centered with top margin -->
<!-- ESP - Contenedor principal centrado con margen superior -->
<div class="container" style="text-align: center; margin-top: 30px;">
    <!-- Video galley title -->
    <!-- ENG - Video galley title -->
    <!-- ESP - Título de la galería de video -->
    <h2>{$galleyFile->getLabel()}</h2>
    <!-- Video container with a maximum width of 100% and a width of 80% of the parent container -->
    <!-- ENG - Video container with a maximum width of 100% and a width of 80% of the parent container -->
    <!-- ESP - Contenedor de video con un ancho máximo del 100% y un ancho del 80% del contenedor padre -->
    <div style="display: inline-block; max-width: 100%; width: 80%;">
        <!-- Video player using Video.js -->
        <!-- ENG - Video player using Video.js -->
        <!-- ESP - Reproductor de video usando Video.js -->
        <video id="video-js" class="video-js vjs-default-skin vjs-big-play-centered" controls preload="auto" width="100%" height="auto" data-setup="{}">
            <!-- Video source, obtained from the galley download URL -->
            <!-- ENG - Video source, obtained from the galley download URL -->
            <!-- ESP - Fuente del video, obtenida de la URL de descarga de la galería -->
            <source src="{url page="article" op="download" path=$galleyFile->getBestGalleyId()}" type="video/mp4">
            <!-- Message displayed if the browser does not support JavaScript -->
            <!-- ENG - Message displayed if the browser does not support JavaScript -->
            <!-- ESP - Mensaje mostrado si el navegador no soporta JavaScript -->
            <p class="vjs-no-js">
                {translate key="plugins.generic.videoJsViewer.noJsMessage"}
            </p>
        </video>
    </div>
</div>

<!-- Links to Video.js resources (stylesheets and scripts) -->
<!-- ENG - Links to Video.js resources (stylesheets and scripts) -->
<!-- ESP - Enlaces a los recursos de Video.js (hojas de estilo y scripts) -->
<link href="https://vjs.zencdn.net/7.10.2/video-js.css" rel="stylesheet" />
<script src="https://vjs.zencdn.net/7.10.2/video.js"></script>

<!-- Include the footer template file -->
<!-- ENG - Include the footer template file -->
<!-- ESP - Incluye el archivo de plantilla del pie de página -->
{include file="frontend/components/footer.tpl"}
