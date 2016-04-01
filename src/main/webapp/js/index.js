var ImagePosition = function () {
    this.photo_id = 0;
    this.x_px = 0;
    this.y_px = 0;
    this.x_page = 0;
    this.y_page = 0;
}

var music = {
    playOrPause: function (target, id) {
        var className = $(target).attr('class');
        var ids = document.getElementById(id);
        (className == 'on')
            ? $(target).removeClass('on').addClass('off')
            : $(target).removeClass('off').addClass('on');
        (className == 'on')
            ? ids.pause()
            : ids.play();
    },
    play: function () {
        document.getElementById('music').play();
    }
}

// 图片动画

var gallery = {
    status: 0, // 0:暂停；1:播放
    Zooms: [],
    width_height: [],
    images: 0,
    screenWidth: 0,
    screenHeight: 0,
    createElement: function (container, type, param) {
        var elem = document.createElement(type);
        for (var key in param) {
            elem[key] = param[key];
        }
        container.appendChild(elem);
        return elem;
    },
    Zoom: function (i) {
        this.span = gallery.createElement(document.getElementById("screen"), "span", {
            'className': 'spanSlide'
        });
        gallery.createElement(this.span, "img", {
            'className': "imgSlide",
            'src': gallery.images[i].src
        });
        this.N = i;
    },

    loop: function () {
        with (this) {
            for (i = 0; i < images.length; i++) {
                Zooms[i].N += 1 / 160;
                h = Math.pow(5, Zooms[i].N % images.length);
                with (Zooms[i].span.style) {
                    left = ((screenWidth - (h * width_height[i])) / (screenWidth + h) * (screenWidth * 0.5)) + "px";
                    top = ((screenHeight - h) / (screenHeight + h) * (screenHeight * 0.5)) + "px";
                    width = (h * width_height[i]) + "px";
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
            screenWidth = parseInt(document.getElementById("screen").style.width);
            screenHeight = parseInt(document.getElementById("screen").style.height);
            images = document.getElementById("images").getElementsByTagName("img");
            for (var i = 0; i < images.length; i++) {
                width_height[i] = images[i].width / images[i].height;
                Zooms[i] = new Zoom(i);
            }
            loop();
        }
        $("#gallery_btn").removeClass('off').addClass('on');
    }
}