$(document).on('turbolinks:load', function() {

  $("#users tr").click(function (e) {
    $("html, body").animate({ scrollTop: 0 }, 600);
    var id = $(this).find("td").first().html();
    $.get('/users/' + id + '/edit.js');
  });
  
  /*
  $('#example2').DataTable({
    "paging": true,
    "lengthChange": false,
    "searching": false,
    "ordering": true,
    "info": true,
    "autoWidth": false
  });
  */
});
