console.log("OWL LOADED");
$(document).ready(function(){
    $('.owl-carousel').owlCarousel({
        margin:15,
        dots:true,
        nav:true,
        navText : ["<i class='fa fa-chevron-left'></i>","<i class='fa fa-chevron-right'></i>"],
        responsive:{
            0:{
                items:2
            },
            600:{
                items:2
            },
            1000:{
                items:4
            }
        }
    })
})