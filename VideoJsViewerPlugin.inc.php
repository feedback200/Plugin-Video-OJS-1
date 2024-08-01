<?php

// ENG - Imports the base class for PKP generic plugins
// ESP - Importa la clase base para los plugins genéricos de PKP

import('lib.pkp.classes.plugins.GenericPlugin');

// ENG - Defines the VideoJsViewer plugin class that extends GenericPlugin
// ESP - Define la clase del plugin VideoJsViewer que extiende GenericPlugin

class VideoJsViewerPlugin extends GenericPlugin {

    /** ENG
     * Registers the plugin in a specific category
     * 
     * @param string $category The category in which the plugin is registered
     * @param string $path The plugin path
     * @param int|null $mainContextId The main context ID (optional)
     * @return bool true if successfully registered, false otherwise
     */

    /** ESP
     * Registra el plugin en una categoría específica
     * 
     * @param string $category La categoría en la que se registra el plugin
     * @param string $path La ruta del plugin
     * @param int|null $mainContextId El ID del contexto principal (opcional)
     * @return bool true si se registró con éxito, false de lo contrario
     */

    function register($category, $path, $mainContextId = null) {
    // ENG - Calls the register method of the base class
    // ESP - Llama al método register de la clase base

    if (parent::register($category, $path, $mainContextId)) {
        // ENG - Checks if the plugin is enabled
        // ESP - Verifica si el plugin está habilitado

        if ($this->getEnabled($mainContextId)) {
            // ENG - For OPS: registers the hook for preprint galley viewing
            // ESP - Para OPS: registra el gancho para la visualización de galeradas de preprints
            HookRegistry::register('PreprintHandler::view::galley', [$this, 'submissionCallback'], HOOK_SEQUENCE_LAST);
            // ENG - For OJS: registers the hook for article galley viewing
            // ESP - Para OJS: registra el gancho para la visualización de galeradas de artículos
            HookRegistry::register('ArticleHandler::view::galley', [$this, 'submissionCallback'], HOOK_SEQUENCE_LAST);
            // ENG - For OJS: registers the hook for issue galley viewing
            // ESP - Para OJS: registra el gancho para la visualización de galeradas de números
            HookRegistry::register('IssueHandler::view::galley', [$this, 'issueCallback'], HOOK_SEQUENCE_LAST);
            // ENG - Requires common application locale components
            // ESP - Requiere componentes locales comunes de la aplicación
            AppLocale::requireComponents(LOCALE_COMPONENT_APP_COMMON);
        }
        return true;
    }
    return false;
}

/**
 * ENG - Gets the display name of the plugin
 * ESP - Obtiene el nombre para mostrar del plugin
 * 
 * @return string The display name of the plugin
 */
function getDisplayName() {
    return __('plugins.generic.videoJsViewer.name');
}

/**
 * ENG - Gets the description of the plugin
 * ESP - Obtiene la descripción del plugin
 * 
 * @return string The description of the plugin
 */
function getDescription() {
    return __('plugins.generic.videoJsViewer.description');
}

/**
 * ENG - Callback for preprint/article viewing
 * ESP - Callback para la visualización de preprints/artículos
 * 
 * @param string $hookName The name of the hook
 * @param array $args The arguments passed to the hook
 * @return bool true if successfully processed, false otherwise
 */
function submissionCallback($hookName, $args) {
    // ENG - Gets the arguments from the hook call
    // ESP - Obtiene los argumentos de la llamada del gancho
    $request = $args[0];
    $issue = $args[1];
    $galley = $args[2];
    $submission = $args[3];
    $submissionFile = $galley->getFile();
    $author = $submission->getCurrentPublication()->getData('authors')[0];

    // ENG - Checks if the file is an MP4 video
    // ESP - Verifica si el archivo es un video MP4
    if ($submissionFile->getData('mimetype') === 'video/mp4') {
        // ENG - Gets the template manager
        // ESP - Obtiene el gestor de plantillas
        $templateMgr = TemplateManager::getManager($request);
        // ENG - Assigns variables to the template
        // ESP - Asigna variables a la plantilla
        $templateMgr->assign(array(
            'displayTemplateResource' => $this->getTemplateResource('display.tpl'),
            'pluginUrl' => $request->getBaseUrl() . '/' . $this->getPluginPath(),
            'galleyFile' => $submissionFile,
            'issue' => $issue,
            'submission' => $submission,
            'author' => $author,
            'galleyTitle' => $galley->getLabel(),
            'videoUrl' => $request->url(null, 'article', 'download', [$submission->getBestId(), $galley->getBestGalleyId()]),
            'datePublished' => $submission->getCurrentPublication()->getData('datePublished'),
            'page_title' => $submission->getLocalizedTitle(),
        ));
        // ENG - Displays the template
        // ESP - Muestra la plantilla
        $templateMgr->display($this->getTemplateResource('display.tpl'));
        return true;
    }

    return false;
}

/**
 * ENG - Callback for issue viewing
 * ESP - Callback para la visualización de números
 * 
 * @param string $hookName The name of the hook
 * @param array $params The parameters passed to the hook
 * @return bool true if successfully processed, false otherwise
 */
function issueCallback($hookName, $params) {
    // ENG - Gets the parameters from the hook call
    // ESP - Obtiene los parámetros de la llamada del gancho
    $request = $params[0];
    $issue = $params[1];
    $galley = $params[2];

    // ENG - Checks if the file is an MP4 video
    // ESP - Verifica si el archivo es un video MP4
    if ($galley->getFileType() == 'video/mp4') {
        // ENG - Gets the template manager
        // ESP - Obtiene el gestor de plantillas
        $templateMgr = TemplateManager::getManager($request);
        // ENG - Assigns variables to the template
        // ESP - Asigna variables a la plantilla
        $templateMgr->assign(array(
            'displayTemplateResource' => $this->getTemplateResource('display.tpl'),
            'pluginUrl' => $request->getBaseUrl() . '/' . $this->getPluginPath(),
            'galleyFile' => $galley->getFile(),
            'issue' => $issue,
            'galley' => $galley,
            'videoUrl' => $request->url(null, 'issue', 'download', [$issue->getBestIssueId(), $galley->getBestGalleyId()]),
            'datePublished' => $issue->getData('datePublished'),
        ));
        // ENG - Displays the template
        // ESP - Muestra la plantilla
        $templateMgr->display($this->getTemplateResource('display.tpl'));
        return true;
    }

    return false;
}
?>
