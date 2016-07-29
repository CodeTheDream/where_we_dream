previous = 0;
function hideHeader() {
  $(window).scroll(function(){
    var scroll_down = $(window).scrollTop() > previous;
    var nav_is_closed = !( $('.nav').is(':visible') );
    var window_is_phone_width = $(window).width() <= 768;
    if (scroll_down) {
      removeNotice();
      if ( nav_is_closed && window_is_phone_width ) {
        if ( !($('header').hasClass('header--hidden')) ) {
          $('header').addClass('header--hidden');
        };
      };
    } else if ( $('header').hasClass('header--hidden') ) {
      $('header').removeClass('header--hidden');
    };
    previous = $(window).scrollTop();
  });
};

function removeNotice() {
  $('#notice').fadeOut(500, function() {
    $(this).remove();
  });
};

$(hideHeader);
