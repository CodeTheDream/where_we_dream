//= require jquery
//= require jquery_ujs
//= require_tree .
function setCoverHeight() {
  var height = $(window).height();
  // var height = $(window).height() - $('header').height();
  $('.cover').height( height );
};

function responsiveCoverHeight() {
  $( window ).resize( setCoverHeight );
};

function toggleMobileNavs() {
  $('#js-navigation-menu li').click( function() {
    var id = $(this).attr('id');
    if ($('#nav-' + id).css('display') == 'none') {
      $('#mobile-nav').show();
      $('#nav-' + id ).show();
      if (id=='admin') {
        $('#nav-features').hide();
      } else {
        $('#nav-admin').hide();
      }
      setMobileNavHeight();
    } else {
      $('#mobile-nav').hide();
      $('#nav-features').hide();
      $('#nav-admin').hide();
    };
  });
};

function setMobileNavHeight() {
  var headerHeight = $('#header-wrapper').height();
  var height1 = $(window).height() - headerHeight;
  $('#mobile-nav').height( height1 );
  var features = $('.feature:visible').length;
  var featureHeight = $('.feature:visible').height();
  var height2=($(window).height()-(headerHeight+(features*featureHeight)))/(features*2);
  $('.feature:visible').css('padding', height2 + 'px 0');
};

previous = 0;
function autoHideHeader() {
  $(window).scroll(function(){
    clearTimeout(timer);
    if ($(window).scrollTop() > previous) { //scroll down
      $('header').addClass('header--hidden');
    } else {                                //scroll up
      $('header').removeClass('header--hidden');
      timedHide();
    };
    previous = $(window).scrollTop();
  });
};

function timedHide() {
  timer = setTimeout( function() {
    $('header').addClass('header--hidden');
  }, 5000);
};

$(setCoverHeight);
$(responsiveCoverHeight);
$(toggleMobileNavs);
$(autoHideHeader);
$(timedHide);
