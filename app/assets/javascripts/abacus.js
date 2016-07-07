$(document).on('turbolinks:load', function() {
	$(".auto-dismissible").fadeTo(4000, 500).slideUp(500, function(){
	    $(".auto-dismissible").alert('close');
	});
});