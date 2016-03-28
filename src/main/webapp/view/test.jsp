<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>
    测试<br />

    <c:forEach items="${pas}" var="pa">
        id:${pa.id}<br />
        key:${pa.key}<br />
        value:${pa.value}<hr />
    </c:forEach>
</t:layout>