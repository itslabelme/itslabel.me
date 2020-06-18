
/** Mobile Menu */

$('.toggle-email-nav').on('click', function() {
    $('.mail-left').toggleClass('open');
});


/** Right Context Menu */

var mouseX;
var mouseY;
$(document).mousemove(function(e) {
   mouseX = e.pageX; 
   mouseY = e.pageY;
});  
$(document).bind("mousedown", function (e) {
// If the clicked element is not the menu
if (!$(e.target).parents(".context-menu").length > 0) {    
    // Hide it
    $(".context-menu").hide(100);
}
});