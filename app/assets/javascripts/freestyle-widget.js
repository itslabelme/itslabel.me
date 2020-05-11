/** Scroll */

$(document).ready(function(){

    $('.column1').on('mouseenter', function(){ 
        $('.column1').on('scroll', function () {
            $('.column2').scrollTop($(this).scrollTop());
        });
    });
    $('.column1').on('mouseleave', function(){ 
        $('.column1').off('scroll');
        $('.column2').off('scrollTop');
    });
    
    $('.column2').on('mouseenter',function(){ 
        $('.column2').on('scroll', function () {
            $('.column1').scrollTop($(this).scrollTop());
        });
    }); 
    $('.column2').on('mouseleave', function(){ 
        $('.column2').off('scroll');
        $('.column1').off('scrollTop');
    });

});