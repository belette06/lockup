// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)


$(document).ready(function () {

    $('.about-nav').click(function () {
        $('html, body').animate({
            scrollTop: $('.about-section').offset().top
        }, 1300);
    });

    $('.projects-nav').click(function () {
        $('html, body').animate({
            scrollTop: $('.projects').offset().top
        }, 1300);
    });

    $('.contact-nav').click(function () {
        $('html, body').animate({
            scrollTop: $('.contact').offset().top
        }, 1300);
    });

    $(document).ready(function () {
        var scrollStart = 0;
        var scrollEnd = 0;
        var hOffset = $('#start-navbar-dark').offset();
        var aOffset = $('#start-about-animation').offset();
        var pOffset = $('#start-projects').offset();

        // Optimization flags so that it doesnt change css every scroll
        var aboutAnimate = true;
        var headerAnimate = true;
        var projectsAnimate = true;

        $(document).scroll(function () {
            scrollStart = $(this).scrollTop();
            scrollEnd = scrollStart + $(window).height();
            if (scrollStart > hOffset.top && headerAnimate) {
                $('.navbar').css('background', '#373737');
                headerAnimate = false;
            } else if (scrollStart === hOffset.top) {
                $('.navbar').css('background', 'none');
                headerAnimate = true;
            } else if (scrollEnd > aOffset.top && aboutAnimate) {
                $('.about p, .about h4').addClass('animated fadeInUp');
                $('.about h3').addClass('animated fadeInDown');
                aboutAnimate = false;
            }
        });
    });

    window.sr = ScrollReveal();
    sr.reveal('.f3');
    sr.reveal('.s3');

});