// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require tinymce
//= require rails.validations
//= require_tree .
//= require_self
$(document).ready(function(){
    $(".alert-alert").delay(1000).slideUp(300);
});
$(document).ready(function(){
    $(".alert-notice").delay(1000).slideUp(300);
});


$(document).ready(function(){
  $('.average-review-rating').raty({
    readOnly: true,
    score: function() {
      return $(this).attr('data-score')
    }
  });

  $('.review-rating').raty({
    readOnly: true,
    score: function() {
      return $(this).attr('data-score')
    }
  });


  $('#rating-form').raty({
    scoreName: 'review[rating]'
  });
});

function flash_update(html)  {
   $('div#flash-id').empty();
   $('div#flash-id').html(html);
   $('.alert-alert').delay(10000).slideUp(300);
   $('.alert-notice').delay(10000).slideUp(300);

}
