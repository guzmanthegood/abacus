$(document).on('turbolinks:load', function() {
	bind_projects_click();
});

function bind_projects_click(){
  $("#projects tr").each(function(i) {
  	var id = $(this).find("td").first().html();
  	bind_project_click(id);
  });
}

function bind_project_click(id) {
	$("#project_" + id).click(function (e) {
		var aTag = $("#project-form-title");
    $('html,body').animate({scrollTop: (aTag.offset().top - 75)}, 600);
  	//$.get('/project/' + id + '/show.js');
  	console.log('/project/' + id + '/show.js');
  });
}