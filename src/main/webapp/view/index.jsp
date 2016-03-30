<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>

    <c:forEach var="photo" items="${photos}">
        <img src="${photo.url}" />
    </c:forEach>

</t:layout>