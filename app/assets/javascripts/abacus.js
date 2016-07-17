$(document).on('turbolinks:load', function() {
  bind_select_current_project();
  bind_select2();
  bind_auto_dismissible();
  $(document).ajaxStart(function() { Pace.restart(); });
});

function bind_auto_dismissible(){
	$(".auto-dismissible").fadeTo(3000, 500).slideUp(500, function() {
    $(".auto-dismissible").alert('close');
	});
}

function animate_color(selector, background, color, delete_after) {
  delete_after = delete_after || false
  
  var e = $(selector)
  var original_background = e.css('backgroundColor');
  var original_color = e.css('color');
  
  e.animate({backgroundColor: background, color: color}, 500)
   .animate({backgroundColor: original_background, color: original_color}, 500, function() { 
    if (delete_after) e.remove();
    e.removeAttr('style'); // Mini fix -> care with this!
  });
}

function animate_form_background(form, background) {
  var e = $(form).find('input[type=text], select');
  var l = $(form).find('label');
  var original_background = e.eq(0).css('backgroundColor');
  var original_label_color = e.eq(0).css('color');
  
  e.animate({backgroundColor: background}, 500).animate({backgroundColor: original_background}, 500);
  l.animate({color: background}, 500).animate({color: original_label_color}, 500);
}


function sidebar_active(e) {
  $("ul.sidebar-menu li").removeClass("active");
  $("ul.sidebar-menu li." + e).addClass("active");
}

function bind_select2() {
  $(".select2").each(function(i) {
    $(this).select2({
      placeholder: $(this).attr("placeholder")
    });
  });
}

function bind_select_current_project() {
  $("#current_project_select").change(function (e) {
    $("#current_project_form").submit();
  });
}