//= require jquery
//= require jquery_ujs
//= require_tree .
function setCoverHeight() {
  $('.cover').height( $(window).height() );
};

function responsiveCoverHeight() {
  $( window ).resize( setCoverHeight );
};

function toggleMobileNav() {
  $('#stack').click( function() {
    if ($('#mobile-nav').css('display') == 'none') {
      $('#mobile-nav').show()
    } else {
      $('#mobile-nav').hide()
    };
    $('#stack').css('color','black')
  });
};

$(setCoverHeight);
$(responsiveCoverHeight);
$(toggleMobileNav)
