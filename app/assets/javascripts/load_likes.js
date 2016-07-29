function loadLikes() {
  $.each($('.likes-bar'), function() {
    this.style.width = $(this).attr('width');
  });
  $.each($('.no-opinions-bar'), function() {
    this.style.background = 'lightgray';
  });
};

$(loadLikes);
