$(document).ready(function(){
    $('.owl-carousel').owlCarousel({
        loop:true,
        margin:15,
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
