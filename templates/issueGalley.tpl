{**
 * plugins/generic/videoJsViewer/templates/issueGalley.tpl
 *
 * Embedded viewing of a video galley.
 *}

<!-- ENG - Capture the URL to download the video galley -->
<!-- ESP - Captura la URL para descargar la galería de video -->
{capture assign="videoUrl"}{url op="download" path=$issue->getBestIssueId($currentJournal)|to_array:$galley->getBestGalleyId($currentJournal) escape=false}{/capture}
<!-- ENG - Assign the video galley download URL to the "videoUrl" variable -->
<!-- ESP - Asigna la URL de descarga de la galería de video a la variable "videoUrl" -->

<!-- ENG - Capture the URL of the parent, which is the issue view -->
<!-- ESP - Captura la URL del padre, que es la vista del número -->
{capture assign="parentUrl"}{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}{/capture}
<!-- ENG - Assign the issue view URL to the "parentUrl" variable -->
<!-- ESP - Asigna la URL de la vista del número a la variable "parentUrl" -->

<!-- ENG - Capture the galley title -->
<!-- ESP - Captura el título de la galería -->
{capture assign="galleyTitle"}{translate key="submission.representationOfTitle" representation=$galley->getLabel() title=$issue->getIssueIdentification()|escape}{/capture}
<!-- ENG - Assign the galley title to the "galleyTitle" variable -->
<!-- ESP - Asigna el título de la galería a la variable "galleyTitle" -->

<!-- ENG - Capture the formatted publication date -->
<!-- ESP - Captura la fecha de publicación formateada -->
{capture assign="datePublished"}{translate key="submission.outdatedVersion" datePublished=$issue->getData('datePublished')|date_format:$dateFormatLong urlRecentVersion=$parentUrl}{/capture}
<!-- ENG - Assign the formatted publication date to the "datePublished" variable -->
<!-- ESP - Asigna la fecha de publicación formateada a la variable "datePublished" -->

<!-- ENG - Include the specified template file to display the video -->
<!-- ESP - Incluye el archivo de plantilla especificado para mostrar el video -->
{include file=$displayTemplateResource title=$issue->getIssueIdentification() parentUrl=$parentUrl videoUrl=$videoUrl galleyTitle=$galleyTitle datePublished=$datePublished}
<!-- ENG - Include the display template using the captured variables -->
<!-- ESP - Incluye la plantilla de visualización usando las variables capturadas -->
