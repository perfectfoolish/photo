var ImagePosition = function () {
    this.photo_id = 0;
    this.x_px = 0;
    this.y_px = 0;
    this.x_page = 0;
    this.y_page = 0;
}

var music = {
    status: 0, // 0:暂停；1:播放
    playOrPause: function (target, id) {
        var audio = document.getElementById(id);
        if (this.status == 1) {
            this.status = 0;
            $(target).removeClass('on').addClass('off');
            audio.pause();
        } else {
            this.status = 1;
            $(target).removeClass('off').addClass('on');
            audio.play();
        }
    },
    play: function () {
        this.status = 1;
        document.getElementById('music').play();
    }
}

// 图片动画

var gallery = {
    status: 0, // 0:暂停；1:播放
    Zooms: [],
    images: 0,
    screenWidth: 0,
    screenHeight: 0,
    createElement: function (container, type, param) {
        var elem = document.createElement(type);
        for (var key in param) {
            elem.setAttribute(key, param[key]);
        }
        container.appendChild(elem);
        return elem;
    },
    Zoom: function (i) {
        with (gallery) {
            this.span = createElement(document.getElementById("screen"), "span", {
                'class': 'spanSlide'
            });
            createElement(this.span, "img", {
                'class': "imgSlide",
                'photo_id': images[i].getAttribute("photo_id"),
                'src': images[i].src
            });
            this.N = i;
            this.ratio = images[i].width / images[i].height;
        }
    },

    loop: function () {
        with (this) {
            for (i = 0; i < images.length; i++) {
                Zooms[i].N += 1 / 160;
                h = Math.pow(5, Zooms[i].N % images.length);
                with (Zooms[i].span.style) {
                    left = ((screenWidth - (h * Zooms[i].ratio)) / (screenWidth + h) * (screenWidth * 0.5)) + "px";
                    top = ((screenHeight - h) / (screenHeight + h) * (screenHeight * 0.5)) + "px";
                    width = (h * Zooms[i].ratio) + "px";
                    height = h + "px";
                    zIndex = Math.round(10000 - h * 0.1);
                }
            }
            if (status == 1) {
                setTimeout("gallery.loop();", 16);
            }
        }
    },

    playOrPause: function (target) {
        with (this) {
            if (status == 0) {
                status = 1;
                $(target).removeClass('off').addClass('on');
                loop();
            } else {
                status = 0;
                $(target).removeClass('on').addClass('off');
            }
        }
    },

    play: function () {
        with (this) {
            status = 1;
            screenWidth = parseInt($("#screen").css("width"));
            screenHeight = parseInt($("#screen").css("height"));
            images = $("#images img");
            for (var i = 0; i < images.length; i++) {
                Zooms[i] = new Zoom(i);
            }
            loop();
        }
    }
}


window.onload = function () {

    $("#screen").css({
        width: $(window).width(),
        height: $(window).height()
    });

    $(document.body).bind('touchmove', function (e) {
        e.preventDefault();
    });

    $(document.body).doubletap(function (e) {
        e.preventDefault()
    });

    gallery.play();
    music.play();


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
        with (window.popover) {
            var text = $.trim(prompt.val());
            if (text.length == 0) {
                alert("内容不能为空！");
            } else {
                $.post("/photo/prompt", {
                    photo_id: p.photo_id,
                    x: p.x_px,
                    y: p.y_px,
                    text: text
                }, function (result) {
                    prompt.val("");
                    hide();
                });
            }
        }
    }
}