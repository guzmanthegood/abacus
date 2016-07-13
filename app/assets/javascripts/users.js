$(document).on('turbolinks:load', function() {
	bind_users_click();
});

function bind_users_click(){
  $("#users tr").each(function(i) {
  	var id = $(this).find("td").first().html();
  	bind_user_click(id);
  });
}

function bind_user_click(id) {
	$("#user_" + id).click(function (e) {
  	$.get('/users/' + id + '/edit.js');
    scroll_users_form();
  });
}

function scroll_users_form() {
  var aTag = $("#user-form-title");
  $('html,body').animate({scrollTop: (aTag.offset().top - 75)}, 600);
}