$(document).on('turbolinks:load', function() {
	auto_dismissible();
});

function auto_dismissible(){
	$(".auto-dismissible").fadeTo(3000, 500).slideUp(500, function(){
	    $(".auto-dismissible").alert('close');
	});
}