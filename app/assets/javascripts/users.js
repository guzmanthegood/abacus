$(document).on('turbolinks:load', function() {

  // Select user click
  $("#users tr").click(function (e) {
    $("html, body").animate({ scrollTop: 0 }, 300);
    var id = $(this).find("td").first().html();
    $.get('/users/' + id + '/edit.js');
  });
  
});
