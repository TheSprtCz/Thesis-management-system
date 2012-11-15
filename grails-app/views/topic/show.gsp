<%@ page import="com.redhat.theses.Topic" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'topic.label', default: 'Topic')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
    <div class="span8">
        <g:if test="${topicInstance?.title}">
            <h1 class="header">
                <g:fieldValue bean="${topicInstance}" field="title"/>
            </h1>
        </g:if>

        <g:if test="${topicInstance?.description}">
            <markdown:renderHtml text="${topicInstance?.description}"/>
        </g:if>

        <g:if test="${topicInstance?.tags}">
            <p>
                <strong><g:message code="topic.tags.label" default="Tags" />:</strong>
                <g:each in="${topicInstance.tags}" var="t">
                    <g:link controller="tag" class="tag" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link>
                </g:each>
            </p>
        </g:if>

        <richg:comments comments="${comments}" article="${topicInstance}"/>
    </div>

    <div class="span4">
        <div class="thesis">
            <h4>Topic Information</h4>
            <dl class="dl-thesis">
                <g:if test="${topicInstance?.owner}">
                    <dt><g:message code="topic.owner.label" default="Owner" /></dt>
                    <dd><g:link controller="user" action="show" id="${topicInstance?.owner?.id}">
                        ${topicInstance?.owner?.encodeAsHTML()}
                    </g:link></dd>
                </g:if>
                <g:if test="${topicInstance?.dateCreated}">
                    <dt><g:message code="topic.dateCreated.label" default="Date Created" /></dt>
                    <dd><g:formatDate date="${topicInstance?.dateCreated}" dateStyle="LONG" type="date" /></dd>
                </g:if>
                <g:if test="${!supervisions.empty}">
                    <dt><g:message code="topic.supervisions.label" default="Supervisions" /></dt>
                    <g:each in="${supervisions}" status="i" var="supervision">
                        <g:each in="${supervision.value}" var="supervisor">
                            <dd><g:link controller="user" action="show" id="${supervisor?.id}">
                                ${supervisor?.encodeAsHTML()}
                            </g:link></dd>
                        </g:each>
                    </g:each>
                </g:if>
            </dl>
        </div>

        <div class="thesis">
            <h4>Topic Management</h4>
            <g:form>
                <g:hiddenField name="topic.id" value="${topicInstance?.id}" />
                <g:link class="btn btn-warning" action="edit" id="${topicInstance?.id}">
                    <g:message code="default.button.edit.label" default="Edit" />
                </g:link>
                <g:actionSubmit class="btn btn-danger" action="delete"
                                value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
            </g:form>
        </div>
    </div>

</body>
</html>
