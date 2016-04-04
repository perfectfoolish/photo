<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:photo_frame>

    <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/double.tap.js"></script>
    <script src="${pageContext.request.contextPath}/js/index.js"></script>

    <div id="toolbar">
        <div id="gallery_btn" class="on" onclick="gallery.playOrPause(this);">
        </div>
        <div id="audio_btn" class="on" onclick="music.playOrPause(this,'music')">
            <audio id="music" src="/raw/xajh.mp3" autoplay="autoplay"></audio>
        </div>
    </div>

    <div id="screen"></div>

    <div id="images" style="visibility:hidden">
        <c:forEach var="photo" items="${photos}">
            <img src="${photo.url}" id="photo_${photo.id}" photo_id="${photo.id}" class="clickable"/>
        </c:forEach>
    </div>

    <div id="popover" class="popover image_toolbar">
        <div class="input-group has-success">
            <span class="input-group-addon">
                <span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span>
            </span>
            <span class="input-group-addon">
                <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
            </span>
            <input id="prompt" type="text" class="form-control"/>
            <span id="submit" class="input-group-addon">
                <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
            </span>
        </div>
    </div>

</t:photo_frame>