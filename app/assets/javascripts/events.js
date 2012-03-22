$(function(){
  $("input#event_start_date").datepicker({dateFormat: 'yy-mm-dd'});
  $("input#event_start_time").timepicker({
    ampm: false
  });
  $("input#event_end_date").datepicker({dateFormat: 'yy-mm-dd'});
});
