<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:layout>

    <style type="text/css">
        .image_toolbar {
            display: none;
            position: absolute;
            top: 0;
            left: 0;
            padding: 0;
        }
    </style>

    <script>

        function ImagePosition() {
            this.photo_id = 0;
            this.x_px = 0;
            this.y_px = 0;
            this.x_page = 0;
            this.y_page = 0;
        }

        $(function () {

            window.popover = $("#popover");
            window.popover.prompt = $("#prompt");

            $("body").bind('click', function (e) {
                window.popover.hide();
            });

            $("img.clickable").bind('click', function (e) {
                var p = new ImagePosition();
                p.photo_id = $(this).attr("photo_id");
                p.x_page = e.pageX;
                p.y_page = e.pageY;
                p.x_px = e.pageX - parseInt($(this).offset().left);
                p.y_px = e.pageY - parseInt($(this).offset().top);
                window.popover.show();
                window.popover.css({top: p.y_page, left: p.x_page});
                window.popover.prompt.focus();
                window.popover.p = p;
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

    <c:forEach var="photo" items="${photos}">
        <img src="${photo.url}" id="photo_${photo.id}" photo_id="${photo.id}" class="clickable"/>
    </c:forEach>

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

</t:layout>