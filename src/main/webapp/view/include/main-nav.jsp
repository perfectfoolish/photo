<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="action" value="${requestScope['javax.servlet.forward.request_uri']}"/>

<ul id="main-nav" class="nav nav-stacked">
    <li class=${empty action ? "active" : ""}>
        <a href="/index2.jsp">首页</a>
    </li>

    <li class=${action == "/admin/feedback/list2" ? "active" : ""}>
        <a href="/admin/feedback/list2">反馈管理</a>
    </li>

    <li class=${action == "/charts" ? "active" : ""}>
        <a href="./charts.html">版本管理</a>
    </li>
    <li class=${action == "/#" ? "active" : ""}>
        <a href="#">论坛板块管理</a>
    </li>

    <c:set var="advActions" value="/admin/advertisement2/list,/admin/infoflowadv/list"/>
    <c:set var="isAdvs" value="${not empty action && fn:contains(advActions, action)}"/>
    <li class=${isAdvs ? "active" : ""}>
        <a href="#advManager" class="nav-header collapsed" data-toggle="collapse">
            广告管理<span class="pull-right glyphicon glyphicon-chevron-down"></span>
        </a>
        <ul id="advManager" class="nav second-nav collapse ${isAdvs ? 'in' : ''}" style="height: 0px;">
            <li class=${action == "#" ? "active" : ""}>
                <a href="#">闪屏页广告</a>
            </li>

            <li class=${action == "/admin/advertisement2/list" ? "active" : ""}>
                <a href="/admin/advertisement2/list">置顶图片广告</a>
            </li>

            <li class=${action == "/admin/infoflowadv/list" ? "active" : ""}>
                <a href="/admin/infoflowadv/list">信息流广告</a>
            </li>

        </ul>
    </li>

</ul>