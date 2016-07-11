$(document).on('turbolinks:load', function() {
	auto_dismissible();
  $(document).ajaxStart(function() { Pace.restart(); });
});

function auto_dismissible(){
	$(".auto-dismissible").fadeTo(3000, 500).slideUp(500, function() {
    $(".auto-dismissible").alert('close');
	});
}

function animate_color(selector, background, color, delete_after) {
  delete_after = delete_after || false
  
  var e = $(selector)
  var original_background = e.css('backgroundColor');
  var original_color = e.css('color');
  
  e.animate({backgroundColor: background, color: color}, 500)
   .animate({backgroundColor: original_background, color: original_color}, 500, function() { 
    if (delete_after) e.remove();
  });
}