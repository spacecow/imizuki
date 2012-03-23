//= require jquery
//= require jquery_ujs
//= require jquery-ui-1.8.18.custom.min
//= require jquery-ui-timepicker-addon
//= require jquery.datePicker
//= require_self
//= require_tree .

// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
  sparkle1 = setInterval(hoverfade1, 5500);
  sparkle2 = setInterval(hoverfade2, 11000);
  sparkle3 = setInterval(hoverfade3, 8000);
  sparkle4 = setInterval(hoverfade4, 11000);
  sparkle5 = setInterval(hoverfade5, 12000);
  sparkle6 = setInterval(hoverfade6, 12500);
  function hoverfade1(){ $('div#star1').fadeOut(1000).fadeIn(1000); }
  function hoverfade2(){ $('div#star2').fadeOut(1500).fadeIn(1500); }
  function hoverfade3(){ $('div#star3').fadeOut(1200).fadeIn(1200); }
  function hoverfade4(){ $('div#star4').fadeOut(1500).fadeIn(1500); }
  function hoverfade5(){ $('div#star5').fadeOut(1500).fadeIn(1500); }
  function hoverfade6(){ $('div#star6').fadeOut(1500).fadeIn(1500); }
});
