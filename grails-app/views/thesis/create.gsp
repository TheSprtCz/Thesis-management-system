<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="light">
    <title><g:message code="thesis.create.title" /></title>
</head>
<body>
    <h2 class="header">
        <g:message code="thesis.create.header" />
        <small class="pull-right">
            <g:link controller="thesis">
                <i class="icon-double-angle-left"></i>
                ${message(code: 'default.back.button')}
            </g:link>
        </small>
    </h2>
    <g:form class="form-inline" action="save" >
        <div class="control-group ${hasErrors(bean: thesisInstance?.topic, field: 'title', 'error')} required">
            <label class="control-label" for="thesis.topic.title">
                <strong><g:message code="topic.label" /></strong>
                <span class="required-indicator">*</span></strong>
            </label>
            <div class="controls">
                <g:hiddenField name="thesis.topic.id" value="${thesisInstance?.topic?.id}" />
                <a4g:textField name="thesis.topic.title"
                               value="${thesisInstance?.topic?.title}"
                               disabled="${disabledTopicField}"
                               placeholder="${message(code: 'topic.label')}"
                               autocomplete-url="${createLink(controller: 'json', action: 'listTopicsByTitle')}"
                               autocomplete-target="thesis.topic.id" />
            </div>
        </div>

        <g:render template="form"/>

        <div class="control-group">
            <div class="controls">
                <g:submitButton name="create"
                                class="tms-btn btn-large"
                                value="${message(code: 'default.create.button')}" />
            </div>
        </div>
    </g:form>
</body>
</html>
