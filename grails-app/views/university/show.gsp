<%@ page import="com.redhat.theses.util.Util" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title><g:message code="university.show.title" args="[universityInstance.name]" /></title>
</head>
<body>
    <div class="span4 sidebar">
        <div class="panel left">
            <div class="avatar">
                %{--University logo will be here soon!--}%
            </div>
            <h4><g:message code="university.information.label"/></h4>
            <div class="panel-content">
                <dl>
                    <g:if test="${universityInstance?.name}">
                    <dt>
                        <i class="icon-suitcase"></i>
                        ${message(code: 'university.name.label').toString().toLowerCase()}
                    </dt>
                    <dd>
                        <g:fieldValue bean="${universityInstance}" field="name"/>
                    </dd>
                    </g:if>
                </dl>
            </div>
        </div>
    </div>
    <div class="span8 content">
        <div class="controls pull-right">
            <g:link class="tms-btn" action="edit"
                    id="${universityInstance?.id}"
                ><i class="icon-wrench"></i><g:message code="default.edit.button"/></g:link>
        </div>

        <div>
            <h2><g:message code="university.show.topics.header"/></h2>
            <g:if test="${topicInstanceList && !topicInstanceList?.empty}">
                <ul class="tms-list unstyled">
                <g:each in="${topicInstanceList}" var="topic">
                    <li class="tms-elem">
                        <i class="icon-book"></i>
                        <g:link controller="topic" action="show"
                                id="${topic?.id}" params="${Util.hyphenize(topic?.title)}"
                        ><g:fieldValue field="title" bean="${topic}"/></g:link>
                        <span class="pull-right">
                            <i class="icon-comment-alt"></i> ${commentCounts[topic] ?: 0}
                        </span>
                        <ul class="inline">
                            <li>
                                <i class="icon-time"></i>
                                <g:formatDate date="${topic?.dateCreated}"
                                              dateStyle="LONG"
                                              type="date" />
                            </li>
                        </ul>
                    </li>
                </g:each>
                </ul>
            </g:if>
            <g:else>
                <p class="center muted"><g:message code="university.no.topics.found" /></p>
            </g:else>
        </div>
    </div>
</body>
</html>
