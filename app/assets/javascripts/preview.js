function preview2() {
  $('.preview').click(function() {
    var form = $('form');
    var url = form.attr('action').replace(/[^\D]/g, ''); // 'stories/'

    // Sends data
    $.ajax({
      url: url + '/preview',
      type: 'PATCH',
      data: form.serialize()
    });

    // Stops form from submitting
    return false;
  });
};

$(preview2);
