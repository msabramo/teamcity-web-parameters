<%@ include file="/include.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<jsp:useBean id="context" scope="request" type="jetbrains.buildServer.controllers.parameters.ParameterRenderContext"/>
<jsp:useBean id="options" scope="request" type="ru.mail.teamcity.web.parameters.data.Options"/>
<jsp:useBean id="enableEditOnError" scope="request" type="java.lang.Boolean"/>
<jsp:useBean id="errors" scope="request" type="java.util.Map<java.lang.String, java.lang.String>"/>

<link rel="stylesheet" type="text/css"
      href="${teamcityPluginResourcesPath}/ru/mail/teamcity/web/parameters/css/webParameter.css">

<c:choose>
    <c:when test="${empty errors}">
        <c:set var="selectedKey" value="${context.parameter.value}"/>
        <forms:select name="${context.id}" id="${context.id}" enableFilter="true" style="width:100%">
            <c:forEach var="option" items="${options.options}">
                <c:set var="selected" value="${option.key eq selectedKey}"/>
                <forms:option value="${option.value}" selected="${selected}" disabled="${not option.enabled}">
                    <c:out value="${option.key}"/>
                </forms:option>
            </c:forEach>
        </forms:select>
    </c:when>

    <c:otherwise>
        <div class="web-param-error">
            <c:forEach var="error" items="${errors}">
                <h3>${error.key}</h3>
                <span>${error.value}</span>
            </c:forEach>
        </div>

        <c:if test="${enableEditOnError == true}">
            <div>
                <label for="${context.id}"><c:out value="Manual value input"/></label>
                <forms:textField
                        name="${context.id}"
                        id="${context.id}"
                        style="width: 100%;"
                        value=""
                        noAutoComplete="true"
                        className="buildTypeParams"
                        expandable="true"
                        />
            </div>
        </c:if>

    </c:otherwise>
</c:choose>