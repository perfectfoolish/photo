<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:photo_frame>

    <script src="${pageContext.request.contextPath}/js/double.tap.js"></script>

    <style type="text/css">

        body {
            overflow: hidden;
        }

        #toolbar {
            position: absolute;
            z-index: 2147483647;
        }

        .image_toolbar {
            display: none;
            position: absolute;
            top: 0;
            left: 0;
            padding: 0;
        }

        .spanSlide {
            position: absolute;
            font-size: 1px;
            overflow: hidden;
        }

        .imgSlide {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
    </style>

    <script>

        function createElement(container, type, param) {
            o = document.createElement(type);
            for (var i in param) {
                o[i] = param[i];
            }
            container.appendChild(o);
            return o;
        }

        mooz = {
            O: [],
            /////////
            mult: 6,
            nbI: 5,
            /////////
            width_height: [],
            images: 0,
            W: 0,
            H: 0,

            Xoom: function (N) {
                this.o = createElement(document.getElementById("screen"), "span", {
                    'className': 'spanSlide'
                });
                img = createElement(this.o, "img", {
                    'className': "imgSlide",
                    'src': mooz.images[N % mooz.images.length].src
                });
                this.N = 10000 + N;
            },

            mainloop: function () {
                with (this) {
                    for (i = 0; i < mooz.nbI; i++) {
                        O[i].N += 50 / 8000;
                        N = O[i].N % nbI;
                        ti = Math.pow(mult, N);
                        with (O[i].o.style) {
                            left = Math.round((W - (ti * width_height[i])) / (W + ti) * (W * .5)) + "px";
                            top = Math.round((H - ti) / (H + ti) * (H * .5)) + "px";
                            zIndex = Math.round(10000 - ti * .1);
                            width = Math.round(ti * width_height[i]) + "px";
                            height = Math.round(ti) + "px";
                        }
                    }
                }
                setTimeout("mooz.mainloop();", 16);
            },

            oigres: function () {
                with (this) {
                    W = parseInt(document.getElementById("screen").style.width);
                    H = parseInt(document.getElementById("screen").style.height);
                    images = document.getElementById("images").getElementsByTagName("img");
                    for (var i = 0; i < nbI; i++) {
                        width_height[i] = images[i].width / images[i].height;
                        O[i] = new Xoom(i);
                    }
                    mainloop();
                }
            }
        }

        function ImagePosition() {
            this.photo_id = 0;
            this.x_px = 0;
            this.y_px = 0;
            this.x_page = 0;
            this.y_page = 0;
        }

        window.onload = function () {
            $("#screen").css({
                width: $(window).width(),
                height: $(window).height()
            });
            mooz.oigres();

            $(document.body).bind('touchmove', function (e) {
                e.preventDefault();
            });

            $(document.body).doubletap(
                    function (e) {
                        e.preventDefault()
                    }
            );
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
        <button onclick="alert(999);">开始</button>
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