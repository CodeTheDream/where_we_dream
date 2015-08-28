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

function setMobileNavHeight() {
  $('#stack').click(function() {
    if ($('#mobile-nav').css('display') != 'none') {
      var headerHeight = $('#header-wrapper').height();
      var height1 = $(window).height() - headerHeight;
      $('#mobile-nav').height( height1 );
      var features = $('.feature').length
      var featureHeight = $('.feature').height()
      var height2 = ( $(window).height() - ( headerHeight + (features*featureHeight) ) )/( features + 1 );
      console.log(height2)
      $('.feature').css('margin', height2 + 'px 0');
    }
  });

};

$(setCoverHeight);
$(responsiveCoverHeight);
$(toggleMobileNav);
$(setMobileNavHeight);
