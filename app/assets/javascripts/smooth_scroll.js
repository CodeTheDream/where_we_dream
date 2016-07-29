function smoothScroll() {
  $('a[href*=\\#]:not([href=\\#])').click(function() {
    var path = $(this).attr('href');
    var link = $('a[name=' + path.slice(1) + ']');
    var start = $(window).scrollTop();
    var stop = target = setDestination(link);
    var distance = Math.abs(start - stop);
    var time = putTime(distance);
    link.closest('h3').addClass('highlight');
    $('html,body').animate( {scrollTop: target}, time, removeHighlight);
    return false;
  });
};

function setDestination(link) {
  var value = link.offset().top;
  if ($(window).width() > 768) {
    value -= 85;
  };
  return value;
};

function putTime(distance) {
  if (distance < 1000) {
    return distance*3/5;
  } else if (distance < 2000) {
    return distance/2;
  } else if (distance < 4000) {
    return distance/4;
  } else {
    return distance/5;
  };
};

function removeHighlight() {
  $('.highlight').removeClass('highlight');
};

$(smoothScroll);
