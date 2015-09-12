//= require jquery
//= require parsley
//= require jquery_ujs
//= require_tree .
function setCoverHeight() {
  var height = $(window).height();
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
    // clearTimeout(timer);
    if ($(window).scrollTop() > previous  && $(window).width() <= 768) {  //scroll down
      if ( !($('#nav-features').is(":visible") || $('#nav-admin').is(":visible")) ) {
        $('header').addClass('header--hidden');
      }
    } else {                                                              //scroll up
      $('header').removeClass('header--hidden');
    };
    previous = $(window).scrollTop();
  });
};

function addQuestionsPartial() {
  $("#new-question").click(
    function() {
      $.ajax({
        url: "/new_question_partial",
        type: "PATCH",
      });
    }
  )
}

function deleteQuestion() {
  $('.destroy-button').click(function() {
    $($(this).closest('div')).hide();
  });
};

function updateQuestion() {
  $(".edit-question").blur(function() {
    sendQuestionUpdate(this);
  }).focus(function(){
    this.addEventListener('keypress', function (e) {
      var key = e.which || e.keyCode;
      if (key === 13) { // once ENTER key is presssed, do this:
        $(this).blur();
      }} // close e function
    );
  });
};

function sendQuestionUpdate(question) {
  var value = $(question).val();
  var id = $(question).attr('id');
  $.ajax({
    url: "/admin/questions/" + id,
    type: "PATCH",
    data: {
      'question' : {
        'value': value
      }
    }
  })
}

function makeTextareaElastic() {
  $(window).on('load resize', function() {
    goThruArray();
  });
};

function goThruArray() {
  if ($('.edit-question').length > 0) {
    var array = $('.edit-question');
  } else {
    var array = $('.details');
  }
  $.each(array, function() {
    $(this).height(this.scrollHeight - 4)
  });
}

function showAdditionalDetails() {
  $(window).on('load', function() {
    $.each($('.rule'), function() {
      var val = $('input:checked',$(this)).val();
      if (val == "true" || val == "false") {
        $('.details-container', $(this)).show()
      };
    });
  });
  $('input[type="radio"]').click(function() {
    var val = $(this).val();
    var container = $('.details-container',$($(this)).closest('.rule'));
    if (val == "true" || val == "false") {
      container.show()
      goThruArray();
    } else {
      container.hide()
    }
  });
};

$(setCoverHeight);
$(responsiveCoverHeight);
$(toggleMobileNavs);
$(autoHideHeader);
$(addQuestionsPartial);
$(deleteQuestion);
$(updateQuestion);
$(showAdditionalDetails);
$(makeTextareaElastic);
