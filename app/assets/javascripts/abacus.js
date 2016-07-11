$(document).on('turbolinks:load', function() {
	auto_dismissible();
  $(document).ajaxStart(function() { Pace.restart(); });
});

function auto_dismissible(){
	$(".auto-dismissible").fadeTo(3000, 500).slideUp(500, function(){
	    $(".auto-dismissible").alert('close');
	});
}