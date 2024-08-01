<?php

// Imports the base class for PKP generic plugins
// ENG - Imports the base class for PKP generic plugins
// ESP - Importa la clase base para los plugins genéricos de PKP
import('lib.pkp.classes.plugins.GenericPlugin');

// Defines the VideoJsViewer plugin class that extends GenericPlugin
// ENG - Defines the VideoJsViewer plugin class that extends GenericPlugin
// ESP - Define la clase del plugin VideoJsViewer que extiende GenericPlugin
class VideoJsViewerPlugin extends GenericPlugin {

    /**
     * Registers the plugin in a specific category
     * 
     * @param string $category The category in which the plugin is registered
     * @param string $path The plugin path
     * @param int|null $mainContextId The main context ID (optional)
     * @return bool true if successfully registered, false otherwise
     */
    function register($category, $path, $mainContextId = null) {
        // Calls the register method of the base class
        // ENG - Calls the register method of the base class
        // ESP - Llama al método register de la clase base
        if (parent::register($category, $path, $mainContextId)) {
            // Checks if the plugin is enabled
            // ENG - Checks if the plugin is enabled
            // ESP - Verifica si el plugin está habilitado
            if ($this->getEnabled($mainContextId)) {
                // For OPS: registers the hook for preprint galley viewing
                // ENG - For OPS: registers the hook for preprint galley viewing
                // ESP - Para OPS: registra el hook para la visualización de la galería de preprints
                HookRegistry::register('PreprintHandler::view::galley', [$this, 'submissionCallback'], HOOK_SEQUENCE_LAST);
                // For OJS: registers the hook for article galley viewing
                // ENG - For OJS: registers the hook for article galley viewing
                // ESP - Para OJS: registra el hook para la visualización de la galería del artículo
                HookRegistry::register('ArticleHandler::view::galley', [$this, 'submissionCallback'], HOOK_SEQUENCE_LAST);
                // For OJS: registers the hook for issue galley viewing
                // ENG - For OJS: registers the hook for issue galley viewing
                // ESP - Para OJS: registra el hook para la visualización de la galería del número
                HookRegistry::register('IssueHandler::view::galley', [$this, 'issueCallback'], HOOK_SEQUENCE_LAST);
                // Requires common application locale components
                // ENG - Requires common application locale components
                // ESP - Requiere componentes de localización comunes de la aplicación
                AppLocale::requireComponents(LOCALE_COMPONENT_APP_COMMON);
            }
            return true;
        }
        return false;
    }

    /**
     * Gets the display name of the plugin
     * 
     * @return string The display name of the plugin
     */
    function getDisplayName() {
        return __('plugins.generic.videoJsViewer.name');
    }

    /**
     * Gets the description of the plugin
     * 
     * @return string The description of the plugin
     */
    function getDescription() {
        return __('plugins.generic.videoJsViewer.description');
    }

    /**
     * Callback for preprint/article viewing
     * 
     * @param string $hookName The name of the hook
     * @param array $args The arguments passed to the hook
     * @return bool true if successfully processed, false otherwise
     */
    function submissionCallback($hookName, $args) {
        // Gets the arguments from the hook call
        // ENG - Gets the arguments from the hook call
        // ESP - Obtiene los argumentos de la llamada al hook
        $request = $args[0];
        $issue = $args[1];
        $galley = $args[2];
        $submission = $args[3];
        $submissionFile = $galley->getFile();
        $author = $submission->getCurrentPublication()->getData('authors')[0];
    
        // Checks if the file is an MP4 video
        // ENG - Checks if the file is an MP4 video
        // ESP - Verifica si el archivo es un video MP4
        if ($submissionFile->getData('mimetype') === 'video/mp4') {
            // Gets the template manager
            // ENG - Gets the template manager
            // ESP - Obtiene el gestor de plantillas
            $templateMgr = TemplateManager::getManager($request);
            // Assigns variables to the template
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
            // Displays the template
            // ENG - Displays the template
            // ESP - Muestra la plantilla
            $templateMgr->display($this->getTemplateResource('display.tpl'));
            return true;
        }
    
        return false;
    }
    
    /**
     * Callback for issue viewing
     * 
     * @param string $hookName The name of the hook
     * @param array $params The parameters passed to the hook
     * @return bool true if successfully processed, false otherwise
     */
    function issueCallback($hookName, $params) {
        // Gets the parameters from the hook call
        // ENG - Gets the parameters from the hook call
        // ESP - Obtiene los parámetros de la llamada al hook
        $request = $params[0];
        $issue = $params[1];
        $galley = $params[2];

        // Checks if the file is an MP4 video
        // ENG - Checks if the file is an MP4 video
        // ESP - Verifica si el archivo es un video MP4
        if ($galley->getFileType() == 'video/mp4') {
            // Gets the template manager
            // ENG - Gets the template manager
            // ESP - Obtiene el gestor de plantillas
            $templateMgr = TemplateManager::getManager($request);
            // Assigns variables to the template
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
            // Displays the template
            // ENG - Displays the template
            // ESP - Muestra la plantilla
            $templateMgr->display($this->getTemplateResource('display.tpl'));
            return true;
        }

        return false;
    }
}
?>
