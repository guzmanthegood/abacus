$(document).on('turbolinks:load', function() {
  init_tasks_datatable();
});

function init_tasks_datatable() {
  $('table.tasks.datatable').DataTable({
    "order": [[ 1, 'asc' ]],
    "lengthChange": false,
    "autoWidth": false,
    "pageLength": 15,
    "columnDefs": [
      { "orderable": false, "targets": 0 },
      { "width": "10px", "targets": [0,1,2,3,6,7] },
      { "type": "num", "targets": [1, 6] },
      { "type": "date", "targets": [7] }
    ]
  });
}