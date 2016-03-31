<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:photo_frame>

    <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/double.tap.js"></script>
    <script src="${pageContext.request.contextPath}/js/index.js"></script>


    <script>

        window.onload = function () {

            $("#screen").css({
                width: $(window).width(),
                height: $(window).height()
            });

            $(document.body).bind('touchmove', function (e) {
                e.preventDefault();
            });

            $(document.body).doubletap(
                    function (e) {
                        e.preventDefault()
                    }
            );

            gallery.play();
            music.play();
        }

        $(function () {

            window.popover = $("#popover");
            window.popover.prompt = $("#prompt");
            window.popover.p = new ImagePosition();

            $("body").bind('click', function (e) {
                window.popover.hide();
            });

            $("img.clickable").bind('click', function (e) {
                with (window.popover.p) {
                    photo_id = $(this).attr("photo_id");
                    x_page = e.pageX;
                    y_page = e.pageY;
                    x_px = e.pageX - parseInt($(this).offset().left);
                    y_px = e.pageY - parseInt($(this).offset().top);
                    window.popover.css({top: y_page, left: x_page});
                }
                window.popover.show();
                window.popover.prompt.focus();
                e.stopPropagation();
            });

            window.popover.bind('click', function (e) {
                e.stopPropagation();
            });

            window.popover.prompt.bind('keypress', function (event) {
                if (event.keyCode == "13") {
                    submit();
                }
            });

            $("span#submit").bind('click', function (e) {
                submit();
            });

            function submit() {
                var text = $.trim(window.popover.prompt.val());
                if (text.length == 0) {
                    alert("内容不能为空！");
                } else {
                    $.post("/photo/prompt", {
                        photo_id: window.popover.p.photo_id,
                        x: window.popover.p.x_px,
                        y: window.popover.p.y_px,
                        text: text
                    }, function (result) {
                        window.popover.prompt.val("");
                        window.popover.hide();
                    });
                }
            }
        });

    </script>

    <div id="toolbar">
        <button onclick="gallery.playOrPause()">开始</button>
        <div id="audio-btn" class="on" onclick="music.playOrPause(this,'music')">
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