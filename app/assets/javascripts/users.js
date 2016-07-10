$(document).on('turbolinks:load', function() {
	bind_users_click()

  // Users search
  $("#users_search_input").keyup(function(e) {
  	var str = $(this).val();
  	if (e.which <= 90 && e.which >= 48){console.log('hello')}
  	if (str.length > 3) {
  		$.get('/users.js', {search: str});
		}

	});  	
  
});

function bind_users_click(){
  $("#users tr").each(function( index ) {
  	var id = $(this).find("td").first().html();
  	bind_user_click(id);
  });
}

function bind_user_click(id) {
	$("#user_" + id).click(function (e) {
	  $("html, body").animate({ scrollTop: 0 }, 300);
  	$.get('/users/' + id + '/edit.js');
  });
}