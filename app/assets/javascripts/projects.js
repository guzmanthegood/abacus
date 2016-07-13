$(document).on('turbolinks:load', function() {
  bind_projects_click();
});

function bind_projects_click(){
  $("#projects tr").click(function (e) {
    var id = $(this).find("td").first().html();
    window.location.href = '/projects/' + id;
  });
}